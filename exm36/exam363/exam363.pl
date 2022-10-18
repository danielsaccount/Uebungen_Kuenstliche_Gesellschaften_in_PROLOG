/* exam363  

Ein Reihe von Balken verschiedener Farbe und verschiedener Höhe wird
dargestellt. Die Höhe der Balken ändern sich mit der Zeit. In diesem
Programm wird eine Sequenz von Balken erscheinen; ein Balken stellt
die Stärke und ein zweiter Balken die Werte eines Akteurs zu einem Tick dar.

Im Beispiel bedeutet ein grüner Balken die Stärke eines Akteurs und ein 
blauer Balken der Gesamtwert von Dingen, die ein Akteur zu einem bestimmten
Tick hat. Sie sehen beim Übergang von einem Tick zu einem nächsten, dass
sich die Balken für Werte verändern. Die zwei Eigenschaften der Stärke und 
des Werts stammen aus einem Programm, in dem unter anderem der Handlungstyp
"räubern" (predate) benutzt wird. Jede Akteur "ist" - mehr oder weniger auch - ein Raubtier.
Da in unserem Beispiel nur diese Eigenschaft benutzt wird, nennen wir die
Akteure  "predators", (siehe exam35?). Wenn der Balken für den Wert eines 
Akteurs kürzer wird, wurde der Akteur beraubt; wenn der Balken größer wird,
raubt der Akteur selbst. Dabei werden die Werte quantitativ durch die Längen 
der Balken dargestellt.
 
Für dieses Programm müssen die Werte (wealth_take) und die Stärken (strength)
in den verschiedenen Ticks bereitliegen: 

    fact(RUN,TICK,wealth_take(ACTOR,VALUE)),
    fact(RUN,TICK,strength(ACTOR,STRENGTH)).

Wir haben diese Fakten von einem anderen Programm (exam411, res411.pl) 
kopiert. Auch die Parameter aus dem Programm exam411 benutzen wir hier; sie 
sind hier in einer Datei "para363.pl" vorhanden. D.h. wir können die Parameter in 
diesem Beispiel hier nicht einfach verändern. Dazu müssten wir das Beispiel
exam411 zunächst das Programm exam411 mit neuen Parametern durchlaufen 
lassen.
   
In 2 wird ein bestimmter Run, eine Wiederholung eines Ablaufs für 
statistische Zwecke, ablaufen. Die Bildsequenz stellt nur die Funktion innerhalb eines 
Runs (hier RUN = 2) dar. In 3 haben wir den Term make_picture(predator)
eingeführt.

In 4 werden die Parameter und die Resultate geladen. In 5 wird der Name 
für das Bild konstruiert. Dazu fügen wir das in Anführungszeichen geschriebene
Wort 'Picture-' mit dem Wort "predator" zusammen. In 6 wird der Rahmen für 
dieses Bild als ein Objekt (@predator) erzeugt und geöffnet. Mit 
send(@predator, open) sehen wir, dass dieser neue Rahmen für dieses Bild im
Monitor zu sehen ist. "send", "@" und "open" sind XPCE Befehle. Im 
trace-Modus sehen Sie, dass in 6 die Variable Vd1 tatsächlich so aussieht: 
Vd1 = Picture-predator. 


In 7 wird in diesem Programm die Y-Achse generiert und in das Bild 
eingezeichnet. Dazu wird in XPCE das Prädikat "display" und der Term 

    new(Y_AXIS, line(5,5,5,160,first))

verwendet. Die Variable Y_AXIS wird als "Name" für das neue Objekt "Y-Achse" 
benutzt. Durch diese Methode können dem Objekt weitere Eigenschaften 
zugesprochen werden. Anders gesagt ist es nicht nötig, der Y-Achse einen echten
Namen zu geben. Die Variable Y_AXIS reicht für den Ablauf aus.  

Mit dem Term line(5,5,5,160,first) zeichnet XPCE die Linie des "Names" Y_AXIS 
so, dass der Anfangspunkt der Linie der Punkt (die Koordinate) [5,5] ist und 
dass der Endpunkt der Linie der Punkt (die Koordinate) [5,160] ist. Der Befehl
"first" besagt, dass am Endpunkt der Linie ein Pfeil angebracht wird. Ganz 
genauso wird in 8 die X-Achse gezeichnet. Auch diese Achse bekommt einen 
"Namen" X_AXIS, zwei Anfangs- und Endkoordinaten und einen Pfeil.

Im Weiteren werden einerseits die verschiedenen Bildelemente erzeugt, die 
zusammengenommen ein Bild ausmachen und andererseits werden bestimmte 
Bildelemente bei jedem Tick verändert. Bei den Bildelementen unterscheiden wir 
daher zwischen Objekte, die sich mit der Zeit verändern, und Objekten, die sich 
mit der Zeit nicht ändern. Die erste Art von Objekten wird in einer Liste 

   object_list(predator,LIST_OF_OBJECTS)

gesammelt, siehe 9. LIST_OF_OBJECTS enthält XPCE-Namen für veränderliche 
Objekte (hier: Balken mit ihren Höhen). Zwei weitere "Hilfsobjekte" werden
in 3 erzeugt.

Die Objektliste steht in diesem Programm im Zentrum. Ein Objekt aus dieser 
Liste wird in der zentralen Schleife in 29 ständig verändert. Das Objekt 
bekommt am Anfang einen Namen. Dieser "Name" bleibt aber hier auf der Variablenebene. 
Der Name bleibt im Ablauf gleich. Zusätzlich werden dem 
Objekt weitere Eigenschaften mitgegeben; diese verändern sich mit der Zeit.
Genauso bekommt jedes Hilfsobjekt einen "Namen".

In 10 wird die Anzahl TICKS der Ticks aus der Datenbasis geholt. Wir verwenden 
hier statt "tick" das Wort "periods". In 10 wird weiter der 
hervorgehobene Run von 2 geholt, RUN = 2.

In 11 werden die zentralen Objekte (hier Balken) erzeugt. In 12 wird die Zahl
der Akteure geholt. In 14 wird eine Schleife über die Anzahl der Objekte 
(hier: Paare von Balken) gelegt. In diesem Programm brauchen wir die
Akteure nicht von den Nummern dieser Akteure zu unterschieden. D.h. 
eine Zahl ACTOR (ACTOR =< NUMBER_OF_ACTOR) drückt gleichzeitig die
Stelle in der Liste aller Akteure und den Akteur (sein Namen) selbst aus.
In einem Schleifenschritt werden die Koordinaten zweier Balken berechnet. 
Dies geschieht wie folgt. In 15 wird der Akteur B (eine Zahl) genommen und 
aus dieser Zahl die X-Koordinate durch "I is 5 + (B-1)*20" berechnet. 
Dazu wird die Anfangskoordinate 5 auf der X-Achse um (B-1)*20 Pixel erhöht.
Weiter wird eine zweite X-Koordinate I1 berechnet für den zweiten Balken:
I1 is I + 10. Der zweite Balken liegt 10 Pixel weiter rechts vom Balken 
Nr. B. Die Y-Koordinaten haben wir in 15 einfach per Hand eingetragen: 
J = 140 (Pixel).
  
In 16 wird mit

   send(@predator, display, new(NAME_OF_BAR,box(10,20)), point(I,J))

erstens ein Balken erzeugt, welcher den "Namen" NAME_OF_BAR trägt und die
Breite 10 und die Höhe 20 hat, zweitens wird dieser Balken an die Koordinate 
point(I,J) angeheftet und drittens wird das Resultat an den Rahmen geschickt. 
Im trace-Modus können Sie sehen, dass an dieser Stelle tatsächlich ein neuer
Balken "an der richtigen Stelle" erscheint. Dieser Balken hat auch die 
richtigen Maße; er hat aber noch keine Farbe. In 19 holt XPCE die Objektliste
LIST_OF_OBJECTS. In diesem Beispiel besteht ein Objekt aus einem
Paar von (Namen von) Balken. In 20 fügt der Liste LIST_OF_OBJECTS das Paar 
[NAME_OF_BAR,NAME_OF_BAR1] hinzu. In 21 und 22 wird die Objektliste angepasst.

Am Ende der Schleife 11 sind alle Balken eingezeichnet. All diese Balken 
haben dieselbe Y-Koordinate, d.h. in dieser Phase haben alle Balken dieselbe
Höhe. 

In 23 werden zwei Hilfsobjekte konstruiert. In 24 

   send(@predator, display, new(@W1, text('tick')), point(20,162)),

wird das Prädikat "text" verwendet. Der Text selber wird in Anführungszeichen
als Argument benutzt. In 24 ist der Text sehr einfach; er besteht aus einem 
einzigen Wort "tick". Das Objekt ist hier also ein Text mit Inhalt "tick". 
Durch "new" bekommt dieses Objekt ("Text") einen Name @W1. Das Objekt (der 
Text) wird rechts oben an den Punkt point(20,162) mit den Koordinaten [20,162]
angehängt. Mit "send" wird dieser Text an den Rahmen geschickt. Das zweite  
Objekt ist ebenfalls ein Text, der an der entsprechenden Stelle in dem Bild
eingezeichnet wird. Beide Texte werden aber erst in 28 im Monitor sichtbar.
Das zweite Hilfsobjekt @W2 wird in 27 mit asserta(object(good,@W2)) an die
Datenbasis hinzugefügt. 

In 29 wird nun das Bild dynamisch verändert. In 30 wird zunächst der  
bestimmte Run eingesetzt. In unserem Beispiel wird dieser Fakt in 2 aus der
Datenbasis geholt. Weiter wird relativ zu diesem Run in Zeile 30.2 der maximale 
Wert maximal_value(MAX) über alle Werte VALUE aus den Fakten der Form 
(fact(2,TICK,wealth_take(ACTOR,VALUE))) berechnet. Dazu werden in 30.2 
all diese Fakten aus der Datenbasis geholt, in 30.3 sortiert und in 30.4
wird die Länge dieser Liste berechnet. Die letzte Komponente dieser Liste
ist der maximale Wert unter allen den Werten VALUE.

In 31 wird die Anzahl der Ticks und die Anzahl der Akteure geholt. In 32
wird eine Schleife über die Anzahl der Ticks gelegt. In 32 geschieht in einem
Schleifenschritt folgendes. In 33 werden die Eigenschaften der Objekte und 
Hilfsobjekte für diesen Tick vorbereitet. In 33 wird zunächst das Hilfsobjekt
OBJECT (ein Text) geholt. An dieses Objekt wird die Zahl TICK geschickt.
Inhaltlich schreibt XPCE an die Textstelle die Zahl TICK (z.B. TICK = 1).
Dies läst sich im trace-Modus nachprüfen. In 35 wird ein Parameter MAGNIFY
geholt, den wir verwenden, um die Höhe der blauen Balken zu skalieren.
Um die Änderung eines blauen Balkens zu erkennen, muss der Balken eine
gewisse Höhe haben. Wenn der Balken z.B. 15 Pixel hoch ist, wird eine 
Höhenveränderung kaum zu sehen sein. In diesem Fall kann die Veränderung
arithmetisch kleiner als "ein Pixel" sein. Bei Probeläufen haben wir den
Parameter per Hand eingestellt. Dies liesse sich natürlich auch theoretisch
bestimmen - was uns aber hier nicht so wichtig ist.

In 36 wird eine Schleife über die Akteure gelegt. In einem Schleifenschritt
wird in 37 die Objektliste geholt und das Objektpaar (Paar von Balken) für
den Akteur ACTOR bestimmt. In 38 wird die Stärke des Akteurs ACTOR aus der
Datenbasis geholt. Dieser Fakt wurde in 4 (in res363.pl) gefunden. In 38
haben wir die Stärke SA vergrößert. Von dem ersten Objekt OA1 aus dem Paar
wird die Position bestimmt (der linke obere Endpunkt des Balkens). Die
Y-Koordinate wird (die Stärke) berechnet. In diesem Beispiel bleibt dieser
Balken mit der Zeit gleich. In 40 wird die neue (und damit die alte) Höhe
an das Objekt gesendet. In 41 wird an dieses Objekt (an diesen Balken)
die "richtige" Farbe, grün, gechickt. In 42 wird diese Farbe aus sichtbar.

Analog verfahren wir bei dem Wert für den Akteur ACTOR. In 43 wird
der vorher berechnete maximale Wert geholt. In 44 wird die Position des
Objekts OA2 (der blaue Balken) geholt. In 45.1 wird unterschieden, ob der Akteur
noch einen positiven Wert besitzt oder nicht (V1 =< 0). Wenn ACTOR keinen
Besitz mehr hat, ist ihm auch Nichts mehr zu rauben, deshalb wird die Höhe des 
Balken auf Null (V = 0) gesetzt. Im anderen Fall wird die Höhe mit
V is MAGNIFY * (V1/MAX)*20 berechnet. An dieser Stelle sehen Sie das 
Skalierungsproblem. Wenn der maximale Wert über alle(!) Akteur viel größer 
ist als der Wert V1 des bestimmten Akteurs ACTOR, können wir oft eine
Änderung bei dem Akteur ACTOR graphisch nicht mehr erkennen. Inhaltlich
lassen sich solche Relationen nicht vermeiden. Der reichste Akteur bekommt
ein Balken, der z.B. 2000 Mal höher ist als der des armen Akteurs ACTOR. 
Da bei XPCE der blaue Balken von der Y-Koordinate nach unten hängt, müssen
wir die Zahl V1 in 45.2 von 160 abziehen. In 46 werden die neuen Daten an
das Objekt gesendet, in 47 wird das Objekt (der Balken, wieder) blau gefärbt
und in 48 wird das Resultat im Monitor zu sehen sein.

Damit ist die Schleife in 29 beendet. In 49 wird ein Name für das 
Hilfsobjekt, welche noch in der Datenbasis verhanden ist, gelöscht.
Schließlich wird in 50 auch das XPCE Fenster geschlossen. Das hier
verwendete Verfahren funktioniert auch ohne Etwas einzutragen.
*/

