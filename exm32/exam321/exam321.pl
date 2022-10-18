/* exam321 

Ein Modul für den Ablauf einer Beeinflussung eines Akteurs durch einen
anderen Akteur

Einige Fakten, die alle in einem vollständigen Programm schon existieren
müssen, haben wir hier in 1 - 3 aufgeschrieben. Der Prozess der 
Beeinflussung beginnt hier zum Tick 14. Der "Macher" (MAKER) ist
Akteur 5 und der "Betroffene" (SERVER) ist Akteur Nr. 3. 

Wir haben hier beide Akteure als Paare notiert, um rein
PROLOG-technische Komplikationen beim Holen der Fakten aus der Datenbasis in
6 zu vermeiden. Da wir hier keine konkreten Handlungen beschreiben, 
belassen wir das Modul auf der abstrakten Ebene. 

Genauso haben wir zwei abstrakte Handlungen action4 und action2 als ein Paar in 
1 notiert. In einem vollständigen Programm werden
die Handlungen action4 und action2 als Handlungstypen benutzt, 
welche erst durch weitere Argumente zu Handlungen werden.

Der Aspekt der Verursachung wurde in Zeile 2 schon vorgesehen, er wird aber 
hier nicht inhaltlich benutzt. Die Konstante time_delay_constant(action4,6)
in 3 drückt aus, dass die ausführende Handlung action2 nicht direkt im nächsten 
Tick stattfinden muss, sondern sie kann zu einem späteren Tick
stattfinden (hier: 6 Ticks später). Die Konstante pressure_on(3,90) 
besagt, dass auf dem betroffenen Akteur Nr.3 ein psychologischer Druck 
im Grade 90 lastet. Der Grad ist hier von 0 bis 100 normiert. Im Beispiel
ist der betroffene Akteur also ziemlich stark unter Druck; er hat wenig
Kraft, der Anweisung des Akteurs Nr.5 zu widerstehen.   

In 4 wird die Resultatdatei res321.pl geleert. In 5 wird die 
Beeinflussungssequenz mehrfach wiederholt. Wir tun dies, um auf zwei 
Stellen (15 und 23) hinzuweisen, an denen die Beeinflussung scheitern kann.

In 6 werden die Fakten aus der Datenbasis geholt. In 7 denkt der
Macher, Akteur Nr.5, nach; er fasst einen rudimentären Plan. Dazu wird
in 8 die Zeitspanne C aus der Datenbasis geholt. Der spätere Tick
TICK1 (is TICK + C) in 9 wird in 7 aufbewahrt. In 10 wird die anzuweisende 
Handlung (eigentlich ein Handlungstyp) und eine dazugehörige Person
SERVER bestimmt. Dies geschieht in 11 durch die Fakten in 1. In
einem vollständigen Programm würde dies vorher in anderer Weise geschehen.
Dabei wird bei der Planung in 12 auch untersucht, ob die Handlung,
die durch Akteur Nr.3 ausführen soll, kausal auch von der Handlung des
Machers - jedenfalls teilweise - abhängig ist.  

In 13 wird schliesslich die Beeinflussung beschrieben. In 14 wird die
Einstellung des Machers aus der Datenbasis geholt. Hier im Beispiel
haben wir diese Einstellung in Zeile 14.1 einfach auf "richtig" gesetzt.
Real gesehen muss diese Einstellung des Machers im Programm vorher
entstehen. Die Einstellung in 14 beinhaltet folgendes. Zu Tick T
hat der Macher MAK die Einstellung, die Handlung act_sup(...) auszuführen.
ACTION_MAK ist hier durch action4 besetzt, D.h. der Macher hat vor, 
action4 auszuführen - und zwar zum selben Tick T durch den Macher MAK
selbst. Weiter hat MAK auch seinen Plan [ACTION_SER,TICK1,SER] gefasst.
Letzterer umfasst 1) die Handlung ACTION_SER (hier die Handlung action2),
2) den späteren Tick TICK1, zu dem die Handlung auszuführen ist und 3)
den Betroffenen SER (hier Akteur Nr.3). All diese Variablen sind an 
dieser Stelle schon instantiiert.

Nachdem der Macher diese Einstellung hat, führt er in 15 diese 
Handlung auch durch. Dazu haben wir in 15 - 21 vorgesehen, dass die 
Handlung act_sup(...) auch scheitern kann. In 5 Prozent der Fälle 
wird die Handlung in 21 vorzeitig beendet. In diesen Fällen wird 
in 20 die Information action_with_out_success(TICK,ACTION_MAK)
an die Resultatdatei geschickt. In den positiven Fällen in 17 und 
18 wird die Beschreibung der Handlung an die Resultatdatei geschickt. 
PROLOG hat die Klause 15 richtig bearbeitet und wendet sich 22 zu. Hier
trifft PROLOG das Negationszeichen "\+" und versucht den Term int(...)
zunächst zu beweisen. Dies gelingt nicht. In der Datenbasis gibt es keine 
Einstellung dieser speziellen Art für den Akteur Nr.3 und die Handlung
action2. In diesem Fall trifft die Verneinung in 22 zu, d.h. 22 stimmt
so.

In 23 wird nun die Einstellung des Betroffenen geändert. In 24 wird der
Druck PRESSURE "für" den betroffenen Akteur SER (Nr.3) als Fakt geholt. 
In 25 - 31 haben wir vorgesehen, dass diese Änderung auch scheitern 
kann. In diesem Fall wird in 30 die Klause 23 falsch und 
damit die gesamte Sequenz. Im Normalfall ist in 26 der Druck PRESSURE 
größer als die Zufallszahl X. In diesem Fall wird Klause 23 richtig.
In 27 wird die geänderte Einstellung an die Resultatdatei geschickt.
In 23 ist die vorher negative Einstellung durch Druck zu einer positiven 
Einstellung geworden. In 27 wird die dazugehörige Einstellung auch in
die Datenbasis geschrieben. In 32 wird nun diese Einstellung aus der
Datenbasis geholt und in 33 die betreffende Handlung ausgeführt. 
Diese Handlung wird in 33.1 ohne Inhalt auch ausgeführt.

In den Resultaten sehen wir, wie "wahrscheinlich" es ist, dass die
Beeinflussung nicht gelingt. Dazu müssen wir die Anzahl der Ticks groß
genug und die Zufallszahl PRESSURE in 25 nahe bei 100 wählen. Eine 
zweite Konstante in Zeile 17 haben wir per Hand auf 95 gesetzt. Auch dies
lässt sich durch einen weiteren Fakt variabel halten.

In diesem Beispiel wird das Prädikat "int" in zwei verschiedenen,
syntaktischen Weisen benutzt. Da hier dieses Prädikat in 27 auch für
das Eintragen in die Datenbasis verwendet wird, müssen wir ganz am Anfang
in 0 dieses Prädikat für dynamische Veränderungen freigeben. 

Abkürzungen:
ACTION_MAK = ACTION_TYP_FOR_A_MAKER
ACTION_SER = ACTION_TYP_FOR_A_SERVER
MAK = MAKER
SER = SERVER
act_sup = action_of_superior_kind
act_inf = action_of_inferior_kind
*/


