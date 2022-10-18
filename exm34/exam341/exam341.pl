/* exam341

Zwei "Makroakteure" werden durch zwei Threads bearbeitet. 

Der Mainthread tritt hier nicht in Erscheinung.

Der erste Akteur ist ein Unternehmen, der ein Produkt herstellt. Der 
zweite Akteur ist eine Kampfeinheit, z.B. eine Bataillon mit 5 Kompanien. 

Das Unternehmen produziert in Zeile 1 eine Ware in zwanzig Standorten. 
Beim Produzieren werden in 2 zwei Inputquantitäten, number_of_quantities(1,1000) 
und number_of_quantities(2,500) benutzt. Z.B.
könnte die Quantität der ersten Art Arbeit und die Quantität der zweiten Art
eine chemische Substanz sein. Z.B. würde number_of_quantities(1,1000) 
1000 Einheiten (Arbeitsstunden) der Art 1 ("Arbeit") sein und
number_of_quantities(2,500) 500 Tonnen des chemischen Substanz ("Art" 2). 
Für die Produktion werden in 3 die beiden Inputarten in einem
Produktionsprozeß mit den Konstanten const1(0.7) und const2(0.3) benutzt.

Die Kampfeinheit in 4 umfasst 900 Soldaten: number_of_soldiers(900) und 5 
Kompanien: number_of_groups(5). In einer Kampfepisode wird in 5 eine
Konstante const3(0.8) verwendet, welche besagt, wie verlustleich dieser
Kampf ist.

In 1-5 sind einige Konstanten eingetragen, in 6 werden die Resultatdateien
geleert und in 7 werden die Fakten aus der Datenbasis geholt und auch als
Resultate verschickt. 

In 8 wird der erste Thread mit dem Name "actor1" eingerichtet. Die
Identifikationsnummer Id1 wird durch PROLOG automatisch vergeben. Im 
Beispiel bekommt der erste Thread die Identifikationsnummer 2 (Id1 = 2).
(Dies lässt sich mit "trace" überprüfen.) Dieser Thread wird durch die
Klause 8.1 bearbeitet. An dieser Stelle entsteht beim Lesen ein Sprung
von der Zeile 8 zu der Zeile 8.1. Aus dem Term thread_create(actor1,Id1,[]),
springt PROLOG mit "actor1" zu der Klause in 8.1, deren Kopf mit "actor1" 
identisch ist. 

In 8.2 wird die Identifikationsnummer Id1 dieses Threads mit dem Befehl
"thread_self" aus der Datenbasis geholt. Diesen Fakt haben wir in 8.2 in
der Form actor1thread(Id1) wieder in die Datenbasis eingefügt. Die Zeile
8.3 besagt, dass an dieser Stelle der Thread Nr. Id1 auf den trace-Modus 
geschaltet wird. Diese Zeile haben hier auskommentiert. Wenn Sie diese Zeile 
aktiv schalten, können Sie warten, was genauer passiert. 
In 8.4. - 8.6 werden die Konstanten aus der Datenbasis geholt. In 8.7 werden
bestimmte Anteile von Inputwaren festgelegt. In 8.8 wird eine Schleife über
alle Produktionsstätten (PRODUCTION_PLACES = 20) gelegt. In einem 
Schleifenschritt in 8.8 werden die Inputgrößen für die bestimmte 
Produktionsstätte PLACE festgelegt. Diese haben wir teilweise
theoretisch bestimmt. Aus PL2 wird Z3 berechnet und aus den Zahlen  
C1, PL1, C2 und Z3 wird die Menge der produzierten Ware errechnet. Die 
Gleichung in 8.10 drückt eine in der Ökonomie benutzte Standardform einer
Produktionsfunktion (Cobb-Douglas) prologisch aus. In 8.11 wird das Ergebnis in die
Datenbasis übernommen. An dieser Stelle ist es nicht möglich, dieses 
Resultat an eine Resultatdatei zu schicken, weil die Figur "append(...),
write(...), told" innerhalb eines bestimmten Thread so nicht funktioniert. 

In 9 wird der zweite Thread mit dem Namen "actor2" eingerichtet. Hier
benutzen wir gleich das Prädikat "actor" als weiteren Namen für den Thread.
D.h. statt Id2, verwenden wir im Folgenden "actor2". Dies schieht durch
das Argument "[alias(actor2)]". PROLOG springt von 9 zu 9.1, wobei "actor2"
in 9.1 gerade der Kopf der Klause in 9.1 ist. In 9.2 wird die 
Identifikation "actor2" aus der Datenbasis geholt und "für uns selber"
noch einmal in die Datenbasis aufgenommen. In 9.3 haben wir den trace
für den Thread "actor2" eingeschaltet. Wenn dies stört, müssen wir die Zeile
9.3 auskommentieren. In 9.4 wird die Zahl der Gruppen aus der Datenbasis
geholt und in 9.5 um Eins erhöht, um den Nenner im Bruch in 9.7 nicht Null 
werden zu lassen. In 9.6 wird die Zahl der Soldaten geholt. In 9.7 wird ein
Bruchteil davon genommen. In 9.8 wird die Konstante C3 geholt und die
Zahl der Soldaten als Pool eingetragen, aus dem im Weiteren geschöpft wird. 
In 9.9 beginnt eine Schleife, die wir hier in der Art der Informatiker
formuliert haben. 

In 9.9a wendet sich PROLOG dem Ende der Schleife zu. Da diese Zeile noch
falsch ist, wendet sich PROLOG zu 9.9b. Der Schleifenindex NR_GROUP läuft
über die Zahlen 1,...,NUMBER_OF_GROUPS. In 9.10 wird geprüft, ob dieser
Index noch echt kleiner als die Anzahl (plus 1) der Gruppen ist. In diesem
Fall wendet sich PROLOG zu 9.11. Dort wird in 9.12 der Pool POOL aus der
Datenbasis geholt und zufällig eine Zahl NUMBER_OF_FALLEN von Gefallenen
gezogen. In 9.13 wird diese Zahl für die Gruppe NR_GROUP als Fakt
eingetragen. D.h. im Kampf sind in der Gruppe NR_GROUP einige Kämpfer
gefallen, nämlich NUMBER_OF_FALLEN. In 9.13 wird der POOL angepasst.
Die Gefallenen werden aus dem Pool herausgenommen. In 9.15 wird nun die
nächste Gruppe des Namens NR_GROUPnew bearbeitet. Dazu nimmt PROLOG den
Term in 9.15 mit der nächsten Gruppennummer. Dies geht so lange, bis
die Ungleichung in 9.10 falsch wird. In diesem Fall geht PROLOG zurück 
zu 9.9a. An diesem Punkt ist 9.9a nun richtig.

In 10 wird der erste Thread "actor1" und in 11 der zweite Thread wieder
entfernt. Die Statusinformationen besagen, in welcher Form ein Thread
beendet wurde.

Erst in 12 wird nun begonnen, die Resultate an die Resultatdateien
zu schicken. In 12 wird die Resultatdatei res3412.pl geöffnet. Mit
"repeat" werden nun alle Fakten der Form production(X,Y) in 14 
verschickt. Am Ende von 14 wird diese Datei wieder geschlossen. In 
derselben Weise wird die nächste Resultatdatei res3413.pl geöffnet.
Alle Fakten der Form battle(X,Y) werden dort hingeschickt.
*/

