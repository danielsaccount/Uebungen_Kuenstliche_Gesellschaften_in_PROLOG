/* exam323 

Gemeinsame Einstellungen (joint intentions) werden durch Wahl erzeugt.

Dazu haben wir eine ad hoc Prozentzahl 60/100 benutzt. 
In diesem Beispiel sind die gemeinsamen Handlungen (joint actions) mit 
individuellen Handlungstypen identisch. 

Zur Vorbereitung erzeugen wir Gruppen mit den zugehörigen Mitgliederlisten
und Listen für charakteristische Handlungstypen für jede Gruppe. 

   group(GROUP_NAME,LIST_OF_MEMBERS)
   z.B. group(2,[4,5,6,7])
   action_typs_for(GROUP,LIST_OF_ACTION_TYPS)
   z.B. action_typ_for(2,[act_typ(3),act_typ(2),act_typ(5)])

In 1 finden wir die verschiedenen Konstanten. Die Gruppe 1 ist zu
95 Prozent intelligent und Gruppe 2 zu 70 Prozent. Diese Konstante benutzen
wir bei der Erzeugung der individuellen Einstellungen (intention). Je
intelligenter die Gruppe ist, desto mehr Einstellungen werden erzeugt.
Die Wahl-Konstante bestimmt, welcher Prozentsatz von Mitgliedern reicht,
um eine gemeinsame Einstellung zu generieren.  

In 2 werden die Resultatdateien geleert und in 3 die Fakten geholt. In
4 berechnen wir eine Zahl, die die verschiedenen Gruppengrößen regeln.
Die Gruppengrößen werden in bestimmten Grenzen zufällig erzeugt, so dass 
die Anzahl der Akteure mit der Summe aller Gruppengrößen identisch ist.

In 5 werden die Gruppen erzeugt und in 5.1 an eine Resultatdatei geschickt.
In 6 werden Listen von Handlungstypen für jeden Handlungstyp erzeugt und
in 6.1 an eine Resultatdatei geschickt.

In 7 werden zu jedem Tick indidivuelle und gemeinsame Einstellungen
(intentions) erzeugt. In 8 werden für jeden Akteur (individuelle)
Einstellungen generiert. Diese brauchen wir als Vorbereitung für die hier
eigentlich zu generierenden gemeinsamen Einstellungen. In einem Schleifenschritt
in 9 wird berechnet, zu welcher Gruppe GROUP der Akteur ACTOR gehört. Die
in 9 benutzte Konstruktion funktioniert, weil die Listen für die Gruppen 
alle disjunktion erzeugt wurden. In 10 wird die Intelligenz der Gruppe GROUP
geholt und eine Zufallszahl X gezogen, mit welcher wir zwei Möglichkeiten
eröffnen. Wenn die Intelligenz der Gruppe größer (=<) als X ist, wird für
den Akteur ACTOR, der ein Mitglied der Gruppe ist, eine indidivuelle
Einstellung erzeugt. Wenn die Gruppe dumm ist, wird für den Akteur in 11
keine Einstellung generiert. In 12 wird die Liste der Handlungstypen 
LIST_OF_ACTION_TYPS für die Gruppe geholt und in 13 ihre Länge bestimmt.
In 14 und 15 wird zufällig ein Handlungstyp ACTION_TYP aus der Liste 
gezogen. In 16 wird die so neu erzeugte Einstellung

     intention(TICK,ACTOR,ACTION_TYP)

in die Datenbasis eingefügt und in 17 an die Resultatdatei res3232.pl geschickt. 
Nach Beendigung der Schleife in 8 wird in 19 die Anzahl der Gruppen aus der 
Datenbasis geholt.

In 20 wird eine Schleife über die Anzahl der Gruppen gelegt. In einem
Schleifenschritt wird in 21 die Mitgliederliste der Gruppe geholt und
ihre Länge berechnet. Genauso wird in 22 und 23 die Länge der Liste der
Handlungstypen für die Gruppe GROUP berechnet. Für jeden Handlungstyp
wird in der Schleife in 24 und 25 eine gemeinsame Einstellung für die 
Gruppe GROUP generiert. Dazu wird in 24 aus der Liste LIST_OF_ACTION_TYPS
jeweils ein Handlungstyp geholt und in 25 in einem Schleifenschritt eine
gemeinsame Einstellung erzeugt. In 26 analysieren wir den Handlungstyp
und schreiben ihn wie folgt: ACTION_TYP = act_typ(TYP). In dieser Weise
können wir die Identifikationsnummer TYP des Handlungstyps act_typ(TYP)
in 27 benutzen. In 27 sammeln wir mit "findall" alle Akteure Z auf, die
in den vorher generierten individuellen Einstellungen zu finden sind.
Dabei wird nur ein bestimmter Handlungstyp act_typ(TYP) benutzt. Wenn wir
26 weglassen würden und mit der Variablen ACTION_TYP arbeiten, findet
"findall" weitere Akteure, die Einstellungen relativ zu anderen
Handlungstypen haben. In 27 erhalten wir die Liste ACTOR_LIST. In 28 wird
aus der Anzahl LENGTH1 der Mitglieder der Gruppe GROUP eine Zahl P 
berechnet. Dazu wird 60 Prozent von LENGTH1 genommen und auf die nächste
ganze Zahl aufgerundet. Weiter wird die Länge LENGTH2 der Mitgliederliste
berechnet. In 29 und 32 wird je nach dieser Länge in 29 eine gemeinsame
Einstellung generiert oder in 32 nichts getan. Die Ungleichung 
LENGTH2 >= P in 29 besagt folgendes. Die Anzahl LENGTH2 der Akteure, die
die individuelle Einstellung für den Handlungstyp in der Gruppe haben, 
ist größer als die P Prozent der Mitglieder der Gruppe. Anders gesagt
wird eine gemeinsame Einstellung in einer Gruppe und relativ zu einem
Handlungstyp erzeugt, wenn genügend Mitglieder diese Einstellung schon als
Indidivuum haben. In 31 und 32 wird die gemeinsame Einstellung in die
Datenbasis aufgenommen und an die Resultatdatei res3233.pl geschickt.

Wenn wir die verschiedenen Resultatdateien öffnen, sehen wir die Fakten
in dieser Weise ordentlich aufgereiht. So können wir die individuellen
und gemeinsamen Einstellungen ohne Probleme in andere Programmteile 
einbauen. 
*/