:- dynamic fact/3 .                                                      /* 1 */
choose_one_run(2).                                                       /* 2 */

start :-
   make_picture(predator).                                               /* 3 */

make_picture(predator) :-                                                /* 3 */
% trace,    
   consult('para363.pl'), consult('res363.pl'),                          /* 4 */
   VV3 = 'Picture-', concat(VV3,predator,Vd3),                           /* 5 */
   new(@predator, picture(Vd3)), send(@predator, open),                  /* 6 */
   send(@predator, display, new(Y_AXIS, line(5,5,5,160,first))),         /* 7 */
   send(@predator, display, new(X_AXIS, line(5,160,400,160,second))),    /* 8 */
   asserta(list_of_objects(predator,[])),                                /* 9 */
   periods(TICKS), choose_one_run(RUN),                                 /* 10 */
   make_objects(predator,TICKS,RUN),                                    /* 11 */
   make_other_objects(predator),                                        /* 23 */
   activate_picture(predator,RUN),                                      /* 29 */
   retractall(object(OO1,OO2)),                                         /* 49 */
   ask_for_end, destroy(Answer),!.                                      /* 50 */

make_objects(predator,TICKS,RUN) :-                                     /* 11 */
  number_of_actors(NUMBER_OF_ACTORS),                                   /* 12 */
  ( between(1,NUMBER_OF_ACTORS,ACTOR), make_cell(ACTOR,RUN), fail       /* 14 */
  ;
    true),
  send(@predator,flush),                                                /* 11 */
  list_of_objects(predator,OBJECT_LIST),                                /* 11 */
  asserta(list_of_objects(predator,OBJECT_LIST)),!.                     /* 11 */

