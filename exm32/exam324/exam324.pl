/* exam324 

Ein allgemeines Modul für Institutionen.

In 1 sind die benutzten Konstanten notiert, in 2 werden die Resultatdateien 
geleert und in 3 werden die Konstanten aus der Datenbasis geholt.
In 4 und 5 wird der Baum konstruiert, welcher die Grobstruktur der
Institution trägt. In 6 ist der Baum TREE und die Liste END_LIST der
Endpunkte vorhanden. In 7 haben wir diesen Baum in eine eigene Resultatdatei 
res3243.pl geschickt. 

In 8 werden Abhängigkeitsbeziehungen zwischen den Punkten (d.h. inhaltlich
zwischen den Gruppen) generiert. Zu einer gegebenen Gruppe GROUP_I wird 
eine Liste LIST_OF_DEP_GROUPS_I zugeordnet:

    dependencies([[GROUP1,LIST_OF_DEPENDENT_GROUPS1],...,
                                    [GROUP_N,LIST_OF_DEPENDENT_GROUPS_N]]).

[GROUP_I,LIST_OF_DEPENDENT_GROUPS_I] = [GROUP_I,[GROUP_I_1,...,GROUP_I_M]].
Inhaltlich besagt dies, dass durch Beeinflussung genau die Gruppen
GROUP_I_1,...,GROUP_I_M von der Gruppe GROUP_I abhängig sind. Diese
Abhängigkeiten werden in Zeile 8.11 nach Generierung der Dateibasis hinzugefügt. 
In 8.1 wird dazu der Baum TREE analysiert. Der N-te Ast (N_TH_BRANCH) 
besteht aus Linien [S_P_OA_L,N_TH]; S_P_OA_L ("START_POINT_OF_A_LINE") ist
der Startpunkt einer Linie und N_TH der Endpunkt (welcher zugleich die 
Nummer der Linie ist):   

   findall(S_P_OA_L,nth1(N_TH,TREE,[N_TH,[S_P_OA_L,N_TH]]),LIST_SP).

Mit "trace" lässt sich dies anschaulicher machen. Die mit "findall"
gesammelte Liste LIST_SP enthält alle Startpunkte aller
Linien. Diese Liste wird in 8.2 reduziert, weil in dieser Liste Punkte
mehrfach vorkommen.  Weiter wird der Startpunkt 0 eliminiert. Der Punkt 0
wird in dem Baum nicht benutzt. Für die so reduzierte Liste 
LIST_OF_RED_START_POINTS wird in 8.3 die Länge LO_LIST_RED_SP dieser Liste bestimmt. 

In 9 werden die Äste definiert, die im Baum vorhanden sind. Dieses Äste
haben wir zu einer Liste zusammengefasst:

   branches([[P1_1,...P1_M1],...,[PN_1,...,PN_MN]]).

Ein Ast hat also die Form einer Liste [PI_MI,...PI_MI] von Punkten.
Diese Äste werden an eine eigene Resultatdatei res3245.pl geschickt.
Dabei notieren wir nicht nur die "ausgewachsenen" Äste, sondern auch die
Teiläste, die in der Erzeugung des Baumes entstehen.  

In 10 bekommt jede Gruppe einen Status. Dazu wird in 10.1 die Liste der 
Äste branches(LIST_OF_BRANCHES) geholt und ihre Länge bestimmt. Über die
Länge dieser Liste wird in 10.2 eine Schleife gelegt. Zusätzlich
wird in 10.2 ein Hilfszähler max(_) eingerichtet, der auf 0 gestellt ist. 
In einem Schleifenschritt in 10.3 wird, kurz gesagt, die Länge LENGTH des 
Astes BRANCH und der Ast selber durch ein Paar [BRANCH,LENGTH1] in eine
Liste aufgenommen. 

In 10.4 wird ein Ast BRANCH aus der Liste der Äste bestimmt und in 10.5
die Länge dieses Astes berechnet. Weiter wird die bis jetzt bestimmte
maximale Länge der Äste mit max(MAX) aus der Datenbasis geholt. In 10.6
und 10.7 wird eine Fallunterscheidung getroffen. In 10.6 ist der gerade
untersuchte Ast länger als MAX; in 10.7 ist er nicht länger. In 10.8
wird der Hilfszähler in jedem Fall angepasst. In 10.9 wird die Liste
LIST3 geholt und an diese das Paar [[BRANCH,LENGTH1]] angefügt. In 10.10
wird diese Liste angepasst.

In 10.11 wird die vollständige Liste LIST von aux_list(LIST) geholt, ihre
Länge berechet und in 10.19 auch gelöscht. Weiter wird der Stand des
Hilfszähler max(MAX) überprüft. MAX ist nach der Schleife 10.3 die 
maximale Länge "des" längsten Astes. Wir schicken diese in 10.12 an die
Resultatdatei res3245.pl. 

In 10.13 werden aus den Zahlen MAX und LENGTH die Statuswerte für die 
Gruppe bestimmt. In 10.14 wird dazu in einem Schleifenschritt Nr. Y das 
Paar [BRANCH,STATUS1] bestimmt. In 10.15 wird aus dem Ast BRANCH die 
letzte Komponenten GROUP bestimmt und in 10.16 wird der Status für diese
Gruppe GROUP durch

    STATUS is MAX - (STATUS1 - 1)

bestimmt. In 10.17 werden diese Statuswerte an die Datenbasis angefügt und 
in 10.18 an die Resultatdatei res3245.pl geschickt.  

In 11 wird eine Liste von Mitgliederlisten der Gruppen erzeugt. Diese
Klause programmieren wir hier anders als in exam252, so dass wir auch diese
Klause genauer beschreiben. In 11.1 wird eine Hilfsliste "aux_list" eingerichtet, 
in der am Anfang eine Liste LIST [I,NUMBER_OF_ACTORS] steht. 
In 11.2 wird die Anzahl der Gruppen um Eins vermindert:
NUMBER_OF_GROUPminus1. Über diese Anzahl wird in 11.3 eine Schleife über die
Gruppen - außer der Gruppe Nr.1 - gelegt. In einem Schleifenschritt
in 11.3.1 wird die Hilfsliste LIST geholt und aus der Anzahl der Akteure
zufällig in 11.3.2 eine Akteursnummer X gezogen. Um Mehrfachziehungen zu
vermeiden, wird in 11.3.3 geprüft, ob die gezogene Zahl X schon vorher in 
der Liste LIST vorhanden ist. Erst wenn dies nicht der Fall ist, wird in
11.3.4 diese Nummer in die Liste aufgenommen. In 11.3.5 wird die Liste angepasst.

In 11.4 wird die vollständig erzeugte Liste LIST 

   [1,I_2,...,I_M,AA]

aus der Datenbasis geholt, sortiert und die Länge LENGTH der reduzierten
Liste bestimmt. Die Zahlen aus dieser Liste werden in 12 später
als Intervallgrenzen genommen. Eine Intervall [I_J,I_(J+1)] enthält im
Folgenden die Akteure von I_J bis I_(J+1). In 11.5 und in 11.6 wird eine
Fallunterscheidung getroffen. In 11.5 wird der Ausnahmefall behandelt,
in dem jede Gruppe genau einen Akteur enthält. In diesem Fall enthält in
der weiteren Induktion im ersten Schritt die Gruppe Nr.1 genau
ein Mitglied. Dieser Fakt internal_lists([[1,1]]) wird in die Datenbasis
eingetragen. Im zweiten Fall in 11.6 gibt es weniger Intervallgrenzen
(LENGTH) als Akteure. In diesem Fall werden als ersten Induktionsschritt die
Intervallgrenzen für Gruppe Nr.1 wie folgt eingetragen: internal_lists([[1,B]]). 
In 11.7 wird eine Schleife über die Gruppen - außer Gruppe Nr.1 - gelegt. In 
einem Schleifenschritt in 11.7 geschieht in einem Induktionsschritt folgendes.

In 11.8 wird die interne Liste INTERNAL_LIST geholt. In 11.9 wird 
aus der Liste LISTn an der Stelle GROUP_NR_Y die Grenze LIMIT für die Gruppe
Nr. GROUP_NR_Y geholt. In 11.10 wird die nächste Grenznummer LIMITnew 
(LIMITnew is N_GROUP + 1) und die nächste Gruppennummer GROUP_NR_Ynew 
(GROUP_NR_Ynew is GROUP_NR_Y + 1) genommen. In 11.11 wird diese nächste
Grenze LIMITnn für die Gruppe der Nummer GROUP_NR_Ynew aus der Liste LISTn
geholt. In 11.12 wird das Intervall [LIMITnew,LIMITnn] in die interne
Liste aufgenommen. In 11.13 wird diese interne Liste angepasst. In 
11.14 wird die interne Liste internal_list(LIST_OF_LISTS) aus der Datenbasis
geholt und in 11.15 an die Resultatdatei res3245.pl  geschickt. In 11.16 
wird diese Liste gelöscht und in 11.17 geschieht dies ebenfalls mit der
Hilfsliste "aux_list". 

In 12 werden die Intervallgrenzen mit (Nummern von) Akteuren gefüllt.
In 12.1 wird eine Hilfliste bestehend aus Akteuren und eine leere Liste
list_of_groups([]) von Gruppen eingerichtet. In 12.2 wird eine Schleife 
über die Anzahl der Gruppen gelegt. In einem Schleifenschritt Nr. N werden 
in 12.3 die beiden neuen Listen geholt. In 12.4 wird eine Teiliste mit
make_sublist(N,INTERVALS,AA) erzeugt. In 12.4.1 wird dazu das N-ten
Intervall [K1,K2] aus der Liste INTERVALS genommen. In 12.4.2 wird in
dem Intervall [K1,K2] eine Schleife über die (Nummern der) Akteure
gelegt, die in diesem Intervall liegen werden.

In 12.4.2.1 wird die Hilfsliste "aux_actorlist" geholt. In 12.4.2.2 wird
eine Zufallszahl aus dem Bereich von 1 bis NUMBER_OF_ACTORS gezogen, d.h.
zufällig wird ein Akteur gezogen. In 12.4.2.3 wird geprüft, ob dieser
Akteur schon in der Liste ACTORLIST zu finden ist. Wenn ja, wird 12.4.2.3
falsch und PROLOG kehrt zu 12.4.2.2 und "repeat" zurück. Wenn ACTOR nicht
in der Liste zu findet ist, geht PROLOG weiter zu 12.4.2.4. Hier wird
die Hilfsliste LIST mit aux_list(LIST) geholt. An diese Liste wird der
Akteur ACTOR hinzugefügt. In 12.4.2.6 wird genauso zur Liste ACTORLIST
der ACTOR hinzugefügt. In 12.4.2.5 und 12.4.27 werden diese Listen
angepasst.

In 12.5 wird die Hilfsliste LIST geholt und gelöscht. In 12.6 wird die Liste
LIST_OF_GROUPS geholt. An diese Liste wird die Liste LIST angeklebt. In
12.8 wird die Liste LIST_OF_GROUPS angepasst. In 12.9 wird dieselbe Liste
LIST auch an die Akteurliste ACTORLIST angefügt. In 12.10 wird auch die
Akteurliste angepasst. In 12.11 wird die Hilfsliste ACTORLIST1 geholt
und gelöscht. In 12.12 wird die Liste der Gruppen geholt. In 12.13 tragen
wir diese Liste in die Datenbasis ein.

In 13 wird die Liste der Gruppen geholt und in 14 an die Resultatdatei
res3242.pl geschickt. In 15 werden Konstanten für jede Gruppe erzeugt.
In 15.1 wird die Konstante MC aus der Datenbasis geholt, die wir am Anfang
in 1 notiert hatten. Diese Konstante werden hier nicht mit Inhalt gefüllt.
Eine solche Konstante soll ausdrücken, wie weit dieses Gesamtsystem von 
dem rein individualistischen Weltbild entfernt ist. Wir nehmen in 15.2 
(eine Nummer für) eine Gruppe und ziehen eine Zufallszahl X zwischen 1 und
MC. In 15.3 wird für die Gruppe der Status geholt, die Komponente C für 
die Macht die Gruppe definiert, in 15.4 als power_constant(GROUP, POWER_CONSTANT) 
in die Datenbasis hinzugefügt und in 15.5 auch an die Resultatdatei res3243.pl 
geschickt.  

In 16 wird für jeden Akteur ein "Konto" eingerichtet. Welche Werte 
in dem Konto verwalten werden, bleibt hier inhaltlich offen. Ein Kontowert
könnte ein Geldbetrag, aber auch ein abstrakter Wert (z.B. ein Wert für
die individuelle Macht) sein. In 16.1 wird die in 1 festgelegte Konstante
RC geholt. Diese Zahl kann man bei einer graphischen Darstellung benutzen,
um die Kontostände in der Zeit funktional angemessen darzustellen. Weiter
wird die Konstante MC für Moralität geholt. In 16.2 wird die Liste der 
Gruppen LIST_OF_GROUPS geholt und ihre Länge bestimmt. Über diese Anzahl
der Gruppen wird in 16.3 eine Schleife gelegt. In einem Schleifenschritt in
16.3.1 wird die Gruppe GROUP aus der Liste der Gruppen herausgepickt und
die Länge, d.h. die Zahl der Mitglieder, bestimmt. In 16.3.2 wir eine
Schleife über die Anzahl LENGTH1 der Mitglieder gelegt. In einem
Schleifenschritt in 16.3.2.1 für einen Akteur ein Konto erzeugt. Zunächst
wird in 16.3.2.1 aus der Gruppe GROUP der Akteur ACTOR der Nummer NR_ACTOR
geholt. Weiter wird eine Zufallszahl aus 1 bis MC gezogen. In 16.3.2.2
wird ebenso der Status STATUS der Gruppe NR_GROUP geholt und mit der
Zufallszahl X multipliziert. Diese Zahl nehmen wir als den anfänglichen
(d.h. 1) Kontostand für den Akteur ACTOR. Der Wert W wird in 16.3.2.3
in der Form individual_account(1,ACTOR,W) in die Datenbasis eingetragen und
in 16.3.2.4 an die Resultatdatei res3242.pl geschickt. 

Schließlich generieren wir noch für jede Gruppe ein Gruppenkonto, welches
ebenfalls bedeutungsmäßig offen bleibt. Dieses Gruppenkonto wird einfach
als die Summe der individuellen Konto definiert. Wir generiert diese
Gruppenkonten, um in dieser Form den Gesamtprozess besser zu durchschauen.
In 17.1 wird die Liste von Gruppen geholt und die Länge bestimmt. In 17.2
wird eine Schleife über die Gruppennummern NR_GROUP gelegt. In einem
Schleifenschritt wird aus der Gruppennummer die Gruppe GROUP und die Länge
der Gruppe bestimmt. In 17.2 wird das Gruppenkonto für GROUP generiert.
Dazu wird in 17.2.1 ein Hilfszähler aux_list(0) eingerichtet, der am Anfang
auf 0 steht. In 17.2.2 wird eine Schleifen über Zahl der Mitglieder 
gelegt. In 17.2.2 wird eine Gruppenkonto für die Gruppe GROUP erzeugt.

In 17.2.2.1 wird aus der Liste GROUP der Akteur ACTOR herausgepickt.
Das individuelle Konto von ACTOR und der Hilfszähler werden in 17.2.2.2 geholt. 
In 17.2.2.3 wird zum Stand SUM des Zählers der Wert W addiert. In
17.2.2.4 wird der Hilfszähler angepasst. In 17.2.3 wird der Hilfszähler
am Ende göffnet, die Machtkonstante PC geholt und der Kontowert WG
berechnet. In 17.2.4 wird das Gruppenkonto group_account(1,NR_GROUP,WG)
mit dem Wert WG in die Datenbasis geschrieben und in 17.2.5 auch an
die Resultatdatei res3244.pl geschickt. 

 -----------------------------------

In 18 wird nun die eigentliche, hier interessante Schleife dargestellt.
In dieser Schleife werden die Ticks bearbeitet. In einem TICK geschieht
folgendes. In 19 und 20 wird die Länge LENGTH der Liste LIST_OF_DEPENDECIES
bestimmt. 

Eine Komponente dieser Liste ist ein Paar 
 
   [GROUP_independent,[G1_dep,...,GN_dep]],

wobei GROUP_independent die Macht ausübende, unabhängige Gruppe ist und
G1_dep,..., GN_dep Gruppen sind, die von der unabhängigen Gruppe abhängig
sind. Ein solches Paar nennen wir einen "Komplex". In 21 wird eine Schleife
über die Anzahl der Komplexe gelegt. In einem Schleifenschritt wird jeweils
ein Komplex mit dem Term "traverse_tree" bearbeitet. Das erste Argument 
NR_COMPLEX des Terms

   traverse_tree(NR_COMPLEX,NUMBER_OF_ACTORS,TICK)

drückt aus, dass der Komplex Nummer NR_COMPLEX aus der Liste
LIST_OF_DEPENDENT_GROUP bearbeitet wird: nth1(NR_COMPLEX,
LIST_OF_DEPENDENCIES,COMPLEX), wobei ein Komplex die Form 

    COMPLEX = [NR_GROUP_independent, [NR_G1dep,...,NR_GNdep]] 

hat. In 22 und 23 wird aus der Liste ein bestimmter Komplex COMPLEX
herausgeholt. In 24 wird aus dem Komplex die Liste LISTdep der abhängigen
Gruppen genommen. Wir müssen hier zwischen dem Namen NAME_GROUP (hier 
einfach einer Zahl) einer Gruppe und der Gruppe GROUP selbst unterscheiden. 
Eine Gruppe ist dargestellt durch eine Liste(!) von Zahlen (Namen) für die
Mitglieder (Akteure) der Gruppe. In 24 wird die Länge der Liste der
abhängigen (Namens)Gruppen bestimmt. In 25 wird eine Schleife über die
abhängigen Gruppen gelegt, die relativ zu einer bestimmten, unabhängigen Gruppe 
gehören. In einem Schleifenschritt in 26 - 28 wird in dem Komplex
der Name für die unabhängige Gruppe bestimmt. In 29 wird die Liste der
Gruppen geholt und in 30 für den Namen NAME_GROUP_indep die entsprechende 
Gruppe GROUP herausgepickt. In 31 und 32 wird der Status und die
Machtkonstante für diese Gruppe geholt. In 33 wird die Länge der Gruppe, 
d.h. die Zahl der Mitglieder der Gruppe, bestimmt: LENGTH_GROUP. R1
besagt, wie groß die Gruppe relativ zur Gesamtgröße des System
(NUMBER_OF_ACTORS) ist. In 34 wird aus diesen Zahlen ein Wert VALUE definiert. 
In 35 bis 39 wird dieser Wert von der unabhängigen Gruppe ausgegeben ("spend") 
und  ("take") der abhängigen Gruppe gegeben. Diesen
Prozeß können wir als eine Art von Entlohnung auf Gruppenebene ansehen.

Genauer wird aus der Ausgabenseite der Gruppe NAME_GROUP_indep in 35 das
Gruppenkonto geöffnet und in 36 oder 37 verändert. Im Normalfall in
36 wird die Gruppe nicht alles ausgeben, was sie auf ihrem Konto hat.
Im zweiten Fall in 37 kann es aber sein, dass sich die Gruppe "verspekuliert"
hat. Die Gruppe hat einen Plan umgesetzt, bei dem alles, was die Gruppe auf
dem Konto hat, auch einsetzt. Wenn der Plan eigentlich noch mehr Mittel
braucht, sollten wir zum Thema Kapital kommen. In unserem Programm gibt
es aber keine Schulden, so dass dieses hier nicht thematisiert wird.
In 37 wird der Wert auf 1 gesetzt. In 38 wird das Gruppenkonto angepasst
und in 39 werden diese Veränderungen an die Resultatdatei res3241.pl
geschickt. Da diese Resultate ziemlich umfangreich werden, verlieren wir
schnell den Überblick. An diesem Punkt wäre zu überlegen, wie wir diese
Resultate besser verteilen können. 

In ähnlicher Weise wird die Auszahlung des Wertes VALUE an die abhängige
Gruppe NAME_GROUPdep programmiert. In 40 wird das Gruppenkonto geholt
und der Kontostand angepasst. Hier gibt es nur eine Richtung. In 41 wird 
zum alten Kontostand der hinzukommende Wert VALUE addiert. In
43 wird das Konto angepasst und in 44 die Veränderung an die Resultatdatei 
res3241.pl geschickt.

Nach Ende von 21 wird die Periode weiterbearbeitet. In 44 wird die Endlinie 
des Baumes geholt und die Länge der Endlinie bestimmt. Diese Liste enthält
genau die Gruppen, die am unteren Ende des Baumes liegen und die selber
keine Gruppe "unter sich" hat. D.h. für eine solche Gruppe GROUP gibt es
keine Gruppe, die von GROUP abhängig ist. In 45 wird eine Schleife über 
diese "letzten" Gruppen gelegt. Diese Gruppen schicken eine Abgabe, eine Art
Steuer ("tax"), an die "erste, oberste" Gruppe aus dem Baum. In einem 
Schleifenschritt wird in 45.1 und 45.2 der Status und die Machtkonstante 
für die abhängige Gruppe geholt. In 45.3 und 45.4 wird die zugehörige Gruppe 
als Liste GROUP von Mitgliedern berechnet und in 45.5 die Anzahl der Mitglieder 
bestimmt. In 45.6 und 45.7 wird der Wert VALUE für diese Gruppe definiert. In 
45.8 wird dieser Wert "versteuert".  

Genauer wird in 45.8.1 das Gruppenkonto der Gruppe NAME_GROUPdep geholt
und den Steuerbetrag VALUE abgebucht. Auch hier kann es sein, dass die 
Gruppe diesen Wert VALUE nicht auf dem Konto hat. In diesem Fall wird der
Betrag (minus 1) abgebucht, der im Konto vorhanden ist. In 45.8.4-5 wird
das Konto angepasst und in 45.8.6 diese Veränderung an die Resultatdatei
res3241.pl geschickt. In 45.8.7 wird dieser Betrag an die Gruppe Nr.1
geschickt. In 45.8.7.1 wird der Betrag VALUE dem Gruppenkonto der Gruppe 
Nr.1 gutgeschrieben und das Konto angepasst und die Änderung als Resultat
gespeichert. 

In 46 wird schließlich der nächste TICK aufgerufen. In 46 und 47 werden 
alle Kontenbestände an den nächsten TICK1 angepasst. D.h. der Zeitstempel
jedes Kontos wird in 48 verändert. In 49 werden diese angepassten
Kontostände an die Resultatdatei res3241.pl geschickt. 

In 50 werden schließlich die Kontostände der Gruppen nach dem letzten TICK 
an die Resultatdatei res3244.pl geschickt.
   
Abkürzungen: 
ANB_MAX_LENGTH = A_NUMBER_OF_BRANCH_OF_MAXIMAL_LENGTH
LIST_SP = LIST_OF_START_POINTS
LO_LIST_RED_SP = LENGTH_OF_LIST_REDUCED_START_POINTS
*/

