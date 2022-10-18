/* exam314 

Eine Liste von Überzeugungen (beliefs) für einen Akteur A zu einem bestimmten  
Tick wird erzeugt. Eine Überzeugung hat die Form
  
   believe(12, 10, 0.4, 2), oder allgemein: 
   believe(A,TICKlast,W,NAME_OF_RANDOM_EVENT).

Die "Wahrscheinlichkeit" W eines Zufallsereignisses des Names NAME_OF_RANDOM_EVENT
wird aus der Vorgeschichte des Zufallsereignisses berechnet. Eine solche
Vorgeschichte hat die Form

   history_of(r_event(2), [[tick(1), ev_components([1, 3, ..])], 
                           [tick(2), ev_components([1, 2, ..])], 
                           [tick(3), ev_components([1, 3, ..])]
                           ... 
                                                               ])

oder allgemein: 

   history_of(r_event(NAME_OF_RANDOM_EVENT), 
                     [[tick(T1), ev_components([K11, K21, ..])], 
                      [tick(T2), ev_components([K12, K22, ..])], 
                      [tick(T3), ev_components([K13, K23, ..])]
                        ...                                    ]).

Als Vorbereitung werden am Anfang Elementareignisse (siehe unser Buch, 2.3)
erzeugt, die in einem vollständigen Programm schon vorhanden sind. Ein 
solches Ereignis hat die Form
 
    elementary_event(14, 8, 5), oder allgemein:
    elementary_event(R_EVENT,TICK,EV_COMPONENT),

wobei R_EVENT ein Name für ein bestimmtes Zufallsereignis ist, TICK ein
Zeitpunkt und EV_COMPONENT eine abstrakt bleibende Dimension ("component"),
die die Zufallsereignisse kennzeichnet. Z.B. könnte die EV_COMPONENT einfach
ein Ort sein, zu dem ein Zufallsereignis R_EVENT gehört, so dass R_EVENT
mehrere Orte umschließt. Ein Zeitpunkt TICK eines Elementareignisses liegt 
früher als der Zeitpunkt TICKlast der Überzeugung, die "am Schluß" des 
Moduls gebildet wird: TICK =< TICKlast.

-------------------------------------

In 1 - 4 haben wir die relevanten Fakten zur Erzeugung bereitgestellt.
In 5 werden die Resultatdateien geleert und in 6 werden die Fakten von 1 - 4
aus der Datenbasis geholt. In 7 und 8 wird ein weiterer Fakt in die
Datenbasis eingefügt, der durch andere Fakten explizit definiert ist: die 
Anzahl der möglichen Elementarereignisse (siehe Abschnitt 2.3 in unserem Buch).  

Eine erste Schleife läuft in 9 über den Bereich der Zufallsereignisse.
Ein bestimmtes Zufallsereignis R_EVENT (genauer: ein Name oder der Index
des Zufallsereignisses) wird bearbeitet.
In 10 wird eine zweite Schleife eingerichtet, die über den Bereich der Ticks 
läuft. In einem Schleifenschritt in "loop_over1" wird in 11 eine weitere 
Schleife bearbeitet. In einem Schleifenschritt in "loop_over" in 12 wird
der Bereich der Komponenten (oder Dimensionen) des Zufallsereignisses 
R_EVENT - relativ zu dem bestimmten TICK - bearbeitet.

In 13 - 17 haben wir eine zufällige, einfache Auswahl getroffen. Bildet 
ein gegebenes Zufallsereignis R_EVENT, ein bestimmter TICK und die gerade
untersuchte Komponente EV_COMPONENT zusammen ein Ereignis: [R_EVENT,TICK,EV_COMPONENT]? 
Dazu haben wir in 13 eine Zufallszahl Z aus dem Bereich von 1 bis R_EVENT * TICK 
gezogen und in 14 gefragt, ob Z/2 eine natürliche Zahl ist oder nicht. Im 
ersten Fall wird in 14 das mögliche Elementarereignis [R_EVENT,TICK,EV_COMPONENT] 
in 15 in die Datenbasis eingetragen:

   elementary_event(R_EVENT,TICK,EV_COMPONENT).

Wir haben hier den Befehl "assertz" benutzt. Die Elementarereignisse werden
am Ende ("z") der Datenbasis eingetragen. In dieser Weise werden 
Elementarereignisse in für uns passender Ordnung später aus der
Datenbasis herausgelesen. D.h. PROLOG findet Komponenten KI, KI1, KI2,...
in dieser Reihenfolge. In 16 haben wir die Elementarereignisse auch an
die Resultatdatei res3141.pl geschickt. 

Im zweiten, zufallsgesteuerten Fall wird in 17 die mögliche Kombination
[R_EVENT,TICK,EV_COMPONENT] nicht als Elementarereignis angesehen und
damit nicht in die Datenbasis eingetragen.

Am Ende der Schleife in 10 werden in 18 alle Paare [TICK,EV_COMPONENT] aus
den vorher erzeugten Elementarereignissen zusammengestellt und in eine Liste
LIST geschrieben. In 19 schicken wir diese Liste LIST an die Resultatdatei
res3141.pl in der Form: random_event(R_EVENT,LIST). D.h. es handelt sich
um eine Liste LIST, die zusammen mit dem Namen R_EVENT ein Zufallsereignis
des Names R_EVENT ausmacht (siehe 2.3 in unserem Buch). In 20 wird die
Länge LENGTH der Liste bestimmt. Inhaltlich ist diese Länge LENGTH gerade 
die absolute Häufigkeit der Elementarereignisse, die das Zufallsereignis
des Namens R_EVENT ausmachen (siehe unser Buch, 2.3). In 22 wird die Anzahl
NPELEVS der möglichen Elementarereignisse aus der Dateibasis geholt, die 
in 8 voher eingetragen wurde und in 23 berechnen wir die relative Häufigkeit
W (die "Wahrscheinlichkeit") des Zufallsereignisses R_EVENT:  

    W is LENGTH/NPELEVS. 

In 24 können wir nun diese Wahrscheinlichkeit W benutzen, um die Überzeugung
des Akteurs (ACTOR = 12) zum Tick (TICKbel = 10) für das 
Ereignis R_EVENT zu formulieren und an die Resultatdatei res3142.pl zu
schicken:
   
    believe(ACTOR,TICKbel,W,R_EVENT).

Als Zeitpunkt, in dem die Überzeugung gebildet wird, haben wir hier einfach
die Zahl NUMBER_OF_TICKS ( = TICKbel ) genommen. In einem vollständigen 
Programm ist TICKbel formal unabhängig von der Anzahl NUMBER_OF_TICKS, die 
für die Erzeugung der Elementarereignisse benutzt wird. Dies betrifft auch 
die Ticks, die in den Elementarereignissen zu finden sind. In einem
vollständigen Programm entwickeln sich diese Elementarereignisse im Ablauf
des Geschehens, nicht wir hier durch ein Erzeugungsmodul.
 
In 25 - 33 haben wir schließlich die Resultate so umgebaut, dass wir sie
als Vorgeschichte eines jeweiligen Zufallsereignisses R_EVENT so beschrieben, dass 
wir sie auch inhaltlich verstehen können. In 25 richten wir
eine leere Liste [ ] ein, die die Vorgeschichte "history_of" eines 
Zufallsereignisses R_EVENT betrifft. Da R_EVENT nur eine Zahl, ein "Name" für
ein Zufallsereignis ist, schreiben wir diese Zahl so: r_event(R_EVENT).
Die leere Liste [ ] wird durch die Schleife in 26 so gefüllt:

       LIST =        [[tick(T1), ev_components([K11,K12, ..])], 
                      [tick(T2), ev_components([K21,K22, ..])], 
                      [tick(T3), ev_components([K31,K32, ..])]
                           ...                                ].

Die Vorgeschichte bekommt die Form 

     history_of(r_event(R_EVENT),LIST)), 

siehe auch die Beschreibung am Anfang oben. 

In 27 sammeln wir alle Komponenten EV_COMPONENT, die in Elementarereignissen
der Art elementary_event(R_EVENT,TICK,EV_COMPONENT) relativ zu R_EVENT 
und TICK zu finden sind: LIST1. In 28 wird die im Aufbau befindliche Vorgeschichte 
history_of(r_event(R_EVENT),LIST2) aus der Datenbasis geholt und in 29 wird die 
gerade gesammelte Liste LIST1 an LIST2 dazugefügt. In 30 und 31 wird der 
Term history_of(r_event(..),...) in jedem Schleifenschritt angepasst.

Schließlich haben wir in 34 - 36 die im Ablauf erzeugten Fakten wieder 
gelöscht.

Zwei Abkürzungen:
  N_POT_ELEVS = NUMBER_OF_POTENTIAL_ELEMENTARY_EVENTS
  NREVS = NUMBER_OF_RANDOM_EVENTS
*/