make_cell(B,RUN) :-                                                     /* 14 */
   J is 140, I is 5 + (B-1)*20, I1 is I + 10,                           /* 15 */
   send(@predator, display, new(NAME_OF_BAR, box(10,20)), point(I,J)),  /* 16 */
   send(@predator, display, new(NAME_OF_BAR1,box(10,20)), point(I1,J)), /* 17 */
   send(@predator, flush),                                              /* 18 */
   list_of_objects(predator,OBJECT_LIST),                               /* 19 */
   append(OBJECT_LIST,[[NAME_OF_BAR,NAME_OF_BAR1]],OBJECT_LIST1),       /* 20 */
   asserta(list_of_objects(predator,OBJECT_LIST1)),                     /* 21 */
   retract(list_of_objects(predator,OBJECT_LIST)),!.                    /* 22 */

make_other_objects(predator) :-                                         /* 23 */
     send(@predator, display, new(@W1, text('tick')), point(20,162)),   /* 24 */
     send(@W1, flush),                                                  /* 25 */
     send(@predator, display, new(@W2, text('tick')), point(60,162)), /* 26 */
     asserta(object(tick,@W2)),                                         /* 27 */
     send(@W2, flush),!.                                                /* 28 */

activate_picture(predator,RUN) :-                                       /* 29 */
     choose_one_run(RUN), make_maxima(RUN),                             /* 30 */
     periods(TICKS), number_of_actors(NUMBER_OF_ACTORS),                /* 31 */
     ( between(1,TICKS,TICK), 
         depict_period(predator,TICK,NUMBER_OF_ACTORS,RUN), fail        /* 32 */
     ; true),!.

