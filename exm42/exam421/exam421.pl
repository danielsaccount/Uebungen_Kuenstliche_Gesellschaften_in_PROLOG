/* exam421 

Ein einfaches Programm zur Simulation eines Modells von Heider.

Aus einer Menge von Personen und einer Menge von Objekten wird eine 
Liste von Triaden erzeugt. Diese wird als Anfangsfakt verwendet. Die
Liste wird in jedem Tick untersucht und eventuell verändert. Bei einer
Untersuchung wird für jeden Akteur A geprüft, ob es in der Liste Triaden
gibt, die relativ zu A nicht ausbalanciert sind. Wenn ja, wird eine der
nicht ausbalancierten Triaden so verändert, dass sie zu den restlichen 
Triaden für A passt.     

Aus diesem Programm lässt sich aus den Resultaten ohne Mühe untersuchen,
ob die Anzahl der ausbalancierten Triaden mit der Zeit größer wird oder
nicht. Dies überlassen wir hier den LeserInnen. 

Neben den Anzahlen brauchen wir die Unterscheidung zwischen ausbalancierten
und nicht ausbalancierten Triaden. Diese Unterscheidung wurde bei Heider 
empirisch gestätigt. 

Eine Triade hat die Form
  
   triade([NUMBER,[PERSONA,PERSONB,OBJECT],[INDEX1,INDEX2,INDEX3]]),

dabei wird jeder Triade eine Nummer gegeben. Die Indizes INDEX1, INDEX2 und
INDEX3, die die Form 1 oder -1 haben können, drücken aus, dass jede der 
drei Beziehungen zwischen PERSONA - PERSONB, PERSONA - OBJECT und zwischen
PERSONB - OBJECT - in dieser Reihenfolge - positiv (1) oder negativ (-1) ist
(siehe mehr dazu in Abschnitt 4.2 in unserem Buch).   

Beim Start werden in 1 und 2 zunächst die Dateien data421.pl und die 
Resultatdateien leergeräumt. In 3 wird die Datei data421.pl wieder 
eingerichtet, so dass am Anfang dieser Datei die Zeile

    :- dynamic stored/2.

vorhanden ist. In dieser Weise können wir die Erzeugung der Anfangsfakten
gleich im Hauptprogramm erledigen. Wenn wir die erzeugten Fakten gar nicht
in eine Datei data421 auslagern, was natürlich möglich wäre, müssten wir
zwei Arten von Wrappern unterscheiden. 

In 4 wird die Anzahl der Ticks aus der Datenbasis geholt. In 5 werden die
Anfangsdaten erzeugt. In 5.2 wird ein Modul benutzt, mit dem die Menge 
der Paare von Akteuren erzeugt werden, die verschieden sind. Die Klause
make_pot_pairs bewahren wir normalerweise in der Datei für Hilfsmodule 
"pred" auf. In 5.3 werden diese Paare in einer Schleife erzeugt. Dazu wird 
in einem Schleifenschritt aus der Menge der Paare zufällig ein solches 
Paar [A,B] ausgewählt. Aus diesem Paar [A,B] wird mit expand_to_a_triade([A,B],OO,N) 
in 5.5 dieses Paar von Akteuren zu einer Triade ergänzt.

In 5.7 wird ein Objekt zufällig aus der Liste aller Objekte gezogen
und in 5.8 werden drei Münzen geworfen. Je nach dem Resultat wird 1 oder
-1 für die Triade TR = [N,[A,B,Ob],[W1,W2,W3]] eingetragen. Diese Triade
wird in 5.9 an die Liste der Triaden angefügt und diese Liste wird 
angepasst. In 5.10 wird aus der Menge der Paare das gerade benutzte Paar
entfernt und die entsprechenden Listen angepasst. Am Ende von 5 können 
wird die so generierte Liste von Triaden in der Datei data421.pl anschauen.
In 6 wird diese Datei in die Datenbasis geladen. In 7 werden all diese
Fakten auch an die Resultatdatei geschickt.
         
In 8 wird nun die Zeitschleife bearbeitet. Zu einem TICK wird in 9 die
Akteurschleife bearbeitet. In einem Schleifenschritt von 10 wird ein Akteur
ACTOR zum Tick TICK bearbeitet. In 11 wird die Triadenliste LIST_TR geholt und
ihre Länge bestimmte. In 12 wird eine offene Schleife angelegt. In jedem 
Schritt wird in 13 eine Triade TR1 aus der Triadenliste genommen und in 14 
wird diese Triade analysiert. In 15 prüft PROLOG, ob der gerade aktive Akteur
ACTOR identisch mit dem Akteur A1 ist, der an der ersten Stelle der Triade 
TR1 steht. 

Hier gibt es nun zwei Fälle. Wenn diese Gleichung stimmt, geht PROLOG weiter.
In 16 beginnt eine weitere, offene Schleife über die Triadenliste. In 17
wird eine Triade TR2 aus der Liste LIST_TR herausgenommen und in 18 wird 
geprüft, ob die Triade TR2 identisch mit der Triade TR1 ist. Wenn beide
Triaden veschieden sind, wird in 19 untersucht, ob die beiden Triaden TR1 
und TR2 nicht ausbalanciert sind. Genauer werden die beiden Fakten geholt, 
die die Signatur der Triaden angeben (siehe Details in 4.2 unseres Buches). 
Im ersten Fall hat die Triade TR1 eine Signatur der ersten Art und die 
Triade TR2 eine Signatur der zweiten Art, oder umgekehrt. Und beide
Siganturen sind verschieden. 

Wenn die Klause 19 falsch ist, passen die Triaden TR1 und TR2 schon 
zusammen. In diesem Fall wird PROLOG die offene Schleife in 16 in Zeile 
22 beenden. Wenn 19 aber richtig ist, sind die Triaden TR1 und TR2 nicht
ausbalanciert. In 20 wird eine dieser Triaden verändert, so dass beide
ausbalanciert werden. Dazu gibt es mehrere Fälle, die in 20 genauer 
beschrieben sind. Auch die beiden möglichen Resultate werden beschrieben 
und an die Resultatdatei geschickt. Schließlich wird die Triadenliste 
angepasst. 

Am Ende eines Ticks wird in 23 der Tick um eins erhöht. Gleichzeitig wird
die Triadenliste angepasst für den nächsten Tick. 
*/

