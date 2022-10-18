/* exam141

Der Zweck dieses Programms:
1) Starten eines PROLOG Programms im trace Modus.
2) Die Struktur eines Sim-Programms erkennen: Fakten versus Hypothesen.
3) Eine Ableitung eines "neuen" Fakts anschauen. Der "neue" Fakt hier  ist  
fact2(a).
 
Der Name des Programms sollte mit .pl enden, also im diesem Beispiel: exam141.pl   
Mit Doppelklick öffnet sich das PROLOG Fenster. Wir sehen "1 ?- ".
Wenn das Fragezeichen nicht zu sehen ist, drücken wir den Blank.
Dann müssten diese Symbole "1 ?- " erscheinen. (Warum ??) 

Wenn das PROLOG Fenster offen ist, tragen wir ein: 

"start." und drücken "return".

Am Ende des Ablaufs kann das PROLOG Fenster oben rechts bei "x" gelöscht werden. 
 */


fact1(a).

start :- 
%  trace,           /* Zeile 3 */
  fact2(X).

fact2(X) :- 
  fact1(X), 
  write(fact2(X)).  /* Zeile 7 */

/* Das Programm funktioniert auch ohne die Zeilen 3 und 7. */

