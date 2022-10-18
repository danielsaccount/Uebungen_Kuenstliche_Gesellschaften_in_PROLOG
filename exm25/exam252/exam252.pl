/* exam252

Erzeugung einer Liste von Akteurslisten (Gruppen).

Der einzige hier in 1 benutzte Fakt 

  distribution_of_actors_in_groups(5,[3,3,6,7,18]) 
 
enthält die Anleitung zur Erzeugung von 5 Listen. Die 1-te Komponente von
[3,3,6,7,18] ist 3, die 2-te Komponente 3, die 3-te Komponente 6 etc.
Jede X-te Komponente (1 =< X =< 5)  gibt die Anzahl von Akteuren an, die sich
in der X-ten Gruppe befinden. Dabei repräsentieren wir die 
Akteure durch natürliche Zahlen. Innerhalb einer Gruppe werden dabei die 
"Akteursnamen" (also hier: Zahlen) zufällig generiert und zwar so,
dass die Gruppen disjunkt sind. Jeder Akteur gehört also genau zu einer
einzigen Gruppe. 

In 2 wird die Resultatdatei res252.pl geleert. In 3 wird eine Liste von
Listen erzeugt. Am Ende wird diese Liste von Listen, LIST_OF_GROUPS, z.B.
so aussehen: 

list_of_lists([[18, 37, 2], [33, 22, 26], [28, 36, 27, 30, 14, 32], [25, 4, 
16, 19, 35, 5, 12], [1, 29, 17, 15, 6, 31, 9, 34, 8, 23, 7, 3, 20, 21, 10, 
24, 13, 11]]).

Diese Liste haben wir hier einfach aus einem früheren Ablauf des Programms
aus der Resultatdatei herüberkopiert. Sie sehen, dass die erste Gruppe 3 
Akteure, die zweiten Gruppe 3 Akteure, die dritte Gruppe 6 Akteure enthält, und 
so weiter. Wenn Sie etwas genauer hinschauen, "sehen" Sie auch, dass kein Akteur 
in zwei Gruppen auftritt.

In 6 werden zwei Hilfslisten eingerichtet: eine Hilfsliste von Akteuren
und eine Hilfsliste von Listen. Diese Listen werden im Ablauf immer größer.
In 7 wird der Fakt von 1 geholt: NUMBER_OF_GROUPS = 5, DISTRIB = [3,3,6,7,18].
In 8 wird die Summe der Zahlen aus der Liste [3,3,6,7,18] addiert. Als
Resultat wird diese Summe durch TOTAL_NUMBER_OF_ACTORS ausgegeben, im
Beispiel 37.

In 9 wird eine Schleife über die Anzahl der Gruppen, NUMBER_OF_GROUPS, gelegt.
Die Zahl GROUP_INDEX sagt aus, dass die Gruppe der Nummmer GROUP_INDEX gerade 
erzeugt wird. In einem Schleifenschritt wird in 12 jeweils eine Gruppe generiert. 
In 13 wird die Hilfsliste von Akteuren geöffnet und eine weitere Hilfsliste 
"aux_list" für eine Liste eingerichtet, die intern für diese Gruppe benutzt
wird. In 14 wird für die Gruppe Nr. GROUP_INDEX eine Liste generiert, die eine
Subliste aus der Liste alle Akteure ist. In 21 wird die Komponente aus der Liste
DISTRIB ( = [3,3,6,7,18]) berechnet, die an der Stelle steht, die durch den
Gruppenindex angegeben ist. Wenn z.B. der Schleifenschritt Nr. 3 und damit der 
Gruppenindex 3 bearbeitet wird, steht an der 3-ten Stelle von [3,3,6,7,18] die 
Zahl 6, d.h. die Anzahl der Akteure, die für die Gruppe Nr. GROUP_INDEX 
festgelegt ist. In 22 wird über diese Anzahl eine Schleife gelegt: X = 1,...,K 
( = 6 ). In jeden Schritt Nr. X wird in dieser Schleife in 23 die Hilfsliste von 
Akteuren geholt und in 24 beginnt eine offene Schleife. In 25 wird eine 
Zufallszahl A zwischen 1 und der Gesamtanzahl von Akteuren, TOTAL_NUMBER_OF_ACTORS, gezogen. 
In 26 wird geprüft, ob diese Zahl A für einen potentiellen,
neuen Akteur in der Hilfsliste von Akteuren schon vorkommt. Wenn ja, 
geht PROLOG wieder zu 25 zurück. Aus der Gesamtkonstruktion des Programms 
geht hervor, dass am Ende immer eine Zufallszahl gezogen wird, die noch nicht
in der Liste ACTORLIST steht. Die drei Zeilen 24 - 26 lassen sich leicht umbauen,
so dass das Programm nicht so viel arbeiten muss. Im trace-Modus sehen Sie,
dass in diesen drei Zeilen immer dasselbe passiert.

Wenn in 26 A "neu" ist, wird dieser neue Akteur A in 27 zu der Liste LIST
( aux_list(LIST) ) hinzugefügt und in 28 upgedatet. In 29 wird A auch in
die Hilfsliste von Akteuren, ACTORLIST ( aux_actorlist(ACTORLIST) ), siehe 24,
geschrieben und in 30 - 31 upgedatet.

Nach Beendigung der Schleife in 22 geht PROLOG nach 14 zurück und holt in 15
die Liste der Gruppen, LIST_OF_LISTS und die Hilfsliste AUX_LIST aus der 
Datenbasis. In 17 wird die Hilfsliste an die LIST_OF_LISTS angeklebt. In
18 - 19 wird die Liste der Gruppen upgedatet.

PROLOG geht über 12 zurück zu 9. Wenn in 9 alle Gruppen generiert sind und diese
Gruppen zur Liste von Gruppen hinzugefügt wurde, holt PROLOG in 10 die Hilfsliste von
Akteuren und löscht sie. Genauso holt PROLOG in 11 die Liste der Gruppen
und löscht sie. Dabei wird diese LIST_OF_GROUPS in 5 eingetragen. 

Schließlich wandert PROLOG zurück zu 3 und schickt das Resultat in 4 an 
die Resultatdatei res252.pl. 

Wir öffnen diese Resultatdatei und sehen genau diese Liste von Listen.
*/