number_of_ticks(2).                                                 /* 1 */
number_of_actors(7). 
number_of_groups(2).
number_of_action_typs(6).
intelligent(1,95). intelligent(2,70). 
election_constant(60).

start :- 
  (exists_file('res3231.pl'), delete_file('res3231.pl'); true),     /* 2 */
  (exists_file('res3232.pl'), delete_file('res3232.pl'); true),  
  (exists_file('res3233.pl'), delete_file('res3233.pl'); true), 
  number_of_ticks(NUMBER_OF_TICKS),                                 /* 3 */
  number_of_actors(NUMBER_OF_ACTORS),
  number_of_groups(NUMBER_OF_GROUPS), 
  number_of_action_typs(NUMBER_OF_ACTION_TYPS),
  AUX_NUMBER is NUMBER_OF_ACTORS - NUMBER_OF_GROUPS,                /* 4 */
  make_groups(NUMBER_OF_GROUPS,AUX_NUMBER,NUMBER_OF_ACTORS),        /* 5 */
  make_action_typs(NUMBER_OF_ACTION_TYPS,NUMBER_OF_GROUPS),         /* 6 */
  ( between(1,NUMBER_OF_TICKS,TICK), 
      simulate_one_tick(TICK,NUMBER_OF_ACTORS), fail
  ;   true ),                                                       /* 7 */
  retractall(intention(TTT,AAA,LLL)), retractall(aux_list(TTT,GGG,CCC)),
  retractall(joint_intention(TTT1,AAA1,LLL1)),!. 

simulate_one_tick(TICK,NUMBER_OF_ACTORS) :-                         /* 7 */
  ( between(1,NUMBER_OF_ACTORS,ACTOR),
      make_intentions_for_one_actor(ACTOR,TICK), fail 
  ;    true                                                         /* 8 */
  ),!,
  number_of_groups(NUMBER_OF_GROUPS),                              /* 19 */
  ( between(1,NUMBER_OF_GROUPS,GROUP),
      make_joint_intentions(GROUP,TICK),
      fail; true                                                   /* 20 */
  ),!.

make_intentions_for_one_actor(ACTOR,TICK) :-                        /* 8 */
  repeat, ( group(GROUP_NAME,LIST), member(ACTOR,LIST) ),           /* 9 */
  intelligent(GROUP_NAME,INTELLIGENT), X is random(100) + 1,       /* 10 */
     ( X =< INTELLIGENT, 
       action_typs_for(GROUP_NAME,LIST_OF_ACTION_TYPS),            /* 12 */
       length(LIST_OF_ACTION_TYPS,LENGTH),                         /* 13 */
       U is random(LENGTH) + 1,                                    /* 14 */
       nth1(U,LIST_OF_ACTION_TYPS,ACTION_TYP),                     /* 15 */
       asserta(intention(TICK,ACTOR,ACTION_TYP)),                  /* 16 */
       append('res3232.pl'), write(intention(TICK,ACTOR,ACTION_TYP)), 
       write('.'), nl, told                                        /* 17 */
     ;
       X > INTELLIGENT, true                                       /* 11 */
     ),!.

