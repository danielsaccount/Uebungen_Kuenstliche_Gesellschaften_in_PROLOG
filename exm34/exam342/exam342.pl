/* exam342

Zwei Akteure werden durch zwei Threads actor1 und actor2 bearbeitet.  
Ein dritter Thread, den wir "main_actor" nennen, nimmt ständig die 
Informationen auf, die von den Akteuren geschickt werden.

Der erste Akteur, actor1, ist ein Unternehmen des produzierenden 
Gewerbes, der eine bestimmte Anzahl von Produktionsstätte 
(NUMBER_OF_PLACES) unterhält. Der zweite Akteur, actor2, ist eine
Armeeeinheit, z.B. ein Bataillon, die aus einer bestimmten Anzahl 
NUMBER_OF_GROUPS von Gruppen besteht (z.B. Kompanien). Es geht also um
folgende Anzahlen

   NUMBER_OF_ACTORS = 2
   NUMBER_OF_PLACES = 4
   NUMBER_OF_GROUPS = 5. 
 
Beim Start wird von diesen drei Zahlen eine Anzahl von "Unterticks", 
festgelegt. Zu jedem Tick gibt es eine bestimmte Anzahl 
NUMBER_OF_ITEMS von Unterticks. Diese Unterticks verwenden wir so, dass 
die beiden Akteure abwechselnd aktiv werden. Zum Untertick 1 tut actor1 
etwas, zum Untertick 2 tut actor2 etwas, zum Untertick 3 tut actor1 etwas, 
zum Untertick 4 tut actor2 etwas, und so weiter. Mathematisch wird die 
Anzahl der Unterticks modular in zwei Untermengen aufgeteilt. Für actor1 
werden die Unterticks 1,3,5,7,... benutzt und für actor2 die Unterticks 
2,4,6,8,... Dazu werden in 10 die Gesamtzahl NUMBER_OF_ITEMS der Unterticks 
berechnet: 
  NUMBER_OF_ITEMS is 
     (NUMBER_OF_PLACES + NUMBER_OF_GROUPS) * NUMBER_OF_ACTORS.
Aus der Liste der Zahlen 1,...,NUMBER_OF_ITEMS lässt sich für jeden 
Akteur, für jede Produktionsstätte, für jede Kampfgruppe und für jeden Tick 
genau einen entsprechenden Untertick zuordnen.

Die Gesamtzahl NUMBER_OF_ITEMS der Unterticks wird in 11 in die Datenbasis 
eingetragen. In 12 wird die Anzahl der "echten" Ticks um Eins erhöht. Dies 
dient der Schleifenkonstruktion in 15 - 19, um die Schleife richtig zu 
beenden. In 13 und 14 wird aus dieser Zahl die Liste der Ticks erzeugt und 
in die Datenbasis eingefügt. In 15 beginnt eine Schleife über die Ticks mit 
"repeat", welche durch ein nicht leicht zu verstehendes Abbruchkriterium 
wieder beendet wird. X in 16 bedeutet die X-te Stelle in der Liste der Ticks. 
In 16 wird die X-te Komponente TICK aus der Liste genommen und in der Klause 
in 17 bearbeitet. Wenn dieser TICK bearbeitet wurde, kommt PROLOG in 18 zu 
einer Ungleichung. In der Liste LIST_OF_TICKS = [1,...TICK,...,TTplus] ist
an der X-ten Stelle die Komponente TICK zu finden. Damit sind X und TICK 
(als Zahlen) identisch: 

   nth1(X,LIST_OF_TICKS,TICK), TICK = X.

Die Ungleichung TICK < X in 18 ist also falsch. PROLOG kommt zu 16 
zurück und nimmt die nächste Instanz für die Variable X. Dies geht so 
lange gut, bis PROLOG zur letzten Komponente der Liste kommt. In 18 ist 
zum letzten Mal die Ungleichung falsch. PROLOG kann an dieser Stelle nicht 
mehr nach oben zu 16 gehen, weil alle Möglichkeiten für die Variable X
ausgeschöpft wurden; alle Stellen der Liste wurden untersucht. In diesem 
Fall kommt PROLOG zu 19. Damit kommt diese Schleife zu einem Ende.

In 17 werden rein technische Schritte ausgeführt. In 17.1 - 17.3 werden
drei Threads eingerichtet. Der erste Thread bekommt das Prädikat
"main_actor", der zweite das Prädikat "actor1" und der dritte das Prädikat
"actor2". In 17.4 - 17.6 werden diese drei Threads am Ende auch wieder gelöscht. 
Der main_actor wird erst dann gelöscht, wenn die anderen, "normalen" Akteure 
beendet wurden. 

In 17.1 -17.3 bekommen die Prädikate der drei Threads weitere Argumente. 

  thread_create(main_actor(TICK),Id1,[]),                         17.1 
  thread_create(actor1(Id1,TICK),Id2,[]),                         17.2 
  thread_create(actor2(Id1,TICK),Id3,[]),                         17.3

Der Thread Nr.1, "main_actor", hat immer den TICK parat. Thread Nr.2,
"actor1", hält immer Id1 und TICK bereit, Thread Nr.3, "actor2", hält immer 
Id1 und TICK bereit. Diese etwas verwirrenden Identifikationsnummern Id1, 
Id2, Id3 für diese drei Threads vergibt PROLOG automatisch. Im Beispiel 
ist Id1 = 2, Id2 = 3 und Id3 = 4. Die Zahl 1 ist in PROLOG als eine 
Identifikationsnummer immer für das "Hauptprogramm" reserviert (siehe
Abschnitt 3.4 unseres Buches).
  
In 17.2 wird der Kopf für die Klause in 17.2 unten zusätzlich mit zwei 
Argumenten versehen: actor1(Id1,TICK). Dabei ist Id1 die Threadnummer des 
main_actors (hier Id1 = 2). Diese Informationen wird im Thread 
des Akteurs "actor1" in 17.2.15 und 17.2.16 auch benutzt. Dort wird ein 
Inel an den main_actor Id1 geschickt. In 17.2.1 wird die Identifikationsnummer
für den ersten, "normalen" Akteur "actor1" ermittelt. Der Thread für diesen 
Akteur bekommt durch PROLOG automatisch die Zahl Id2 zugeordnet, hier Id2 = 3 
(siehe Abschnitt 3.4 unseres Buches). 

In 17.7 - 17.12 werden die Resultate aufgesammelt, die der main_actor 
von den normalen Akteuren bekommen, und die er in die Dateibasis eingefügt
hatte. In 17.7 werden nur Inels der Form

   message_from_to(TICK,ACTOR1,Id1,P,PRODUCTION_VALUE)
   inel_from_to(TICK,ACTOR1,Id1,P,PRODUCTION_VALUE)

gesammelt, in denen es um Nachrichten geht, die der Akteur ACTOR1 an den 
main_actor Id1 schickt. Um die Resultate besser lesen zu können, haben wir
den ersten, "normalen" Akteur mit der Zahl 1 benannt: ACTOR1 is Id2 - 2, 
Id2 = 3, ACTOR1 = 1. PRODUCTION_VALUE ist die (Größe der) Menge, die ACTOR1 
an der Produktionsstätte P produziert. P ist in 17.7 eine Variable für die
modularisierten Produktionsstätten, d.h. für die Stätten, an denen der 
actor1 aktiv ist. Diese Resultate werden als Listen gesammelt und an die 
Resultatdatei res3422.pl geschickt. Weiter werden diese Werte addiert und 
auch die Gesamtsumme an res3422.pl geschickt. D.h. die Gesamtmenge der 
Warenart aus den verschiedenen Produktionsstätten wird bestimmt. 

In derselben Weise wird in 17.10 für den zweiten, "normalen" Akteur "actor2" 
verfahren. In 17.3.14 und in 17.3.15 wird eine Nachricht von ACTOR2 zu Id1 
geschickt

     message_from_to(TICK,ACTOR2,Id1,S,FALLEN),
     inel_from_to(TICK,ACTOR2,Id1,S,FALLEN),

wobei S eine modularisierte Variable für die Kampfgruppen und FALLEN die 
Zahl der in der Gruppe gefallenen Kämpfer ausdrückt.

Damit ist das Gesamtprogramm bearbeitet. Wir wenden uns nun zu den drei
Threads, die durch die Klausen 17.1, 17.2 und 17.3 beschrieben sind. In 17.1
wird der Nachrichtenvermittler, "main_actor", programmiert. In 17.1 wird
in 17.1.1 die Identifikationsnummer des Threads geholt (hier Id = 2).
Die auskommentierte Zeile 17.1.2 kann verwendet werden, um in einem 
Ablauf den Thread Nr.1 im trace-Modus anzuschauen. In dem so geöffneten 
trace-Fenster sehen wir aber nur Sachen, die diesen Thread betreffen. In 17.1.3 
wird die Gesamtzahl der Dinge aus der Datenbasis geholt (siehe 11). In 17.1.4
wird ein Hilfszähler "item" eingerichtet und auf 1 gesetzt. In 17.1.5 -
17.1.12 wird eine Schleife über alle Dinge von 1 bis NUMBER_OF_ITEMS
gelegt. Die technische Konstruktion haben wir schon erörtert. In 17.1.7
wird der PROLOG Befehl "thread_get_message" aufgerufen. Der main_actor
wartet auf eine Nachricht. Hier entsteht bei der Threadstruktur ein 
Problem, wenn der Akteur "main_actor" keine Nachricht findet. Die Schleife
in 17.1.5 - 17.1.12 hat nichts(!) mit den Ticks zu tun. Diese Schleife 
läuft in PROLOG ständig rasend schnell ab. Wenn main_actor keine
Nachricht findet, gibt es beim Programmieren zwei Möglichkeiten. Erstens
wird gewartet. In diesem Fall wird PROLOG nach einiger Zeit eine
Fehlermeldung ausgeben. Ohne Nachricht, kommt PROLOG ím Programm nicht
weiter. Als zweite Möglichkeit können wir eine Oder-Verbindung 
programmieren, bei der nach einer bestimmten, festgelegten Zeit, PROLOG
zu einer anderen Klause springt. In unserem Beispiel haben wir das
Programm "absichtlich" so formuliert, dass der main_actor immer eine
Nachricht nachricht(NACHRICHT) findet. In 17.1.8 wird diese Nachricht
sofort an die Resultatdatei res3422.pl geschickt. Mehr tut der main-actor
in diesem Programm nicht.

In 17.2 wird der Thread Nr.2 bearbeitet; der den Akteur Nr.1 betrifft.
In 17.2.1 wird die Identifikationsnummer Id2 des Threads bestimmt und
diese Information direkt ausgegeben. Dies ist am Anfang sinnvoll, um die
Idéntifikationsnummern zu unterscheiden. In der auskommentierten Zeile 
17.2.2 können wir diesen Thread im trace-Modus laufen lassen. In dem betreffenden 
trace-Fenster sehen wir aber nur Sachen, die diesen Thread betreffen. In
17.2.3 haben wir den ersten, "normalen" Akteur mit der Zahl 1 gekennzeichnet: 
ACTOR1 is Id2 - 2, Id2 = 3, ACTOR1 = 1. Wir tun dies, um die 
Resultate später besser lesen und verstehen zu können. In 17.24 - 17.2.8 
werden die benötigen Konstanten aus der Datenbasis herausgelesen und in 
17.2.9 weiter benutzt. In 17.2.10 wird die Liste der Produktionsstätte 
(als Zahlen) modular erzeugt und eingetragen. D.h. es werden neben den 
echten Produktionsstätten weitere Dummy-Produktionsstätten erzeugt, in 
den nichts passiert, weil bei einem Untertick gerade der "andere" Akteur
actor2 handelt. In 17.2.12 - 17.2.18 wird eine Schleife in der schon 
erörterten Weise über diese Liste gelegt. In einem Schleifenschritt in 
17.2.14 wird in einer bestimmten Produktionsstätte eine bestimmte Menge 
PRODUCTION_VALUE produziert. Dies geschieht durch eine Standardfunktion 
(Cobb-Douglas), die in der Ökonomie oft verwendet wird. Anders gesagt ist 
PRODUCTION_VALUE der Funktionswert, welcher aus den bereitstehenden 
Zahlen berechnet wird. In 17.2.14 gibt es zwei Möglichkeiten. In 17.2.14.1
wird die Zahl P halbiert. Wenn das Resultat keine natürliche Zahl ist, ist 
P der Name (die Zahl) einer echten Produktionsstätte. In diesem Fall wird 
in 17.2.14.2 die Produktionsfunktion benutzt. Wenn P/2 eine natürliche Zahl
ist, wird in 17.2.14.2 nichts geschehen, weil bei den Unterticks der andere
Akteur, actor2, gerade handelt.

In 17.2.15 wird dieser Wert durch den PROLOG Befehl "thread_send_message" 
an den Akteur Id1, also an den main_actor, geschickt. Diese Nachricht 
enthält alle Details, die bei der späteren Resultateauswertung gebraucht 
werden. Die Produktion findet zum Tick TICK statt. Der Unternehmer ist 
ACTOR1, Id1 ist die Nummer für den main_actor, P die bestimmte Produktionsstätte 
und PRODUCTION_VALUE ist die produzierte Menge dieser Ware zu diesem 
TICK an diesem Platz P. In 17.2.16 wird dieses Inel auch in die Datenbasis 
eingetragen.

In 17.3 wird dies in derselben Weise für den zweiten Akteur gemacht.
Dabei wird nur die Handlung in 17.3.13 anders beschrieben. Auch hier werden
in 17.3.13 die Gruppen modular behandelt. Eine Gruppe S tut nichts, wenn 
der Index für S/2 eine natürliche Zahl ist. 
*/