distribution_of_actors_in_groups(5,[3,3,6,7,18]).                        /* 1 */

%----------------------------------------

start :- 
%  trace ,
  (exists_file('res252.pl'), delete_file('res252.pl'); true),             /* 2 */
  make_list_of_lists(LIST_OF_GROUPS),                                     /* 3 */
  append('res252.pl'), write(list_of_lists(LIST_OF_GROUPS)), write('.'),  /* 4 */
  nl, told.

make_list_of_lists(LIST_OF_GROUPS) :-                                     /* 5 */
  asserta(aux_actorlist([])), asserta(list_of_lists([])),                 /* 6 */
  distribution_of_actors_in_groups(NUMBER_OF_GROUPS,DISTRIB),             /* 7 */
  sum(NUMBER_OF_GROUPS,DISTRIB,TOTAL_NUMBER_OF_ACTORS),                   /* 8 */
  ( between(1,NUMBER_OF_GROUPS,GROUP_INDEX), 
         make_list_for_one_group(GROUP_INDEX,DISTRIB,TOTAL_NUMBER_OF_ACTORS),
         fail; true),!,                                                   /* 9 */
  aux_actorlist(AACTORLIST),  retract(aux_actorlist(AACTORLIST)),         /* 10 */
  list_of_lists(LIST_OF_GROUPS), retract(list_of_lists(LIST_OF_GOUPS)).   /* 11 */

make_list_for_one_group(GROUP_INDEX,DISTRIB,TOTAL_NUMBER_OF_ACTORS) :-    /* 12 */
  aux_actorlist(ACTORLIST), asserta(aux_list([])),                        /* 13 */
  make_sublist(GROUP_INDEX,DISTRIB,TOTAL_NUMBER_OF_ACTORS),               /* 14 */
  list_of_lists(LIST_OF_LISTS), aux_list(AUX_LIST),                       /* 15 */
  append(LIST_OF_LISTS,[AUX_LIST],LIST_OF_LISTSnew),                      /* 17 */
  retract(list_of_lists(LIST_OF_LISTS)),                                  /* 18 */
  asserta(list_of_lists(LIST_OF_LISTSnew)),!.                             /* 19 */

make_sublist(GROUP_INDEX,DISTRIB,TOTAL_NUMBER_OF_ACTORS) :-               /* 20 */
  nth1(GROUP_INDEX,DISTRIB,K),                                            /* 21 */
  ( between(1,K,X), add_one_actor(X,TOTAL_NUMBER_OF_ACTORS), fail; 
    true ),!.                                                             /* 22 */
 
add_one_actor(X,TOTAL_NUMBER_OF_ACTORS) :- 
  aux_actorlist(ACTORLIST),                                               /* 23 */
  repeat,                                                                 /* 24 */
  A is random(TOTAL_NUMBER_OF_ACTORS) + 1,                                /* 25 */ 
  \+ member(A,ACTORLIST),                                                 /* 26 */
  aux_list(LIST), append(LIST,[A],LISTnew),                               /* 27 */
  retract(aux_list(LIST)), asserta(aux_list(LISTnew)),                    /* 28 */
  append(ACTORLIST,[A],ACTORLISTnew),                                     /* 29 */
  retract(aux_actorlist(ACTORLIST)),                                      /* 30 */
  asserta(aux_actorlist(ACTORLISTnew)),!.                                 /* 31 */

% ------------------------------------------------------

sum(N,L,S) :- asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !.  

