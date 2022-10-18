/* exam351 

Ein Gesamtintervall [1,....,NUMBER_OF_OBJECTS] wird in disjunkte Teilintervalle 
geteilt, wobei die Längen der Teilintervalle zufällig ausgewählt werden.

Als Objekte nehmen wir die Zahlen 1,....,NUMBER_OF_OBJECTS (hier = 10).
Das Gesamtintervall wird in diesem Beispiel in 3 Intervalle geteilt. In 3 
wird die Resultatdatei geleert. In 4 werden die Fakten aus der Datenbasis 
geholt. 

In 5 werden rechte Intervallgrenzen erzeugt. Dazu wird in 7 eine leere 
Hilfsliste einrichtet. In einem ersten Fall gibt es in 8 genau ein Objekt. Diese
Fall kann in diesem Beispiel (number_of_objects(10)) nicht eintreten. 
In diesem Fall wird eine ein-elementige Liste [NUMBER_OF_OBJECTS] in die 
Hilfsliste eingetragen. Im zweiten, normalen Fall gibt es in 9 mehrere Objekte. 
In 10 wird eine Schleife über die Anzahl NUMB_OF_INTERVALS von Intervallen gelegt.

In 10.1 wird die Hilfsliste geholt. In 10.2 wird eine Zufallszahl Y gezogen.
Dies hat Erfolg, wenn diese Zahl noch nicht in der Liste LIST zu finden
ist. In 10.3 und 10.4 gibt es eine Fallunterscheidung. Im Normalfall in 10.4
wird die gezogene Zahl Y in die Hilfsliste eingetragen. Im anderen Fall, 
wird in 10.3 als letzte, rechte Intervallgrenze die Zahl NUMBER_OF_OBJECTS
genommen. In 10.5 wird die Hilfsliste angepasst.
 
In 11 wird die vollständige Liste LIST aus der Datenbasis geholt und sortiert.
Diese Liste von rechten Grenzintervallen wird in 12 an die Resultatdatei 
res351.pl geschickt. In 13 wird eine Liste der Intervalle eingerichtet, die 
zunächst leer ist. 

In 14 wird eine weitere Schleife über die Anzahl der Intervalle gelegt. In 16
wird die Intervallliste geholt und ihre Länge LENGTH bestimmt. In einem 
Schleifenschritt können nun verschiedene Fälle auftreten. Im ersten Fall in 17
geht es um den ersten Schleifenschritt (Z = 1) und um den Fall, dass es nur ein 
einziges (NUMBER_OF_OBJECTS = 1) Objekt gibt. In diesem Fall wird in 18 das 
Intervall [1,NUMBER_OF_OBJECTS] in die Intervallliste eingetragen und die Liste
angepasst. 

Im zweiten Fall in 20 ist Z = 1 und die Zahl der Objekte ist größer als 1. 
In 20 wird die Z-te Komponente B aus der Hilfsliste LISTnew herausgegriffen, 
in 21 wird das Intervall [1,B] zur Intervallliste hinzugefügt und die Liste
wird angepasst. 

Im dritten Fall in 24 geht es um den "normalen" Schleifenschritt. In diesem Fall
ist das Intervall Nr. Z weder das erste noch das letzte Intervall aus der 
Zahlenreihe 1,...,NUMB_OF_INTERVALS. In 24 wird die im Moment letzte,
rechte Intervallgrenze [A,B] aus der Liste INTERVALS geholt. Für das nächste
Intervall nehmen wir in 25 als linke Grenze die Zahl Bn (Bn = B + 1), d.h. das
nächste Intervall schließt direkt an das Intervall [A,B] an. In 26 wird die
Länge LENGTH der Intervalliste INTERVALS um Eins erhöht. An dieser Stelle wird
nun in 26 die LENGTHnew-te Komponente C aus der Hilfsliste LISTnew herausgegriffen. 
In 27 wird dieses "nächstes" Intervall [Bn,C] der Intervallliste 
hinzugefügt und die Intervallliste angepasst. Im letzten Fall in 29 geht es 
bei dem Schleifenschritt um die letzte Zahl Z (Z = NUMB_OF_INTERVALS). Hier 
wird in 30 das in diesem Moment "letzte" Intervall [A,B] aus der Liste INTERVALS geholt. 
Die linke Intervallgrenze für das "nächste" Intervall ist Bn, Bn = B + 1, und 
als rechte Grenze nehmen wir in diesem Fall einfach das letzte Objekt. Das 
Intervall hat also die Form [Bn,NUMBER_OF_OBJECTS]. Dieses Interall wird in
die Intervallliste eingetragen und diese Liste angepasst.  

Schießlich wird in 15 diese Intervallliste aus der Datenbasis gelöscht
und diese Liste in 6 an die Resultatdatei res351.pl geschickt.  
*/