make_joint_intentions(GROUP,TICK) :-                               /* 20 */
  group(GROUP,LIST_OF_MEMBERS), length(LIST_OF_MEMBERS,LENGTH1),   /* 21 */
  action_typs_for(GROUP,LIST_OF_ACTION_TYPS),                      /* 22 */
  length(LIST_OF_ACTION_TYPS,LENGTH),                              /* 23 */
  ( between(1,LENGTH,N), nth1(N,LIST_OF_ACTION_TYPS,ACTION_TYP),   /* 24 */
     make_joint_intention_for(ACTION_TYP,LIST_OF_MEMBERS,LENGTH1,
     TICK,GROUP), fail; true                                       /* 25 */
  ),!.

make_joint_intention_for(ACTION_TYP,LIST_OF_MEMBERS,LENGTH1,TICK,
        GROUP) :-                                                  /* 25 */
  ACTION_TYP = act_typ(TYP),                                       /* 26 */
  findall(Z,( intention(TICK,Z,act_typ(TYP)), 
       member(Z,LIST_OF_MEMBERS) ),  ACTOR_LIST ),                 /* 27 */
  P is ceiling((60 / 100) * LENGTH1), length(ACTOR_LIST,LENGTH2),  /* 28 */
  ( LENGTH2 >= P,                                                  /* 29 */
    asserta(joint_intention(TICK,GROUP,ACTION_TYP)),               /* 30 */
    append('res3233.pl'), write(joint_intention(TICK,GROUP,ACTION_TYP)), 
    write('.'), nl, told                                           /* 31 */
  ;
    P > LENGTH2, true                                              /* 32 */
  ),!.

% make_groups -----------------------------------------

make_groups(NUMBER_OF_GROUPS,AUX_NUMBER,NUMBER_OF_ACTORS) :-        /* 5 */
  asserta(aux_count(0)),
  ( between(1,NUMBER_OF_GROUPS,GROUP_NAME), 
      make_one_group(GROUP_NAME,AUX_NUMBER,NUMBER_OF_GROUPS), fail; true ),
  aux_count(CCC), retract(aux_count(CCC)),!.

make_one_group(GROUP_NAME,AUX_NUMBER,NUMBER_OF_GROUPS) :- 
  asserta(group(GROUP_NAME,[])),
  ( GROUP_NAME < NUMBER_OF_GROUPS,  
    X is random(AUX_NUMBER) + 1
  ;
    GROUP_NAME = NUMBER_OF_GROUPS, aux_count(C),
    number_of_actors(NUMBER_OF_ACTORS),
    X is NUMBER_OF_ACTORS - C
  ), 
  ( between(1,X,Nth_MEMBER), add_member(Nth_MEMBER,GROUP_NAME), fail;
     true),!,
  group(GROUP_NAME,LISTnew),
  append('res3231.pl'), write(group(GROUP_NAME,LISTnew)), write('.'), 
  nl, told.                                                       /* 5.1 */

add_member(Nth_MEMBER,GROUP_NAME) :- 
  aux_count(C), ACTOR is C + 1,
  group(GROUP_NAME,LIST), append(LIST,[ACTOR],LISTnew),
  retract(group(GROUP_NAME,LIST)), asserta(group(GROUP_NAME,LISTnew)),
  retract(aux_count(C)), asserta(aux_count(ACTOR)),!.

% make_list_of_action_typs --------------------------------------

make_action_typs(NUMBER_OF_ACTION_TYPS,NUMBER_OF_GROUPS) :-         /* 6 */
  ( between(1,NUMBER_OF_GROUPS,GROUP), 
      make_action_typs_for_a_group(GROUP,NUMBER_OF_ACTION_TYPS), 
      fail; true
  ),!.

make_action_typs_for_a_group(GROUP,NUMBER_OF_ACTION_TYPS) :-
  Y is random(NUMBER_OF_ACTION_TYPS) + 1, 
  asserta(action_typs_for(GROUP,[])),
  ( between(1,Y,V), make_one_action_typ_for_a_group(V,GROUP,
     NUMBER_OF_ACTION_TYPS), fail; true ),!,
  action_typs_for(GROUP,LIST11), 
  sort(LIST11,LIST33), retract(action_typs_for(GROUP,LIST11)),
  asserta(action_typs_for(GROUP,LIST33)),
  append('res3231.pl'), write(action_typs_for(GROUP,LIST33)), 
  write('.'), nl, told.                                           /* 6.1 */

make_one_action_typ_for_a_group(V,GROUP,NUMBER_OF_ACTION_TYPS) :-
  U is random(NUMBER_OF_ACTION_TYPS) + 1,
  action_typs_for(GROUP,LIST22),
  append(LIST22,[act_typ(U)],LIST22new), 
  retract(action_typs_for(GROUP,LIST22)),
  asserta(action_typs_for(GROUP,LIST22new)),!. 