number_of_production_places(20).                                    /* 1 */
number_of_quantities(1,1000). number_of_quantities(2,500).          /* 2 */
const1(0.7). const2(0.3).                                           /* 3 */

number_of_soldiers(900). number_of_groups(5).                       /* 4 */
const3(0.8).                                                        /* 5 */


start :- 
  (exists_file('res3311.pl'), delete_file('res3311.pl') ; true),    /* 6 */
  (exists_file('res3312.pl'), delete_file('res3312.pl') ; true),
  (exists_file('res3313.pl'), delete_file('res3313.pl') ; true),
  number_of_production_places(PRODUCTION_PLACES), 
  writein('res3311.pl',number_of_production_places(PRODUCTION_PLACES)),
  number_of_soldiers(NUMBER_OF_SOLDIERS), 
  writein('res3311.pl',number_of_soldiers(NUMBER_OF_SOLDIERS)),     /* 7 */
  thread_create(actor1,Id1,[]),                                     /* 8 */
  thread_create(actor2,Id2,[alias(actor2)]),                        /* 9 */
  thread_join(Id1,Status1),                                        /* 10 */
  thread_join(actor2,Status2),                                     /* 11 */
  append('res3412.pl'),                                            /* 12 */
  repeat,                                                          /* 13 */
  ( production(X,Y), write(production(X,Y)), write('.'), nl, fail; true),
  told,                                                            /* 14 */
  append('res3413.pl'),                                            /* 15 */ 
  repeat,                                                          /* 16 */
  ( battle(X,Y), write(battle(X,Y)), write('.'), nl, fail; true),
  told.                                                            /* 17 */

