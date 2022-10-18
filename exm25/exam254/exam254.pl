/* exam254

In einem Krisenmodell werden für einen bestimmten Akteur in einem Tick 
alle Feinde "bearbeitet". Dazu wird am Anfang für jeden Akteur eine Feindliste erzeugt. 

In 1 werden einige Fakten festgelegt: ein Tick 53, die Anzahl 5 der Akteure und ein 
bestimmter Akteur Nr. 3.

In 2 wird die Resultatdatei res254.pl geleert und in 3 werden die Fakten 
von 1 oben geholt. In 4 werden die Feindschaftensbeziehungen in Form
von Listen erzeugt. In 5 wird eine einfache Struktur programmiert, mit 
der "der" Akteur handelt.

In 25 wird dazu die Anzahl der Akteure geholt und in 26 wird für jeden
Akteur A ein Feind (oder mehrere Feinde) definiert. Dazu wird zunächst in
34 die Liste LIST1 aller Akteure erzeugt und in 35 wird der gerade aktive
Akteur aus dieser Liste gelöscht. In 36 wird die Restliste POT_ENEMIES 
in die Datenbasis eingetragen, in 37 wird die Länge dieser Liste
bestimmt und um Eins erhöht. In 38 wird eine Zufallszahl aus dem Bereich
von 1 bis LENGTH gezogen. Die Erhöhung der Länge in 37 ist dazu gedacht, um
auch die Zahl Null benutzen zu können. Wenn die Zufallszahl 0 ist, wird für A in 39 
gar kein Feind, und im anderen Fall in 41 mindestens ein Feind (X = 1) 
oder mehrere Feinde (1 < X) festgelegt. In diesem Fall wird in 42 eine
weitere Schleife bearbeitet, in der in jedem Schritt ein weiterer Feind
für A entsteht.
 
In einem Schleifenschritt in 43 wird in 44 die Liste der potentiellen
Feinde von A geholt. In 45 wird die Länge dieser Liste bestimmt und in
46 wird eine Zufallszahl im Bereich von 1 bis LENGTH1 gezogen. In 47 wird
der zu diesem Index W passende potentielle Feind aus der Liste POT_ENEMIES
geholt und in 48 aus dieser Liste entfernt. In 49 - 50 wird diese veränderte
Liste upgedatet. In 51 wird schließlich das "Feindpaar" [A,ENEMY] als Fakt in
die Datenbasis eingetragen und auch an die Resultatdatei res254.pl geschickt.
  
Damit sind in der Schleife in 26 alle Feindpaare erzeugt. In 27 wird in
einer weiteren Schleife für jeden Akteur eine "Feindliste" aus den 
"Feindpaaren" zusammengestellt. Dazu wird in 30 mit "findall" alle Feinde
aus den Fakten der Form enemy_pair(A,ENEMY) gesammelt und in eine Liste
ENEMY_LIST geschrieben. Diese Liste wird in 31 in die Datenbasis geschrieben
und an die Resultatdatei res254.pl geschickt. 

Nach diesen Vorbereitungen, die wir in vollständigen Programmen in einer
eigenen Daten, z.B. create, aufbewahren, wenden wir uns in 5 der Akteurschleife
zu. In 7 holt PROLOG in einem Schleifenschritt für den Akteur A die Liste 
ENEMY_LIST und bestimmt in 8 die Länge dieser Liste. In 9 wird eine
Hilfsliste auxlist(_) eingerichtet, in der die in der Generierungsphase
benutzten Feinde eingetragen werden. In 10 werden für A in einer Schleife zu 
einem gegebenen Tick mit dem Index N alle Feinde von A Schritt für Schritt traktiert. 
Dies geschieht in 12 in einem Schritt wie folgt.

In 13 wird die Hilfsliste auxlist(ENEMY_LIST1) und ihre Länge bestimmt.
In 14 wird eine Zufallszahl X im Bereich von 1 bis LE gezogen und in 15
nimmt PROLOG die X-te Komponente aus dieser Liste. In 16 wird dieses 
"Feindpaar" [A,ENEMY] aktiviert und in 20 - 23 kommt es dann zu einer
Auseinandersetzung beider Akteure, deren Form hier nicht weiter erörtert
wird. In 17 wird dieser nun "bearbeitete" Feind aus der Liste gelöscht und
diese Liste upgedatet.

Als Resultate sind die Feindpaare der Form enemy_pair(A,ENEMY) und die
Listen der Feindpaare in Form von list_of_enemies(A,[ENEMY1,ENEMY2]) zu 
sehen.
*/