number_of_actors(2). number_of_ticks(3).                            /* 1 */
number_of_ticks(3).                                                 /* 2 */

number_of_production_places(4).                                     /* 3 */
number_of_quantities(1,1000). number_of_quantities(2,500).          /* 4 */
const1(0.7). const2(0.3).                                           /* 5 */

number_of_groups(5). number_of_soldiers(900).                       /* 6 */
const3(0.8).                                                        /* 7 */

start :- 
  (exists_file('res3421.pl'), delete_file('res3421.pl') ; true),    /* 8 */
  (exists_file('res3422.pl'), delete_file('res3422.pl') ; true),
  number_of_actors(NUMBER_OF_ACTORS),  
  writein('res3421.pl',number_of_actors(NUMBER_OF_ACTORS)),       
  number_of_ticks(NUMBER_OF_TICKS),
  number_of_production_places(NUMBER_OF_PLACES), 
  writein('res3421.pl',number_of_production_places(NUMBER_OF_PLACES)),                                                                          /* 9 */
  number_of_groups(NUMBER_OF_GROUPS), 
  writein('res3421.pl',number_of_groups(NUMBER_OF_GROUPS)), 
  NUMBER_OF_ITEMS is 
     (NUMBER_OF_PLACES + NUMBER_OF_GROUPS) * NUMBER_OF_ACTORS,     /* 10 */
  asserta(main_items(NUMBER_OF_ITEMS)),                            /* 11 */
  TTplus is NUMBER_OF_TICKS + 1,                                   /* 12 */
  findall(T,between(1,TTplus,T),LIST_OF_TICKS),                    /* 13 */
  asserta(list_of_ticks(LIST_OF_TICKS)),                           /* 14 */
  repeat,                                                          /* 15 */
  ( nth1(X,LIST_OF_TICKS,TICK),                                    /* 16 */
    execute_one_tick(TICK),                                        /* 17 */
    TICK < X                                                       /* 18 */
  ; true                                                           /* 19 */
  ), 
  list_of_ticks(TLLL), retract(list_of_ticks(TLLL)).               /* 20 */
 
