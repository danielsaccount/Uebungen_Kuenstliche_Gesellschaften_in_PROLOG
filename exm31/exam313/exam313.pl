/* exam313 

Wir erzeugen ein System von Überzeugungen (beliefs) für einen einzigen 
Akteur A (A = 2) und für einen einzigen Tick (T = 5). 

Wir benutzen in 1 zwei Konstante, die erst in einem vollständigen Programm 
zur Entfaltung kommen. social(A,SOCIAL_CONSTANT) besagt, dass Akteur A
im Grad SOCIAL_CONSTANT (1 =< SOCIAL_CONSTANT =< 1) sozial eingestellt ist.
Im Beispiel ist hier A kaum sozial eingestellt ( SOCIAL_CONSTANT = 0.3). Die 
zweite Konstante INTELLIGENCE_CONSTANT (1 =< INTELLIGENCE_CONSTANT =< 1) drückt
aus, wie intelligent der Akteur A in Bezug auf die Entwicklung von 
Überzeugungen ist. 

Die Anzahl der Ticks (NUMBER_OF_TICK = 12), die Anzahl der 
Akteure (NUMBER_OF_ACTORS = 10) und die Anzahl der Ereignisse 
(NUMBER_OF_EVENTS = 10) wird festgelegt. 

Die Überzeugungen sind hier in drei Arten aufgeteilt:
Überzeugungen von Ereignissen, in denen a) kein Akteur, ober b) genau 
ein Akteur involviert ist, oder c) in denen genau zwei Akteur involviert
sind. In 2 und 4 haben wir eine "Einteilungsfunktion für Ereignisse"
erzeugt, die die "Ausprägungen" von Ereignisse zufällig und
diskret verteilt generieren. Die drei gerade beschriebenen Arten von 
Ereignissen haben wir nicht durch Wörter, sondern einfach durch die Zahlen
0,1,2 ausgedrückt. Der Term "Einteilungsfunktion für Ereignisse" wäre
in diesem Modul überflüssig. In einem vollständigen Programm werden aber
normalerweise verschiedene Funktionen zufällig erzeugt, die wir 
unterscheiden müssen. Auf Englisch könnten wir diese Funktion etwa als 
"random_function_for_kinds_of_events" bezeichnet, oder abgekürzt:
"rand_event" und als Variable: RAND_EVENT. 

In 3 werden diese Konstanten geholt und in 4 werden die Ausprägungen 
(ARITY, "Arten") eines Ereignisses Nummer N als Resultate 
als Fakten in die Datenbasis und an die Resultatdatei res313.pl geschickt.
Ein Fakt der Form fact(RAND_EVENT,N,ARITY) in Zeile 4.1 unten drückt aus, dass
ARITY der Wert für das Argument N der Funktion RAND_EVENT ist. Inhaltlich:
Ereignis Nr. N gehört bei der Funktion RAND_EVENT zur Art Nr. ARITY.
Z.B. fact(rand_event,4,2) bedeutet: Ereignis Nr. 4 gehört zur Art Nr. 2.
In 4 wird eine Schleife über die Anzahl NUMB der Ereignisse gelegt.
LIST ist die Liste aus 2 (LIST = [33,66,100]).

In 5 findet PROLOG eine Schleife über die Anzahl NUMB der Ereignisse
- relativ zum Akteur A und zum Tick T. VNMBE ist die Variable für den
Index der Ereignisse (VNMBE = VARIABLE_FOR_A_NUMBER_OF_EVENTS).
Der Fakt fact(rand_event,VNMBE,ARITY) in Zeile 5.1 wurde in 4 vorher erzeugt. 
In 5.2 wird make_beliefs(ARITY,VNMBE,T,A,INTELL_CONST,SOC_CONST) aufgerufen.
Je nach Ausprägung ARITY geht PROLOG zu den entsprechenden drei Klausen
6,7 oder 8.

Im ersten Fall in 6 wird der Term "make_belief1(...)" aufgerufen, in dem
es um Überzeugungen von Ereignissen ohne Bezug auf einen Akteur geht (z.B.
"die Sonne geht auf"). In 6.1 wird eine Zufallszahl Z1 aus dem Bereich 
von 0 bis 100 gezogen und durch 100 geteilt. Z ist dann eine 
Wahrscheinlichkeit; eine Zahl Z aus dem Bereich 0 bis 1. Die Konstante 
INTELL_CONST in 6.2 war im Kopf der Klause in 6 schon vorhanden. Die 
Wahrscheinlichkeit Z wird mit der Konstanten für den Akteur A verglichen. 
X =< Z bedeutet inhaltlich, dass die gezogene Wahrscheinlichkeit Z so 
groß ist, dass, im Vergleich zur Intelligenz des Akteurs A, eine Überzeugung 
gebildet werden kann. In diesen Fall wird in 6.4 diese neue Überzeugung
bel(T,A,1,W,ev(VNMBE)) als Fakt an die Resultatdatei res313.pl geschickt.
bel(T,A,1,W,ev(VNMBE)) bedeutet, dass zum Tick T der Akteur A die Überzeugung 
der Art Nr. 1 mit Wahrscheinlichkeit W hat und dass diese Überzeugung  
das Ereignis ev(VNMBE) betrifft. Hier wird ein "konkretes" Ereignis nur durch die 
Zahl VNMBE von anderen Ereignissen auseinander gehalten. In einer speziellen
Simulationsanwendung können wir natürlich auch das Prädikat "ev" durch ein
bedeutungsreicheres Wort ersetzen und den Term mit weiteren Argumente versehen. 
In 6.5 ist die Zufallszahl und die Wahrscheinlichkeit Z kleiner als die
Intelligenz (Z < X) von A. In diesem Fall wird keine Überzeugung gebildet.

Im zweiten Fall wird in 7.2 der Term make_belief2(...) bearbeitet. Hier
wird eine Schleife 7.2 über alle Akteure gelegt. Im Term make_belief_two(T,A,B,...) 
wird in jedem Schleifenschritt ein Akteur
B untersucht. In 7.4 und 7.10 wird wieder wie im Fall 1 (in 6) eine 
Unterscheidung zufällig getroffen. Der Akteur A bildet eine Überzeugung
oder nicht. Im positiven Fall geht es um die Überzeugung eines Ereignisses,
in dem ein Akteur B eine Rolle spielt. In 7.4 haben wir die Zufallszahl Y
nicht zwischen 0 und 100, sondern zwischen 0 und 1000 gezogen. In
dieser Weise müssen wird in 7.5 die Zahl Y durch 1000 dividieren, um eine 
Wahrscheinlichkeit W zu bekommen. In 7.5 und 7.6 haben wir eine weitere 
Unterscheidung getroffen. Einerseits wird in 7.5 für A eine Überzeugung 
über ein Ereignis gebildet, in dem A selbst involviert ist ( B = A ,
W is Y/1000 ). Andererseits geht es in 7.6 um ein Ereignis, in dem der
Akteur B nicht mit A übereinstimmt. D.h. A bildet eine Überzeugung für
ein Ereignis, in dem ein anderer Akteur B vorkommt. In 7.6 - 7.8 haben
wird die Zufallszahl Y weiter bearbeitet, um sie als eine Wahrscheinlichkeit
benutzen zu kommen. Zunächst haben wir in 7.6 Y um Eins erhöht. Ohne diese
Vorsichtsmaßnahme kann es im Ablauf zu einer Fehlermeldung kommen. Wenn
PROLOG Y gezogen hat, kann Y auch 0 sein. In diesem Fall wäre die
Zufallszahl Y2 durch "Y2 is random(Y)" nicht definiert. Dagegen gibt es bei
Y1 is Y + 1, Y2 is random(Y1) kein Problem. Die Zufallszahl Y2 benutzen wir,
um der Überzeugung eine Wahrscheinlichkeit zuzuordnen: W is Y5/1000.
In 7.9 wird diese Wahrscheinlichkeit W in die Überzeugung bel(T,A,2,W,ev(VNMBE,[B])) 
von A zu T der Art Nr.2 eingebaut. A glaubt zu T,
dass das Ereignis ev(VNMBE,[B]) der Art 2 mit Wahrscheinlichkeit W 
stattgefunden hat. Die Berechnungen in 7.6 - 7.8 könnten in einer Anwendung
durch einen inhaltlichen Prozess ersetzt werden. Z.B. kann das Ereignis
von A schon öfter wahrgenommen worden sein. 

Schließlich wird im dritten Fall in 8 eine Überzeugung für A gebildet,
die ein Ereignis über zwei Akteure betrifft. Die Erzeugung läuft ähnlich 
wie in Fall 2 ab. Sie wird aber in 8.3 durch eine weitere Schleife komplexer. 
Inhaltlich wird das kartesische Produkt aus den Mengen der Akteure
gebildet und aus dieser Menge jeweils ein Paar [B,C] von Akteuren zufällig 
gezogen. Dieses Paar wird in 8.4 in der Überzeugung bel(...) benutzt. 
Die Wahrscheinlichkeit W wurde durch verschiedene Vorsichtsmaßnahmen
zufällig erzeugt.

Im Ende haben wir die Programmierung eines kartesischen Produkts und die
Menge der Paare (von Akteuren) in auskommentierter Weise aufgeschrieben. 
Die Klausen 9 und 10 können in vielen anderen Anwendungen verwendet
werden. Wenn wir diese Klausen verwenden, können wird den Term 
make_belief3 in 8 einfacher formulieren.   

In der Resultatdatei sehen wir nach Ablauf die erzeugten Überzeugungen.
Auch die 3 Ausprägungen für die Funktion rand_event sind zu sehen.
Wir sehen auch, dass die "wirklichen" Ereignisse zu einer Überzeugungswelt 
aufgebläht werden. Die Zahl der Überzeugungen ist hier viel größer 
als die Zahl der Ereignisse. Interessant ist auch, wie die Anzahl der
Überzeugungen für die drei Arten verteilt werden. Die beiden Konstanten
social(2,0.3) und intelligence(2,0.4) sind hier entscheidend. Wir können
sie durch andere Zahlen ersetzen und schauen, wie sich die Resultate
verändern. All dies führt zu interessanten Fragen.
*/