actor1 :-                                                         /* 8.1 */
  thread_self(Id1),  asserta(actor1thread(Id1)),                  /* 8.2 */
%    thread_signal(Id1,(attach_console,trace)),                   /* 8.3 */
  number_of_production_places(PRODUCTION_PLACES),                 /* 8.4 */
  const1(C1), const2(C2),                                         /* 8.5 */
  number_of_quantities(1,Q1), number_of_quantities(2,Q2),         /* 8.6 */
  PL1 is Q1/PRODUCTION_PLACES, PL2 is Q2/PRODUCTION_PLACES,       /* 8.7 */
  ( between(1,PRODUCTION_PLACES,PLACE), 
      produce(PLACE,C1,PL1,C2,PL2,QUANTITIY), fail; true).        /* 8.8 */

produce(PLACE,C1,PL1,C2,PL2,QUANTITY) :-                          /* 8.8 */
   Z1 is PL2/2, Z2 is random(ceiling(Z1)), Z3 is Z1 + Z2,         /* 8.9 */ 
   QUANTITY is (C1*log(PL1))*(C2*log(Z3)),                       /* 8.10 */
   asserta(production(PLACE,QUANTITY)),!.                        /* 8.11 */

actor2 :-                                                         /* 9.1 */
  thread_self(actor2), asserta(actor2thread(actor2)),             /* 9.2 */
  thread_signal(actor2,(attach_console,trace)),                   /* 9.3 */
  number_of_groups(NUMBER_OF_GROUPSoriginal),                     /* 9.4 */
  NUMBER_OF_GROUPS is NUMBER_OF_GROUPSoriginal + 1,               /* 9.5 */
  number_of_soldiers(NUMBER_OF_SOLDIERS),                         /* 9.6 */
  PL3 is NUMBER_OF_SOLDIERS/NUMBER_OF_GROUPS,                     /* 9.7 */
  const3(C3), asserta(pool(NUMBER_OF_SOLDIERS)),                  /* 9.8 */
  loop(1,NUMBER_OF_GROUPS,C3,PL3).                                /* 9.9 */

loop(NUMBER_OF_GROUPS,NUMBER_OF_GROUPS,C3,PL3).                  /* 9.9a */
loop(NR_GROUP,NUMBER_OF_GROUPS,C3,PL3) :-                        /* 9.9b */
  NR_GROUP < NUMBER_OF_GROUPS,                                   /* 9.10 */
  fallen(NR_GROUP,C3,PL3),                                       /* 9.11 */
  NR_GROUPnew is NR_GROUP + 1,                                   /* 9.15 */
  loop(NR_GROUPnew,NUMBER_OF_GROUPS,C3,PL3).                     /* 9.16 */

fallen(NR_GROUP,C3,PL3) :-                                       /* 9.11 */
  pool(POOL), NUMBER_OF_FALLEN is random(ceiling(C3*PL3)) + 1,   /* 9.12 */
  asserta(battle(NR_GROUP,NUMBER_OF_FALLEN)),                    /* 9.13 */
  POOLnew is POOL - NUMBER_OF_FALLEN,                            /* 9.14 */
  retract(pool(POOL)), asserta(pool(POOLnew)),!.     

% aux -------------------------------------

writein(File,Message) :- append(File),
   write(Message), write('. '), nl, told. 