:- multifile stored/2.
:- dynamic stored/2.

number_of_actors(10).
number_of_objects(5).
number_of_ticks(3).

triades_pos_balanced([[1,1,1],[-1,1,-1],[1,-1,-1],[-1,-1,1]]).
triades_neg_balanced([[1,1,-1],[-1,1,1],[1,-1,1]]).

start :- 
  ( exists_file('data421.pl'), delete_file('data421.pl') ; true ),        /* 1 */
  ( exists_file('res4211.pl'), delete_file('res4211.pl') ; true ),       /* 2a */
  ( exists_file('res4212.pl'), delete_file('res4212.pl') ; true ),       /* 2b */
  append('data421.pl'), write(':- dynamic stored/2'), write('.'), nl,nl,
  told,                                                                   /* 3 */
  number_of_ticks(TICKS),                                                 /* 4 */
  make_data,                                                              /* 5 */
  consult('data421.pl'),                                                  /* 6 */
  findall(X,stored(0,X),L), length(L,Length),                             /* 7 */
   (   between(1,Length,Z), nth1(Z,L,FACT), 
       append('res4211.pl'),
       write(stored(0,FACT)), write('. '), nl, told,
       retract(stored(0,FACT)), asserta(stored(1,FACT)),
       fail
   ;   true 
   ), nl, told,
  ( between(1,TICKS,TICK), make_time_loop(TICK), fail; true),             /* 8 */
  retractall(changed(AAA,BBB,CCC,DDD)), retractall(stored(XXX)),!.

make_time_loop(TICK) :-                                                   /* 8 */
   number_of_actors(AS),
   ( between(1,AS,ACTOR), activate(TICK,ACTOR), fail; true),              /* 9 */
   adjust(TICK),!.                                                       /* 23 */