number_of_ticks(12).
number_of_actors(10).
number_of_events(10).                                         /* 1 */
one_tick(5).
one_actor(2).
social(2,0.3).
intelligence(2,0.4).

list_of_exprs([1,2,3]). 
cumulative_frequencies_of(rand_event,[33,66,100]).            /* 2 */
list_of_exprs(rand_event,[1,2,3]).

social(2,0.3).
intelligence(2,0.4).


start :-
  (exists_file('res313.pl'), delete_file('res313.pl'); true),   
  one_tick(T), one_actor(A),
  number_of_events(NUMB),
  cumulative_frequencies_of(RAND_EVENT,LIST),                 /* 3 */
  make_function_dd(RAND_EVENT,LIST,NUMB),                     /* 4 */
  social(A,SOC_CONST),
  intelligence(A,INTELL_CONST),
  make_beliefs(T,A,NUMB),                                     /* 5 */
  retractall(fact(FUU,NNN,EEE)),!.

make_beliefs(T,A,NUMB) :-
  ( between(1,NUMB,VNMBE), 
       make_beliefs_for_one_event(VNMBE,T,A), fail            /* 5 */
  ; true).

make_beliefs_for_one_event(VNMBE,T,A) :-                      /* 5 */
  fact(rand_event,VNMBE,ARITY),                               /* 5.1 */
  intelligence(A,INTELL_CONST),
  social(A,SOC_CONST),
  make_beliefs(ARITY,VNMBE,T,A,INTELL_CONST,SOC_CONST),!.     /* 5.2 */


