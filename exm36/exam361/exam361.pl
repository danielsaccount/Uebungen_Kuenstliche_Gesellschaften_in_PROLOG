/* exam361 

Ein Programm für die bildliche Darstellung einer Funktion. Die Funktionswerte
sind als Punkte (Kreise) in der Fläche dargestellt, so dass jedem Argument
ein Funktionswert entspricht. Zu einem Tick sieht man die grobe Form der
Funktion zu diesem Tick. In dem Programm wird die Funktion in mehreren Ticks 
dargestellt. d.h die Funktion verändert sich mit der Zeit. 

In diesem Beispiel stellt die Funktion zu einer bestimmten Wiederholung ("run")
eines Ablaufs und für einen bestimmten Akteur ein Warenbündel dar, welches 
der Akteur zu einem Tick besitzt (siehe auch exm41). In diesem Beispiel wird 
in mehreren Ticks zu jedem Tick die Funktion neu dargestellt. Im Beispiel wird
das Güterbündel des Akteurs mit der Zeit geändert. Ein Wert einer bestimmten 
Ware wird hier durch einen hellblauen Kreis dargestellt. Mit der Zeit wandert 
ein solcher Kreis nach oben oder unten. Eine Verschiebung eines Kreises für 
eine bestimte Ware bedeutet, dass der Akteur mehr von der Ware hat als vorher
(Verschiebung nach oben), oder eben weniger (Verschiebung nach unten).
 
Für dieses Programm müssen die Güterbündel dieses Akteurs in den verschiedenen 
Ticks bereitliegen: fact(RUN,TICK,bundle(ACTOR,LIST)). Wir haben diese Fakten 
von einem anderen Programm (exam411, res411.pl) genommen. Wir haben dabei die Datei
res411.pl in res361.pl umgenannt. Auch die Parameter, die hier verwendet werden,
wurden dem Programm von exam411 kopiert und umbenannt in "para361.pl" vorhanden. 
In diesem Beispiel können wir daher die Parameter hier nicht ändern. Dazu müssten 
wir das Beispiel exam411 neu mit neuen Parametern durchlaufen lassen.
 
In 2 wird ein bestimmter Run festgelegt. Dadurch sehen Sie eine Wiederholung eines Ablaufs 
aus statistischen Zwecken. Die Bildsequenz stellt nur die Funktion innerhalb eines 
Runs (hier RUN = 2) dar. In 2 wird in derselben Weise auch ein bestimmter Akteur 
ausgewählt. Die dargestellte Funktion betrifft nur den bestimmten Akteur, hier 3.    

In 3 haben wir den Term make_picture(3,exchange1) eingeführt, um mehrere 
Bilder für dasselbe Programm unterscheiden zu können. Im Beispiel ist 
"exchange1" der Name des Programms und "3" besagt, dass es um das dritte
Bild geht. Im Beispiel wird diese Zahl 3 nicht benutzt.   

In 4 werden die Parameter und die Resultate geladen. In 5 wird ein bestimmter 
Run und ein bestimmter Akteur geholt; dies wurde in 2 festgelegt. In 6 wird 
die Anzahl NUMBER_OF_GOODS der Warenarten und die Anzahl TICKS der Ticks aus 
der Datenbasis geholt. Im Beispiel finden wir in para361.pl den Fakt good(4) und 
den Fakt periods(6). ("periods" bedeutet hier dasselbe wie "ticks").

In 7 wird der Name für das Bild konstruiert. Dazu fügen wir das in
Anführungszeichen geschriebene Wort 'Picture-' mit dem Wort exchange1 zusammen.
Im trace-Modus sehen Sie, dass in 7 die Variable Vd1 tatsächlich so aussieht:
Vd1 = Picture-exchange1. 

In 8 wird der Rahmen für dieses Bild als ein Objekt (@exchange1) erzeugt und
geöffnet. Mit send(@exchange1, open) sehen Sie, dass dieser neue Rahmen für 
dieses Bild im Monitor zu sehen ist. "send", "@exchange1" und "open" sind XPCE
Befehle.   

Im Weiteren werden einerseits die verschiedenen Bildelemente erzeugt, die 
zusammengenommen ein Bild ausmachen und andererseits diese Bildelemente bei
jedem Tick verändert. Bei den Bildelementen unterscheiden wir Objekte,
die sich mit der Zeit verändern, und andere Objekte, die sich mit der
Zeit nicht ändern. Die erste Art von Objekten wird in einer Liste 

   object_list(exchange1,LIST_OF_OBJECTS)

gesammelt. LIST_OF_OBJECTS enthält XPCE-Namen für veränderliche Objekte 
(hier: Kreise mit ihren Orten). Eine zweiten Liste von "Hilfsobjekte" wird 
durch

   list_of_other_objects(exchange1,LIST_OF_AUX_OBJECTS)

eingerichtet. 

Die Objektliste steht in diesem Programm im Zentrum. Ein Objekt aus dieser 
Liste wird in der zentralen Schleife in 15 ständig verändert. Das Objekt 
bekommt am Anfang einen Namen, etwa @exchange1. Dieser Name bleibt im Ablauf 
gleich. Zusätzlich werden dem Objekt weitere Eigenschaften mitgegeben; diese 
verändern sich mit der Zeit. Genauso bekommt jedes Hilfsobjekt einen Namen.

In 11 wird in diesem Programm die Y-Achse generiert und in das Bild 
eingezeichnet. Dazu wird in XPCE das Prädikat "display" und der Term 

    new(Y_AXIS, line(5,5,5,175,first))

verwendet. Die Variable Y_AXIS wird als "Name" für das neue Objekt "Y-Achse" 
benutzt. Durch diese Methode können dem Objekt weitere Eigenschaften 
zugesprochen werden. Anders gesagt ist es nicht nötig, der Y-Achse einen echten
Namen zu geben. Die Variable Y_AXIS reicht für den Ablauf aus.  

Mit dem Term line(5,5,5,175,first) zeichnet XPCE die Linie des "Names" Y_AXIS 
so, dass der Anfangspunkt der Linie der Punkt (die Koordinate) [5,5] ist und 
dass der Endpunkt der Linie der Punkt (die Koordinate) [5,175] ist. Der Befehl
"first" besagt, dass am Endpunkt der Linie ein Pfeil angebracht wird. Ganz 
genauso wird die X-Achse gezeichnet. Auch diese Achse bekommt einen "Namen" 
X_AXIS, zwei Anfangs- und Endkoordinaten und einen Pfeil.

In 13 werden die zentralen Objekte (hier Kreise, Funktionswerte) erzeugt. Dazu
wird in 14 eine Zahl für "height" aus der Datenbasis geholt, die in para361.pl 
zu finden ist. Die Zahl HEIGHT (hier HEIGHT = 175) gibt an, wie hoch wir das 
Bild werden lassen. Bei der Y-Achse hatten wir oben 175 festgelegt. Wenn der 
Rahmen des Bildes automatisch generiert wird, sehen wir, wieviel Platz es noch
nach oben gibt. Am Anfang geben wir den Objekten willkürlich festgelegte 
Koordinaten.  
 
In 15 wird eine Schleife über die Anzahl der Objekte (hier: Kreise,
Werte von Waren bestimmten Typs) gelegt. In diesem Programm brauchen wir die
Warentypen nicht von den Nummern dieser Warentypen zu unterschieden. D.h. 
eine Zahl GOOD (GOOD =< NUMBER_OF_GOOD) drückt gleichzeitig auch den 
Warentyp aus. In einem Schleifenschritt werden die Koordinaten eines Kreises 
berechnet. Dies geschieht wie folgt. In 16 wird die Nummer (der Ware) GOOD 
genommen und aus dieser Zahl die X-Koordinate durch "G1 is 5+5*GOOD" berechnet. 
Dazu wird die Anfangskoordinate 5 auf der X-Achse um 5*GOOD Pixel erhöht. 
Die Y-Koordinate wird folgendermaßen berechnet. XPCE holt in 14 die Höhe 
HEIGHT des Fensters und halbiert sie. Das Resultat wird, wenn nötig, zu einer
natürlichen Zahl ceiling(HEIGHT/2) aufgerundet. Die so gefundenen Zahlen
bilden die Koordinaten des Kreises: [G1,HEIGHT1]. In 17 wird mit

   send(@exchange1, display, new(NAME_OF_CIRCLE, circle(4)), point(G1,HEIGHT1)) 

erstens ein Kreis erzeugt, welcher den "Namen" NAME_OF_CIRCLE trägt und den 
Radius 4 hat, zweitens wird dieser Kreis an die Koordinate point(G1,HEIGHT1) 
angeheftet und drittens wird das Resultat an den Rahmen geschickt. Im 
trace-Modus können Sie sehen, dass an dieser Stelle tatsächlich ein neuer Kreis "an 
der richtigen Stelle" erscheint. Dieser Kreis hat auch den richtigen Durchmesser; 
er hat aber noch keine Farbe. In 18 holt XPCE die Objektliste LIST_OF_OBJECTS 
und fügt der Liste den Objektnamen NAME_OF_CIRCLE hinzu. In 19 und 20 wird 
diese Objektliste angepasst.

Am Ende der Schleife 15 sind alle Kreise eingezeichnet. All diese Kreise haben
dieselbe Y-Koordinate, d.h. in dieser Phase hat die Funktion die Form einer
Geraden. 

In 21 werden weitere Hilfsobjekt konstruiert und in die Liste 
LIST_OF_AUX_OBJECTS aufgenommen. Hier werden vier Hilfsobjekte in ähnlicher 
Weise konstruiert, so dass wir die vier Objekte mit einer Schleife 
generieren können. Dabei ist N einfach die N-te Art von Objekt, die 
erzeugt werden soll. In 23 wird die Liste OBJECT_LIST der Objekte geholt. In 
24 wird der Term make_one_object(exchange1,N,OBJECT) aufgerufen, welcher je 
nach der N-ten Art in Zeile 24-i (i=1,2,3,4) bearbeitet wird. In 24.1 wird das 
Prädikat "text" verwendet. Der Text selber wird in Anführungszeichen als 
Argument benutzt. In 24.1 ist der Text sehr einfach; er besteht aus einem 
einzigen Wort "actor". Das Objekt ist hier also ein Text mit Inhalt "actor". 
Durch "new" bekommt dieses Objekt ("Text") einen Name @W11. Das Objekt (der 
Text) wird rechts oben an den Punkt point(20,175) mit den Koordinaten [20,175]
angehängt. Mit "send" wird dieser Text an den Rahmen geschickt. Die drei 
anderen Objekte sind ebenfalls Texte, die an den entsprechenden Stellen in 
dem Bild eingezeichnet werden. All diese Texte werden aber erst in 29 im 
Monitor sichtbar.
 
In 25 wird das jeweils erzeugte Objekt OBJECT an die Hilfsliste angefügt, und 
in 26 und 27 wird diese Hilfsliste angepasst. In 28 wird die Hilfsliste
wieder geöffnet und für jede N-te Objektart der Objektname OBJECT_NAME 
herausgeholt. Mit "flush" und "send" wird das Objekt mit seinem Inhalt
(hier mit dem Text) im Monitor erscheinen. Dies lässt sich im trace-Modus 
auch nachprüfen.

Damit ist der statische Teil des Bildes erzeugt. Er ist auch im trace-Modus 
sichtbar.

In 30 wird nun das Bild dynamisch verändert. In 31 wird zunächst an zwei 
Stellen der Run und der Akteur eingesetzt. In einem vollständigen Programm
sind diese Variablen schon bekannt. In unserem Beispiel werden diese
Fakten in 2 aus der Datenbasis geholt. In 32 werden diese beiden Fakten an 
die passenden Stellen eingezeichnet. Dazu wird in 33 die Objektliste geholt 
und das zweite (2) Hilfsobjekt bestimmt: OBJECT2. An dieses Objekt, 
welches den Typ "Text" hat, wird der Namen (die Zahl) ACTOR des Akteurs an 
dieses Objekt gesendet. Mit "flush" wird diese Zahl in 34 im Monitor rechts 
von dem Text OBJECT2 erscheinen. In ähnlicher Weise wird in 35 und 36 das 
vierte (4) Hilfsobjekt OBJECT4 behandelt.

In 39 wird die Anzahl der Waren und die Anzahl TICKS der Ticks geholt. In 40
wird eine Schleife über die Anzahl der Ticks gelegt. In einem Schleifenschritt
werden in 40 für einen Tick alle Warenwerte aus dem Warenbündel des Akteurs 
ACTOR verändert. D.h. in einem Tick wird die Form der Funktion verändert. 
 
In 53 haben wir nach jedem Schleifenschritt mit dem XPCE Befehl sleep(_)
dem Programm eine kleine Ruhepause verordnet. Im Beispiel haben wir die Zahl
1 eintragen: sleep(1). Hier bezeichnet "1" eine Dauer in Sekunden. D.h. im
normalen Modus (ohne trace) wird nach jedem Tick eine Sekunde gewartet. In
dieser Pause können wir die Form der Funktion "mit einem Blick" erfassen.
Nach einer Sekunde erscheint die Funktion in veränderter Form. Die Schleife
in 40 stellt mit anderen Worten eine Sequenz von Bildern gar.  

In 41 wird für den Akteur ACTOR, den Run RUN und den Tick TICK das Warenbündel
BUNDLE aus der Datenbasis geholt. Dieser Fakt wurde aus der Datei res361.pl 
in 4 in die Datenbasis geladen. Weiter wird die Länge des Bündels berechnet.
In 42 wird über die Anzahl der Warentypen eine Schleife gelegt. In einem
Schleifenschritt in 42 wird ein bestimmter Warentyp GOOD bearbeitet.

In 43 wird der Wert VALUE der Ware GOOD bestimmt, welcher aus dem Warenbündel 
BUNDLE für ACTOR zu finden ist. Wir haben hier aus Kürze ein "Pie-Mal-Daumen"
Verfahren benutzt, um diese Warenwerte, die zu den verschiedenen Ticks 
entstehen, zu skalieren. In para361.pl haben wir eine Prozentzahl MAG mit
magnify_by(MAG) eingetragen. Diese Zahl legen wir nach einigen Probeläufen so
fest, dass all die Funktionswerte in das Bild passen. Wenn wir die
Werte nicht skalieren, kann die Funktion fast die Form einer Linie haben, weil 
alle Werte sehr klein sind. Es kann auch passieren, dass einige Werte 
so groß werden, dass sie in im XPCE-Rahmen nicht mehr zu sehen sind. D.h. solche 
Werte lassen sich nicht sichtbar machen. 

In 44 und 45 wird aus der Höhe der Rahmens HEIGHT und der Konstanten MAG
der Wert VALUE neu justiert. In 47 wird die X-Koordinate des Objekts (GOOD)
bestimmt. In 47 wird die gerade aktive Position des Punktes point(X,Y) aus der
Datenbasis geholt. In 48 wird diese Position einfach "überladen". D.h. der
alte Wert point(X,Y) wird in der Datenbasis durch den neuen Wert
point(GOODnew,VALUEnew) ersetzt. In 49 haben wir eine bestimmte Farbe
festlegt. "colour1" ist dabei ein von uns vergebener Name für diese Farbe.
In XPCE wird in diesem Beispiel aus den drei Zahlen 

     00344,32210,54333
 
in der Computerfarbwelt von RGB ein hellblauer Farbton herauskommen. 
In 50 wird diese Farbe mit "send" an das Objekt gesendet. Als eine 
auskommentierte Zeile in 51 haben wir auch eine andere Methode beschrieben. 
In 51 wird im Beispiel statt den drei Zahlen 00344,32210,54333 der Term
colour(red) verwendet. Neben dem Prädikat "red" sind in XPCE noch einige
weitere Terme für Farben verfügbar: "green", "blue" etc. Schließlich  
wird diese Farbe in 52 mit "flush" auch im Monitor zu sehen sein. 

Damit ist die Schleife in 30 beendet. In 54 wird schließlich noch das
XPCE Fenster geschlossen. In unserem Beispiel funktioniert dies auch ohne 
etwas einzutragen.
  */

