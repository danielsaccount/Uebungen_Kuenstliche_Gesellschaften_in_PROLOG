/* exam163

Eine offene Schleife wird programmiert

Bei einer offenen Schleife wissen wir am Anfang nicht, wieviele 
Schleifenschritte durchlaufen werden.

In 1 sind drei Fakten eingetragen. In 3 wird eine leere Hilfliste "auxlist" 
eingerichtet. In 4 beginnt mit "repeat" die offene Schleife.
PROLOG findet in 5 das loop_predicate und geht nach 8.
In 9 wird die Hilfsliste (hier LIST = [ ]) geholt und in 10 wird
der Term pred(Y) bearbeitet. PROLOG findet in 1 pred(4) und Y wird ersetzt durch 4.
In 11 wird geprüft, ob Y (also 4) ein Element der Liste [ ] ist.
Was nicht der Fall ist. In 12 wird zur Sicherheit der Fakt herausgeschrieben:
pred(4).
In 13 wird das Argument 4 von "pred" an die Liste LIST angeklebt: 
append(LIST,[Y],LISTnew), also append([ ],[4],[4]). Dabei ist die dritte
Komponente von append(_,_,_) die neue, vergrößerte Liste. In 14 wird die alte 
Hilfsliste gelöscht und die neue mit "asserta" in die Datenbasis eingetragen.
In 15 trifft PROLOG "fail" und muss zurück. Da in 15 ein cut ! steht muss
PROLOG direkt nach oben wandern. "loop_predicate" ist falsch und damit auch in 5 
falsch. PROLOG muss weiter nach oben gehen zu "repeat" in 4.
PROLOG beginnt von vorne. PORLOG geht zu 5, 8 und zu 9. Die Hilfliste
LIST hat nun die Form [4]. In 10 nimmt PROLOG den ersten Fakt der Form pred(X),
also pred(4). In 11 wird geprüft, ob 4 Element der Liste [4] ist. Damit ist
die Negation in 11 falsch. PROLOG geht nach oben zu 10 und zu pred(Y) und
nimmt den nächsten Fakt in 1 pred(2): Y = 2. PROLOG geht wieder nach unten
zu 11 und prüft, ob 2 Element von [4] ist. Dies ist nicht der Fall. D.h.
11 ist richtig. In 13 und 14 wird das neue Element 2 in die Hilfliste
aufgenommen. In 15 muss PROLOG mit "fail" und mit "cut" direkt wieder nach 
oben zu 8 und 5 gehen. 
In 5 wird die nächste Schleife gestartet. Dies geht so lange gut, bis in
10 PROLOG in der Datenbasis keinen neuen Fakt mehr findet. In 10 und 11
prüft PROLOG die Fakten, die in 1 zu finden sind. All diese sind  aber
Elemente der Liste LIST, welche im Beispiel an dieser Stelle die Form
[4,2,5] hat. " \+ member(Y,[4,2,5]) " in 11 ist also falsch. Damit muss PROLOG
nach oben zu 8 und 5 gehen.

In 5 sieht PROLOG an dieser Stelle aber eine weitere Möglichkeit, nämlich 
die Zeile 16. In 17 wird loop_predicate richtig. PROLOG geht daher nach oben 
zu 5 und dann zu 6 und 7. PROLOG holt die Hilfsliste LIST = [4,2,5],
schreibt sie auf und löscht den Term aus der Datenbasis. 
*/

pred(4). pred(2). pred(5).                                 /* 1 */

% -------------------------------------------

start :- 
  trace,                                                   /* 2 */
  asserta(auxlist([])),                                    /* 3 */
  repeat,                                                  /* 4 */
  loop_predicate,                                          /* 5 */
  auxlist(LIST), write(auxlist(LIST)),                     /* 6 */
  retract(auxlist(LIST)).                                  /* 7 */
  
loop_predicate :-                                          /* 8 */
  auxlist(LIST),                                           /* 9 */ 
  pred(Y),                                                 /* 10 */
  \+ member(Y,LIST),                                       /* 11 */
  write(pred(Y)),  nl,                                     /* 12 */
  append(LIST,[Y],LISTnew),                                /* 13 */
  retract(auxlist(LIST)), asserta(auxlist(LISTnew)),       /* 14 */
  !,fail.                                                  /* 15 */
 
loop_predicate :-                                          /* 16 */
  true.                                                    /* 17 */