number_of_ticks(2).
number_of_actors(50).
number_of_groups(20). /* das ist die minimal interessante Größe */
number_of_decisions(3).
calibration_constant(1000).
moral_constant(20).                                                 /* 1 */

start :-
% -------------------------------------------------
% All die folgenden Zeilen sind rein Vorbereitung

  (exists_file('res3241.pl'), delete_file('res3241.pl'); true),
  (exists_file('res3242.pl'), delete_file('res3242.pl'); true),
  (exists_file('res3243.pl'), delete_file('res3243.pl'); true),
  (exists_file('res3244.pl'), delete_file('res3244.pl'); true),
  (exists_file('res3245.pl'), delete_file('res3245.pl'); true),     /* 2 */
  number_of_ticks(NUMBER_OF_TICKS), 
  number_of_actors(NUMBER_OF_ACTORS), 
  number_of_groups(NUMBER_OF_GROUPS), 
  number_of_decisions(NUMBER_OF_DECISIONS),                         /* 3 */     
  asserta(tree([[1,[0,1]]])), asserta(end_line([1])),               /* 4 */
  make_a_tree(1,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS),              /* 5 */ 
  tree(TREE), end_line(END_LINE),                                   /* 6 */
  append('res3243.pl'), write(tree(TREE)), write('.'), nl, nl,
  write(end_line(END_LINE)), write('.'), nl, nl, told,              /* 7 */
  make_dependencies(TREE), dependencies(LIST_OF_DEPENDENCIES),      /* 8 */
  make_branches(TREE),                                              /* 9 */
  make_status,                                                     /* 10 */
  make_actorlists(NUMBER_OF_ACTORS,NUMBER_OF_GROUPS,INTERVALS),    /* 11 */
  fill_groups(NUMBER_OF_ACTORS,NUMBER_OF_GROUPS,INTERVALS),        /* 12 */
  list_of_groups(LIST_OF_GROUPS),                                  /* 13 */
  append('res3242.pl'), write(list_of_groups(LIST_OF_GROUPS)), write('.'), 
  nl, nl, told,                                                    /* 14 */
  make_power_constants(NUMBER_OF_GROUPS),                          /* 15 */
  make_individual_accounts(NUMBER_OF_ACTORS),                      /* 16 */
  make_group_accounts(LIST_OF_GROUPS),                             /* 17 */