:- dynamic fact/3 .                                                         /* 1 */
choose_run_exchange1(2). choose_actor_exchange1(3).                         /* 2 */


start :-
   make_picture(3,exchange1).                                               /* 3 */

make_picture(3,exchange1) :-                                                /* 3 */
% trace, 
   consult('para361.pl'), consult('res361.pl'),                             /* 4 */
   choose_run_exchange1(RUN), choose_actor_exchange1(ACTOR),                /* 5 */
   goods(NUMBER_OF_GOODS), periods(TICKS),                                  /* 6 */
   VV1 = 'Picture-', concat(VV1,exchange1,Vd1),                             /* 7 */
   new(@exchange1, picture(Vd1)), send(@exchange1, open),                   /* 8 */ 
   asserta(object_list(exchange1,[])),                                      /* 9 */
   asserta(other_object_list(exchange1,[])),                               /* 10 */
   send(@exchange1, display, new(Y_COORDINATE, line(5,5,5,175,first))),    /* 11 */
   send(@exchange1, display, new(X_COORDINATE, line(5,175,350,175,second))),  
                                                                           /* 12 */       
   make_objects(exchange1,NUMBER_OF_GOODS,ACTOR),                          /* 13 */
   make_other_objects(exchange1),                                          /* 21 */
   activate_picture(exchange1,ACTOR,RUN),                                  /* 30 */
   ask_for_end.                                                            /* 54 */

