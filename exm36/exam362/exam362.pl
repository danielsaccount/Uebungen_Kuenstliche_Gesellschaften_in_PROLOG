/* exam362

Ein Programm zur grafischen Darstellung von Nachbarschaften der Akteure in einem 
Zellraster, wobei sich die Nachbarschaften mit der Zeit ändern.

In diesem Beispiel wird die Belegung der Zellen durch Akteure zweier Arten 
(blau und schwarz) dargestellt. Die nicht belegten Zellen bleiben weiß. 

Es bildet sich für eine Wiederholung ("Run") eine Sequenz von Rastern. Der
Run ist am Anfang als Fakt festgelegt. 

Für dieses Programm müssen Fakten folgender Art bereit liegen:  
    fact(RUN,TICK,colour(ACTOR,COLOUR)),
    fact(RUN,TICK,location(ACTOR,COORD_I,COORD_J)). 

Wir haben diese Fakten von einem anderen Programm (exam411, res411.pl) 
kopiert. Ebenso wurden die Parameter aus dem Programm exam411 übernommen. 
Die Patrameter sind hier in einer Datei "para362.pl" vorhanden. Wir können hier 
die Parameter in diesem Beispiel hier nicht einfach verändern. Dazu 
müssten wir vorher das Beispiel exam411 mit neuen Parametern
durchlaufen lassen und die Parameter und Resultate anch exam362 schicken.
 
In 2 wird ein bestimmter Run festgelegt; eine Wiederholung eines Ablaufs 
für statistische Zwecke. Die Bildsequenz stellt nur die Funktion innerhalb 
eines Runs (hier RUN = 2) dar. 

In 4 werden die Parameter und die Resultate geladen. In 5 wird ein 
bestimmter Run und die Anzahl der Ticks ("periods") aus der Datenbasis 
geholt. In 6 wird der Name für das Bild konstruiert. Dazu fügen wir das 
in Anführungszeichen geschriebene Wort 'Picture-' mit dem Wort "schelling"
zusammen. Im trace-Modus sehen wir, dass in 7 die Variable Vd1 
tatsächlich so aussieht: Vd1 = Picture-schelling. In 8 wird der Rahmen 
für dieses Bild als ein Objekt (@schelling) erzeugt und geöffnet. Mit
send(@schelling, open) sehen wir, dass dieser neue Rahmen für dieses Bild im
Monitor zu sehen ist. "send", "@" und "open" sind XPCE Befehle.   

Im Weiteren werden einerseits die verschiedenen Bildelemente erzeugt, die 
zusammengenommen ein Bild ausmachen und andererseits diese Bildelemente bei
jedem Tick verändert. Bei den Bildelementen unterscheiden wir Objekte,
die sich mit der Zeit verändern, und andere Objekte, die sich mit der
Zeit nicht ändern. Die erste Art von Objekten wird in einer Liste 

   object_list(schelling,LIST_OF_OBJECTS)

gesammelt. LIST_OF_OBJECTS enthält XPCE-Namen für veränderliche Objekte 
(hier: Quadrate ("Boxen") mit ihren Orten). Eine zweite Liste von 
"Hilfsobjekten" wird durch

   list_of_other_objects(schelling,LIST_OF_AUX_OBJECTS)

eingerichtet. 

Die Objektliste steht in diesem Programm im Zentrum. Ein Objekt aus dieser 
Liste wird in der zentralen Schleife in 30 ständig verändert. Das Objekt 
bekommt am Anfang einen Namen. Dieser Name bleibt im Ablauf gleich. 
Zusätzlich werden dem Objekt weitere Eigenschaften mitgegeben; diese 
verändern sich mit der Zeit. Genauso bekommt jedes Hilfsobjekt einen 
Namen.

In 8 - 19 werden die zentralen Objekte (hier Boxen) erzeugt. Dazu wird in 
9 eine Zahl für "height" aus der Datenbasis geholt, die in para362.pl 
zu finden ist. Die Zahl HEIGHT (hier HEIGHT = 175) gibt an, wie hoch wir 
das Bild werden lassen. Wenn der Rahmen des Bildes automatisch generiert 
wird, sehen Sie, wieviel Platz es noch nach oben gibt, falls die Anzahl der 
Zellen erhöht werden müssen. 
 
In 10 werden zwei Parameter geholt. GRIDWIDTH ist eine Zahl (hier 
GRIDWIDTH = 4), die besagt wieviele Zeilen ("rows") und Spalten
("columns") in diesem Zellraster benutzt werden ("Grobkörnigkeit"). 
Im Beispiel gibt es 4 Zeilen und 4 Spalten. SIZE ist eine Zahl (hier SIZE = 10). 
Sie besagt, wie lang (und breit) eine Box ist. Als Einheit dient dabei 
die Einheit "Pixel", die dem XPCE-Programm vertraut ist. Anders gesagt 
beträgt die Länge einer Box 10 Pixel. 

In 11 werden zwei Schleifen über die Zeilen und die Spalten gelegt.
In der ersten Schleife wird in einem Schleifenschritt in 12 eine Zeile
bearbeitet und in der zweiten Schleife über die Spalten in einem
Schleifenschritt eine Spalten bearbeitet. In 13 wird aus der 
Zeilennummer ROW_NUMBER die entsprechende Y-Koordinate und in 14 aus der
Spaltennummer COLUMN_NUMBER die entsprechende X-Koordinate einer Box
berechnet. In 15 wird  mit  

  send(@schelling, display, new(NAME_OF_BOX,box(SIZE,SIZE)), 
          point(ROW_COORD,COLUMN_COORD))

erstens eine Box erzeugt, welche den "Namen" NAME_OF_BOX trägt und die 
"Größe" SIZE (hier 10) hat, zweitens wird diese Box an die Koordinate 
point(ROW_COORD,COLUMN_COORD) angeheftet und drittens wird das Resultat 
an den Rahmen geschickt. Im trace-Modus können Sie sehen, dass an 
dieser Stelle tatsächlich eine neue Box "an der richtigen Stelle" 
erscheint. Diese Box hat auch die richtige Größe; sie hat aber noch 
keine Farbe. In 16 holt XPCE die Objektliste LIST_OF_OBJECTS und in 17
wird der Objektnamen NAME_OF_BOX an diese Liste angefügt. In 18 und 19 
wird diese Objektliste angepasst.

Am Ende der Schleife 8 sind alle Boxen eingezeichnet. All diese Boxen 
sind in dieser Phase weiß.

In 20 werden weitere Hilfsobjekt konstruiert und in die Liste 
LIST_OF_AUX_OBJECTS aufgenommen. Hier werden vier Hilfsobjekte 
konstruiert, die alle den Typ "Text" haben. In 21 wird mit "text(_)"
ein Text erzeugt, welcher in Anführungszeichen stehen muss. Der Text 
selbst wird also in dieser Weise als Argument des Prädikats text(_) 
benutzt. In 21 ist der Text sehr einfach; er besteht aus einem 
einzigen Wort "period". Das Objekt ist hier also ein Text mit Inhalt 
"period". Durch "new" bekommt dieses Objekt ("Text") einen Name @W21. 
Das Objekt (der Text) wird rechts oben an den Punkt point(20,162) mit 
den Koordinaten [20,162] angehängt. Mit "send" wird dieser Text an den 
Rahmen geschickt. Die drei anderen Objekte sind ebenfalls Texte, die 
an den entsprechenden Stellen in dem Bild eingezeichnet werden. All 
diese Texte werden mit dem Befehl "flush" im Bildschirm sichtbar.

Damit ist der statische Teil des Bildes erzeugt. Er ist auch im trace-Modus 
sichtbar.

In 30 wird nun das Bild dynamische verändert. In 31 - 33 wird die
Grobkörnigkeit, die Anzahl der Akteure, die Anzahl der Ticks und die
die Liste der Objekte geholt. In 34 wird die zentrale Schleife über die
Ticks gelegt. Am Ende eines Ticks pausiert das Programm 2 Sekunden:
sleep(2). In jedem Tick wird das Zellraster angepasst, so dass die Akteure
von einer Zelle zu einer anderen umziehen können. Z.B. lebte ein blauer
Akteur auf einer Zelle [2,3], zieht er am Ende des Ticks um zu der Zelle
[1,3], welche für den nächsten Tick noch frei ("weiß") war. Die blaue Zelle 
[2,3] wird in nächste Tick weiß und [1,3] wird im nächsten Tick blau sein. 

In einem Schleifenschritt in 35 wird in 36 die Anzahl der Zellen berechnet:
NUMBER_OF_CELLS. In 37 werden die Hilfsobjekte für diesen Tick angepasst.
In 38 und 39 wird dazu der ausgesuchte Run RUN und die Hilfsliste 
LIST_OF_AUX_OBJECTS geholt. In 40 wird des zweite (2) Hilfsobjekt OBJECT
aus der Liste geholt. Die Zahl RUN wird in 41 an das Objekt OBJECT 
geschickt, wobei der Ort für das OBJECT schon vorher bekannt war. Diese
Zahl wird als Text so an die richtige Stelle eingehängt. Mit "flush" wird
dies in 41 auch sichtbar gemacht. Genauso wir das 4-te Hilfsobjekt an
den richtigen Ort geschickt und die Zahl TICK an diese Stelle eingehängt. 

In 44 - 46 wird in einem Schleifenschritt für eine bestimmte Zelle
zunächst die Zelle "umgestrichen" auf Weiß. Dies ist eine von mehreren
Möglichkeiten. Am Ende eines Ticks, müssen wir die Zellen weiß
streichen, aus denen Akteure weggezogen sind. Wir machen dies, indem
wir zunächst alle(!) Zelle weiß steichen. In 45 wird die Zelle OBJECT
aus der Liste geholt und in 46 wird an diese Zelle mit dem Befehl 
fill_pattern eine bestimmte Farbe geschickt. Hier verwenden wir  
den Term colour(white). Wenn die Zelle im Ablauf am Anfang des Ticks 
z.B. blau war, wird sie wieder weiß.

In 48 wird eine weitere Schleife noch Einmal über die Zelle gelegt.
In 49 und 50 werden nun zwei Fakten aus der Datenbasis geholt, die in 
einem anderen Programm (hier: exam411) als Resultate erzeugt wurden. 
In 49 wird mit anderen Wort die Farbe COLOUR des Akteurs zum Run RUN
und zum Tick TICK geholt. Und in 50 der Ort location(ACTOR,_,_)
des Akteurs. Aus den Ortskoordinaten [COORD_I,COORD_J] wird in 51
die Zelle (das Objekt) berechnet, welche mit dem Ort verbunden ist.
Dazu wird erst die Nummer der Zelle bestimmt und in 52 wird aus dieser 
Nummer der entsprechende Objektnamen aus der Liste LIST_OF_OBJECTS
geholt. OB ist der Name der Zelle. In 53 und 54 wird die Variable COLOUR,
die instantiiert wurde, untersucht. Wenn COLOUR die Form "black" hat,
wird der Zelle OB die Farbe "black" geschickt. Im anderen Fall bekommt
die Zelle die Farbe "blau". Mit "fill_pattern" wird nun das Objekt (die
Box, Zelle) blau gefärbt. 
 
Damit ist die Schleife in 30 beendet. In 57 wird schließlich noch das
XPCE Fenster geschlossen. In unserem Beispiel funktioniert dies auch ohne 
etwas einzutragen.
  */

