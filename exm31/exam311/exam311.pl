/* exam311  

Einfache Ereignissen (events) werden zufällig erzeugt.

In 1 - 3 werden einige Fakten für die Erzeugung bereit gestellt. Ein
wirkliches Ereignis ist im Universum genau ein Mal vorhanden. Diese
Voraussetzung benutzen wir auch bei Simulationen. Wir legen die Anzahl
aller "möglichen" Ereignisse: NUMBER_OF_EVENTS (z.B. = 200) fest. Wenn wir 
dies nicht machen, wird es schwierig, die Wahrscheinlchkeiten von
Resultate aus verschiedenen Abläufen zu vergleichen. 
  
Diese Anzahl sollte "irgendwie" mit der Anzahl der Ticks, NUMBER_OF_TICKS 
(z.B. = 60), und mit der Anzahl der Ereignistypen NUMBER_OF_EVENTTYPS = 3, 
zusammenhängen. In Zeilen 8a und 8b unten haben wir einen groben Vergleich der Anzahlen
durchgeführt. Die Anzahl der Ereignisse sollte mindestens so groß sein, dass
es zu jedem Tick möglichst für jeden Ereignistyp ein Ereignis gibt (siehe auch 
Abschnitt 2.3 unseres Buches).     

In 4 wird die Resultatdatei res311.pl geleert. In 5 - 7 werden die Fakten 
von 1 - 3 geholt und in 8 miteinander verglichen. Wenn die Ungleichung in 8b
falsch ist, wird die ganze Klause gleich beendet.

Im positiven Fall werden in 9 alle Ereignisse zu einer Liste zusammengefügt.
Hier benutzen wir die Zahlen 1,...,NUMBER_OF_EVENTS ( = 200) gleichzeitig
als Namen für ein konkretes Ereignis. Wir könnten natürlich statt z.B. 14
auch event(14) oder event_nr(14) schreiben. Dies führt aber zu weiteren 
zusätzlichen Programmzeilen.

In 10 wird eine Hilfsliste der noch nicht benutzten Ereignisse der 
Datenbasis hinzugefügt. Im ersten Schritt enthält diese Hilfsliste alle
Ereignisse, d.h. hier [1,...,200]. In 11 wird nun diese Liste abgearbeitet.
Die Variable EVENT_Index läuft in 11 inhaltlich über alle Ereignisse.

In jedem Schritt dieser Schleife wird in 12 nun ein bestimmtes Ereignis
weiter spezifiziert.

Dies geschieht durch eine weitere Schleife in 13. Diese Schleife läuft 
über alle Ticks. In einem Schritt dieser Schleife wird in 14 der schon 
bestimmte Tick TICK und der schon bestimmte Ereignisname EVENT_Index
weitere spezifiziert. Dem Ereignis wird nämlich noch ein Ereignistyp
zugeordnet.

Dies geschieht wie folgt. In 15 wird die Zahl NUMBER_OF_EVENTTYPS der
Ereignistypen um Eins vergrößert: X is NUMBER_OF_EVENTTYPS + 1. In 16 wird 
eine Zufallszahl RANDOM aus dem Bereich von 0 bis NUMBER_OF_EVENTTYPS 
gezogen. Da die Zufallszahl RANDOM auch 0 sein kann, haben wir die Zeile 
15 benutzt, um der Wahrscheinlichkeitstheorie genüge zu tun. 

In 17 und 18 gibt es nun zwei Fälle. In 17 ist die Zufallszahl RANDOM 
Null ( = 0). In diesem Fall ist der Schritt in 13 bearbeitet und der 
nächste Tick wird benutzt. Ganz am Ende von 13 springt PROLOG nach oben
zu 12 und 11 und beginnt dort weiter zu arbeiten. 

Im zweiten Fall in 18 ist die Zufallszahl größer Null ( 0 < RANDOM ).
In 19 wird die Hilfsliste EVENTLIST geholt und die Länge dieser Liste
bestimmt: LENGTH. In 20 und 21 gibt es wieder zwei Möglichkeiten. In
20 ist die Liste EVENTLIST abgearbeitet, d.h. sie ist leer: LENGTH = 0.
In diesem Fall ist der Schreifenschritt in 13 bearbeitet.

Im interessanten Fall in 21 ist die Liste nicht leer. In 22 wird 
zufällig eine Komponente aus der Liste EVENTLIST gezogen. D.h. es wird
eine Zufallszahl RandomNUMBER aus dem Bereich von 1 bis LENGTH gezogen.
In 23 wird dann die Komponente aus der Liste genommen, die an der
Stelle Nummer RandomNUMBER steht.   

In 24 wird das so gefundete Ereignis aus der Hilfsliste gelöscht und 
die Hilfsliste mit 25 und 26 upgedatet. In 27 wird das so spezifizierte
Ereignis der Datenbasis hinzugefügt und in 28 schicken wir dieses
Ereignis auch an die Resultatdatei res311.pl.

In 27 und 28 werden die Zahlen TICK, RANDOM und EVENT so notiert, dass
die Leser sie mit der jeweiligen Art der Entität identifizieren können.
D.h. wir schreiben ein bestimmtes Ereignis in folgender Form
event(name(EVENT),time(TICK),typ(RANDOM)).
*/