:- dynamic int/3.                                                    /* 0 */

tick(14). actor_pair(5,3). action_pair(action4,action2).             /* 1 */
caus(action4,action2).                                               /* 2 */
time_delay_constant(action4,6). pressure_on(3,90).                   /* 3 */

start :- 
  ( exists_file('res321.pl'), delete_file('res321.pl') ; true),      /* 4 */
  ( between(1,5,TICK), make_one_time_loop(TICK), fail; true).        /* 5 */

make_one_time_loop(TICK) :-                                          /* 5 */
  actor_pair(MAK,SER), action_pair(ACTION_MAK,ACTION_SER),           /* 6 */
  planning(TICK,MAK,ACTION_MAK,TICK1,ACTION_SER,SER),                /* 7 */
  exert_power(TICK,TICK1,MAK,SER,ACTION_MAK,ACTION_SER).            /* 13 */

planning(TICK,MAK,ACTION_MAK,TICK1,ACTION_SER,SER) :-                /* 7 */
  time_delay_constant(ACTION_MAK,C),                                 /* 8 */
  TICK1 is TICK + C, TICK < TICK1,                                   /* 9 */
  choose_typ_and_person(MAK,ACTION_MAK,SER,ACTION_SER),!.           /* 10 */

choose_typ_and_person(MAK,ACTION_MAK,SER,ACTION_SER) :-             /* 10 */
  actor_pair(MAK,SER), action_pair(ACTION_MAK,ACTION_SER),          /* 11 */
  caus(ACTION_MAK,ACTION_SER),!.                                    /* 12 */

exert_power(TICK,TICK1,MAK,SER,ACTION_MAK,ACTION_SER) :-            /* 13 */
  int(TICK,MAK,act_sup(ACTION_MAK,TICK,MAK,[ACTION_SER,             
      TICK1,SER])),                                                 /* 14 */
  act_sup(ACTION_MAK,TICK,MAK,[ACTION_SER,TICK1,SER]),              /* 15 */
  \+ int(TICK,SER,act_inf(ACTION_SER,TICK1,SER)),                   /* 22 */
  change_intention(TICK,TICK1,SER,act_inf(ACTION_SER,TICK1,SER)),   /* 23 */
  int(TICK1,SER,act_inf(ACTION_SER,TICK1,SER)),                     /* 32 */
  act_inf(ACTION_SER,TICK1,SER).                                    /* 33 */

act_sup(ACTION_MAK,TICK,MAK,[ACTION_SER,TICK1,SER]) :-              /* 15 */
  W is random(101),                                                 /* 16 */
  ( W =< 95,                                                        /* 17 */
    writein(res321,act_sup(ACTION_MAK,TICK,MAK,[ACTION_SER, 
    TICK1,SER]))                                                    /* 18 */
  ; W > 95,                                                         /* 19 */ 
    writein(res321,action_with_out_success(TICK,ACTION_MAK)),       /* 20 */
    fail                                                            /* 21 */
  ),!.

change_intention(TICK,TICK1,SER,act_inf(ACTION_SER,TICK1,SER)) :-   /* 23 */
  pressure_on(SER,PRESSURE),                                        /* 24 */
  X is random(101) + 1,                                             /* 25 */
  ( X =< PRESSURE ,                                                 /* 26 */
     asserta(int(TICK1,SER,act_inf(ACTION_SER,TICK1,SER))),         /* 27 */
     writein(res321,int(TICK1,SER,act_inf(ACTION_SER,TICK1,SER)))   /* 28 */
  ; X > PRESSURE, writein(res321,intention_not_changed(TICK1,       /* 29 */
    SER,ACTION_SER)),                                               /* 30 */
    fail                                                            /* 31 */  
  ),!.
    
int(TICK,MAK,act_sup(ACTION_MAK,TICK,MAK,[ACTION_SER,TICK1,SER])) :- 
  true.                                                           /* 14.1 */
act_inf(ACTION_SER,TICK1,BU) :- true.                             /* 33.1 */

writein(res321,Y) :- append('res321.pl'), write(Y),  
   write('.'), nl, told.                                         