/* exam315 

Erzeugung eines einfachen Netzes (net) aus Punkten (points) und 
Linien (lines).

Ein Netz besteht bildlich gesprochen aus einer Menge von Punkten P1,...,PN
und einer Menge von Linien L1,...,LK, wobei eine Linie LI von einem Punkt 
PI1 zu einem anderen Punkt PI2 führt: LI = [PI1,PI2]. Eine Linie ist
also einfach ein Paar von Punkten, wobei die Linie [PI1,PI2] von PI1 zu 
PI2 führt.

Wir generieren das Netz induktiv. Dazu ordnen wir jedem Punkt die Zahl
der "Andockstellen" (slots) des Punktes im gerade stattfindenden 
Schritt zu. Nur an einer Andockstelle kann eine Linie angeheftet werden.
Wir verwenden hier eine sehr einfache Methode, bei der von einem Punkt 
höchstens zwei Linien ausgehen dürfen. D.h. ein Punkt hat genau zwei Andockstellen.

Wir definieren für ein Netz die Menge der "freien Punkte". Ein Punkt ist 
frei, wenn er eine Andockstelle hat, die nicht belegt ist. An dieser
Andockstelle können wir im nächsten Induktionsschritt an diesem
Punkt eine neue Linie "anheften". Dazu wählen wir zufällig einen
freien Punkt [P,NUMBER] aus der Menge der freien Punkte aus. Dies heißt,
je nach Zahl NUMBER ( = 1 oder 2 ), dass es für den Punkt P noch eine (1) 
oder noch zwei (2) Andockstellen gibt, die noch benutzt werden können. 
Wir hängen dann eine neue Linie [P,Pnew] an die erste freie Stelle an P 
an.

Wir notieren ein Netz so

   NET = [DEPTH,[LINE_1,...,LINE_N]], 

wobei DEPTH die "Tiefe" des Netzes und jede Linie LINE_I ein Paar 
[PI1,PI2] ist. Die Liste der freien Punkte notieren wir so

   [[P1,NUMBER_OF_FREE_SLOTS_1],...,[PM,NUMBER_OF_FREE_SLOTS_M]].

PJ (1 =< J =< M) ist ein Punkt und NUMBER_OF_FREE_SLOTS_J ist die Zahl
der noch freien "Andockstellen" (slots). 

Wir generieren das Netz induktiv. Im ersten Schritt hat das Netz immer
die Form

   NET = [DEPTH,[ARROW1]] = [2,[P1,P2]]

wobei DEPTH ( = 2 ) die "Tiefe" des Netzes und [P1,P2] die einzige Linie
des Netzes ist. P1 und P2 sind die beiden Punkte. Dabei hat der 
Punkt P1 noch eine freie Andockstelle und der Punkt P2 zwei freie 
Andockstellen. Dies notieren wir so

   free_points([[P1,1],[P2,2]],[]).

Punkt P1 hat noch einen freien slot und P2 hat zwei freie slots. Die dritte,
hier noch leere Liste [] enthält Punkte, deren slots alle schon belegt sind. 

Im N-ten Induktionsschritt ist ein Netz der Form 
 
   NET = [DEPTH1,[LINE_1,...,LINE_N]] und eine Liste von freien Punkten
   free_points([[P_I1,NUMBER_OF_SLOTS_I1],...[P_IK,NUMBER_OF_SLOTS_IK]],
                         LIST_OF_USED_POINTS)

schon aufgebaut. Aus der Liste der freien Punkte 
[[P_I1,NUMBER_OF_SLOTS_I1],...[P_IK,NUMBER_OF_SLOTS_IK]]
wählen wir [P_IJ,NUMBER_OF_SLOTS_IJ], nehmen den nächsten, noch nicht
benutzten Punkt Pnew und fügen die neue Linie [P_I,Pnew] der Liste der
Linien hinzu. 

-----------------------------------

Zur Erzeugung benutzen wir hier nur einen einzigen Fakt, nämlich die 
Anzahl der Punkte "number_of_points". In Beispiel erzeugen wir ein 
Netz mit 20 Punkten.

In 2 wird die Resultatdatei res315.pl geleert. In 3 wird der Fakt aus 
der Datenbasis geholt. In 4 werden zwei Anfangsfakten eingetragen. Im ersten
Schritt besteht das Netz net([2,[[1,2]]) aus zwei Punkten 1 und 2 und 
aus der Linie [1,2]. Ein solches Paar "ist" die Linie vom Punkt 1 zum 
Punkt 2. free_points([[1,1],[2,2]],[]) enthält zwei Listen. Die erste Liste
enthält [1,1] und [2,2]. [1,1] besagt, dass Punkt 1 noch eine (1) nicht 
belegte Andockstelle hat. Bei [2,2] geht es um den Punkt 2; dieser hat
2 Andockstellen, an denen wir noch Linien anheften können.  

In 5 wird eine Schleife bearbeitet, deren INDEX von 3 bis 
NUMBER_OF_POINTS läuft. Der Befehl "between" funktioniert immer,
weil hier das erste Argument (hier 3) kleiner-gleich als das zweite
Argument NUMBER_OF_POINTS ist (3 =< 20). Die ersten beiden Punkte werden 
schon in 4 verwendet und eingetragen.

In einem Schleifenschritt wird in 6 das im Aufbau befindliche Netz NET und 
der Eintrag free_points(FREE_POINTS,USED_POINTS) für die freien Punkte 
geholt. In 7 wird die Länge LENGTH der Liste der freien Punkte bestimmt.
In 8 wird eine Komponente [P,NFS] aus dieser Liste zufällig gezogen,
wobei P ein Punkt und NFS die Zahl der freien Andockstellen von P ist.
Je nachdem, ob NFS 1 oder 2 ist, wird PROLOG Zeile 9 oder 10 benutzen.
Wenn NFS = 1, arbeitet PROLOG 9 ab. In 11 bestimmt PROLOG die zweite 
Komponente des Netzes NET, eine Paarliste LOL (LIST_OF_LINES). In 12 
haben wir an diese Paarliste das Paar [P,POINT] hinzugefügt. P stammt von
dem freien Punkt [P,NFS] und POINT stammt vom Index in 5. In 
13 wird die erste Komponente DEPTH des Netzes NET geholt. 

In 14 (und 9) wird nun das Netz NET erweitert. Dazu wird die Liste der
Linien LOL durch die erweiterte Liste LOLnew ersetzt. Die Tiefe DEPTH des
Netzes bleibt in diesem Fall (change1, NFS = 1) gleich. In 15 wird das 
Netz NET angepasst. In 16 wird der Eintrag über freie Punkte angepasst.  
Dazu wird der freie Punkt [P,1] aus der Liste FREE_POINTS gelöscht
(im Fall von change1, ist NFS = 1) und in 17 angepasst. Gleichzeitig wird
in 18 der Punkt P in die zweite Liste USED_POINTS eingetragen. In 19 und
20 wird der Gesamteintrag free_points(FREE_POINTS,USED_POINTS) angepasst.

Im zweiten Fall wird in 10 das Netz NET geholt und als erstes die Tiefe 
DEPTH des Netzes um Eins erhöht: DEPTHnew is DEPTH + 1. In 22 wird
eine "neue" Linie [P,POINT] zu der Liste der Linien hinzugefügt. P
war in 8 ein zufällig gezogener freier Punkt und POINT ist der (Index 
für einen) Punkt der in der ersten Schleife in 5 bearbeitet wird. In
23 wird das Netz NET angepasst.

In 24 - 29 wird der Eintrag über freie Punkte verändert. In 24 wird der
freie Punkt [P,2] aus der Liste FREE_POINTS gelöscht. In diesem Fall ist
NFS = 2, beim Punkt P sind alle zwei Andockstellen belegt. In 25 wird die
Zahl NFS um Eins vermindert: NFSnew is 2 - 1. Diese etwas unnötig komplexe
Formulierung haben wir gewählt, weil wir sie in dieser Art auch für
Netzes mit mehr als zwei Verzweigungen benutzen können. In 26 wird sowohl
der Punkt P als auch der neue Punkt POINT in die Liste FREE_POINTS
hinzugefügt - mit den jeweils richtig berechneten Anzahlen von Andockstellen.
Der neue Punkt POINT hat 2 freie Andockstellen: [POINT,2] und der Punkt 
P hat eine freie Andockstelle: [P,NFSnew] = [P,1], 1 = 2 - 1. Die Liste der  
benutzten Punkte USED_POINTS wird in 27 im Fall 2 (change2, NFS = 2) nicht 
verändert. In 28 und 29 wird schließlich der Gesamteintrag angepasst.

Wenn die Schleife in 5 bearbeitet ist, wird in 30 das nun vollständige
Netz NET und der Eintrag über die freien Punkte aus der Datenbasis geholt.
In 31 werden diese beiden Fakten an die Resultatdatei res351.pl geschickt.
Schließlich löschen wir in 32 die Fakten, die im Ablauf entstanden sind,
um eventuell dieses Modul ohne Altlasten wieder zu starten. 

Zwei Abkürzungen:
NFS = NUMBER_OF_FREE_SLOTS
LOL = LIST_OF_LINES
*/