% -------------------------------------------------- 
  ( between(1,NUMBER_OF_TICKS,TICK),                              /* 18a */
    periode(TICK,NUMBER_OF_ACTORS,NUMBER_OF_GROUPS), 
      fail
  ; true ),                                                       /* 18b */ 
  store_group_accounts(NUMBER_OF_TICKS,NUMBER_OF_GROUPS),          /* 39 */
  retractall(iacc(TTT,TTT1,TTT2)),
  retractall(gaccount(FFF1,FFF2,FFF3)),
  retract(dependencies(LIST_OF_DEPENDENCIES)), 
  retract(tree(TREE)), retract(end_line(END)),!.                    

periode(TICK,NUMBER_OF_ACTORS,NUMBER_OF_GROUPS) :-                 /* 18 */  
  dependencies(LIST_OF_DEPENDENCIES),                              /* 19 */
  length(LIST_OF_DEPENDENCIES,LENGTH),                             /* 20 */
  ( between(1,LENGTH,NR_COMPLEX), 
     traverse_tree(NR_COMPLEX,NUMBER_OF_ACTORS,TICK), fail; true), /* 21 */
  end_line(END_LINE), length(END_LINE,LENGTH_ENDLINE),             /* 44 */
  ( between(1,LENGTH_ENDLINE,NR), nth1(NR,END_LINE,NR_GROUP), 
      work_upward(NR_GROUP,TICK,NUMBER_OF_ACTORS), fail; true),    /* 45 */
  append('res3241.pl'), nl, told, 
  TICK1 is TICK+1, repeat, 
  ( group_account(TICK,X2,X3),                                     /* 46 */ 
     retract(group_account(TICK,X2,X3)),           
     asserta(group_account(TICK1,X2,X3)),                          /* 47 */
     append('res3241.pl'), write(group_account(TICK1,X2,X3)),
      write('.'), nl, told,                                        /* 48 */
     fail
  ; true 
  ),!.