number_of_ticks(10).                                                  /* 1 */
one_actor(12).                                                        /* 2 */
number_of_components(8).                                              /* 3 */
number_of_random_events(20).                                          /* 4 */    

% -----------------------------------------------

start :-
  (exists_file('res3141.pl'), delete_file('res3141.pl'); true), 
  (exists_file('res3142.pl'), delete_file('res3142.pl'); true),       /* 5 */
  number_of_components(NUMBER_OF_COMPONENTS),
  number_of_ticks(NUMBER_OF_TICKS), one_actor(ACTOR), 
  number_of_random_events(NREVS),                                     /* 6 */
  N_POT_ELEVS is NUMBER_OF_TICKS * NUMBER_OF_COMPONENTS,              /* 7 */
  asserta(number_of_possible_elementary_events(N_POT_ELEVS)),         /* 8 */
  ( between(1,NREVS,R_EVENT),          
     make_one_random_event(R_EVENT,NUMBER_OF_TICKS,NUMBER_OF_COMPONENTS,ACTOR),
     fail; true),                                                     /* 9 */
  retract(number_of_possible_elementary_events(N_POT_ELEVS)),         /* 34 */
  retractall(history_of(r_event(RRR,LLL))),                           /* 35 */  
  retractall(elementary_event(RRR,TTT,VVV)).                          /* 36 */