:- dynamic fact/3 .                                            /* 1 */
choose_run_shelling(2).                                        /* 2 */

start :-
   make_picture(shelling).                                     /* 3 */

make_picture(shelling) :-                                      /* 3 */
% trace, 
   consult('para362.pl'), consult('res362.pl'),                /* 4 */
   choose_run_shelling(RUN), periods(TICKS),                   /* 5 */
   VV1 = 'Picture-', concat(VV1,shelling,Vd1),                 /* 6 */
   new(@shelling, picture(Vd1)), send(@shelling, open),        /* 7 */ 
   asserta(object_list(shelling,[])),
   make_objects(shelling,TICKS),                               /* 8 */
   make_other_objects(shelling),                              /* 20 */
   activate_picture(shelling,RUN),                            /* 30 */
   ask_for_end.                                               /* 57 */

make_objects(shelling,TICKS) :-                                /* 8 */
  height(shelling,HEIGHT),                                     /* 9 */
  gridwidth(GRIDWIDTH), size_of_boxes(SIZE),                  /* 10 */
  ( between(1,GRIDWIDTH,ROW_NUMBER),
      make_row(ROW_NUMBER,GRIDWIDTH,SIZE), 
      fail; true),!.                                          /* 11 */

make_row(ROW_NUMBER,GRIDWIDTH,SIZE) :-                        /* 11 */
   ( between(1,GRIDWIDTH,COLUMN_NUMBER), 
         make_column(ROW_NUMBER,COLUMN_NUMBER,SIZE), fail     /* 12 */
   ; true),!.

