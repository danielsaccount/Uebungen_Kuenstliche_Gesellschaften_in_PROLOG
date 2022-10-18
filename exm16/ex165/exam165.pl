/* exam165

Eine Schleife, wie sie in der Informatik verwendet wird.

Als Vorbereitungen haben wir am Anfang in 1 drei Fakten eingetragen.
In 2 wird die Anzahl der Schleifenschritte festgelegt. 

In 3 wird die Anzahl N der Schleifenschritte von 2 geholt: N=3.
Der Schleifenzähler läuft hier über die Variable X. X läuft von 1 bis N.

In 5 findet PROLOG den Term loop(1,3,[4,2,5]). Dieser Term ist als Fakt 
in der Datenbasis nicht vorhanden. PROLOG sucht, ob es ähnliche Terme
gibt, die PROLOG als Kopf einer Klause verwenden kann. In 6 schaut PROLOG den Kopf 
der Klause an. Dieser Term ist nicht mit dem identisch, den er in 5
bearbeitet muss. Also muss PROLOG weitere Klausen suchen, die mit
loop(1,3,[4,2,5]) beginnen.   

PROLOG findet in 7 den Term loop(X,3,[4,2,5]) als Kopf. Hier kann PROLOG den
Rumpf bearbeiten. PROLOG identifiziert X mit 1: loop(1,3,[4,2,5]).
In 8 wird geschaut, ob 1 < 3 ist (in Variablenform: X < N). Dies ist der Fall.
Daher kann PROLOG in 9 das Schleifenprädikat loop_predicate(1,[4,2,5]) bearbeiten. 
PROLOG springt zu 12 und dann zu 13. Dort wird die 1-te Komponente (X=1) aus der
Liste [4,2,5] (LIST = [4,2,5]) berechnet. Als Resultat gibt PROLOG die Komponente
4 aus und ersetzt in "nth1" die  Variable Y durch 4: nth1(1,[4,2,5],4).
In 13 holt PROLOG nun den Fakt pred(4), den er in 1 oben auch findet:
Y = 4. In 14 schreibt PROLOG diesen Fakt heraus. Nach diesem Erfolg geht PROLOG 
wieder nach oben zu 9 zurück. In 10 wird der Zählindex X um Eins erhöht:
    Xnew is X is X + 1 ( = 2). 
Mit diesem neuen Index geht PROLOG zu 11 und bearbeitet 
den Term loop(Xnew,N,LIST), wobei Xnew=2, N=3 und LIST=[4,2,5] ist.  
                                     
In 12 und 13 wird die 2-te Komponente aus der Liste geholt und das
entsprechende pred(2) gefunden und beschrieben. PROLOG geht zu 7 zurück.
Dort ist X inzwischen durch 2 ersetzt.  In 8 rechnet PROLOG aus, ob
2 < 3 ist. Dies ist der Fall. Damit kommt PROLOG zu 9 - und damit zu 12, 13 und 
14. PROLOG bearbeitet 9, wobei X durch 2 instantiiert wurde. In 10 wird 
X um Eins erhöht: Xnew is X + 1 = 2 + 1 = 3. Dann geht PROLOG  nach 11 und
wieder nach 7. Und so weiter.  

Nach einigen Schritten - hier im Beispiel nach 3 Schritten - befindet sich
PROLOG in 8 in der Situation, dass X nicht kleiner als N ist: X = 3, N = 3.
3 < 3 ist falsch. Damit wird 7 falsch. PROLOG sucht nun weiter nach einer
Klause, die mit "loop" beginnt, und findet sie in 6. Dort ist loop(N,N,LIST)
wie folgt belegt: loop(3,3,[4,2,5]). In 6 springt PROLOG daher wieder nach 12 -
14, findet den Term pred(3) und schreibt ihn auf.

Damit ist 6 erfolgreich beendet. Und insgesamt ist auch der "loop"-Term
in 5 erfolgreich bearbeitet und damit das ganze Programm.
*/

pred(4). pred(2). pred(5).                                 /* 1 */
number_of_steps(3).                                        /* 2 */

% ----------------------------------------------

start :- 
  trace,
  number_of_steps(N),                                      /* 3 */
  findall(Y,pred(Y),LIST),                                 /* 4 */
  loop(1,N,LIST).                                          /* 5 */

loop(N,N,LIST) :- loop_predicate(N,LIST).                  /* 6 */                             

loop(X,N,LIST) :-                                          /* 7 */
  X < N,                                                   /* 8 */
  loop_predicate(X,LIST),                                  /* 9 */     
  Xnew is X + 1,                                           /* 10 */
  loop(Xnew,N,LIST).                                       /* 11 */

loop_predicate(X,LIST) :-                                  /* 12 */
   nth1(X,LIST,Y), pred(Y),                                /* 13 */
   write(pred(Y)), nl.                                     /* 14 */  