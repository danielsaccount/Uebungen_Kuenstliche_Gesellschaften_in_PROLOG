/* exam317 

Überzeugungen (beliefs) von Akteuren werden zu einem bestimmten Tick
berechnet. 

Dazu werden zunächst Ereignisse aus der Vergangenheit 
"erzeugt". Aus diesen können wir dann die relative Häufigkeit eines
Zufallsereignisses berechnen (siehe 2.3 in unserem Buch).

Wir legen in 1 Fakten fest, wobei wir den vierten Fakt hier nicht benutzen
werden. In 2 werden die Resultatdateien geleert und in 3 die Fakten aus
der Datenbasis geholt. In 4 werden Elementarereignisse zufällig erzeugt, die 
früher liegen als die Überzeugungen und über die es eigentlich geht. 
Nachdem diese Elementarereignisse in der Form von

    ev(ACTOR,RANDOM_EVENT,EVENT,TICK)

generiert sind und in Zeile 4.1 in die Datenbasis eingefügt wurden, haben wir diese 
Elementarereignisse an die Resultatdatei res3172.pl geschickt. In 4
wurde auch die Anzahl NUMBER_OF_ELEMENTARY_EVENTS der Elementarereignisse
berechnet. Diese Zahl kennen wir erst nach Beendigung der Schleife in 4. 
Inhaltlich gesprochen geht es um genau alle Ereignisse, die in diesem
simulierten System tatsächlich stattfinden. Aus diesen realen Ereignissen
werden nur einige davon in den Akteuren gespeichert und in der Entstehung
der Überzeugungen der Akteur benutzt.   

In 5 wird eine Schleife über die Akteure gelegt. In 6 haben wir aus den
Elementarereignissen relativ zu dem gegebenen Akteur ACTOR alle 
Zufallsereignisse RANDOM_EVENT zu einer Liste LIST_OF_TYPS1
zusammengefügt. In 7 haben wir mehrfaches Auftreten eliminiert und
die Länge der bereinigten Liste berechnet. Dies Liste haben wir in 8 in
einer Datei gespeichert. In derselben Weise erzeugen wir eine Liste der
Elementarereignisse für den ACTOR und die zugehörige Länge. Ganz genauso
machen wir dies für die Liste der Ticks, in denen für ACTOR etwas passierte.
In 11 und 12 holen wir die Konstanten und die drei Längen. In 13 wird für 
jede Länge LENGTH_I (I = 1,2,3) aus dem Bereich von 1 bis LENGTH_I eine 
Zufallszahl gezogen. In 14 bilden wir aus diesen drei Zahlen ihr Produkt
MAX. Die Zahl MAX ist inhaltlich die Anzahl der möglichen(!) Elementar-
ereignisse. Das kartesische Produkt der drei Listen von Akteuren, Ticks 
und Elementarereignissen bildet den Rahmen, aus dem alle Elementarereignisse
stammen. 

Im 15 legen wir eine Schleife über diese Anzahl MAX. In einem Schleifenschritt
werden aus den zur Verfügung stehenden Listen und Zahlen in Zeile 15.2 unten drei
Zufallszahlen gezogen und aus den entsprechenden Listen die Komponenten
RANDOM_EVENT,EVENT und TICK herausgepickt. Wenn diese in 15.3 in einem
Elementarereignis zu finden sind, wird dieses Ereignis im weiteren 
in Erwägung gezogen, d.h. zunächst in 15.4 der Datenbasis in der Form 

   pro_bel(ACTOR,RANDOM_EVENT,EVENT,TICK)                            (1) 

hinzugefügt. Am Ende von 15 sind viele Terme der Form (1) vorhanden. 

In 16 wird eine letzte Schleife über die Länge LENGTH1 der Zufallsereignisse 
gelegt. In 16.1 geschieht in einem Schleifenschritt Nr. Y folgendes. Aus
der Liste LIST_OF_TYPS in 16.1 wird in 16.2 das Y-te Zufallsereignis 
RANDOM_EVENT herausgepickt. In 16.3 werden alle Paare bestehend aus TICK
und EVENT in den Termen pro_bel(ACTOR,RANDOM_EVENT,EVENT,TICK) gesammelt:
LIST = [[TICK1,EVENT1],[TICK2,EVENT2],...]. In 16.5 wird diese Liste 
sortiert mit Resultat LIST1. LIST1 wird als "Geschichte" des Akteurs ACTOR 
in der Form bel_hist(ACTOR,RANDOM_EVENT,[[TICK1,EVENT1],[TICK2,EVENT2],...]) 
in die Resultatdatei res3171.pl geschickt. Dieser Term beinhaltet alle 
Elementarereignisse EVENT1,EVENT2,... des Typs RANDOM_EVENT (siehe 2.3 in 
unserem Buch), die ACTOR zu den Ticks TICK1,TICK2,... wahrgenommen und 
gespeichert hat. In 16.9 wird die Länge LENGTH11 der Liste LIST1 berechnet.
Die Anzahl NUMBER_OF_ELEMENTARY_EVENTS aller Elementarereignisse wurde in 
16.1 schon bereitgestellt. In 16.11 wird der Bruch

    W is LENGTH11 / NUMBER_OF_ELEMENTARY_EVENTS

berechnet. Inhaltlich ist W das Verhältnis zwischen der Zahl der Ereignisse, 
die alle denselben Handlungstyp RANDOM_EVENT haben, die der Akteur ACTOR 
"früher" wahrgenommen und gespeichert hat, und der Zahl aller in dem System 
wirklich stattfindenden Ereignisse. D.h. die Zahl der Elementarereignisse des 
Typs RANDOM_EVENT ist die absolute Häufigkeit dieses Handlungstyps, relativ 
zu dem Akteur ACTOR. Der Bruch W ist approximativ mit der subjektiven 
Wahrscheinlichkeit des Typs RANDOM_EVENT für ACTOR identisch (siehe 2.3 in 
unserem Buch). In 16.2 haben wir die Überzeugung 
   
    bel(TT,ACTOR,W,RANDOM_EVENT)

an die Resultatdatei res3173.pl geschickt. Dazu haben wir 16.10 den letzten 
Tick TT benutzt, welcher in der Datenbasis verhanden ist. Das heißt, die
hier erzeugten Überzeugungen sind dazu vorgesehen, in einem hier nicht 
formulierten, vollständigen Programm zum "richtigen" Zeitpunkt eingesetzt
zu werden. Die Überzeugungen werden in der Schleife in 16 für alle 
Handlungstypen (RANDOM_EVENT), relativ zu dem jeweiligen Akteur, erzeugt.
*/