number_of_points(20).                                                /* 1 */

start :-
% trace,
  ( exists_file('res315.pl'), delete_file('res315.pl') ; true),      /* 2 */
  number_of_points(NUMBER_OF_POINTS),                                /* 3 */
  asserta(net([2,[[1,2]]])), asserta(free_points([[1,1],[2,2]],[])), /* 4 */
  ( between(3,NUMBER_OF_POINTS,POINT), make_one_point(POINT), fail; 
      true),                                                         /* 5 */
  net(NET), free_points(FREE_POINTS,USED_POINTS),                    /* 30 */
  append('res315.pl'), write(net(NET)), write('.'), nl,    
  write(free_points(FREE_POINTS,USED_POINTS)), write('.'), nl, told, /* 31 */
  retractall(net(NNN)), retract(free_points(FFF1,FFF2)).             /* 32 */

make_one_point(POINT) :-                                             /* 5 */
  net(NET), free_points(FREE_POINTS,USED_POINTS),                    /* 6 */
  length(FREE_POINTS,LENGTH),                                        /* 7 */
  X is random(LENGTH) + 1, nth1(X,FREE_POINTS,[P,NFS]),              /* 8 */
  ( NFS = 1, change1(P,POINT,NET,FREE_POINTS,USED_POINTS)            /* 9 */
  ; NFS = 2, change2(P,POINT,NET,FREE_POINTS,USED_POINTS)            /* 10 */
  ),!.