number_of_ticks(60).                                             /* 1 */
number_of_eventtyps(3).                                          /* 2 */
number_of_events(200).                                           /* 3 */

% -----------------------------------------------

start :-
  (exists_file('res311.pl'), delete_file('res311.pl'); true),    /* 4 */ 
% trace,
  number_of_ticks(NUMBER_OF_TICKS),                              /* 5 */
  number_of_eventtyps(NUMBER_OF_EVENTTYPS),                      /* 6 */
  number_of_events(NUMBER_OF_EVENTS),                            /* 7 */
  N is NUMBER_OF_TICKS * NUMBER_OF_EVENTTYPS,                    /* 8a */
  N =< NUMBER_OF_EVENTS,                                         /* 8b */
  findall(Index,between(1,NUMBER_OF_EVENTS,Index),EVENTLIST),    /* 9 */
  asserta(aux_list_of_events(EVENTLIST)),                        /* 10 */
  ( between(1,NUMBER_OF_EVENTS,EVENT_Index), 
    make_one_event(EVENT_Index,NUMBER_OF_EVENTTYPS,NUMBER_OF_TICKS), 
       fail
  ; true
  ),!.                                                           /* 11 */

make_one_event(EVENT_Index,NUMBER_OF_EVENTTYPS,NUMBER_OF_TICKS) :-           
                                                                 /* 12 */
  ( between(1,NUMBER_OF_TICKS,TICK),        
    specify_typ(TICK,NUMBER_OF_EVENTTYPS,EVENT_Index), fail
  ; true ),!.                                                    /* 13 */

specify_typ(TICK,NUMBER_OF_EVENTTYPS,EVENT_Index) :-             /* 14 */
   X is NUMBER_OF_EVENTTYPS + 1,                                 /* 15 */
   RANDOM is random(X) ,                                         /* 16 */
   ( RANDOM = 0, true                                            /* 17 */
   ;
    0 < RANDOM,                                                  /* 18 */
    aux_list_of_events(EVENTLIST), length(EVENTLIST,LENGTH),     /* 19 */
    ( LENGTH = 0, true                                           /* 20 */
    ;
      0 < LENGTH,                                                /* 21 */
      RandomNUMBER is random(LENGTH) + 1,                        /* 22 */
      nth1(RandomNUMBER,EVENTLIST,EVENT),                        /* 23 */
      delete(EVENTLIST,EVENT,EVENTLIST1),                        /* 24 */
      retract(aux_list_of_events(EVENTLIST)),                    /* 25 */
      asserta(aux_list_of_events(EVENTLIST1)),                   /* 26 */
      asserta(event(name(EVENT),time(TICK),typ(RANDOM))),         /* 27 */
      append('res311.pl'), write(event(name(EVENT),time(TICK),typ(RANDOM))), 
      write('.'), nl, told
    )
   ),!.                                                          /* 28 */
  