depict_period(predator,TICK,NUMBER_OF_ACTORS,RUN) :-                    /* 32 */
   update(predator,TICK),                                               /* 33 */
   magnify_by(MAGNIFY),                                                 /* 35 */
   ( between(1,NUMBER_OF_ACTORS,ACTOR), 
         update(predator,TICK,ACTOR,RUN,MAGNIFY), fail; true),!,        /* 36 */
   send(@predator,flush), sleep(2),!.                                   /* 36 */

update(predator,TICK) :- object(tick,OBJECT), send(OBJECT,string,TICK), /* 33 */
    send(OBJECT,flush),!.                                               /* 34 */

update(predator,TICK,ACTOR,RUN,MAGNIFY) :-                              /* 36 */
   list_of_objects(predator,OBL1), nth1(ACTOR,OBL1,[OA1,OA2]),          /* 37 */
   fact(RUN,TICK,strength(ACTOR,SA)), SA1 is 5*MAGNIFY*SA,              /* 38 */ 
   get(OA1, position, point(X,Y)), Y1 is 160 - SA1,                     /* 39 */
   send(OA1, position, point(X,Y1)), send(OA1,height,SA1),              /* 40 */
   send(OA1, fill_pattern, colour(green)),                              /* 41 */
   send(OA1,flush),                                                     /* 42 */
   fact(RUN,TICK,wealth_take(ACTOR,V1)), maximal_value(MAX),            /* 43 */
   get(OA2, position, point(X2,Y2)),                                    /* 44 */
   ( V1 =< 0, V is 0; V is MAGNIFY * (V1/MAX)*20 ) ,                   /* 45.1 */
   Y3 is 160-V,                                                       /* 45.2 */
   send(OA2, position, point(X2,Y3)), send(OA2,height,V),               /* 46 */
   send(OA2, fill_pattern, colour(blue)),                               /* 47 */
   send(OA2,flush),!.                                                   /* 48 */

make_maxima(RUN) :-                                                   /* 30.1 */
   findall(VALUE,fact(RUN,TICK,wealth_take(ACTOR,VALUE)),LIST_OF_VALUES), 
                                                                      /* 30.2 */
   sort(LIST_OF_VALUES,LIST_OF_VALUESnew),                            /* 30.3 */
   length(LIST_OF_VALUESnew,LENGTH),                                  /* 30.4 */
   nth1(LENGTH,LIST_OF_VALUESnew,MAX),                                /* 30.5 */ 
   asserta(maximal_value(MAX)),!.                                     /* 30.6 */

ask_for_end :-                                                          /* 50 */
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(@predator, destroy).







