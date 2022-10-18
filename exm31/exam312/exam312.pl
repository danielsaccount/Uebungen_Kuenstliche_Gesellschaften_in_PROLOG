/* exam312  

F�r jeden Akteur A wird eine Liste von Listen von Ereignissen 
LIST = [LIST_1,...LIST_I,...,LIST_N] erzeugt, die wir so notieren:

   event_hist(A,LIST). 

Der Index I = 1,...,N wird f�r Ereignistypen gebraucht. Eine Liste 
LIST_I enth�lt nur Ereignisse des Typs I, die zu verschiedenen
Ticks ablaufen. Z.B.: 

   LIST_2 = [ev(2,2),ev(2,3),ev(2,5),ev(2,6),ev(2,7)...], 

oder in allgemeiner Notation:

   LIST_I = [ev(I,J_1),...,ev(I,J_M)].

In dieser Form werden zuerst in einer Schleife die Ereignistypen
durchlaufen und erst dann die Ticks. Der Sinn dieser Ordnung wird in
Anwendungen ersichtlich, in denen es um Wahrscheinlichkeiten geht. Aus 
einer Liste LIST_I von Ereignissen k�nnen wir direkt erkennen, wieviele 
solche Ereignisse ein Akteur in seinem Leben erlebt und auch gespeichert hat.
Diese Anzahl, n�mlich die absolute H�ufigkeit des Ereignistyps Nr. I (siehe
2.3 im Buch), f�hrt ohne Umwege zur subjektiven Wahrscheinlichkeit des
Akteurs.

Wenn die Wahrscheinlichkeiten in einer Anwendung keine Rolle
spielen, k�nnen wir die in exam311 beschriebene Ordnung: 
 
   erst Ticks -- dann Ereignistypen 

benutzen. 
  
In 1 - 4 werden die benutzten Fakten bereitgestellt. Die
Konstante intelligence(0.3) dr�ckt aus, wieviele Ereignisse in der 
programmierten Zeitperiode f�r die Akteure A �berhaupt intern gespeichert
werden k�nnen. Dies wird hier durch eine Wahrscheinlichkeit 0.3 ausgedr�ckt.
0.3 bedeutet also, dass h�chstens 70 Prozent (70 = 100 - 0.3*100) der Ticks 
in einem Ablauf f�r einen Akteur gespeichert werden k�nnen.

In 5 wird die Resultatdatei res321.pl geleert und in 6 werden die Fakten
von 1 - 3 geholt. In 8 wird eine erste Schleife �ber die Akteure
gelegt.

In 9 wird die Anzahl TT der Ticks mit Hilfe der Konstanten IC etwas
verkleinert. Die entstehende nat�rliche Zahl PTS dr�ckt eine gerade
erkl�rte Prozentzahl aus. In 10 wird eine Zufallszahl
RAN1 aus dem Bereich von 1 bis PTS gezogen und in 11 etwas erh�ht. 
In 12 wird diese Zahl f�r jeden Akteur A der Datenbasis hinzugef�gt.
Diese Zahl wird in 13 auch an die Resultatdatei res321.pl geschickt.   

In 14 werden zwei Hilfslisten "list_of_lists1" und "list_of_lists2" eingerichtet, 
die in der Schleife in 15 benutzt werden. In 16 und 17 werden
diese Hilfslisten wieder gel�scht. Die Schleife in 15 l�uft �ber die Anzahl
der Ereignistypen NET. Die Indizes ET benutzen wir hier gleichzeitig auch als
"Namen" von Ereignisse.  

In 21 werden die Ticks zu einer Hilfsliste TICKLIST zusammengef�gt und
in 22 der Dateibasis hinzugef�gt. In 23 wird eine weitere Hilfsliste 
"aux_list" f�r die n�chste Schleife in 24 eingerichtet, die in 25 auch 
wieder gel�scht wird. Diese Liste ist am Anfang leer; sie wird in der
Schleife in 24 mit den Ticks gef�llt, die in dieser Schleife bearbeitet
werden. In dieser Schleife werden in 24 nur Ticks TICK im Bereich von 1 bis 
NTS bearbeitet. Die Hilfsliste "aux_ticks" enth�lt am Anfang in 22
alle Ticks. In 24 wird dann jeweils ein Tick aus dieser Liste bearbeitet
und in 40 auch aus dieser Liste gel�scht.

In einem Schleifenschritt in 33 geschieht folgendes. In 34 wird die 
Hilfsliste "aux_ticks" der noch zur Verf�gung stehenden Ticks geholt und
die L�nge ETL dieser Liste bestimmt. In 35 wird eine Zufallszahl aus dem
Bereich von 1 bis ETL gezogen und die entsprechende Komponente TI aus 
TLIST herausgepickt. In 37 wird die Hilfsliste "aux_list" von schon
bearbeiteten Ticks geholt, in 38 der in 36 gefundene Tick TI
an die Liste LIST angeklebt und in 39 wird die Liste "aux_list" upgedatet.
In 40 wird der Tick TI aus der Hilfsliste "aux_ticks" entfernt und
in 41 upgedatet. 

Wenn die Schleife in 24 bearbeitet ist, holt PROLOG in 25 die Hilfsliste
LIST, sortiert diese in eine neue Liste LIST1 und l�scht die alte Liste LIST.
In 26 wird die Liste LIST1 vervollst�ndigt. LIST1 besteht nur aus Zahlen.
In 42 wird f�r jede Zahl K aus der Liste LIST1 und f�r die Zahl N
(ein Ereignistyp ET) ein Term in die Datenbasis eingef�gt, die f�r
Leser besser zu verstehen ist. Aus LIST1 wird in 26 eine Liste LISTP
solcher Terme.

In 27 werden die Hilfslisten GLIST und GLISTP geholt. In 28 wird an die 
Liste GLIST die Liste LIST1 angeklebt und in 29 die Hilfsliste "list_of_lists1" 
upgedatet. Genauso wird in 30 an die Liste GLISTP
die Liste LISTP geklebt und in 31 upgedatet. In 32 wird auch die
Hilfsliste "aux_ticks" gel�scht.

Am Ende der Schleife in 15  werden in 16 und 17 die nun vollst�ndigen
Hilfslisten "list_of_lists1" und "list_of_lists2" geholt und gel�scht.
Die Variablen LLETT und LLR sind in der Klause 8 noch aktiv. Sie
k�nnen also in 18 und 19 noch benutzt werden. In 18 werden die Listen  
der Ticks f�r jeden Akteur an die Resultatdatei geschickt und in
19 die besser lesbaren Listen von Termen, die denselben Inhalt haben. 
Ein Term hist(2, [[1,..],[2,..],[3,..]]) beschreibt die Geschichte des
Akteurs 2. Jede Liste [ET,..] enth�lt den Ereignistyp ET und eine Reihe
von Zahlen, die Ticks angeben, zu denen der Akteur in einem Ereignis 
dieses Typs involviert war. Ein Term event_hist(2, [[ev(3, 2), ev(3, 4),
...]] hebt zus�tzlich den jeweiligen Ereignistyp hervor, hier z.B. 3 
( = ET). 

----------------------------------------------------------  

Wir haben die meisten Variablen abgek�rzt, um den Programmfluss besser
lesen zu k�nnen.

TT = NUMBER_OF_TICKS
AA = NUMBER_OF_ACTORS
A = ACTOR
NET = (N)UMBER_OF_(E)VENT(T)YPS
IC = INTELLIGENCE_CONSTANT
RAN1 = RANDOM_NUMBER_NR1
PTS = (P)ERCENT_OF_(T)ICKS_(S)TORED
LLETT = (L)IST_OF_(L)ISTS_OF_(E)VENTS_FOR_(T)YPS_AND_(T)ICKS
LLR = LISTS_READABLE
NTS = NUMBER_OF_TICKS_STORED
ET = EVENT_TYP
*/

