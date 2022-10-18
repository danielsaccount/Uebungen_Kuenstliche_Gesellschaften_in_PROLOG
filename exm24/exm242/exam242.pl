/* exam242 

Die Erzeugung von Farben "colours".

In 1 wird die Anzahl (hier: 7) der Objekte festgelegt, die eine Farbe 
bekommen. In 2 werden (nur) zwei Farbenausprägungen benutzt. Die 
Eigenschaft Farbe "colour", hat also zwei Ausprägungen (Farben). In 2
werden diesen beiden Häufigkeiten prozentual, diskret und kumulative
erzeugt. Die Verteilung der beiden Farben ist in Zeile 2 festgelegt.
In 3 bekommen die beiden Farbausprägungen eigene Namen; die erste ist mit
weiß "white" und die zweite durch eine Zahl ausgedrückt. 

In 4 wird die Resultatdatei res242.pl geleert. In 5 wird die diskrete
Funktion des Namens FUNCTION_NAME durch die Liste der Häufigkeiten von
2 erzeugt. In 7 wird der Funktionsname FUNCTION_NAME und die Häufigkeitsliste
von 2 geholt: FUNCTION_NAME = colour, FREQUENCY_LIST = [30,101]. In 8 wird
die Anzahl der Objekte aus 1 geholt: NUMBER_OF_OBJECTS = 7. Um welche Art 
von Objekten es sich handelt, bleibt hier offen. In einem vollständigen 
Programm würde ein Objekt z.B. eine Zelle aus der Zellwelt sein.

In 9 wird eine Schleife über die Anzahl, NUMBER_OF_OBJECTS der Objekte 
gelegt. Der Schleifenindex ist durch NR_OF_OBJECTS ausgedrückt. 

In 11 wir die Länge LENGTH der FREQUENCY_LIST mit "length" berechnet. In
12 wird eine Zufallszahl Z aus dem Bereich von 1 bis NUMBER_OF_OBJECTS
gezogen. In 13 wird eine offene Schleife eröffnet, die über die Länge dieser
Liste läuft. Den Schleifenindex drücken wir mit X_TH_POSITION_OF_LIST aus.
In 14 wird die X-te Komponenten mit "nth1" aus der Häufigkeitsliste 
FREQUENCY_LIST berechnet, z.B. FREQUENCY = 30. In 15 wird die Zufallszahl 
Z prozentual normiert: Z wird zu Z1. In 16 wird die Ungleichung Z1 =< FREQUENCY 
geprüft. Im positiven Fall ist die Häufigkeit FREQUENCY größer oder gleich 
wie der zufällig gezogene Objekt"name" Z1: Z1 =< FREQUENCY. In diesem
Fall holt PROLOG in 17 die Farbenlist COLOUR_LIST = [white, @32412] von 3
und berechnet in 18 die Farbe COLOUR, die an der X-ten Stelle der Liste steht.
In 19 wird die so neu erzeugte Farbe in die Resultatdatei res242.pl geschickt.

Wenn die Ungleich in 16 falsch ist, geht PROLOG wieder zurück zu 13,
erhöht in "between" den Schleifenindex um Eins und geht wieder nach unten.
Da die offene Schleife so konstruiert ist, dass sie am Ende immer positiv
beendet wird, geht PROLOG nach oben über 1,9,5 und 1 zu "start".
*/


number_of_generated_facts(7).                                       /* 1 */
cumulative_frequencies_for(colour,[30,101]).                        /* 2 */
list_of_colours([white, @32412]).                                   /* 3 */
 
start :- 
 ( exists_file('res242.pl'), delete_file('res242.pl') ; true ),     /* 4 */ 
%  trace,
  make_function_dd(FUNCTION_NAME,FREQUENCY_LIST,NUMBER_OF_OBJECTS). /* 5 */

make_function_dd(FUNCTION_NAME,FREQUENCE_LIST,NUMBER_OF_OBJECTS) :- /* 6 */
  cumulative_frequencies_for(FUNCTION_NAME,FREQUENCY_LIST),         /* 7 */ 
  number_of_generated_facts(NUMBER_OF_OBJECTS),                     /* 8 */
  ( between(1,NUMBER_OF_OBJECTS,NR_OF_OBJECT),      
          generate_one_dd_number(NR_OF_OBJECT,FUNCTION_NAME,
          FREQUENCY_LIST,NUMBER_OF_OBJECTS), 
          fail ; true ).                                            /* 9 */

generate_one_dd_number(NR_OF_OBJECT,FUNCTION_NAME,FREQUENCY_LIST,
          NUMBER_OF_OBJECTS) :-                                     /* 10 */
% trace,
  length(FREQUENCY_LIST,LENGTH),                                    /* 11 */
  Z is random(NUMBER_OF_OBJECTS) + 1,                               /* 12 */
  between(1,LENGTH,X_TH_POSITION_OF_LIST),                          /* 13 */
  nth1(X_TH_POSITION_OF_LIST,FREQUENCY_LIST,FREQUENCY),             /* 14 */
  Z1 is (Z/NUMBER_OF_OBJECTS) * 100,                                /* 15 */
  Z1 =< FREQUENCY ,                                                 /* 16 */
  list_of_colours(COLOUR_LIST),                                     /* 17 */
  nth1(X_TH_POSITION_OF_LIST,COLOUR_LIST,COLOUR),                   /* 18 */
  append('res242.pl'), write(function(FUNCTION_NAME,NR_OF_OBJECT,COLOUR)), 
  write('.'), nl, told,!.                                           /* 19 */