number_of_ticks(100).
number_of_actors(2).
number_of_random_events(10).
intelligence(1,1,1).                                                /* 1 */

% -----------------------------------------------

start :- 
  (exists_file('res3171.pl'), delete_file('res3171.pl'); true), 
  (exists_file('res3172.pl'), delete_file('res3172.pl'); true),  
  (exists_file('res3173.pl'), delete_file('res3173.pl'); true), 
  (exists_file('res3174.pl'), delete_file('res3174.pl'); true),          /* 2 */
  number_of_ticks(NUMBER_OF_TICKS), 
  number_of_actors(NUMBER_OF_ACTORS),
  number_of_random_events(NUMBER_OF_TYPS),                               /* 3 */
  make_events(NUMBER_OF_TICKS,NUMBER_OF_ACTORS,NUMBER_OF_TYPS,
      NUMBER_OF_ELEMENTARY_EVENTS),                                      /* 4 */
  ( between(1,NUMBER_OF_ACTORS,ACTOR), 
     make_eventlist_for(ACTOR,NUMBER_OF_ELEMENTARY_EVENTS),              /* 5 */
     fail; true ),
  retractall(ev(AAA,EEE,NNN,TTT)),!.

make_eventlist_for(ACTOR,NUMBER_OF_ELEMENTARY_EVENTS) :-
  findall(RANDOM_EVENT,ev(ACTOR,RANDOM_EVENT,EVENT,TICK),LIST_OF_TYPS1), /* 6 */
  sort(LIST_OF_TYPS1,LIST_OF_TYPS), length(LIST_OF_TYPS,LENGTH1),        /* 7 */
  asserta(list_of_typs_for(ACTOR,LIST_OF_TYPS)),                         /* 8 */
  findall(EVENT,ev(ACTOR,RANDOM_EVENTE,EVENT,TICK),LIST_OF_EVENTS1), 
  sort(LIST_OF_EVENTS1,LIST_OF_EVENTS), 
  length(LIST_OF_EVENTS,LENGTH2), 
  asserta(list_of_events_for(ACTOR,LIST_OF_EVENTS)),                     /* 9 */
  findall(TICK,ev(ACTOR,RANDOM_EVENT,EVENT,TICK),LIST_OF_TICKS1), 
  sort(LIST_OF_TICKS1,LIST_OF_TICKS), 
  length(LIST_OF_TICKS,LENGTH3), 
  asserta(ticks_for(ACTOR,LIST_OF_TICKS)),                               /* 10 */
  intelligence(EC,NC,TC), Y1 is ceiling(EC * LENGTH1),                   /* 11 */
  Y2 is ceiling(NC * LENGTH2), Y3 is ceiling(TC * LENGTH3),              /* 12 */
  X1 is random(Y1) + 1, X2 is random(Y2) + 1, X3 is random(Y3) + 1,      /* 13 */
  MAX is X1 * X2 * X3,                                                   /* 14 */
  append('res3173.pl'), write(number_of_events_perceived_by(ACTOR,MAX)), 
     write('.'), nl, nl,told, 
  ( between(1,MAX,X),
     add_one_event(X,ACTOR,LENGTH1,LENGTH2,LENGTH3,LIST_OF_TICKS,LIST_OF_TYPS,
     LIST_OF_EVENTS), fail; true  ),!,                                   /* 15 */
  ( between(1,LENGTH1,Y),
       collect_items(Y,ACTOR,NUMBER_OF_ELEMENTARY_EVENTS,LIST_OF_TYPS), 
       fail; true  ),!.                                                  /* 16 */