make_column(ROW_NUMBER,COLUMN_NUMBER,SIZE) :-                 /* 12 */
   ROW_COORD is (ROW_NUMBER-1)*SIZE,                          /* 13 */
   COLUMN_COORD is (COLUMN_NUMBER-1)*SIZE,                    /* 14 */
   send(@shelling, display, new(NAME_OF_BOX, box(SIZE,SIZE)), 
          point(ROW_COORD,COLUMN_COORD)),                     /* 15 */
   object_list(shelling,LIST_OF_OBJECTS),                     /* 16 */
   append(LIST_OF_OBJECTS,[NAME_OF_BOX],LIST_OF_OBJECTS1),    /* 17 */
   retract(object_list(shelling,LIST_OF_OBJECTS)),            /* 18 */
   asserta(object_list(shelling,LIST_OF_OBJECTS1)),!.         /* 19 */

make_other_objects(shelling) :-                               /* 20 */
    send(@shelling, display, new(@W21, text('period')),       /* 21 */
    point(20,162)), send(@W21, flush),                        /* 22 */
    send(@shelling, display, 
             new(@W22,text('number')), point(60,162)          /* 23 */
        ), 
    send(@W22, flush),                                        /* 24 */
    send(@shelling, display, new(@W23,text('tick')),
             point(135,162)                                   /* 25 */
        ), 
    send(@W23, flush),                                        /* 26 */
    send(@shelling, display, new(@W24, text('number')),
    point(160,162)),                                          /* 27 */
    send(@W24, flush),                                        /* 28 */
    asserta(other_object_list(shelling,[@W21,@W22,@W23,@W24])),!.
                                                              /* 29 */

