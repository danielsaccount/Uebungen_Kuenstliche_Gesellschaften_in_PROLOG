/* exam144

Der Zweck des Programms:

Zus�tzlich zu den Zielen in exam141 und in exam142
werden die Anfangsfakten aus einer externe Datei geholt und zur Datenbasis
hinzugef�gt. Als externe Datei benutzen wir hier eine Datei data144.pl,
die schon vorhanden sein muss.

-----------------------------
  
Wenn das PROLOG Fenster offen ist, tragen Sie ein: 

"start." und dr�cken auf "return".

Nach dem Ende des Programms �ffnen Sie durch einen Texteditor die Datei 
res144.pl und schauen das Resultat an.

Am Ende des Ablaufs kann das PROLOG Fenster oben rechts mit "x" gel�scht 
werden. 

-----------------------------

In Zeile 3 werden alle Fakten der Form fact1(V) auf den Bildschirm
erscheinen. Sie sehen so, dass all die Fakten aus data144.pl tats�chlich 
in der Datenbasis verhanden sind. 
In 4 werden all diese Fakten der Form fact1(V) wieder aus der 
Datenbasis enfernt. 

In Zeile 4 gibt es eine Fehlermeldung, wenn wir nicht am Anfang des 
Programms den Befehl

:- dynamic fact1/1.  

gesetzt haben. Ohne die Zeile 0 k�nnen wir einen Fakt der Form fact1(V) nicht 
aus der Datenbasis entfernen. Sie sehen, dass nach retractall(fact1(XX)) 
kein Fakt der Form fact1(V) in der Datenabsis mehr zu finden ist. Sie k�nnen dies
nachpr�fen, indem Sie die Zeile 0 als Kommentar klammern. Z.B. vor
":- dynamic fact1/1." schreiben Sie einfach das Symbol % davor. 

Ein nicht m�gliche Kommentierung w�re statt 0 folgende Zeile zu benutzen:
/* :- dynamic fact1/1. */                                             /* 0 */
Dies f�hrt zu einem "Klammersalat".
*/

:- dynamic fact1/1.                                                   /* 0 */

start :- 
  trace,
  (exists_file('res144.pl'), delete_file('res144.pl'); true),         /* 1 */
  consult('data144.pl'),                                              /* 2 */
  repeat, ( fact1(V), write(fact1(V)), write('.'), nl, fail ; true ), /* 3 */
  fact2(X),
  retractall(fact1(XX)), ( fact1(W) ; true).                          /* 4 */

fact2(X) :- 
  fact1(X), 
  X = aX, 
  append('res144.pl'), write(fact2(X)), write('.'), nl, told.  


 