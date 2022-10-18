/* exam164

In dem Schleifenprädikat wird zwischen dem Zählindex und dem 
Objekt, das in einem Schleifenschritt bearbeitet wird, unterschieden.

In 1 - 3 werden einige Fakten bereit gestellt. In 4 wird die Akteurliste
aus der Datenbasis geholt: ACTORLIST = [uta,renate,maria,karl,udo,hans].
In 5 werden zwei leere Hilfslisten eingerichtet, die erste Liste enthält
die hübschen ("pretty") Akteure und die zweite die häßlichen ("ugly").
In 6 wird die Länge der Akteurliste bestimmt: 
length([uta,renate,maria,karl,udo,hans],6), E = 6.
In 7 wird die Schleife bearbeitet. Der Zählindex, und damit die Anzahl
der Schleifenschritte, läuft von 1 bis E, hier also von 1 bis 6.
In der Schleife in 7 und 8 wird das Schleifenprädikat in zwei Teile
geteilt. Zuerst bestimmt der Zählindex I mit nth1(I,ACTORLIST,ACTOR)
den zu I gehörigen Akteur ACTOR, und dann wird das eigentliche
Schleifenprädikat investigate(ACTOR) aufgerufen. Diese Zweiteilung ist
aus zwei Gründen nötig. Erstens, wird das eigentliche Schleifenprädikat
"investigate" nicht in jedem Schritt dasselbe machen und zweitens sehen
wir aus inhaltlichen Gründen, dass Hans eine "Sonderbehandlung" erfährt
(siehe unten).
  
In 16 - 18 werden die beiden Hilfslisten geholt. Beide Listen, LISTpretty
und LISTugly, sind in diesem Schritt leer. In 22 wird eine Oder-Verbindung
formuliert, so dass die zugehörigen Klammern in 19 und 26 gut zu erkennen
sind. Aus Lesbarkeitsgründen schreiben einen Oder-Term oft in dieser Weise.
    ( ...
    ;
      ...
    ).
PROLOG hat die Oder-Verbindung erkannt und wendet sich in 19 zu dem
Term pretty(uta). In diesem Term wurde ACTOR schon durch "uta" ersetzt. 
PROLOG versucht diesen Term in der Datenabasis zu findet.
Leider ist Uta nicht hübsch. Der Term ist damit für PROLOG falsch.
PROLOG wendet sich der zweiten Möglichkeit ugly(ACTOR) in 23 zu.
ACTOR ist weiterhin mit "uta" belegt. PROLOG findet in der Datenbasis 
in 3 den Term ugly(uta). In 23 wird "uta" an die Hilfsliste 
"ugly_actors" angeklebt: append([],[uta],[uta]). In 24 wird die alte 
Hilfsliste gelöscht und in 25 die neue Liste mit "ugly_actors"
eingetragen: ugly_actors(LISTuglynew).   
investigate(uta) ist bearbeitet. PROLOG wendet sich nach oben zu 8,
kehrt durch "fail" zurück zu "between" und ersetzt I = 1 durch I = 2.
PROLOG berechnet die 2-te Komponente aus der Akteurliste und findet
ACTOR = renate. PROLOG wandert wieder nach 16, holt die beiden gerade 
aktuellen Hilfslisten. In 19 und 22 findet PROLOG wieder die Oder-
Konstruktion. PROLOG sucht in 19, ob es für "renate" in der Datenbasis 
einen Fakt pretty(renate) gibt. Dies ist der Fall. PROLOG trägt in 19 
- 21 den Namen in die Liste "pretty_actors" ein und ersetzt diese Liste 
in der Datenbasis durch die so upgedatete Liste pretty_actors([renate]). 

Dies geht so weiter bis zum 4 Schleifenschritt: I = 4, ACTOR = karl. 
PROLOG kommt in 19 zur Oder-Konstruktion. In 19 findet PROLOG keinen
Fakt pretty(karl) und in 23 keinen Fakt ugly(karl). In diesem Fall
wird der Term in 16 und in 18 falsch. In diesem Fall wird PROLOG
direkt wieder zurück zu "between" kommen, d.h. "fail" wird in diesem
Fall in 16 nicht aktiv. 

PROLOG bearbeitet den nächsten Schleifenschritt, I = 5. Und so weiter,
bis der letzte, hier 6-te, Schleifenschritt bearbeitet ist. PROLOG
befindet sich in  8 bei "fail"  und in 7 sieht PROLOG, dass der Index
(I = 6) identisch mit E ist (E = 6). In diesem Fall wird "between"
falsch. PROLOG kommt in der Oder-Konstruktion in 7 - 8 zu "true".
Damit ist die Schleife positiv beendet.

In 12 und 13 haben wir die Hilfslisten geholt und aufgeschrieben.
Sie sehen im trace-Modus, wie diese Listen 
pretty_actors([renate,maria,hans]) und ugly_actors([uta,udo])  
aussehen. Sie sehen, dass Karl zu keinen der beiden Listen gehört.
Der Zählindex hat auch den Fall "Karl" bearbeitet, aber ohne Erfolg.
Die Anzahl der Schritte ist damit in drei Arten eingeteilt. Es gibt 
Schritte, in denen ein hübscher Akteur gefunden wird, es gibt Schritte,
in denen ein häßlicher Akteur gefunden wird und es gibt Schritte,
in den ein Akteur keiner dieser beiden Eigenschaten hat. Inhaltlich
kann dies vieles heißen.

Schließlich werden sie beiden Hilfslisten in 14 und 15 wieder gelöscht.
Wenn wir dies nicht tun und das PROLOG Programm nicht beenden, sondern
dasselbe Programm wieder laufen lassen, werden diese Hilfslisten in der
Datenbasis noch stehen. Dies läßt sich leicht überprüfen.              
*/


actor_list([uta,renate,maria,karl,udo,hans]).                 /* 1 */
pretty(renate). pretty(maria). pretty(karl).                  /* 2 */
ugly(uta). ugly(udo).                                         /* 3 */


start :- 
   trace,
   actor_list(ACTORLIST),                                     /* 4 */
   asserta(pretty_actors([])), asserta(ugly_actors([])),      /* 5 */
   length(ACTORLIST,E),                                       /* 6 */
   ( between(1,E,I), nth1(I,ACTORLIST,ACTOR),                 /* 7 */
        investigate(ACTOR), fail                              /* 8 */
   ;                                                          /* 9 */
     true                                                     /* 10 */
   ),                                                         /* 11 */
   pretty_actors(PRETTY), write(pretty_actors(PRETTY)),       /* 12 */
   ugly_actors(UGLY), write(ugly_actors(UGLY)),               /* 13 */
   retract(pretty_actors(PRETTY)),                            /* 14 */
   retract(ugly_actors(UGLY)).                                /* 15 */

 
investigate(ACTOR) :-                                         /* 16 */
   pretty_actors(LISTpretty),                                 /* 17 */
   ugly_actors(LISTugly),                                     /* 18 */
  ( pretty(ACTOR), append(LISTpretty,[ACTOR],LISTprettynew),  /* 19 */
    retract(pretty_actors(LISTpretty)),                       /* 20 */
    asserta(pretty_actors(LISTprettynew))                     /* 21 */
  ;                                                           /* 22 */
    ugly(ACTOR), append(LISTugly,[ACTOR],LISTuglynew),        /* 23 */
    retract(ugly_actors(LISTugly)),                           /* 24 */
    asserta(ugly_actors(LISTuglynew))                         /* 25 */
  ),!.                                                        /* 26 */
 