make_beliefs(ARITY,VNMBE,T,A,INTELL_CONST,SOC_CONST) :-       /* 6 */
  ARITY = 1, make_beliefs1(VNMBE,T,A,INTELL_CONST,SOC_CONST),!.

make_beliefs(ARITY,VNMBE,T,A,INTELL_CONST,SOC_CONST) :-       /* 7 */
  ARITY = 2, make_beliefs2(VNMBE,T,A,INTELL_CONST,SOC_CONST),!.

make_beliefs(ARITY,VNMBE,T,A,INTELL_CONST,SOC_CONST) :-       /* 8 */
  ARITY = 3, make_beliefs3(VNMBE,T,A,INTELL_CONST,SOC_CONST),!.

make_beliefs1(VNMBE,T,A,INTELL_CONST,SOC_CONST) :-            /* 6 */
  Z1 is random(101), Z is Z1/100,                             /* 6.1 */
  ( INTELL_CONST =< Z,                                        /* 6.2 */
    Y is random(1001), W is Y/1000,                           /* 6.3 */
    append('res313.pl'), write(fact(bel(T,A,1,W,ev(VNMBE)))), write('.'), nl,
    told                                                      /* 6.4 */
  ;
    Z < INTELL_CONST , true),!.                               /* 6.5 */

make_beliefs2(VNMBE,T,A,INTELL_CONST,SOC_CONST) :-            /* 7 */
  number_of_actors(AA),                                       /* 7.1 */
  ( between(1,AA,B), make_belief_two(T,A,B,VNMBE,INTELL_CONST,SOC_CONST),
   fail; true),!.                                             /* 7.2 */

make_belief_two(T,A,B,VNMBE,INTELL_CONST,SOC_CONST) :-        /* 7.2 */
   Z1 is random(101), Z is Z1/100,                            /* 7.3 */ 
    ( INTELL_CONST =< Z , Y is random(1001),                  /* 7.4 */
       ( B = A, W is Y/1000                                   /* 7.5 */
       ;
         \+ B = A, Y1 is Y + 1, Y2 is random(Y1) + 1,         /* 7.6 */
         Y3 is Y2/1000, Y4 is Y/1000,                         /* 7.7 */
         Y5 is Y3 * Y4, W is Y5/1000                          /* 7.8 */
       ),
    append('res313.pl'), write(fact(bel(T,A,2,W,ev(VNMBE,[B])))), 
    write('.'), nl, told                                      /* 7.9 */
  ;
    Z < INTELL_CONST , true),!.                               /* 7.10 */