execute_one_tick(TICK) :-                                          /* 17 */
  thread_create(main_actor(TICK),Id1,[]),                        /* 17.1 */
  thread_create(actor1(Id1,TICK),Id2,[]),                        /* 17.2 */
  thread_create(actor2(Id1,TICK),Id3,[]),                        /* 17.3 */
  thread_join(Id2,Status1), writein('res3321.pl',Status1),       /* 17.4 */
  thread_join(Id3,Status2), writein('res3321.pl',Status2),       /* 17.5 */
  thread_join(Id1,Status3), writein('res3321.pl',Status3),       /* 17.6 */
  findall(PRODUCTION_VALUE,inel_from_to(TICK,1,2,P,PRODUCTION_VALUE),
        LIST1),                                                  /* 17.7 */
  writein('res3422.pl',list_of_productions(TICK,LIST1)),         /* 17.8 */
  calculate_sum(LIST1,SUM1), writein('res3422.pl',production(TICK,SUM1)),
                                                                 /* 17.9 */
  findall(FALLEN,inel_from_to(TICK,2,2,S,FALLEN),LIST2),        /* 17.10 */
  writein('res3422.pl',list_of_fallens(TICK,LIST2)),            /* 17.11 */
  calculate_sum(LIST2,S2), writein('res3422.pl',fallen(TICK,S2)),
                                                                /* 17.12 */
  retractall(inel_from_to(UU1,UU2,UU3,UU4,UU5)).                /* 17.13 */

