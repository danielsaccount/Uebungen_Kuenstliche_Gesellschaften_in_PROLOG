/* exam221.pl

In einem Handlungstyp "action_typ" wird eine Variable durch eine Eigenschaft
oder durch einen Zustand ersetzt.

In 3 wird die Resultatdatei "res221.pl" geleert, um die jetzt zu generierenden
Resultate nicht mit denen aus dem letzten Ablauf zu vermischen.

Den Handlungstyp "action_typ" haben wir in 4 in die Datenbasis eingetragen.
In einem vollständigen Programm wäre action_typ(1,2,Z) in der Datenbasis schon 
vorhanden.

In 5 holt PROLOG den Fakt, der in 1 oben existiert. In 6 setzt PROLOG die Variable
Z aus 4 mit der Eigenschaft property(1,2,3) identisch. D.h. PROLOG ersetzt Z
durch property(1,2,3). Dies ist im trace-Modus in 7 zu sehen und dieses Resultat 
wird in 8 auch in die Resultatdatei geschickt.

In 9 wird die Handlung in inhaltsleerer Weise (siehe 15) ausgeführt und in 10 
gelöscht. In 11 wird der Handlungstyp wieder aktiviert. In 12 und in 2 sucht 
PROLOG einen Zustand, findet ihn in 2 und identifiziert ihn mit X. Das Resultat 
wird herausgeschrieben und nach res221.pl geschickt.
*/
             
property(1,2,3).                                                       /* 1 */
state([34,object,1,22]).                                               /* 2 */

start :- 
  trace ,
  ( exists_file('res221.pl'), delete_file('res221.pl'); true ),         /* 3 */
  asserta(action_typ(1,2,Z)),                                           /* 4 */
  property(X1,X2,X3),                                                   /* 5 */
  Z = property(X1,X2,X3),                                               /* 6 */
  write(action_typ(1,2,Z)),                                             /* 7 */
  append('res221.pl'), write(action_typ(1,2,Z)), write('.'), nl, told,  /* 8 */
  act(action_typ(1,2,Z)),                                               /* 9 */
  retract(action_typ(1,2,Z)),                                           /* 10 */
  asserta(action_typ(1,2,X)),                                           /* 11 */
  state(S),                                                             /* 12 */
  X = state(S),                                                         /* 13 */
  write(action_typ(1,2,X)),                                             /* 14 */
  append('res221.pl'), write(action_typ(1,2,X)), write('.'), nl, told,
  retract(action_typ(1,2,X)).

act(action_typ(1,2,Z)) :- true.                                         /* 15 */