number_of_objects(10).                                                       /* 1 */
number_of_intervals(3).                                                      /* 2 */

start :-
  ( exists_file('res351.pl'), delete_file('res351.pl') ; true ),             /* 3 */
  number_of_objects(NUMBER_OF_OBJECTS), 
  number_of_intervals(NUMB_OF_INTERVALS),                                    /* 4 */
  make_intervals(NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS,INTERVALS),             /* 5 */
  append('res351.pl'), write(intervals(INTERVALS)), write('.'), nl, told.    /* 6 */ 

make_intervals(NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS,INTERVALS) :-             /* 5 */
  asserta(aux_list([])),                                                     /* 7 */
  ( NUMBER_OF_OBJECTS  = 1, LIST = [NUMBER_OF_OBJECTS], 
    asserta(aux_list(LIST))                                                  /* 8 */
  ;
    NUMBER_OF_OBJECTS > 1,                                                   /* 9 */
    ( between(1,NUMB_OF_INTERVALS,X), 
      add_one_random_number(X,NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS),         /* 10 */
      fail; true
    )
  ),
  aux_list(LIST), sort(LIST,LISTnew),                                       /* 11 */
  append('res351.pl'), write(list_of_right_boundaries_of_the_sets(LISTnew)),
  write('.'), nl, told,                                                     /* 12 */
  asserta(intervals([])),                                                   /* 13 */
  ( between(1,NUMB_OF_INTERVALS,Z), 
        calculate(Z,NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS,LISTnew), 
        fail; 
    true                                                                    /* 14 */
  ),
  intervals(INTERVALS), retract(intervals(INTERVALS)).                      /* 15 */

calculate(Z,NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS,LISTnew) :-        
  intervals(INTERVALS), length(INTERVALS,LENGTH),                           /* 16 */
  ( Z = 1, NUMBER_OF_OBJECTS = 1,                                           /* 17 */
    append(INTERVALS,[[1,NUMBER_OF_OBJECTS]],INTERVALSnew),                 /* 18 */
    retract(intervals(INTERVALS)), asserta(intervals(INTERVALSnew))         /* 19 */
  ; Z = 1, NUMBER_OF_OBJECTS > 1, nth1(Z,LISTnew,B),                        /* 20 */
    append(INTERVALS,[[1,B]],INTERVALSnew),                                 /* 21 */
    retract(intervals(INTERVALS)), asserta(intervals(INTERVALSnew))         /* 22 */
  ; Z > 1, Z < NUMB_OF_INTERVALS, nth1(LENGTH,INTERVALS,[A,B]),             /* 24 */
    Bn is B + 1,                                                            /* 25 */ 
    LENGTHnew is LENGTH + 1, nth1(LENGTHnew,LISTnew,C),                     /* 26 */
    append(INTERVALS,[[Bn,C]],INTERVALSnew),                                /* 27 */
    retract(intervals(INTERVALS)), asserta(intervals(INTERVALSnew))         /* 28 */
  ; Z > 1 , Z = NUMB_OF_INTERVALS,                                          /* 29 */
    nth1(LENGTH,INTERVALS,[A,B]), Bn is B + 1,                              /* 30 */
    append(INTERVALS,[[Bn,NUMBER_OF_OBJECTS]],INTERVALSnew),                /* 31 */
    retract(intervals(INTERVALS)), asserta(intervals(INTERVALSnew))         /* 32 */
  ),!. 

add_one_random_number(X,NUMBER_OF_OBJECTS,NUMB_OF_INTERVALS) :-             /* 10 */
  aux_list(LIST),                                                         /* 10.1 */
  repeat, Y is random(NUMBER_OF_OBJECTS) + 1, \+ nth1(I,LIST,Y),          /* 10.2 */
  ( X = NUMB_OF_INTERVALS, append(LIST,[NUMBER_OF_OBJECTS],LISTnew)       /* 10.3 */
  ;
    append(LIST,[Y],LISTnew)                                              /* 10.4 */
  ),      
  retract(aux_list(LIST)), asserta(aux_list(LISTnew)),!.                  /* 10.5 */
