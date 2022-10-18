/* exam162

Eine Schleife wird mit between und mit Vor- und Nachbereitungsphase formuliert.

Als Vorbereitung sind in 1 drei Fakten direkt eingetragen und in 2 ist die 
Anzahl von Schleifenschritten festgelegt. Diese Vorbereitungen finden in 
jedem ähnlichen Programm "vorher" statt.
 
In 4 ist die Anzahl der Schleifenschritte bekannt. Im trace-Modus sehen 
Sie in 4, wie die Variable NN durch 3 ersetzt wird. In 5 wird eine einfache 
Methode angewendet, mit der alle Fakten, die in der Schleife benutzt werden, 
gesammelt werden. Sie sehen, wie PROLOG die drei Terme
pred(1), pred(2) und pred(3) findet. PROLOG nimmt von jedem dieser gefundenen
Terme das Argument, also 1,2,3, und schreibt sie in einer Liste
[1, 2, 3]. Diese Liste gibt PROLOG mit findall(_,_,[4, 1, 5]) aus. Dies ist
im Ablauf im trace-Modus zu sehen:
    findall(_G314, user:pred(_G314), [4, 1, 5]) 
Die in "findall" benutzt Variable X ist an dieser Stelle schon wieder 
"freigeschaltet". Sie kann wieder für andere Zwecke benutzt werden, sie hat 
- in diesem Beispiel - die Form _G314 .

In 6 wird die Schleife durch "between" gesteuert. Im Schleifenprädikat
loop_predicate(X,LIST) läuft die Indexvariable X von 1 bis NN, also
hier von 1 bis 3.
In der ersten Schleife sehen Sie: between(1,3,1). Dann ruft PROLOG das 
loop_predicate(_,_) auf. Sie sehen, wie die Variablen X und LIST belegt sind:
X = 1 und LIST = [4,1,5]. 
PROLOG springt zu 7 und findet nth1(X,LIST,Y). Im Ablauf war X schon durch 1 
ersetzt und LIST durch [4,1,5]: nth1(1,[4,1,5],Y). 
PROLOG kann also die erste Komponente der Liste LIST berechnen: Y wird zu 4.
D.h. die erste Komponente der Liste [4,1,5] ist 4. PROLOG sucht nun, ob
in der Datenbasis ein Fakt der Form pred(Y) zu finden ist. Y ist mit 4 belegt.
PROLOG findet diesen Fakt pred(4) in 1. PROLOG schreibt diesen Fakt auf.

Da 7 bearbeitet ist, geht PROLOG wieder zu 6. PROLOG findet "fail" und 
kehrt zurück zu "between". Da X = 1 und X =< 3 ist der Term between(1,3,1) richtig. 
PROLOG ersetzt deshalb 1 durch 2 in "between" : between(1,3,2), 2 is 1+1. 
PROLOG geht wieder zu 7, nimmt die zweite Komponente aus der Liste, hier: 1, findet 
einen entsprechenden Fakt, pred(1), schreibt ihn auf und wendet sich wieder 
zurück zu 6. PROLOG findet "fail" und geht zu "between" zurück. PROLOG findet,
dass 2 =< 3 ist (Y =< NN). Also ist between(1,3,2) ist richtig. PROLOG ersetzt daher
2 durch 3: between(1,3,3). PROLOG kommt wieder zu 7, findet die 3-te 
Komponente der Liste, nämlich 5, und findet auch den Fakt pred(5) in 1.
PROLOG schreibt den Fakt auf und kehrt zu 6 zurück. PROLOG findet "fail"
und kommt zu between(1,3,3). Auch dies ist richtig. PROLOG ersetzt 3 (Y=3) 
mit 4: between(1,3,4). PROLOG sieht, dass dieser Term falsch ist. In
6 geht PROLOG daher zu dem zweiten Teil der Zeile, zum rechten Oder-Teil "true".
"true" ist immer richtig. Damit ist die Zeile 6 vollständig bearbeitet -
und damit auch das ganze Programm. 
*/

pred(4).  pred(1).  pred(5).                              /* 1 */
number_of_steps(3).                                       /* 2 */

% -------------------------------------------

start :-                                                  /* 3 */
  trace,
  number_of_steps(NN),                                    /* 4 */
  findall(Y,pred(Y),LIST),                                /* 5 */
  ( between(1,NN,X), loop_predicate(X,LIST), fail; true). /* 6 */

loop_predicate(X,LIST) :- nth1(X,LIST,Y), pred(Y),        /* 7 */
   write(pred(Y)), nl,!.                                  /* 8 */