activate(TICK,ACTOR) :-                                                  /* 10 */
  stored(TICK,list_of_triades(LIST_TR)), length(LIST_TR,Length1),        /* 11 */
  (  between(1,Length1,Nr),                                              /* 12 */
     nth1(Nr,LIST_TR,TR1),                                               /* 13 */
     nth1(2,TR1,COMP), nth1(1,COMP,A1),                                  /* 14 */
                                    /* TR1 = [Nr,[A1,B1,Ob1],[X1,Y1,Z1]] */
     ACTOR = A1,                                                         /* 15 */
          ( between(1,Length1,Nr1),                                      /* 16 */
            nth1(Nr1,LIST_TR,TR2),                                       /* 17 */
            \+ TR1 = TR2, TR2 = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2]],            /* 18 */
            signs_are_imbalanced(TR1,TR2),                               /* 19 */
            change(TICK,ACTOR,TR1,TR2,TR1new,TR2new)                     /* 20 */
          ;
            true                                                         /* 22 */
          )
  ;
    true
  ),!.

signs_are_imbalanced(TR1,TR2) :-                                         /* 19 */
   triades_pos_balanced(LIST_SIG1), 
   triades_neg_balanced(LIST_SIG2), 
   ( nth1(3,TR1,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR2,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG1 = SIG2
   ;
     nth1(3,TR2,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR1,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG1 = SIG2
   ),!.

change(TICK,ACTOR,TR1,TR2,TR1new,TR2new) :-                              /* 20 */
  TR1 = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1]],
  TR2 = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2]],
  append('res4212.pl'), 
  ( B1 = B2, X1 = X2, 
    ( \+ Y1 = Y2, K2 is random(2)+1,
      ( K2 = 1, Y1n is -Y1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1n,Z1]],
        TR2new = TR2, write(changed(TICK,ACTOR,nr,Nr1)), write('.'), nl
      ; K2 = 2, Y2n is -Y2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2n,Z2]],  
        TR1new = TR1, write(changed(TICK,ACTOR,nr,Nr2)), write('.'), nl
      )
      ; true
    ),
    ( \+ Z1 = Z2, K3 is random(2)+1, 
      ( K3 = 1, Z1n is -Z1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1n]],
        TR2new = TR2, write(changed(TICK,ACTOR,nr,Nr1)), write('.'), nl
      ; K3 = 2, Z2n is -Z2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2n]],  
        TR1new = TR1, write(changed(TICK,ACTOR,nr,Nr2)), write('.'), nl
      )
      ; true
    )
  ;
     Ob1 = Ob2, Y1 = Y2,
     ( \+ X1 = X2, K2 is random(2)+1,
       ( K2 = 1, X1n is -X1, TR1new = [Nr1,[A1,B1,Ob1],[X1n,Y1,Z1]],
         TR2new = TR2, write(changed(TICK,ACTOR,nr,Nr1)), write('.'), nl
       ; K2 = 2, X2n is -X2, TR2new = [Nr2,[A2,B2,Ob2],[X2n,Y2,Z2]],  
         TR1new = TR1, write(changed(TICK,ACTOR,nr,Nr2)), write('.'), nl
       )
       ; true
     ),
     ( \+ Z1 = Z2, K3 is random(2)+1, 
       ( K3 = 1, Z1n is -Z1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1n]],
         TR2new = TR2, write(changed(TICK,ACTOR,nr,Nr1)), write('.'), nl
       ; K3 = 2, Z2n is -Z2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2n]],  
         TR1new = TR1, write(changed(TICK,ACTOR,nr,Nr2)), write('.'), nl
       )
       ; true
     )
  ), told,
  append('res4211.pl'), 
  stored(TICK,list_of_triades(LISTL)),                                   /* 21 */
  ( TR1 = TR1new,
    delete(LISTL,TR2,LISTL1), 
    append(LISTL1,[TR2new],LISTL2),
    nl, write(stored(TICK,list_of_triades(LISTL2))), write('.'), nl 
  ;
    TR2 = TR2new,
    delete(LISTL,TR1,LISTL1), 
    append(LISTL1,[TR1new],LISTL2),
    nl, write(stored(TICK,list_of_triades(LISTL2))), write('.'), nl
  ),
  told,
  retract(stored(TICK,list_of_triades(LISTL))),
  asserta(stored(TICK,list_of_triades(LISTL2))),!.