make_objects(exchange1,NUMBER_OF_GOODS,ACTOR) :-                           /* 13 */
    height(exchange1,HEIGHT),                                              /* 14 */
    ( between(1,NUMBER_OF_GOODS,GOOD), make_dots(exchange1,GOOD,ACTOR,HEIGHT), 
        fail; true),!.                                                     /* 15 */

make_dots(exchange1,GOOD,ACTOR,HEIGHT) :-                                  /* 15 */
   G1 is 5+5*GOOD, HEIGHT1 is ceiling(HEIGHT/2),                           /* 16 */
   send(@exchange1, display, new(NAME_OF_CIRCLE, circle(4)), point(G1,HEIGHT1)),                                                                                  /* 17 */
   object_list(exchange1,OL), append(OL,[NAME_OF_CIRCLE],OL1),             /* 18 */
   retract(object_list(exchange1,OL)),                                     /* 19 */
   asserta(object_list(exchange1,OL1)),!.                                  /* 20 */

make_other_objects(exchange1) :-                                           /* 21 */
   ( between(1,4,N), make_other_objects(exchange1,N), fail ; true),        /* 22 */
    other_object_list(exchange1,OBJECT_LIST),                              /* 28 */
   ( between(1,4,N), nth1(N,OBJECT_LIST,OBJECT), 
                                   send(OBJECT,flush), fail; true),!.      /* 29 */
   