traverse_tree(NR_COMPLEX,NUMBER_OF_ACTORS,TICK) :-                 /* 21 */
  dependencies(LIST_OF_DEPENDENCIES),                              /* 22 */
  nth1(NR_COMPLEX,LIST_OF_DEPENDENCIES,COMPLEX),                   /* 23 */
  nth1(2,COMPLEX,LISTdep), length(LISTdep,LENGTHdep),              /* 24 */ 
  ( between(1,LENGTHdep,NR), nth1(NR,LISTdep,NAME_GROUPdep),
       work_downward(NAME_GROUPdep,NR_COMPLEX,TICK,NUMBER_OF_ACTORS), 
   fail; true),!.                                                  /* 25 */

work_downward(NAME_GROUPdep,NR_COMPLEX,TICK,NUMBER_OF_ACTORS) :-   /* 25 */
  dependencies(LIST_OF_DEPENDENCIES),                              /* 26 */
  nth1(NR_COMPLEX,LIST_OF_DEPENDENCIES,COMPLEX),                   /* 27 */
  nth1(1,COMPLEX,NAME_GROUP_indep),                                /* 28 */
  list_of_groups(LIST_OF_GROUPS),                                  /* 29 */
  nth1(NAME_GROUP_indep,LIST_OF_GROUPS,GROUP),                     /* 30 */
  status(NAME_GROUP_indep,STATUS),                                 /* 31 */
  power_constant(NAME_GROUP_indep,CONSTANT),                       /* 32 */
  length(GROUP,LENGTH_GROUP), R1 is LENGTH_GROUP/NUMBER_OF_ACTORS, /* 33 */
  VALUE is (STATUS * CONSTANT) * R1,                               /* 34 */
  group_account(TICK,NAME_GROUP_indep,VALUEold),                   /* 35 */
  ( VALUE < VALUEold, VALUEnew is VALUEold - VALUE,            
    SALARY is VALUE                                                /* 36 */
  ; VALUEold =< VALUE, VALUEnew is 1, SALARY is VALUEold           /* 37 */
  ),
  retract(group_account(TICK,NAME_GROUP_indep,VALUEold)),
  asserta(group_account(TICK,NAME_GROUP_indep,VALUEnew)),          /* 38 */
  append('res3241.pl'),  nl,                                      /* 39a */
  write(group_account(TICK,NAME_GROUP_indep,VALUEold)), write('.'), nl, 
  write(spend(TICK,NAME_GROUP_indep,SALARY)), write('.'), nl, 
  write(group_account(TICK,NAME_GROUP_indep,VALUEnew)), write('.'), 
  nl, told,                                                       /* 39e */     
  group_account(TICK,NAME_GROUPdep,VALUEdep),                      /* 40 */
  VALUE1new is VALUEdep + VALUE,                                   /* 41 */
  retract(group_account(TICK,NAME_GROUPdep,VALUEdep)),             /* 42 */ 
  asserta(group_account(TICK,NAME_GROUPdep,VALUE1new)),            /* 43 */
  append('res3241.pl'), write(group_account(TICK,                 /* 43a */
      NAME_GROUPdep,VALUEdep)), write('.'), nl,
      write(take(TICK,NAME_GROUPdep,VALUE)), 
      write('.'), nl, write(group_account(TICK,NAME_GROUPdep,VALUE1new)),
      write('.'), nl, told,!.                                     /* 43e */

