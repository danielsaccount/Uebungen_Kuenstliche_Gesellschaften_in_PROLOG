/* exam322 

Ein Netz einer spezieller Art für Insitutionen wird generiert. 

Im exam314 wurde jeweils an einen Endpunkt genau ein neuer Punkt angehängt. 
In exam322 werden dagegen ausgehend von einem gegebenen Punkt mehrere neue 
Punkte an denselben Endpunkt angehängt. Wir nennen ein solches Netz einen "Baum", 
die Punkte nennen wir "Blätter" und die Linien (Teil-)"Äste".

Ein Netz wird in folgender Form beschrieben: 

  tree([[1, [0, 1]], [2, [1, 2]], [3, [1, 3]], [4, [2, 4]], ...]).

Dabei ist in jeder Komponente [I,[P1,P2]] die Variable I die Nummer 
(der "Name") eines Blattes im Baum und [P1,P2] ein Teilast von P1 zu P2. 
Das Blatt Nummer 0 wird als technischen Anfangspunkt gebraucht; dieses 
Blatt wird im Baum graphisch nicht zu sehen sein.

Als Fakten wird in 1 die Anzahl der Blätter eingetragen. In 2 ist 
die Zahl der möglichen Entscheidungen, die ausgehend von einem Endblatt 
nach oben gehen können, eingetragen. In 3 und 4 werden die Resultatdateien geleert 
und in 5 werden die Fakten aus der Datenbasis geholt. 

In 6 wird er "Induktionsanfang" beschrieben. Am Anfang enthält der Baum 
tree([[1,[0,1]]]) genau ein Blatt Nr.1 und einen Ast von 0 
nach 1. Das Blatt 1 ist an dieser Stelle auch ein Endblatt. Es gibt bei 
diesem Blatt keinen Ast, die weiter nach "oben" führt - weil der Baum nur
ein einziges Blatt enthält.

In 7 wird ein Baum mit Ästen der Zahl NUMBER_OF_LEAFS mit der Zahl
DEC von Entscheidungspunkten erzeugt. Dies geschieht durch die Schleife
in 7.1 und 7.2. In 7.1 wird zunächst abgefragt, ob PROLOG beim Erzeugen 
schon am letzten Blatt angekommen ist. In diesem Fall wäre die Nummer des
letzten Blattes die Zahl NUMBER_OF_LEAFS, die identisch mit dem Fakt in 1 
number_of_leafs(NUMBER_OF_LEAFS) ist: NUMBER_OF_LEAFS = 1. Da dies
im unserem Beispiel aber nicht der Fall ist (NUMBER_OF_LEAFS = 10 > 1
= LEAF), ist 7.1 falsch. PROLOG geht weiter zu 7.2. In 7.2 findet PROLOG 
in 7 den Term, in dem das Blatt (LEAF), d.h. das erste Argument in 7, durch
die Nummer 1 besetzt ist. In 8 vergleicht PROLOG daher die beiden Zahlen. 
In diesem Schritt ist LEAF durch 1 belegt und NUMBER_OF_LEAFS durch 10.
8 ist also richtig. PROLOG wendet sich 9 zu. POSSIBILITY_NR_Y ist hier 
eine Variable, die erst später genauer bestimmt wird. Inhaltlich geht es 
um einen der möglichen Wege, die von dem gegebenen Blatt (LEAF) zu einem
neuen Blatt führen kann. Durch 2 ist festgelegt, dass es hier genau zwei 
Möglichkeiten gibt, den Ast "weiter wachsen" zu lassen. In 10 holt PROLOG
den im Entstehen begriffenen Baum tree(TREE) und die zugehörige
end_line(END). In 11 wird die Länge dieser Liste berechnet und zufällig
eine der "freien" Blätter LEAF1 aus dieser Liste genommen. Da hier die
Blätter durch Zahlen ausgedrückt werden, können wir LEAF1 direkt verwenden
und in 12 die Komponente Nr. LEAF1 aus dem Baum TREE bestimmen, nämlich
die Komponente [LEAF1,LL]. LL ist ein Paar bestehend aus zwei Blättern;
LL wird aber an dieser Stelle nicht weiter benutzt. In 13 wird eine
Zufallszahl aus dem Bereich von 1 bis DEC gezogen, die die Y-te Möglichkeit
ausdrückt, im Baum weiter zu wachsen. In 14 wird zur Nummer LEAF die
Zufallszahl Y dazu addiert: POSSIBILITY_NR_Y is LEAF + Y. An dieser Stelle
wurde nun die Variable POSSIBILITY_NR_Y in 9 genau bestimmt. 

In 15 wird eine Schleife über die Zufallszahl Y gelegt. In der hier 
benutzten Struktur wird für ein gegebenes Blatt - wenn möglich - mehrere
neue Blätter dazugenommen. Dazu wird zunächst die neue, zufällig gezogene
Anzahl Y festgelegt und dann je nach Anzahl die neuen Blätter in 15
generiert. In einem Schleifenschritt in 16 wird der Baum und die Endliste
geholt. In 17 wird ein neues Blatt LEAFnew bestimmt: LEAFnew is LEAF + Y. 
In 18 wird das neue Blatt zu dem Baum hinzugenommen. In 19 - 21 werden
die beiden Listen tree(...) und endline(...) angepasst. 

In 9 ist nun ein neues Blatt erzeugt. Das neue Blatt Nr. LEAFnew ist in 
22 zunächst eine Variable. Die Variable in 17 wurde am Ende von 15 wieder
freigeschaltet. Wir müssen die Variable in 22 erst wieder instantiieren.
Dazu nehmen wir die Zahl POSSIBILITY_NR_Y in 9, die in 22 mit LEAFnew 
gleichsetzt wird. In 23 und 25 gibt es zwei Möglichkeiten. In 23 gehört 
das neue Blatt zu den vorgesehenen Blättern, die erzeugt werden. In diesem
Fall wird der Schleifenterm 24 wieder aufgerufen. Allerdings ist nun die 
Zahl LEAFnew im Vergleich zu LEAF in 7.2 größer geworden. In zweiten Fall
passiert in 25 nichts.

Im vorletzten Schleifenschritt in 7.2 und 23 ist die Zahl LEAFnew mit
NUMBER_OF_LEAFS identisch. Im letzten Schleifenschritt ist dann in 23
LEAFnew echt größer als NUMBER_OF_LEAFS. PROLOG wendet sich zu 25 und
zu 7.2. In 8 ist die Ungleichung aber nun falsch. Daher ist 7.2 falsch.
PROLOG findet aber in 7.1 einen Ausweg. 7.1 beschreibt einen Fakt, der 
in der Datenbasis zu finden ist. 7.1 ist also richtig.  

Damit ist 7 beendet. PROLOG holt in 26 den vollständig erzeugten Baum
und schickt die Beschreibung des Baums an die Resultatdatei res3221.pl.
Scließlich verfahren wir in 28 und 29 für die endline(..) in ähnlicher 
Weise.

Abkürzung:
DEC = NUMBER_OF_POSSIBLE_DECISIONS
*/