make_one_random_event(R_EVENT,NUMBER_OF_TICKS,NUMBER_OF_COMPONENTS,ACTOR) :-
  ( between(1,NUMBER_OF_TICKS,TICK),       
    loop_over1(TICK,R_EVENT,NUMBER_OF_TICKS,NUMBER_OF_COMPONENTS), 
    fail; true),                                                      /* 10 */
  findall([TICK,EV_COMPONENT],elementary_event(R_EVENT,TICK,EV_COMPONENT),
      LIST),                                                          /* 18 */
  append('res3141.pl'), write(random_event(R_EVENT,LIST)),
  write('.'), nl, told,                                               /* 19 */
  length(LIST,LENGTH),                                                /* 20 */
  append('res3141.pl'), write(absolute_frequency_of(R_EVENT,LENGTH)), 
  write('.'), nl, told,                                               /* 21 */
  number_of_possible_elementary_events(NPELEVS),                      /* 22 */
  W is LENGTH/NPELEVS,                                                /* 23 */
  append('res3142.pl'), write(believe(ACTOR,NUMBER_OF_TICKS,W,R_EVENT)),
  write('.'), nl,                                                     /* 24 */
  asserta(history_of(r_event(R_EVENT),[])),                           /* 25 */
  ( between(1,NUMBER_OF_TICKS,TICK), 
     build_history_of_one_R_event(TICK,ACTOR,NUMBER_OF_TICKS,R_EVENT,LIST), 
     fail; true),                                                     /* 26 */
  history_of(r_event(R_EVENT),LIST3),                                 /* 32 */
  append('res3142.pl'), write(history_of(r_event(R_EVENT),LIST3)), write('.'),
    nl, told,!.                                                       /* 33 */

build_history_of_one_R_event(TICK,ACTOR,NUMBER_OF_TICKS,R_EVENT,LIST) :-
   findall(EV_COMPONENT,elementary_event(R_EVENT,TICK,EV_COMPONENT),
     LIST1),                                                          /* 27 */
   history_of(r_event(R_EVENT),LIST2),                                /* 28 */
   append(LIST2,[[tick(TICK),ev_components(LIST1)]],LIST2new),        /* 29 */
   retract(history_of(r_event(R_EVENT),LIST2)),                       /* 30 */
   asserta(history_of(r_event(R_EVENT),LIST2new)),!.                  /* 31 */

loop_over1(TICK,R_EVENT,NUMBER_OF_TICKS,NUMBER_OF_COMPONENTS) :- 
  ( between(1,NUMBER_OF_COMPONENTS,EV_COMPONENT),                     /* 11 */
      loop_over(EV_COMPONENT,TICK,R_EVENT),                           /* 12 */
      fail; true),!.

loop_over(EV_COMPONENT,TICK,R_EVENT) :-
  Z is random(R_EVENT * TICK), INT is Z/2,                            /* 13 */
  ( integer(INT),                                                     /* 14 */
    assertz(elementary_event(R_EVENT,TICK,EV_COMPONENT)),             /* 15 */
    append('res3141.pl'), write(elementary_event(R_EVENT,TICK,EV_COMPONENT)), 
    write('.'), nl, told                                              /* 16 */
  ;
    true                                                              /* 17 */
  ),!.
  

   
      