main_actor(TICK) :-                                              /* 17.1 */
  thread_self(Id), nl, write(main_actor(Id)), nl,              /* 17.1.1 */
%  thread_signal(Id,(attach_console,trace)),                   /* 17.1.2 */
  main_items(NUMBER_OF_ITEMS),                                 /* 17.1.3 */
  asserta(item(1)),                                            /* 17.1.4 */
  ( repeat,                                                    /* 17.1.5 */
    item(X), X =< NUMBER_OF_ITEMS,                             /* 17.1.6 */
    thread_get_message(nachricht(NACHRICHT)),                  /* 17.1.7 */
    writein('res3422.pl',inel(NACHRICHT)),                     /* 17.1.8 */
    Xnew is X + 1,                                             /* 17.1.9 */
    retract(item(X)), asserta(item(Xnew)),                    /* 17.1.10 */
    NUMBER_OF_ITEMS < Xnew                                    /* 17.1.11 */
   ;
    true                                                      /* 17.1.12 */   
  ), item(UUU), retract(item(UUU)).
 
actor1(Id1,TICK) :-                                              /* 17.2 */
  thread_self(Id2), nl, write(actor(Id2)), nl,                 /* 17.2.1 */
%  thread_signal(Id2,(attach_console,trace)),                  /* 17.2.2 */
  ACTOR1 is Id2 - 2,                                           /* 17.2.3 */
  number_of_production_places(NUMBER_OF_PLACES),               /* 17.2.4 */
  number_of_actors(NUMBER_OF_ACTORS),                          /* 17.2.5 */
  NUMBER_OF_ENRICHED_PLACES is 
            NUMBER_OF_PLACES * NUMBER_OF_ACTORS,               /* 17.2.6 */
  const1(C1), const2(C2),                                      /* 17.2.7 */
  number_of_quantities(1,Q1), number_of_quantities(2,Q2),      /* 17.2.8 */
  PL1 is Q1/NUMBER_OF_PLACES, PL2 is Q2/NUMBER_OF_PLACES,      /* 17.2.9 */
  findall(P,between(1,NUMBER_OF_ENRICHED_PLACES,P),
        LIST_OF_PLACES),                                      /* 17.2.10 */
  asserta(list_of_places(LIST_OF_PLACES)),                    /* 17.2.11 */
  repeat,                                                     /* 17.2.12 */
  ( nth1(X,LIST_OF_PLACES,P),                                 /* 17.2.13 */
    produce(TICK,P,C1,PL1,C2,PL2,PRODUCTION_VALUE),           /* 17.2.14 */
    thread_send_message(Id1,nachricht(message_from_to(
           TICK,ACTOR1,Id1,P,PRODUCTION_VALUE))),             /* 17.2.15 */
                                                             
    ( integer(P), 
      asserta(inel_from_to(TICK,ACTOR1,Id1,P,PRODUCTION_VALUE)) ; true),
                                                              /* 17.2.16 */
    P < X                                                     /* 17.2.17 */
  ; true                                                      /* 17.2.18 */
  ), 
  list_of_places(TLLL), retract(list_of_places(TLLL)). 