tick(53). number_of_actors(5). actor(3).                           /* 1 */

start :- 
%  trace, 
  (exists_file('res254.pl'), delete_file('res254.pl'); true),      /* 2 */
  tick(T), number_of_actors(NUMBER_OF_ACTORS), actor(A),           /* 3 */
  make_enemies,                                                    /* 4 */
  handle_crisis(T,A).                                              /* 5 */

handle_crisis(T,A) :-                                              /* 6 */
  list_of_enemies(A,ENEMY_LIST),                                   /* 7 */  
  length(ENEMY_LIST,NUMBER_OF_ENEMIES),                            /* 8 */
  asserta(auxlist(ENEMY_LIST)),                                    /* 9 */
  ( between(1,NUMBER_OF_ENEMIES,N), choose_enemy(N,T,A), 
         fail ; true ),                                            /* 10 */
  retract(auxlist(ENLL)).                                          /* 11 */

choose_enemy(N,T,A) :-                                             /* 12 */
  auxlist(ENEMY_LIST1), length(ENEMY_LIST1,E),                     /* 13 */
  X is random(E) + 1,                                              /* 14 */
  nth1(X,ENEMY_LIST1,ENEMY),                                       /* 15 */
  activate_enemypair(T,A,ENEMY),                                   /* 16 */ 
  delete(ENEMY_LIST1,ENEMY,ENEMY_LIST1new),                        /* 17 */
  retract(auxlist(ENEMY_LIST1)),                                   /* 18 */
  asserta(auxlist(ENEMY_LIST1new)),!.                              /* 19 */

activate_enemypair(T,A,ENEMY) :-                                   /* 20 */    
  ENEMYPAIR = [A,ENEMY],                                           /* 21 */
  activate(T,A,ENEMY),!.                                           /* 22 */

activate(T,A,ENEMY) :- true.                                       /* 23 */


% ---------------------------------


make_enemies :-                                                    /* 24 */
  number_of_actors(NUMBER_OF_ACTORS),                              /* 25 */
  ( between(1,NUMBER_OF_ACTORS,A), make_enemy_pairs(A,NUMBER_OF_ACTORS), 
       fail; true),                                                /* 26 */
  ( between(1,NUMBER_OF_ACTORS,A), make_enemy_list(A), fail; true),/* 27 */
   retractall(enemy_pair(PP)).                                     /* 28 */
  
make_enemy_list(A) :-                                              /* 29 */
  findall(ENEMY,enemy_pair(A,ENEMY),ENEMY_LIST),                   /* 30 */
  asserta(list_of_enemies(A,ENEMY_LIST)),                          /* 31 */
  writein('res254.pl',list_of_enemies(A,ENEMY_LIST)),!.            /* 32 */

make_enemy_pairs(A,NUMBER_OF_ACTORS) :-                            /* 33 */
  findall(V,between(1,NUMBER_OF_ACTORS,V),LIST1),                  /* 34 */
  delete(LIST1,A,POT_ENEMIES),                                     /* 35 */
  asserta(potential_enemies(A,POT_ENEMIES)),                       /* 36 */
  length(POT_ENEMIES,LEN), LENGTH is LEN + 1,                      /* 37 */
  X is random(LENGTH),                                             /* 38 */
  ( X = 0, true                                                    /* 39 */
  ;                                                                /* 40 */
    0 < X,                                                         /* 41 */
    ( between(1,X,INDEX_FOR_ENEMY), add_one_enemy(INDEX_FOR_ENEMY,A),       
           fail; true)                                             /* 42 */
  ),!.

add_one_enemy(INDEX_FOR_ENEMY,A) :-                                /* 43 */
   potential_enemies(A,POT_ENEMIES),                               /* 44 */
   length(POT_ENEMIES,LENGTH1),                                    /* 45 */
   W is random(LENGTH1) + 1,                                       /* 46 */
   nth1(W,POT_ENEMIES,ENEMY),                                      /* 47 */
   delete(POT_ENEMIES,ENEMY,POT_ENEMIESnew),                       /* 48 */
   retract(potential_enemies(A,POT_ENEMIES)),                      /* 49 */
   asserta(potential_enemies(A,POT_ENEMIESnew)),                   /* 50 */
   asserta(enemy_pair(A,ENEMY)),                                   /* 51 */
   writein('res254.pl',enemy_pair(A,ENEMY)),!.                     /* 52 */

% -----------------------------------------

writein(X,Y) :- append(X), write(Y), write('.'), nl, told.

  


