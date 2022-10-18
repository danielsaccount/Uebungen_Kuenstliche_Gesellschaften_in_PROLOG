/* exam143

Hier haben wir eine sehr einfache, "selbst gestrickte"  empirische Theorie programmiert.
Das Programm liegt in der Datei exam143, die mit .pl enden muss, also

   exam143.pl 

Wir könnten natürlich auch einen anderen Namen für diese Datei benutzen.

Mit Doppelklick auf diese Datei öffnet sich das PROLOG Fenster, hier: exam143.pl 
Sie sehen in der letzten Zeile in diesem Fenster 

   1  ?-

Wenn dies nicht so zu sehen ist, drücken Sie noch ein Mal den blank. Dann 
sollte dieser Eintrag zu sehen sein.(??) 
1 ist die Zeilennummer, die PROLOG gerade bearbeitet. Das Fragezeichen
?- bedeutet, dass PROLOG auf eine Frage wartet, die wir stellen sollen.  

Sie tippen eine bestimmte Frage nach dem ?- ein, z.B.
  
   bleibt(hans).

Hier ist der Punkt wichtig, den Sie nicht vergessen dürfen. Wenn der Punkt fehlt,
wartet PROLOG weiter. In diesem Fall können Sie z.B. in diesem Fenster 
rechts oben bei x drücken. Das Programm wird beendet. Mit Doppelklick können Sie das
Programm wieder - wie beschrieben - beginnen lassen.
Sie tippen ein:  bleibt(hans). (mit Punkt).

In Zeile 3 wird der trace schon eingeschaltet. Sie drücken nun 
genau ein Mal die return Taste. Sie sehen nun 

   Call: (8) mag(hans, _L149) ?

Das bedeutet: PROLOG ruft die neue Frage mag(_L149, hans) auf. Sie sehen hier
und in Zeile 4, dass in der Frage, ob Hans bleibt ( bleibt(hans) ), die 
Variable X durch hans ersetzt wurde und Y durch _L149 . _L149 ist die erste 
Variable, die PROLOG an der Stelle in 4 "findet" und benutzt. PROLOG 
übersetzt sozusagen X in die Symbolreihe hans und Y in _L149 .

Sie drücken ein Mal "return" und sehen
   
Call: (9) mag(_L149, hans) ?

PROLOG springt - was nicht zu sehen ist - zu 6 und hat diese Klause 
angewendet, mit dem Resultat

   mag(_L149), hans)

In Klause 6 werden, mit anderen Worten, die Argumente in mag(Z,Y) werden vertauscht,
mit Resultat mag(Y,Z) . 

Sie drücken ein Mal return und sehen:

   Exit: (9) mag(uta, hans) ?

PROLOG hat die Variable _L149 mit uta ersetzt, und die beiden Argumente 
von mag vertauscht.

Sie drücken return und finden:

   Exit: (8) mag(hans,uta) ?

PROLOG ist nach oben gewandert, nach Zeile (8). Auch dort hat PROLOG
die Variable _L149 durch uta ersetzt. 

Sie drücken ein Mal return und sehen

   Exit: (7) bleibt(hans) ?

Dies war die ursprüngliche Frage. Diese Frage hatten Sie am Anfang 
eingetippt. PROLOG hat diese Frage nun durch das Programm richtig beantwortet. 
PROLOG hat folgendes gemacht. In 5 hat PROLOG den Rumpf 
mag(Y,X) gefunden und gesehen, dass Y durch uta und X durch
hans ersetzt wurde. PROLOG kehrt deshalb zum Kopf von (5) zurück, nämlich zu
bleibt(X), wobei statt X hans steht. PROLOG hat dieses Resultat
bleibt(hans) ausgegeben.

Sie drücken ein Mal return und sehen:

  Yes

Damit ist die Frage positiv beantwortet: yes. PROLOG hat gefunden, dass
der Kopf mit dem Fakt bleibt(hans) in (K1) identisch ist. 

Da PROLOG weiterhin aktiv ist, sehen Sie genauer:
  
  Yes 
  [debug] 2 ?-

D.h. Sie können eine weitere Frage rechts von ?- eintragen. PROLOG
numeriert den folgenden Prozess wieder neu. D.h. PROLOG ist gerade in Zeile
Nummer 2.

Sie tragen z.B. ein:

   mag(hans, uta).

Sie drücken return und sehen:

  Yes
  [debug] 3 ?- 

D.h. PROLOG findet diese Antwort sofort. Warum?
PROLOG nimmt sofort die Klause 6 und wendet sie an.
Sie können nicht sehen, dass PROLOG hans mit einer
Variablen und uta mit einer anderen Variablen identifiziert hat
und die Klause 6 angewendet wurde. Das Resultat
mag(uta,hans) sehen Sie nicht, weil PROLOG dies schon
am Anfang erkannte. PROLOG hat nur geantwortet: 

  Yes 
  [debug] 3 ?-

Schließlich tippen Sie eine Frage ein, die zu einen fatalen 
Fehler führt. 

   mag(hans, peter). 

Nach return gibt PROLOG folgendes Resultat aus: 
  
  ERROR: Out of local stack
   Exception: (246,479) mag(hans, peter) ? 

Inhaltlich geschieht folgendes. PROLOG findet nur die Klause 6,
mit der PROLOG mit dieser Frage weiterkommen kann. Aus mag(hans, peter) wird  
durch 6 mag(peter, hans). Dann wieder mit 6 aus mag(peter,hans),
wieder mag(hans,peter). Und so weiter. In diesem Sinn "handelt" PROLOG reflexiv. 
Anders gesagt, kann das Programm nicht weiterarbeiten: der Speicher von PROLOG ist voll. 
Die Klause 6 wird ständig wiederholt, wobei in jedem Schritt eine neue Variable gebraucht 
wird. Nach einigen Schritten wird - je nach Größe des Computers - der Fehler 

   Out of local stack 

ausgegeben. 

In dem hier benutzten, alten Computer kommt PROLOG an Zeile
Nr. (246,479) an seine Grenzen.    

Als Übung könnten Sie eine andere Frage der fatalen Art formulieren und
eintippen.

Sie können dieses Programm exam143 beenden, indem Sie auf dem PROLOG 
Fenster rechts oben auf x drücken. Damit beenden Sie nicht nur 
das Programm exam143 , sondern auch das ganze PROLOG Programm.
Das PROLOG Fenster ist nicht mehr zu sehen.

Wenn Sie das Programm nicht beendet haben, sondern weitere Fragen 
eingetippt haben, und nicht weiter wissen, drücken Sie rechts
oben auf x und warten. Sie sehen dann folgenen Eintrag  

   Waiting for Prolog. Close again to force termination ..

Nach einiger Zeit drücken Sie noch ein Mal auf x. Damit sollte
das PPOLOG Programm beendet sein.  
*/

% ------------------------------
% Fakten: 
 
bleibt(peter).          /* 1 */
mag(uta,hans).          /* 2 */

% ------------------------------
% Hypothesen

bleibt(X) :- 
   trace,               /* 3 */
   mag(X,Y).            /* 4 */

bleibt(X) :- mag(Y,X).  /* 5 */

mag(Z,Y) :- mag(Y,Z).   /* 6 */