make_other_objects(exchange1,N) :-                                         /* 22 */
    other_object_list(exchange1,OBJECT_LIST),                              /* 23 */
    make_one_object(exchange1,N,OBJECT),                                   /* 24 */
    append(OBJECT_LIST,[OBJECT],OBJECT_LISTnew),                           /* 25 */
    retract(other_object_list(exchange1,OBJECT_LIST)),                     /* 26 */
    asserta(other_object_list(exchange1,OBJECT_LISTnew)),!.                /* 27 */

make_one_object(exchange1,1,@W11) :- 
   send(@exchange1, display, new(@W11, text('actor')), point(20,175)).   /* 24.1 */
make_one_object(exchange1,2,@W12) :- 
   send(@exchange1, display, new(@W12, text('number')), point(60,175)).  /* 24.2 */
make_one_object(exchange1,3,@W13) :- 
   send(@exchange1, display, new(@W13, text(' , run')), point(110,175)). /* 24.2 */
make_one_object(exchange1,4,@W14) :- 
   send(@exchange1, display, new(@W14, text('number')), point(150,175)). /* 24.2 */

activate_picture(exchange1,ACTOR,RUN) :-                                   /* 30 */
   update(exchange1,RUN,ACTOR),                                            /* 32 */
   object_list(exchange1,LIST_OF_OBJECTS),                                 /* 38 */
   goods(NUMBER_OF_GOODS), periods(TICKS),                                 /* 39 */
   ( between(1,TICKS,TICK), 
     display_run(exchange1,TICK,NUMBER_OF_GOODS,ACTOR,LIST_OF_OBJECTS,
                 RUN),                                                     /* 40 */
     sleep(1),                                                             /* 53 */
     fail
   ; 
     true
   ),!.