number_of_ticks(60).                                                   /* 1 */
number_of_actors(2).                                                   /* 2 */
number_of_eventtyps(3).                                                /* 3 */
intelligence(0.3).                                                     /* 4 */

start :-
  (exists_file('res312.pl'), delete_file('res312.pl'); true),          /* 5 */ 
  number_of_ticks(TT), number_of_actors(AA), number_of_eventtyps(NET), /* 6 */
  intelligence(IC),                                                    /* 7 */ 
  ( between(1,AA,A), make_eventlist_for(A,TT,NET,IC,LLETT), fail;     
    true),!.                                                           /* 8 */

make_eventlist_for(A,TT,NET,IC,LLETT) :- 
  PTS is TT - ceiling(IC * TT),                                        /* 9 */
  RAN1 is random(PTS) + 1,                                             /* 10 */
  NTS is RAN1 + ceiling(IC * TT),                                      /* 11 */  
  asserta(number_of_items_stored_for_(A,NTS)),                         /* 12 */
  append('res312.pl'), write(number_of_ticks_for(A,NTS)),
     write('.'), nl, told,                                             /* 13 */
  asserta(list_of_lists1([])), asserta(list_of_lists2([])),            /* 14 */
  ( between(1,NET,ET), make_event_list(ET,TT,NTS), fail; true),!,      /* 15 */
