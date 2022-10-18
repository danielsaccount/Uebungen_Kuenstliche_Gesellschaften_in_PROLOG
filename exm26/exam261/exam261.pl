/* exam261 

Namen bekommen ID-Nummern zugeordnet.

Wir haben die Listen von Zahlen und Namen als Fakten eingetragen.
In einem vollständigen Programm ist der erste Fakt in 1 in dieser Form 
nicht nötig. Eine Konstante wäre ausreichend; sie legt die maximale Anzahl
möglicher ID-Nummern fest.

In 3 stellen wir einen weiteren, möglichen Fakt bereit. Wenn wir 2 durch
3 austauschen, kommt die Klause sofort in 6 und 14 zum Ende.  

In 4 und 5 werden die beiden Listen geholt und ihre Längen bestimmt.
In 6 und 14 werden die beiden Möglichkeiten beschrieben. Wenn es in 14 mehr
Namen als ID-Nummern gibt, ist es nicht möglich jedem Akteur (jedem Namen)
eindeutig eine ID-Nummer zuzuordnen. In diesem Fall scheitert die Zuordnung.
PROLOG gibt einen entsprechenden Fehler aus.

Im positiven Fall kann in 6 jedem Namen eine ID-Nummer zugeordnet werden.
In 7 und 8 werden zwei Hilfslisten eingerichtet, die am Ende in 11 und
12 wieder gelöscht werden. Die erste Hilfsliste enthält am Anfang die 
Liste ID_LIST alle ID-Nummern. Die zweite Hilfsliste enthält Paare bestehend aus 
einem Namen und eine zugehörigen ID-Nummer. Diese Liste "aux_list_of_pairs" ist 
am Anfang leer.    

In 9 wird eine Schleife eröffnet, die über die Zahl der Namen (LENGTH_NL)
läuft. In dieser Schleife wird die Namensliste abgebaut und die Paar-Liste
aufgebaut. In einem Schleifenschritt I wird in 16 die Namensliste und die
Paar-Liste aus der Datenbasis geholt. In 17 wird die Hilfsliste
ID_LIST durch den PROLOG Befehl [ | ] in die erste Komponente der Liste
(der HEAD) und den Rest in den TAIL der Liste gelegt: ID_LIST = [HEAD | TAIL]. 
In 18 wird die Hilfsliste "aux_list" angepasst; die Liste ID_LIST wird
durch die Restliste TAIL ersetzt. In 19 wird die I-te Komponente, ein Name NAME,
aus der Namensliste herausgepickt. In 20 wird das neue Paar [NAME,HEAD] an die 
Paar-Liste angeklebt. In 21 und 22 wird die Paar-Liste angepasst. 
*/

id_list([2,5,6,1,77]).                                          /* 1 */
namelist([peter, uta, udo, karl]).                              /* 2 */
% namelist([peter, uta, udo, karl, renate, uschi]).             /* 3 */

start :- 
%  trace, 
  id_list(ID_LIST), length(ID_LIST,LENGTH_ID),                  /* 4 */
  namelist(NAMELIST), length(NAMELIST,LENGTH_NL),               /* 5 */
  ( LENGTH_NL =< LENGTH_ID,                                     /* 6 */
    asserta(aux_list(ID_LIST)),                                 /* 7 */
    asserta(aux_list_of_pairs([])),                             /* 8 */
    ( between(1,LENGTH_NL,I), indexing(I,LENGTH_NL,NAMELIST), 
      fail; true),                                              /* 9 */
    aux_list_of_pairs(LIST_OF_PAIRS),                           /* 10 */
    retract(aux_list_of_pairs(LIST_OF_PAIRS)),                  /* 11 */
    retract(aux_list(LLL)),                                     /* 12 */
    write(indexed_list(LIST_OF_PAIRS))                          /* 13 */
  ;
    LENGTH_ID < LENGTH_NL,                                      /* 14 */
    write(failed)                                               /* 15 */
  ).

indexing(I,LENGTH_NL,NAMELIST) :- 
   aux_list(ID_LIST), aux_list_of_pairs(LIST_OF_PAIRS),         /* 16 */
   ID_LIST = [HEAD | TAIL],                                     /* 17 */
   retract(aux_list(ID_LIST)), asserta(aux_list(TAIL)),         /* 18 */
   nth1(I,NAMELIST,NAME),                                       /* 19 */
   append(LIST_OF_PAIRS,[[NAME,HEAD]],LIST_OF_PAIRSnew),        /* 20 */
   retract(aux_list_of_pairs(LIST_OF_PAIRS)),                   /* 21 */
   asserta(aux_list_of_pairs(LIST_OF_PAIRSnew)),!.              /* 22 */