change1(P,POINT,NET,FREE_POINTS,USED_POINTS) :-                      /* 9 */
  nth1(2,NET,LOL),                                                   /* 11 */
  append(LOL,[[P,POINT]],LOLnew),                                    /* 12 */
  nth1(1,NET,DEPTH),                                                 /* 13 */
  NETnew = [DEPTH,LOLnew],                                           /* 14 */
  retract(net(NET)), asserta(net(NETnew)),                           /* 15 */
  delete(FREE_POINTS,[P,1],FREE_POINTSp),                            /* 16 */
  append(FREE_POINTSp,[[POINT,2]],FREE_POINTSnew),                   /* 17 */
  append(USED_POINTS,[P],USED_POINTSnew),                            /* 18 */
  retract(free_points(FREE_POINTS,USED_POINTS)),                     /* 19 */    
  asserta(free_points(FREE_POINTSnew,USED_POINTSnew)),!.             /* 20 */

change2(P,POINT,NET,FREE_POINTS,USED_POINTS) :-                      /* 10 */
  NET = [DEPTH,LOL], DEPTHnew is DEPTH + 1,                          /* 21 */
  append(LOL,[[P,POINT]],LOLnew),                                    /* 22 */ 
  retract(net(NET)), asserta(net([DEPTHnew,LOLnew])),                /* 23 */
  delete(FREE_POINTS,[P,2],FREE_POINTSp),                            /* 24 */ 
  NFSnew is 2 - 1,                                                   /* 25 */
  append(FREE_POINTSp,[[P,NFSnew],[POINT,2]],FREE_POINTSnew),        /* 26 */
  USED_POINTSnew = USED_POINTS,                                      /* 27 */
  retract(free_points(FREE_POINTS,USED_POINTS)),                     /* 28 */  
  asserta(free_points(FREE_POINTSnew,USED_POINTSnew)),!.             /* 29 */