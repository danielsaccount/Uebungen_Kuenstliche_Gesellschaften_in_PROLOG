/* exam142

Der Zweck des Programms:

A) wie in exam141:
1) Starten eines PROLOG Programms im trace Modus.
2) Die Struktur eines Sim-Programms erkennen: Fakten versus Hypothesen.
3) Eine Ableitung eines "neuen" Fakts anschauen. Der "neue" Fakt hier ist fact2(c).

B) Der "neue", abgeleitete Fakt werden in einer externen Datei gespeichert.
Diese Datei heißt hier res142 . 
Am Anfang des Programms nach "start"  und "trace" wird die Zeile (1) bearbeitet:

(exists_file('res142.pl'), delete_file('res142.pl'); true),

Diese Zeile löscht am Anfang die externe Datei res142 , falls sie schon
existiert. Wenn diese Datei noch nicht existiert, springt das Programm in die 
nächste Zeile 2. 

Der Name des Programms sollte mit .pl enden, also im diesem Beispiel: exam141.pl   
Mit Doppelklick öffnet sich das PROLOG Fenster. Wir sehen "1 ?- ".
Wenn das Fragezeichen nicht zu sehen ist, drücken wir "blank".
Dann müsste es erscheinen. (Warum ??) 

Wenn das PROLOG Fenster offen ist, tragen wir ein: 

"start." und "return".

Nach dem Ende des Programms öffnen wir durch einen Texteditor die Datei res142 und
schauen das Resultat an.

Am Ende des Ablaufs kann das PROLOG Fenster oben rechts bei "x"  gelöscht werden. 
 */


fact1(a). fact1(b). fact1(bba). fact1(aX).

start :- 
  trace,
  (exists_file('res142.pl'), delete_file('res142.pl'); true),   /* 1 */
  fact2(X).                                                     /* 2 */

fact2(X) :- 
  fact1(X), 
  X = bba,                                                      /* 3 */
  append('res142.pl'), write(fact2(c)), write('.'), told.  

/* Das Programm funktioniert auch ohne trace. 
Was passiert, wenn Sie Zeile 3 ersetzen durch X = b ?
Was passiert, wenn Sie Zeile 3 ersetzen durch X = aX ?
*/