make_beliefs3(VNMBE,T,A,INTELL_CONST,SOC_CONST) :-            /* 8 */
  number_of_actors(AA), findall(Z,between(1,AA,Z),AAL),       /* 8.1 */
  X1 is INTELL_CONST * ((AA * AA) - AA),                      /* 8.2 */
  NN is ceiling(SOC_CONST * X1),  
  ( between(1,AA,B), make_belief_three(T,A,B,VNMBE,AA,AAL,NN),
   fail; true),!.

make_belief_three(T,A,B,VNMBE,AA,AAL,NN) :-
  delete(AAL,B,AALnew), asserta(auxlist3(AALnew)),
  asserta(auxlist2([])),
  ( between(1,NN,N), make_belief(N,T,A,B,VNMBE,AA), fail      /* 8.3 */
  ;  
    true
  ),!,
  retract(auxlist2(CCC)), 
  retract(auxlist3(LLL)),!.

make_belief(N,T,A,B,VNMBE,AA) :-
  auxlist3(AAL1), length(AAL1,E),
  (   0 < E,
      U is random(E) + 1, nth1(U,AAL1,C), 
      auxlist2(L2), append(L2,[[B,C]],L2new),
      retract(auxlist2(L2)), asserta(auxlist2(L2new)),
      delete(AAL1,C,L1new),
      retract(auxlist3(AAL1)), asserta(auxlist3(L1new)),
      Z1 is random(101), Z is Z1/100, intelligence(A,INTELL_CONST),
      X is INTELL_CONST, 
      ( X =< Z , Y is random(1001), 
           ( B = A, W is Y/1000,!
           ;
             \+ B = A, Y1 is Y + 1, Y2 is random(Y1) + 1,
             Y3 is Y2/1000, Y4 is Y/1000,
             Y5 is Y3 * Y4, W is Y5/1000
           ),
        append('res313.pl'), write(fact(bel(T,A,3,W,ev(VNMBE,[B,C])))), 
        write('.'), nl, told                                 /* 8.4 */
      ;
        Z < X , true)
  ;
    true),!.
 
% 4) ----------------------------------

make_function_dd(RAND_EVENT,LIST,NUMB) :-                      /* 4  */
  ( between(1,NUMB,N),
    generate_one_dd_number(N,RAND_EVENT,LIST,NUMB), fail
  ;
    true
  ). 

generate_one_dd_number(N,RAND_EVENT,LIST,NUMB) :- 
  length(LIST,LENGTH),
  RANDOM is random(NUMB) + 1,
  Z is (RANDOM/NUMB) * 100,
  between(1,LENGTH,X_TH_POSIT_OF_LIST),
  nth1(X_TH_POSIT_OF_LIST,LIST,PERCCUMUL),
  Z =< PERCCUMUL, 
  list_of_exprs(RAND_EVENT,LIST_OF_ARITYS), 
  nth1(X_TH_POSIT_OF_LIST,LIST_OF_ARITYS,ARITY), 
  append('res313.pl'),         
  write(fact(RAND_EVENT,N,ARITY)), write('.'), nl, told,
  asserta(fact(RAND_EVENT,N,ARITY)),!.                          /* 4.1 */
                           
/* -----------------------------------------

actor_pairs(AA,LIST1) :-                                        /* 9 */
   asserta(auxlist11([])),
   ( between(1,AA,M), add_a_pair(M), fail; true),
   auxlist11(LIST1), retract(auxlist11(LIST1)),!.

add_a_pair(M) :- 
  auxlist11(LIST11), append(LIST11,[[M,M]],LIST11new), 
  retract(auxlist11(LIST11)), asserta(auxlist11(LIST11new)),!. 

cart(AAL,AAL,CART) :-                                           /* 10 */
  length(AAL,X),
  asserta(aux(LIST)),
  ( between(1,X,U), make_one(U,AAL,AAL), fail; true),
  aux(CART), retract(aux(CART)).

make_one(U,AAL,AAL) :- length(AAL,Y), 
  ( between(1,Y,V), make_pair(U,V,AAL,AAL), fail; true),!.
  
make_pair(U,V,AAL,AAL) :- aux(LIST), nth1(U,AAL,C1), nth1(V,AAL,C2),
   append(LIST,[[C1,C2]],LISTnew),
   retract(aux(LIST)), asserta(aux(LISTnew)),!.

----------------------------- */


  




  


  