adjust(TICK) :- findall(X,stored(TICK,X),L), Tnew is TICK+1,
  length(L,E),
  ( between(1,E,N), adjust_fact(TICK,Tnew,N,L), fail; true),!.

adjust_fact(TICK,Tnew,N,L) :- nth1(N,L,FACT), 
%   append('res4211.pl'), write(stored(TICK,FACT)), write('.'), nl, told,
   asserta(stored(Tnew,FACT)), retract(stored(TICK,FACT)),!. 

% ----------------------------------------------

make_data :-                                                              /* 5 */
   number_of_actors(AS), number_of_objects(OO),
   NP is ceiling((1/2)*((AS*AS)-AS)),                                   /* 5.1 */
   make_pot_pairs(AS),                                                  /* 5.2 */
   asserta(list_of_pairs([])),
   asserta(list_of_triades([])),
   ( between(1,NP,N), generate_a_pair(N,NP,AS,OO), fail; true),!,       /* 5.3 */
   list_of_pairs(LIST1), list_of_triades(LIST_TR),
   append('data421.pl'), 
   write(stored(0,list_of_triades(LIST_TR))), write('.'), nl,nl,
   told,
   retract(list_of_pairs(LIST1)).

 /*  nth1(1,LIST_TR,TR), TR = [1,[A,B,Ob],[W1,W2,W3]], 
   nl, write(triade([1,[A,B,Ob],[W1,W2,W3]])),nl,
   write(A), write(','), write(B), write(' are the actors, ' ), 
   write(Ob), write(' the object' ), nl, write('and '), write(W1),
   write(','), write(W2), write(','), write(W3), 
   write(' are the marked relations'), nl,!. */

generate_a_pair(N,NP,AS,OO) :-                                          /* 5.3 */
  list_of_pairs(LIST1), list_pot_pairs(LIST2), length(LIST2,E2),
  S is random(E2)+1, nth1(S,LIST2,[A,B]),                               /* 5.4 */
  expand_to_a_triade([A,B],OO,N),                                       /* 5.5 */
  delete(LIST2,[A,B],LIST2new), retract(list_pot_pairs(LIST2)),        /* 5.10 */
  asserta(list_pot_pairs(LIST2new)),
  append(LIST1,[[A,B]],LIST1new),
  retract(list_of_pairs(LIST1)),
  asserta(list_of_pairs(LIST1new)),!.

expand_to_a_triade([A,B],OO,N) :-                                       /* 5.6 */
   Ob is random(OO)+1,                                                  /* 5.7 */
   Q1 is random(2)+1, Q2 is random(2)+1, Q3 is random(2)+1,             /* 5.8 */
   list_of_triades(LIST_TR), 
   (Q1 = 1 , W1 is 1 ; Q1 = 2, W1 is -1),
   (Q2 = 1 , W2 is 1 ; Q2 = 2, W2 is -1),
   (Q3 = 1 , W3 is 1 ; Q3 = 2, W3 is -1),
   TR = [N,[A,B,Ob],[W1,W2,W3]],                                        /* 5.9 */
   append(LIST_TR,[TR],LIST_TRnew), 
   retract(list_of_triades(LIST_TR)), 
   asserta(list_of_triades(LIST_TRnew)),!.


% -------------------------------------------------------  
% pred421

make_pot_pairs(AS) :-                                                   /* 5.2 */
  asserta(list_pot_pairs([])),
  ( between(1,AS,A), make1_pot_pair(A,AS), fail; true),!,
  list_pot_pairs(LIST),
  asserta(list_pot_pairs(LIST)),
  write(list_pot_pairs(LIST)).
  
make1_pot_pair(A,AS) :- AA is AS - A,
   ( between(1,AS,B), make2_pot_pair(A,B,AA), fail; true),!.

make2_pot_pair(A,B,AA) :- A < B, list_pot_pairs(LIST), 
   append(LIST,[[A,B]],LISTnew),
   retract(list_pot_pairs(LIST)), asserta(list_pot_pairs(LISTnew)),!. 



 