display_run(exchange1,TICK,NUMBER_OF_GOODS,ACTOR,LIST_OF_OBJECTS,RUN) :-   /* 40 */
   fact(RUN,TICK,bundle(ACTOR,BUNDLE)), length(BUNDLE,E),                  /* 41 */
   ( between(1,NUMBER_OF_GOODS,GOOD), 
     make_bundle(GOOD,RUN,TICK,ACTOR,LIST_OF_OBJECTS,BUNDLE), fail         /* 42 */
   ; true
   ),!.

make_bundle(GOOD,RUN,TICK,ACTOR,LIST_OF_OBJECTS,BUNDLE) :-                 /* 42 */
    nth1(GOOD,BUNDLE,VALUE),                                               /* 43 */
    magnify_by(MAG), height(exchange1,HEIGHT),                             /* 44 */
    W is MAG*VALUE, VALUEnew is HEIGHT-W,                                  /* 45 */
    nth1(GOOD,LIST_OF_OBJECTS,OBJECT), GOODnew is 5+5*GOOD,                /* 46 */
    get(OBJECT, position, point(X,Y)),                                     /* 47 */
    send(OBJECT, position, point(GOODnew,VALUEnew)),                       /* 48 */
    COLOUR = colour(colour1,00344,32210,54333),                            /* 49 */
               send(OBJECT, fill_pattern, COLOUR),                         /* 50 */
%   send(OBJECT, fill_pattern, colour(red)),                               /* 51 */ 
    send(OBJECT,flush),!.                                                  /* 52 */ 

update(exchange1,RUN,ACTOR) :-                                             /* 32 */
  other_object_list(exchange1,LIST_OF_OBJECTS),                            /* 33 */
  nth1(2,LIST_OF_OBJECTS,OBJECT2),                                         /* 34 */
  send(OBJECT2,string,ACTOR), send(OBJECT2,flush),                         /* 35 */
  nth1(4,LIST_OF_OBJECTS,OBJECT4), send(OBJECT4,string,RUN),               /* 36 */ 
  send(OBJECT4,flush),!.                                                   /* 37 */

ask_for_end :-                                                             /* 54 */
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(@exchange1, destroy). 