% trace,
  list_of_lists1(LLETT), retract(list_of_lists1(LLETT)),               /* 16 */
  list_of_lists2(LLR), retract(list_of_lists2(LLR)),                   /* 17 */
  append('res312.pl'), write(hist(A,LLETT)), write('.'), nl, nl,       /* 18 */ 
  write(event_hist(A,LLR)), write('.'), nl, nl, told,!.                /* 19 */

make_event_list(ET,TT,NTS) :-                                          /* 20 */
  findall(TICKS,between(1,TT,TICKS),TICKLIST),                         /* 21 */
  asserta(aux_ticks(TICKLIST)),                                        /* 22 */
  asserta(aux_list([])),                                               /* 23 */
  ( between(1,NTS,TICK), add_one_eventtick(TICK,ET,TT), fail; true),!,      
                                                                       /* 24 */
  aux_list(LIST), sort(LIST,LIST1), retract(aux_list(LIST)),           /* 25 */ 
% trace,
  complete(LIST1,ET,LISTP),                                            /* 26 */
  list_of_lists1(GLIST), list_of_lists2(GLISTP),                       /* 27 */
  append(GLIST,[LIST1],GLISTnew), retract(list_of_lists1(GLIST)),      /* 28 */
  asserta(list_of_lists1(GLISTnew)),                                   /* 29 */
  append(GLISTP,[LISTP],GLISTPnew), retract(list_of_lists2(GLISTP)),   /* 30 */
  asserta(list_of_lists2(GLISTPnew)),                                  /* 31 */
  retract(aux_ticks(TTT)),!.                                           /* 32 */

add_one_eventtick(TICK,ET,TT) :-                                       /* 33 */
  aux_ticks(TLIST), length(TLIST,ETL),                                 /* 34 */
  RAN2 is random(ETL) + 1,                                             /* 35 */
  nth1(RAN2,TLIST,TI),                                                 /* 36 */
  aux_list(LIST),                                                      /* 37 */
  append(LIST,[TI],LISTnew),                                           /* 38 */
  retract(aux_list(LIST)), asserta(aux_list(LISTnew)),                 /* 39 */
  delete(TLIST,TI,TLISTnew),                                           /* 40 */
  retract(aux_ticks(TLIST)), asserta(aux_ticks(TLISTnew)),!.           /* 41 */

% --------------------------

complete(L,N,LL) :-                                                    /* 42 */
  asserta(aux([])),                                                    /* 43 */
  length(L,E),                                                         /* 44 */
  ( between(1,E,X), nth1(X,L,K), complete(K,N), fail; true),           /* 45 */
  aux(LL), retract(aux(LL)),!.                                         /* 46 */

complete(K,N) :-                                                       /* 47 */
  aux(L1), append(L1,[ev(N,K)],L2), retract(aux(L1)),                  /* 48 */
   asserta(aux(L2)),!.                                                 /* 49 */