work_upward(NAME_GROUPdep,TICK,NUMBER_OF_ACTORS) :-                /* 45 */
  status(NAME_GROUPdep,STATUS),                                  /* 45.1 */
  power_constant(NAME_GROUPdep,CONSTANT),                        /* 45.2 */
  list_of_groups(LIST_OF_GROUPS),                                /* 45.3 */
  nth1(NAME_GROUP_indep,LIST_OF_GROUPS,GROUP),                   /* 45.4 */
  length(GROUP,LENGTH),                                          /* 45.5 */
  R2 is NUMBER_OF_ACTORS/LENGTH,                                 /* 45.6 */
  VALUE is (STATUS * CONSTANT) * R2,                             /* 45.7 */
  give_tax(TICK,VALUE,NAME_GROUPdep),!.                          /* 45.8 */

give_tax(TICK,VALUE,NAME_GROUPdep) :-                            /* 45.8 */
   group_account(TICK,NAME_GROUPdep,VALUEold),                 /* 45.8.1 */
   ( VALUE < VALUEold, VALUEnew is VALUEold - VALUE, 
     TAX is VALUE                                              /* 45.8.2 */
   ; VALUEold =< VALUE, VALUEnew is 1, TAX is VALUEold         /* 45.8.3 */
   ),
   retract(group_account(TICK,NAME_GROUPdep,VALUEold)),        /* 45.8.4 */
   asserta(group_account(TICK,NAME_GROUPdep,VALUEnew)),        /* 45.8.5 */ 
   append('res3241.pl'), nl,                                  /* 45.8.6a */
      write(group_account(TICK,NAME_GROUPdep,VALUEold)), write('.'), nl,
      write(give_tax(TICK,NAME_GROUPdep,TAX)), 
      write('.'), nl, write(group_account(TICK,NAME_GROUPdep,VALUEnew)), 
      write('.'), nl, told,                                   /* 45.8.6d */
   send_tax(TICK,TAX,1),!.                                     /* 45.8.7 */