produce(TICK,P,C1,PL1,C2,PL2,PRODUCTION_VALUE) :-             /* 17.2.14 */
  Z is P/2,                                                 /* 17.2.14.1 */
  ( \+ integer(Z), Z1 is PL2/2, Z2 is random(ceiling(Z1)), Z3 is Z1 + Z2, 
    PRODUCTION_VALUE is (C1*log(PL1))*(C2*log(Z3))          /* 17.2.14.2 */
  ; PRODUCTION_VALUE is 0, true),!.                         /* 17.2.14.3 */
  
actor2(Id1,TICK) :-                                              /* 17.3 */
  thread_self(Id3), write(actor(Id3)),                         /* 17.3.1 */
%  thread_signal(Id3,(attach_console,trace)),                  /* 17.3.2 */
  ACTOR2 is Id3 - 2,                                           /* 17.3.3 */
  number_of_actors(NUMBER_OF_ACTORS),                          /* 17.3.4 */
  number_of_groups(NUMBER_OF_GROUPS),                          /* 17.3.5 */
  NUMBER_OF_ENRICHED_GROUPS is    
       NUMBER_OF_GROUPS * NUMBER_OF_ACTORS,                    /* 17.3.6 */
  number_of_soldiers(Q3),                                      /* 17.3.7 */
  PL3 is Q3/NUMBER_OF_GROUPS, const3(C3), asserta(pool(Q3)),   /* 17.3.8 */
  findall(S,between(1,NUMBER_OF_ENRICHED_GROUPS,S),LIST_OF_GROUPS),                                                                         /*17.3.9 */
  asserta(aux_list(LIST_OF_GROUPS)),                          /* 17.3.10 */
  repeat,                                                     /* 17.3.11 */
  ( nth1(X,LIST_OF_GROUPS,S),                                 /* 17.3.12 */
    fallen(TICK,S,C3,PL3,FALLEN),                             /* 17.3.13 */
      thread_send_message(Id1,nachricht(message_from_to(
      TICK,ACTOR2,Id1,S,FALLEN))),                            /* 17.3.14 */
    ( integer(S), asserta(inel_from_to(TICK,ACTOR2,Id1,S,FALLEN)) ; true),
                                                              /* 17.3.15 */
    S < X                                                     /* 17.3.16 */
  ; true                                                      /* 17.3.17 */
  ),
  aux_list(TLLL), retract(aux_list(TLLL)). 

fallen(TICK,S,C3,PL3,FALLEN) :-                               /* 17.3.13 */
  Z is S/2,
  ( \+ integer(Z), pool(POOL), 
    FALLEN is random(ceiling(C3*PL3)) + 1,
    POOLnew is POOL - FALLEN, retract(pool(POOL)), asserta(pool(POOLnew))
  ; FALLEN = 0, true),!.
  

% -------------------------------------
% aux

writein(File,Message) :- append(File),
   write(Message), write('. '), nl, told. 
% --------------------------------

calculate_sum(L,S) :- asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !.  