collect_items(Y,ACTOR,NUMBER_OF_ELEMENTARY_EVENTS,LIST_OF_TYPS) :-     /* 16.1 */
  nth1(Y,LIST_OF_TYPS,RANDOM_EVENT),                                   /* 16.2 */
  findall([TICK,EVENT],pro_bel(ACTOR,RANDOM_EVENT,EVENT,TICK),LIST),   /* 16.3 */
  append('res3174.pl'), write(list_of_events_at_tick(LIST)), write('.'), 
     nl, told,                                                         /* 16.4 */
  sort(LIST,LIST1),                                                    /* 16.5 */
  asserta(bel_hist(ACTOR,RANDOM_EVENT,LIST1)),                         /* 16.6 */
  append('res3171.pl'), write(bel_hist(ACTOR,RANDOM_EVENT,LIST1)),     /* 16.7 */ 
     write('.'), nl, nl, told,                                         /* 16.8 */
  length(LIST1,LENGTH11),                                              /* 16.9 */
  W is LENGTH11 / NUMBER_OF_ELEMENTARY_EVENTS,                        /* 16.10 */ 
  number_of_ticks(TT),                                                /* 16.11 */
  append('res3173.pl'), write(bel(TT,ACTOR,W,RANDOM_EVENT)),
  write('.'), nl, told,!.                                             /* 16.12 */

add_one_event(X,ACTOR,LENGTH1,LENGTH2,LENGTH3,LIST_OF_TICKS,          
  LIST_OF_TYPS, LIST_OF_EVENTS) :-                                     /* 15.1 */ 
  Z1 is random(LENGTH1) + 1, nth1(Z1,LIST_OF_TYPS,RANDOM_EVENT),
  Z2 is random(LENGTH2) + 1, nth1(Z2,LIST_OF_EVENTS,EVENT),
  Z3 is random(LENGTH3) + 1, nth1(Z3,LIST_OF_TICKS,TICK),              /* 15.2 */
  ev(ACTOR,RANDOM_EVENT,EVENT,TICK),                                   /* 15.3 */
  asserta(pro_bel(ACTOR,RANDOM_EVENT,EVENT,TICK)),!.                   /* 15.4 */
  
% -----------------------------------------------

make_events(NUMBER_OF_TICKS,NUMBER_OF_ACTORS,NUMBER_OF_TYPS,
  NUMBER_OF_ELEMENTARY_EVENTS) :- 
  asserta(counter(0)),
  POT_EVENTS is NUMBER_OF_TICKS * NUMBER_OF_TYPS * NUMBER_OF_ACTORS,
  ( between(1,NUMBER_OF_ACTORS,ACTOR), 
    make_events_for(ACTOR,NUMBER_OF_TYPS,NUMBER_OF_TICKS,POT_EVENTS),
    fail; true ),
  counter(NUMBER_OF_ELEMENTARY_EVENTS),
  retract(counter(NUMBER_OF_ELEMENTARY_EVENTS)),!.

make_events_for(ACTOR,NUMBER_OF_TYPS,NUMBER_OF_TICKS,POT_EVENTS) :-
  ( between(1,NUMBER_OF_TICKS,TICK), 
     make_eventlist_in_time(TICK,ACTOR,NUMBER_OF_TYPS,POT_EVENTS), fail
  ;            
     true  
  ), !.

make_eventlist_in_time(TICK,ACTOR,NUMBER_OF_TYPS,POT_EVENTS) :- 
  findall(U,between(1,POT_EVENTS,U),LIST), asserta(aux_list_events(LIST)),
  NPE is random(NUMBER_OF_TYPS) + 1,  
  ( between(1,NPE,XE), make_eventlist_for(XE,NUMBER_OF_TYPS,TICK,ACTOR), 
    fail; true  ),!.

make_eventlist_for(XE,NUMBER_OF_TYPS,TICK,ACTOR) :- 
  aux_list_events(LIST1),
  length(LIST1,E1), Z is random(E1) + 1, nth1(Z,LIST1,EVENT),
  delete(LIST1,EVENT,LIST2), 
  retract(aux_list_events(LIST1)), asserta(aux_list_events(LIST2)),
  RANDOM_EVENT is random(NUMBER_OF_TYPS) + 1, 
  asserta(ev(ACTOR,RANDOM_EVENT,EVENT,TICK)),                       /* 4.1 */
  append('res3172.pl'), write(ev(ACTOR,RANDOM_EVENT,EVENT,TICK)),   /* 4.2 */
  write('.'), nl, told,
  counter(NUMBER), NUMBERnew is NUMBER + 1,
  retract(counter(NUMBER)), asserta(counter(NUMBERnew)),!.