number_of_leafs(10).                                                 /* 1 */
number_of_decisions(2).                                              /* 2 */

start :-
  (exists_file('res3221.pl'), delete_file('res3221.pl'); true),      /* 3 */
  (exists_file('res3222.pl'), delete_file('res3222.pl'); true),      /* 4 */
  number_of_leafs(NUMBER_OF_LEAFS), number_of_decisions(DEC),        /* 5 */
  asserta(tree([[1,[0,1]]])), asserta(end_line([1])),                /* 6 */
  make_a_tree(1,NUMBER_OF_LEAFS,DEC),                                /* 7 */
  tree(TREE),                                                       /* 26 */
  append('res3221.pl'), write(tree(TREE)), write('.'), nl, nl, 
       told,                                                        /* 27 */
  end_line(END),                                                    /* 28 */
  append('res3222.pl'), write(end_line(END)), write('.'), nl, told, /* 29 */
  retract(tree(TREE)), retract(end_line(END)),!.                    /* 30 */
  
make_a_tree(NUMBER_OF_LEAFS,NUMBER_OF_LEAFS,DEC).                  /* 7.1 */
make_a_tree(LEAF,NUMBER_OF_LEAFS,DEC) :-                           /* 7.2 */
% trace,
  LEAF =< NUMBER_OF_LEAFS,                                           /* 8 */
  add_points(LEAF,NUMBER_OF_LEAFS,DEC,POSSIBILITY_NR_Y),             /* 9 */
  LEAFnew is POSSIBILITY_NR_Y,                                      /* 22 */
  ( LEAFnew =< NUMBER_OF_LEAFS,                                     /* 23 */
    make_a_tree(LEAFnew,NUMBER_OF_LEAFS,DEC)                        /* 24 */
  ; true                                                            /* 25 */
  ),!.                                                            

add_points(LEAF,NUMBER_OF_LEAFS,DEC,POSSIBILITY_NR_Y) :-             /* 9 */
  tree(TREE), end_line(END),                                        /* 10 */
  length(END,LENGTH), X is random(LENGTH) + 1, nth1(X,END,LEAF1),   /* 11 */ 
  nth1(LEAF1,TREE,[LEAF1,LL]),                                      /* 12 */
  Y is random(DEC) + 1,                                             /* 13 */
  POSSIBILITY_NR_Y is LEAF + Y,                                     /* 14 */
  ( between(1,Y,Z), add_one_leaf(Z,LEAF,LEAF1), fail; true),        /* 15 */
  end_line(END1), delete(END1,LEAF1,ENDnew), retract(end_line(END1)),
  asserta(end_line(ENDnew)),!.

add_one_leaf(Z,LEAF,LEAF1) :-                                       /* 15 */
  tree(TREE), end_line(END1),                                       /* 16 */
  LEAFnew is LEAF + Z,                                              /* 17 */
  append(TREE,[[LEAFnew,[LEAF1,LEAFnew]]],TREEnew),                 /* 18 */
  retract(tree(TREE)), asserta(tree(TREEnew)),                      /* 19 */
  append(END1,[LEAFnew],ENDnew),                                    /* 20 */
  retract(end_line(END1)), asserta(end_line(ENDnew)),!.             /* 21 */
   
  


  