send_tax(TICK,VALUE,1) :-                                      /* 45.8.7 */
   group_account(TICK,1,VALUEold),                           /* 45.8.7.1 */
   VALUEnew is VALUEold + VALUE,                             /* 45.8.7.2 */
   retract(group_account(TICK,1,VALUEold)),                  /* 45.8.7.3 */
   asserta(group_account(TICK,1,VALUEnew)),                  /* 45.8.7.4 */
      append('res3241.pl'),                                 /* 45.8.7.4a */
      write(group_account(TICK,1,VALUEold)), write('.'), nl,
      write(take_tax(TICK,1,VALUE)), 
      write('.'), nl, write(group_account(TICK,1,VALUEnew)), write('.'), 
      nl, told,!.                                           /* 45.8.7.4d */

% -----------------------------------

make_group_accounts(LIST_OF_GROUPS) :-                             /* 17 */
 list_of_groups(LIST_OF_GROUPS), length(LIST_OF_GROUPS,EL),      /* 17.1 */
 ( between(1,EL,NR_GROUP), nth1(NR_GROUP,LIST_OF_GROUPS,GROUP),
    length(GROUP,LENGTH), 
    make_group_account(GROUP,LENGTH,NR_GROUP), fail; true),!.    /* 17.2 */

make_group_account(GROUP,LENGTH,NR_GROUP) :- 
   asserta(aux_sum(0)),                                        /* 17.2.1 */
   ( between(1,LENGTH,NR_ACTOR), add_group_account(NR_ACTOR,GROUP), 
       fail; true),                                            /* 17.2.2 */
   aux_sum(SUM), power_constant(NR_GROUP,PC), WG is SUM * PC,  /* 17.2.3 */
   asserta(group_account(1,NR_GROUP,WG)),                      /* 17.2.4 */
   append('res3244.pl'), write(group_account(1,NR_GROUP,WG)), write('.'), 
      nl, told,!.                                              /* 17.2.5 */

add_group_account(NR_ACTOR,GROUP) :-  
  nth1(NR_ACTOR,GROUP,ACTOR), individual_account(1,ACTOR,W), /* 17.2.2.1 */
  aux_sum(SUM),                                              /* 17.2.2.2 */
  SUMnew is SUM + W,                                         /* 17.2.2.3 */
  retract(aux_sum(SUM)), asserta(aux_sum(SUMnew)),!.         /* 17.2.2.4 */

% -------------------------------------

make_individual_accounts(NUMBER_OF_ACTORS) :-                      /* 16 */
% trace,
  calibration_constant(RC), moral_constant(MC),                  /* 16.1 */
  list_of_groups(LIST_OF_GROUPS), length(LIST_OF_GROUPS,LENGTH), /* 16.2 */
  ( between(1,LENGTH,NR_GROUP), make_accounts(NR_GROUP,RC,MC,LIST_OF_GROUPS), 
     fail; true),!.                                              /* 16.3 */

make_accounts(NR_GROUP,RC,MC,LIST_OF_GROUPS) :-  
  nth1(NR_GROUP,LIST_OF_GROUPS,GROUP), length(GROUP,LENGTH1),  /* 16.3.1 */
  (  between(1,LENGTH1,NR_ACTOR), 
     make_individual_account(NR_ACTOR,RC,MC,NR_GROUP,GROUP), 
     fail; true),!.                                            /* 16.3.2 */

make_individual_account(NR_ACTOR,RC,MC,NR_GROUP,GROUP) :- 
  nth1(NR_ACTOR,GROUP,ACTOR), X is random(MC) + 1,           /* 16.3.2.1 */
  status(NR_GROUP,STATUS), W is X * STATUS,                  /* 16.3.2.2 */
  asserta(individual_account(1,ACTOR,W)),                    /* 16.3.2.3 */
  append('res3242.pl'), write(individual_account(1,ACTOR,W)), write('.'), 
  nl, told,!.                                                /* 16.3.2.4 */

% -------------------------------------------

make_power_constants(NUMBER_OF_GROUPS) :-                          /* 15 */
  moral_constant(MC),                                            /* 15.1 */
  ( between(1,NUMBER_OF_GROUPS,GROUP), X is random(MC) + 1,      /* 15.2 */
    status(GROUP,STATUS), 
    POWER_CONSTANT is (X/NUMBER_OF_GROUPS) * STATUS,             /* 15.3 */
    asserta(power_constant(GROUP,POWER_CONSTANT)),               /* 15.4 */
    append('res3243.pl'), write(power_constant(GROUP,POWER_CONSTANT)),
          write('.  '), nl, told, fail                               /* 15.5 */
  ;  true 
  ),!.                                                          

% ------------------------------------