activate_picture(shelling,RUN) :-                             /* 30 */
   gridwidth(GRIDWIDTH), actors(NUMBER_OF_ACTORS),            /* 31 */
   periods(TICKS),                                            /* 32 */
   object_list(shelling,LIST_OF_OBJECTS),                     /* 33 */
   ( between(1,TICKS,TICK), 
       display_run(shelling,RUN,TICK,NUMBER_OF_ACTORS,GRIDWIDTH,
       LIST_OF_OBJECTS),                                      /* 34 */
       sleep(1),
       fail
   ; 
     true
   ),
   retract(object_list(shelling,LIST_OF_OBJECTS)),!.          /* 56 */

display_run(shelling,RUN,TICK,NUMBER_OF_ACTORS,GRIDWIDTH,
   LIST_OF_OBJECTS) :-                                        /* 35 */
   NUMBER_OF_CELLS is GRIDWIDTH * GRIDWIDTH,                  /* 36 */
   update(shelling,TICK),                                     /* 37 */
   ( between(1,NUMBER_OF_CELLS,CELL_X),                       /* 44 */
     nth1(CELL_X,LIST_OF_OBJECTS,OB),                         /* 45 */
     send(OB, fill_pattern, colour(white)),                   /* 46 */
     send(OB, flush), fail                                    /* 47 */
    ; true
    ),!, 
    ( between(1,NUMBER_OF_ACTORS,ACTOR),
         display(shelling,RUN,TICK,GRIDWIDTH,LIST_OF_OBJECTS,ACTOR), 
         fail                                                 /* 48 */
    ; true),!.

display(shelling,RUN,TICK,GRIDWIDTH,LIST_OF_OBJECTS,ACTOR) :-  /* 48 */    
   fact(RUN,TICK,colour(ACTOR,COLOUR)),                        /* 49 */
   fact(RUN,TICK,location(ACTOR,COORD_I,COORD_J)),             /* 50 */
   N is (COORD_I-1)*GRIDWIDTH + COORD_J,                       /* 51 */
nth1(N,LIST_OF_OBJECTS,OB),                                    /* 52 */
   ( COLOUR = black, X = colour(black)                         /* 53 */
   ; 
     COLOUR = white, X = colour(blue)                          /* 54 */
   ),
   send(OB, fill_pattern, X), send(OB, flush),!.               /* 55 */

update(shelling,TICK) :-                                       /* 37 */
   choose_run_shelling(RUN),                                   /* 38 */
   other_object_list(shelling,LIST_OF_AUX_OBJECTS),            /* 39 */
   nth1(2,LIST_OF_AUX_OBJECTS,OBJECT),                         /* 40 */
   send(OBJECT,string,RUN), send(OBJECT,flush),                /* 41 */
   nth1(4,LIST_OF_AUX_OBJECTS,OBJECT1),                        /* 42 */
   send(OBJECT1,string,TICK), send(OBJECT1,flush),!.           /* 43 */

ask_for_end :-                                                 /* 57 */
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(shelling, destroy). 