fill_groups(NUMBER_OF_ACTORS,NUMBER_OF_GROUPS,INTERVALS) :-        /* 12 */ 
  asserta(aux_actorlist([])), asserta(list_of_groups([])),       /* 12.1 */
  ( between(1,NUMBER_OF_GROUPS,N), 
       make_group_list(N,NUMBER_OF_ACTORS,INTERVALS),fail
  ; true
  ),!,                                                           /* 12.2 */
  aux_actorlist(AAA),  retract(aux_actorlist(AAA)),             /* 12.11 */
  list_of_groups(LIST_OF_GROUPS),                               /* 12.12 */
  asserta(list_of_groups(LIST_OF_GROUPS)),!.                    /* 12.13 */

make_group_list(N,NUMBER_OF_ACTORS,INTERVALS) :-                 /* 12.2 */
  aux_actorlist(ACTORLIST), asserta(aux_list([])),               /* 12.3 */
  make_sublist(N,INTERVALS,NUMBER_OF_ACTORS),                    /* 12.4 */
  aux_list(LIST), retract(aux_list(LIST)),                       /* 12.5 */
  list_of_groups(GLIST),                                         /* 12.6 */
  append(GLIST,[LIST],GLISTnew),                                 /* 12.7 */
  retract(list_of_groups(GLIST)),                             
  asserta(list_of_groups(GLISTnew)),                             /* 12.8 */
  append(ACTORLIST,LIST,ACTORLISTnew),                           /* 12.9 */
  retract(aux_actorlist(ACTORLIST)),
  asserta(aux_actorlist(ACTORLISTnew)),!.                       /* 12.10 */

make_sublist(N,INTERVALS,NUMBER_OF_ACTORS) :-                    /* 12.4 */
  nth1(N,INTERVALS,[K1,K2]),                                   /* 12.4.1 */
  ( between(K1,K2,X), add_one_actor(X,NUMBER_OF_ACTORS), 
      fail; true),!.                                           /* 12.4.2 */
 
add_one_actor(X,NUMBER_OF_ACTORS) :-                           /* 12.4.2 */
  aux_actorlist(ACTORLIST),                                  /* 12.4.2.1 */
  repeat, A is random(NUMBER_OF_ACTORS) + 1,                 /* 12.4.2.2 */
  \+ member(A,ACTORLIST),                                    /* 12.4.2.3 */ 
  aux_list(LIST), append(LIST,[A],LISTnew),                  /* 12.4.2.4 */
  retract(aux_list(LIST)), asserta(aux_list(LISTnew)),       /* 12.4.2.5 */
  append(ACTORLIST,[A],ACTORLISTnew),                        /* 12.4.2.6 */
  retract(aux_actorlist(ACTORLIST)), 
  asserta(aux_actorlist(ACTORLISTnew)),!.                    /* 12.4.2.7 */

%---------------------------------------------------
  
make_actorlists(NUMBER_OF_ACTORS,NUMBER_OF_GROUPS,
       LIST_OF_LISTS) :-                                           /* 11 */
  asserta(aux_list([1,NUMBER_OF_ACTORS])),                       /* 11.1 */
  NUMBER_OF_GROUPminus1 is NUMBER_OF_GROUPS - 1,                 /* 11.2 */
  ( between(1,NUMBER_OF_GROUPminus1,N), 
     add_one_random_number(N,NUMBER_OF_ACTORS), fail; true),     /* 11.3 */
  aux_list(LIST), sort(LIST,LISTn), length(LISTn,LENGTH),        /* 11.4 */
  ( LENGTH = NUMBER_OF_ACTORS, asserta(interval_lists([[1,1]]))  /* 11.5 */
  ;
    LENGTH < NUMBER_OF_ACTORS, nth1(2,LISTn,B),                  /* 11.6 */
    asserta(interval_lists([[1,B]]))                                  
  ),
  ( between(2,NUMBER_OF_GROUPS,GROUP_NR_Y), 
     calculate(GROUP_NR_Y,NUMBER_OF_ACTORS,LISTn), 
     fail; true                                                  /* 11.7 */
  ),
  interval_lists(LIST_OF_LISTS),                                 /* 11.14 */
  append('res3245.pl'), nl, write(actor_intervals(LIST_OF_LISTS)), 
       write('.'), nl, told,                                    /* 11.15 */
  retract(interval_lists(LIST_OF_LISTS)),                        /* 11.16 */
  retract(aux_list(DDD)),!.                                     /* 11.17 */

calculate(GROUP_NR_Y,NUMBER_OF_ACTORS,LISTn) :-                  /* 11.7 */
   interval_lists(INTERNAL_LIST),                                 /* 11.8 */
   nth1(GROUP_NR_Y,LISTn,LIMIT),                                 /* 11.9 */
   LIMITnew is LIMIT + 1, GROUP_NR_Ynew is GROUP_NR_Y + 1,      /* 11.10 */
   nth1(GROUP_NR_Ynew,LISTn,LIMITnn),                           /* 11.11 */
   append(INTERVAL_LIST,[[LIMITnew,LIMITnn]],INTERVAL_LISTnew), /* 11.12 */
   retract(interval_lists(INTERVAL_LIST)),
   asserta(interval_lists(INTERVAL_LISTnew)),!.                  /* 11.13 */

add_one_random_number(N,NUMBER_OF_ACTORS) :-                     /* 11.3 */
  aux_list(LIST),                                              /* 11.3.1 */
  repeat, X is random(NUMBER_OF_ACTORS) + 1,                   /* 11.3.2 */
  \+ nth1(J,LIST,X),                                           /* 11.3.3 */
  append(LIST,[X],LISTnew),                                    /* 11.3.4 */
  retract(aux_list(LIST)),
  asserta(aux_list(LISTnew)),!.                                /* 11.3.5 */

% ---------------------------------------------

make_status :-                                                     /* 10 */
% trace,
  branches(LIST_OF_BRANCHES), asserta(aux_list([])),             /* 10.1 */
  asserta(max(0)), length(LIST_OF_BRANCHES,LENGTH_BRANCH),       /* 10.2 */
  ( between(1,LENGTH_BRANCH,NR_BRANCH),   
    calculate_status(NR_BRANCH,LIST_OF_BRANCHES), 
    fail                                                         /* 10.3 */
  ; true
  ),
  aux_list(LIST), length(LIST,LENGTH), max(MAXX),               /* 10.11 */
  append('res3245.pl'), write(maximal_status(MAXX)), 
     write('.'), nl, nl, told,                                      /* 10.12 */
  make_inverse_status(MAXX,LENGTH,LIST),                        /* 10.13 */
  retract(aux_list(LLL)),!.                                     /* 10.19 */

calculate_status(NR_BRANCH,LIST_OF_BRANCHES) :-                  /* 10.3 */
  nth1(NR_BRANCH,LIST_OF_BRANCHES,BRANCH),                       /* 10.4 */
  length(BRANCH,LENGTH1), max(MAX),                              /* 10.5 */
  ( MAX < LENGTH1, MAXnew is LENGTH1                             /* 10.6 */
  ; 
    LENGTH1 =< MAX, MAXnew = MAX                                 /* 10.7 */
  ),
  retract(max(MAX)), asserta(max(MAXnew)),                       /* 10.8 */
  aux_list(LIST3), append(LIST3,[[BRANCH,LENGTH1]],LISTnew),     /* 10.9 */     
  retract(aux_list(LIST3)),
  asserta(aux_list(LISTnew)),!.                                 /* 10.10 */

make_inverse_status(MAXX,LENGTH,LIST) :-                        /* 10.13 */
  ( between(1,LENGTH,Y), nth1(Y,LIST,[BRANCH,STATUS1]),         /* 10.14 */
    nth1(STATUS1,BRANCH,GROUP),                                 /* 10.15 */
    STATUS is MAXX - (STATUS1 - 1),                             /* 10.16 */
    asserta(status(GROUP,STATUS)),                              /* 10.17 */
    append('res3245.pl'), write(status(GROUP,STATUS)), write('.'), nl, told,
    fail ; true),!.                                             /* 10.18 */
  
% -------------------------------------------------------

make_branches(TREE) :-                                              /* 9 */
  asserta(branches([[1]])), length(TREE,E),
  ( between(1,E,X), make_branches(X,TREE), fail; true),
  branches(BL), asserta(branches(BL)),
  append('res3245.pl'), write(branches(BL)), write('.'),          /* 9.1 */
  nl, nl, told,!.

make_branches(X,TREE) :- branches(BL), nth1(X,TREE,[A,[B,C]]),
  length(BL,EB),
  ( between(1,EB,Y),  analyse(Y,B,C,BL), fail; true),!.

analyse(Y,B,C,BL) :- nth1(Y,BL,BR), length(BR,EBR), nth1(EBR,BR,B),
  append(BR,[C],BRnew), append(BL,[BRnew],BLnew), retract(branches(BL)),
  asserta(branches(BLnew)),!.

% dependencies ------------------------------------------------

 make_dependencies(TREE) :-                                         /* 8 */
  findall(S_P_OA_L,nth1(N_TH,TREE,[N_TH,[S_P_OA_L,N_TH]]),
       LIST_SP),                                                  /* 8.1 */
  sort(LIST_SP,LIST2), delete(LIST2,0,LIST_OF_RED_START_POINTS),  /* 8.2 */ 
  length(LIST_OF_RED_START_POINTS,LO_LIST_RED_SP),                /* 8.3 */
  asserta(dependencies([])),                                      /* 8.4 */
  ( between(1,LO_LIST_RED_SP,X),
      make_depend(X,LIST_OF_RED_START_POINTS,TREE), fail; 
      true
  ),                                                              /* 8.5 */
  dependencies(LIST_OF_DEPENDENCIES),                             /* 8.6 */
  asserta(dependencies(LIST_OF_DEPENDENCIES)),                    /* 8.7 */
  append('res3243.pl'), nl, write(dependencies(LIST_OF_DEPENDENCIES)), 
  write('.'), nl , nl, told,!.                                  /* 8.8 */

make_depend(X,LIST_OF_RED_START_POINTS,TREE) :- 
  nth1(X,LIST_OF_RED_START_POINTS,G),
  dependencies(LIST_OF_DEPENDENCIESdyn),
  findall(Y,nth1(Y,TREE,[Y,[G,Y]]),LL1),
  append(LIST_OF_DEPENDENCIESdyn,[[G,LL1]],LIST_OF_DEPENDENCIESnew),
  retract(dependencies(LIST_OF_DEPENDENCIESdyn)),
  asserta(dependencies(LIST_OF_DEPENDENCIESnew)),!. 

% the tree -----------------------------------
 
make_a_tree(NUMBER_OF_GROUPS,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS). /* 5 */

make_a_tree(G,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS) :-
  G =< NUMBER_OF_GROUPS,
  add_points(G,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS,GY),
  Gnew is GY, 
  ( Gnew =< NUMBER_OF_GROUPS, 
      make_a_tree(Gnew,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS)
  ;   true),!.

add_points(G,NUMBER_OF_GROUPS,NUMBER_OF_DECISIONS,GY) :- 
  tree(TREE), end_line(END_LINE),
  length(END_LINE,E), X is random(E) + 1, nth1(X,END_LINE,G1), 
  nth1(G1,TREE,[G1,LL]), GGn is NUMBER_OF_GROUPS - 1,
  ( G = GGn, Y is 1 
  ; G < GGn, 
    Y1 is min(NUMBER_OF_GROUPS - G,NUMBER_OF_DECISIONS),
    Y is random(Y1) + 1 
  ), 
  GY is G + Y,
  ( between(1,Y,Z), add_one_point(Z,G,G1), fail; true),
  end_line(END_LINE1), delete(END_LINE1,G1,END_LINEnew),
  retract(end_line(END_LINE1)),
  asserta(end_line(END_LINEnew)),!.

add_one_point(Z,G,G1) :-
  tree(TREE), end_line(END_LINE1),
  Gnew is G + Z,
  append(TREE,[[Gnew,[G1,Gnew]]],TREEnew),
  retract(tree(TREE)), asserta(tree(TREEnew)),
  append(END_LINE1,[Gnew],END_LINEnew), 
  retract(end_line(END_LINE1)), asserta(end_line(END_LINEnew)),!.

% ----------------------------------------

store_group_accounts(NUMBER_OF_TICKS,NUMBER_OF_GROUPS) :-          /* 39 */
  ( between(1,NUMBER_OF_GROUPS,NG), 
     store_group_account(NUMBER_OF_TICKS,NG), 
    fail; true),!.

store_group_account(NUMBER_OF_TICKS,NG) :- 
  TT1 is NUMBER_OF_TICKS + 1, group_account(TT1,NG,W),
  append('res3244.pl'), write(group_account(TT1,NG,W)), write('.'), 
  nl, told,!.

% aux ------------------------------------------------------

sum(N,L,S) :- 
  asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !. 



