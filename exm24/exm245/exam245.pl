/* exam245 

Hier wird eine Klause beschrieben, die wir als Variante des Modells von 
(Schelling, 1971) benutzt haben. In dieser Klause wird zu T für einen bestimmten
Akteur A eine bestimmte Zelle CELL in der Zellwelt untersucht ("investigate"). Das 
Resultat der Untersuchung ist eine Zahl FIT. Sie drückt aus, in
welchem Maße die Zelle CELL zur Umgebung von CELL aus der Sicht des Akteurs passt:
investigate(T,A,CELL,FIT).

Für diese Klause werden mehrere, bedingende Prädikate benutzt. Vorbereitend
wird in 1 unten das Zellraster, in 2 die Orte der Akteure, in 3 die 
Farben der Akteure und in 4 die Nachbarschaft einer Zelle erzeugt. Die Erzeugung 
von Nachbarschaften durch make_neighborhood(CELL,CELLS_IN_THE_SURROUNDING), die in
unserem Buch gebraucht wird, haben wir hier nicht beschrieben, sondern nur als 
Kommentar hingefügt. Da hier im Beispiel nur ein bestimmter Akteur und eine bestimmte 
Zelle CELL untersucht wird, haben wir hier nur die Umgebung der Zelle [2,3] 
aufgeschrieben: 

   CELLS_IN_THE_SURROUNDING = [[2,2],[2,4],[1,3],[3,3]].

In 5 - 9 sind die konstanten Fakten eingetragen. Die Anzahl von Akteuren ist in 
5 auf 12 und in 6 die Breite (und damit auch die Höhe) des Zellrasters auf 5 
festgesetzt. In 7 wird ein bestimmter Tick, hier: T = 2, ein bestimmter Akteur,
one_actor(3) und eine bestimmte Zelle, one_cell([2,3]) festlegt. Die 
Hauptklause legt nur die Untersuchung einer bestimmten Zelle für einen 
bestimmten Akteur zu einem bestimmten Tick fest. In 8 werden drei Farbausprägungen, 
"black,green,@21232", diskret, kumulativ, prozentual erzeugt.   
 
In 10 und 13 werden Fakten von 5 und 7 geholt. In 11 werden die Orte
erzeugt (siehe 2 unten und exam243). Dazu werden in 1 unten zunächst die
Zellen selber generiert (siehe exam243). In 12 werden die Farben für jede
der Zellen festgelegt. Wird geben auch den unbesetzten Zelle eine Farbe.

In 14 und 17 wird die Klause mit investigate(T,A,CELL,FIT) aktiviert.
In 18 findet PROLOG zwei Fälle. Im ersten Fall, in "case1" in 22, wird in 
23 die in 7 festgelegte Zelle CELL genommen und geschaut, ob es einen Akteur B 
gibt, der auf dieser Zelle lebt: position(T,B,CELL). Wenn die Zelle
besetzt ist, wird "case1" positiv beendet. PROLOG schreibt in 24
result(cell_used) in die Datenbasis. In diesem Fall wird "case2" nicht
benutzt und die Klause "investigate" wird beendet.  

Interessant wird es nur, wenn die Zelle CELL nicht besetzt ist. In
diesem Fall geht PROLOG in 18 zum "case2" über. In 25 und 26 findet PROLOG den
Term make_list_of_neighbors(T,A,CELL,NEIGHBORS), welcher in 4 unten 
bearbeitet werden muss. Für die Zelle CELL wird eine Liste von Nachbarn,
NEIGHBORS, für diese Zelle berechnet. Die Klause im 26 haben wir hier nicht
beschrieben. Wir haben in hier die Liste aller Umgebungszellen von [2,3] explizit 
aufgeschrieben: 

    CELLS_IN_THE_SURROUDING = [[2,2],[2,4],[1,3],[3,3]]. 

In unserem Buch ist in Figur 2.4.2.a eine Umgebung dieser Art dargestellt.
In einem vollständigen Programm müsste diese Umgebung jeweils berechnet 
werden. Der dazugehörige Term ist in Zeile 4.2 auskommentiert. In Zeile 4.3 wird eine
Liste neigh_list(CELL,[])) eingerichtet und in 4.4 die Länge der Umgebung
berechnet. In 4.5 wird eine Schleife über diese Umgebung, d.h. über ihre
Länge, gelegt. In 4.9 wird ein Schleifenschritt bearbeitet. Dazu wird in
4.10 die bis jetzt generierte Nachbarschaftsliste neigh_list(CELL,DYN_LIST)   
geholt und in 4.11 die Länge der Umgebungsliste CELLS_IN_THE_SURROUNDING
berechnet: LENGTH_SURROUND. In 4.12 sucht PROLOG in der Datenabasis nach
einem Ort für einen Akteur B, der auf der Zelle CELLdyn lebt: 
position(T,B,CELLdyn). Dabei liegt diese Zelle in der vorher berechneten 
Umgebung und A ist ungleich B. In 4.13 wird dieser Akteur in die Liste 
"neigh_list" der Nachbarn der Zelle CELL aufgenommen und diese Liste 
upgedatet. Wenn die Schleife in 4.5 beendet ist, holt PROLOG in 4.5 
die vollständige Liste NEIGHBORS, schickt sie in 4.7 zur Resultatdatei
res245.pl. Diese Liste ist in 4 nun auch an die Stelle der vorherigen Variablen
getreten und PROLOG kehrt zu 26 zurück. In 27 wird die Länge der Liste von
Nachbarn für CELL bestimmt und in 28, 36 und 38 findet PROLOG eine Oder-Konstruktion.
Im ersten Fall wird in 28 ein neuer Zähler für eine bestimmte Zelle CELL
eingerichtet: fitness(T,A,CELL,0). In 30 - 32 wird eine Schleife über die
Nachbarn gelegt, die in der Umgebung der Zelle CELL leben. Im Schleifenschritt
in 39 wird in 40 der Nachbar B der Liste von NEIGHBORS bestimmt. In 41 findet
PROLOG die Farben von B und von A als Fakten, die in 3 erzeugt wurden.
Wenn in 42 beide Akteure A und B dieselbe Farbe haben, COLOUR_A = COLOUR_B,
wird in 43 und 44 der Zähler in fitness(T,A,CELL,FITaux) um Eins erhöht: 
FITauxnew is FITaux + 1, und in 45 und 46 upgedatet.

PROLOG kehrt am Ende dieser Schleife wieder zu 31 zurück und holt in 33 aus
fitness(T,A,CELL,FITend) den Endzählerstand FITend. In 34 wird diese Zahl auf
die Länge LENGTH von Nachbarn von CELL normiert: FIT is FITend/LENGTH. Diese Zahl
drückt aus, wie FIT die Umgebung der Zelle CELL für A zu T ist. D.h. wie passend
die Umgebung der Zelle CELL für den Akteur A ist, der eventuell zu dieser Zelle hinziehen
möchte. Die Zahl FIT wird in 35 durch result(FIT) in die Datenbasis geschrieben.
In einem zweiten Fall ist in 37 die Liste der Nachbarn für CELL leer; auch
dies wird gespeichert: result(0).

Damit ist der zweite Fall, "case2", in 18 abgeschlossen. PROLOG holt in 19 den 
Fakt über die Fitness, FIT, schickt den entsprechenden Fakt in die Resultatdatei 
res245.pl und löscht schließlich diesen Fakt wieder aus der Datenbasis.

Wir erwähnen, dass der Term fitness(...), der in 39 neu generiert wurde, im
Term investigate(...) nicht gelöscht wird. Denn dieser Term wird im
vollständigen Programm noch gebraucht. 

Die Fitness hängt in diesem Beispiel sehr stark von der Häufigkeitsverteilung 
in 8 ab. Da es für die Zelle CELL nur vier mögliche Nachbarn gibt, sieht man 
schnell, wie sich die Wahrscheinlichkeit, dass ein Akteur aus dieser 
Umgebung dieselbe Farbe wie A hat, ändert. Wenn wir in 8 die Liste z.B. 
durch [40,80,100] oder durch [95,98,100] ersetzen, wird FIT in fit(T,A,CELL,FIT)
in der Resultatdatei anders aussehen.
*/

number_of_actors(12).                                         /* 5 */
spacelength(5).                                               /* 6 */
one_tick(2). one_actor(3). one_cell([2,3]).                   /* 7 */
cumulative_frequencies_for(colour,[5,60,100]).                /* 8 */
list_of_typs([black,green,@21232]).                           /* 9 */

start :-
  ( exists_file('res245.pl'), delete_file('res245.pl') ; true ),
%  trace,
  number_of_actors(AA),                                       /* 10 */
  make_positions,                                             /* 11 */
  make_colours,                                               /* 12 */
  one_tick(T), one_actor(A), one_cell(CELL),                  /* 13 */
  investigate(T,A,CELL,RESULT),                               /* 14 */
  retractall(position(AAA,BBB,CCC)),                          /* 15 */
  retractall(colour(XXX,DDD)).                                /* 16 */

investigate(T,A,CELL,RESULT) :-                               /* 17 */
%  trace,
 ( case1(T,A,CELL) ; case2(T,A,CELL) ),                       /* 18 */
 result(RESULT),                                              /* 19 */
 append('res245.pl'), write(result(RESULT)),
          write('.'), nl, told,                               /* 20 */
 retract(result(RESULT)).                                     /* 21 */

case1(T,A,CELL) :-                                            /* 22 */
  position(T,B,CELL),                                         /* 23 */
  RESULT = cell_used, asserta(result(RESULT)).                /* 24 */

case2(T,A,CELL) :-                                            /* 25 */
% trace,
  make_list_of_neighbors(T,A,CELL,NEIGHBORS),                 /* 26 */
  length(NEIGHBORS,LENGTH),                                   /* 27 */
  ( 0 < LENGTH,                                               /* 28 */
    asserta(fitness(T,A,CELL,0)),                             /* 29 */
    ( between(1,LENGTH,NEIGHBOR),                             /* 30 */
      look_at(T,A,NEIGHBORS,NEIGHBOR),                        /* 31 */
      fail; true ),                                           /* 32 */
    fitness(T,A,CELL,FITend),                                 /* 33 */
    FIT is FITend/LENGTH,                                     /* 34 */
    asserta(result(FIT))                                      /* 35 */
  ;                                                           /* 36 */
    0 = LENGTH, asserta(result(0))                            /* 37 */
  ),!.                                                        /* 38 */

look_at(T,A,NEIGHBORS,NEIGHBOR) :-                            /* 39 */
  nth1(NEIGHBOR,NEIGHBORS,B),                                 /* 40 */
  colour(B,COLOUR_B), colour(A,COLOUR_A),                     /* 41 */ 
  ( COLOUR_B = COLOUR_A,                                      /* 42 */
    fitness(T,A,CELL,FITaux),                                 /* 43 */
    FITauxnew is FITaux + 1,                                  /* 44 */
    retract(fitness(T,A,CELL,FITaux)),                        /* 45 */
    asserta(fitness(T,A,CELL,FITauxnew))                      /* 46 */ 
  ; true ),!.                                                 /* 47 */

% -------------------------------------

make_list_of_neighbors(T,A,CELL,NEIGHBORS) :-                 /* 4 */
  CELLS_IN_THE_SURROUNDING = [[2,2],[2,4],[1,3],[3,3]],       /* 4.1 */
/*  make_neighborhood(CELL,CELLS_IN_THE SURROUINDING),           4.2 */
/*  CELLS_IN_THE_SURROUNDING = [B1,...,BM], 1 */  
  asserta(neigh_list(CELL,[])),                               /* 4.3 */
  length(CELLS_IN_THE_SURROUNDING,LENGTH),                    /* 4.4 */
  ( between(1,LENGTH,NUMB), 
    is_B_a_neighbor_of(T,CELL,NUMB,CELLS_IN_THE_SURROUNDING), 
    fail; true),                                              /* 4.5 */
  neigh_list(CELL,NEIGHBORS),                                 /* 4.6 */
  append('res245.pl'), write(neighbor_list(T,A,CELL,NEIGHBORS)), 
     write('.'), nl, told,                                    /* 4.7 */
  retract(neigh_list(CELL,NEIGHBORS)).                        /* 4.8 */

is_B_a_neighbor_of(T,CELL,NUMB,CELLS_IN_THE_SURROUNDING) :-   /* 4.9 */
% trace,
  neigh_list(CELL,LIST1),                                     /* 4.10 */
  nth1(NUMB,CELLS_IN_THE_SURROUNDING,CELLdyn),                /* 4.11 */
  ( position(T,B,CELLdyn),                                    /* 4.12 */
    append(LIST1,[B],LIST1new),                               /* 4.13 */
    retract(neigh_list(CELL,LIST1)),                          /* 4.14 */
    asserta(neigh_list(CELL,LIST1new))                        /* 4.17 */
  ;                                                           /* 4.18 */
    true                                                      /* 4.19 */
  ),!.                                                        /* 4.20 */

% --------------------------------------

make_colours :-                                               /* 3 */
% trace,  
  cumulative_frequencies_for(colour,LIST),                    /* 3.1 */
  number_of_actors(AA),                                       /* 3.2 */
 ( between(1,AA,N), generate_one_dd_number(N,colour,LIST,AA), 
        fail ; true).                                         /* 3.3 */

generate_one_dd_number(N,colour,LIST,AA) :-                   /* 3.4 */
  length(LIST,LENGTH),                                        /* 3.5 */
  Z is random(AA) + 1,                                        /* 3.6 */
  between(1,LENGTH,X_TH_POSIT_OF_LIST),                       /* 3.7 */
  nth1(X_TH_POSIT_OF_LIST,LIST,PERCCUMUL),                    /* 3.8 */
  Z1 is (Z/AA) * 100,                                         /* 3.9 */
  Z1 =< PERCCUMUL ,                                           /* 3.10 */
  list_of_typs(TYP_LIST),                                     /* 3.11 */
  nth1(X_TH_POSIT_OF_LIST,TYP_LIST,COLOUR),                   /* 3.12 */
  append('res245.pl'), write(function(colour,N,COLOUR)), 
      write('.'), nl, told,                                   /* 3.13 */
  asserta(colour(N,COLOUR)),!.                                /* 3.14 */

% ----------------------------------------

make_positions :-                                             /* 2 */
  number_of_actors(AA), 
  spacelength(GG),
  make_list_of_cells(GG,LIST_FREE_CELLS),!,
  asserta(aux_list_of_free_cells(LIST_FREE_CELLS)),  
  ( between(1,AA,A), make_a_position(A), fail ; true ),!, 
  aux_list_of_free_cells(AUXLC),  
  retract(aux_list_of_free_cells(AUXLC)).

make_a_position(A) :- 
  aux_list_of_free_cells(LIST_FREE_CELLS), 
  length(LIST_FREE_CELLS,NUMBER),
  X is random(NUMBER) + 1, 
  nth1(X,LIST_FREE_CELLS,CELL),
  delete(LIST_FREE_CELLS,CELL,LIST_FREE_CELLSnew), 
  retract(aux_list_of_free_cells(LIST_FREE_CELLS)),
  asserta(aux_list_of_free_cells(LIST_FREE_CELLSnew)),
  asserta(position(T,A,CELL)),
  append('res245.pl'), write(position(1,A,CELL)), write('.'), nl, told,!. 

% ---------------------------------------

make_list_of_cells(GG,CELL_LISTS) :-                           /* 1 */                    
  asserta(aux_list_cells([])),
  ( between(1,GG,U), make_row(U,GG), fail; true),!,
  aux_list_cells(CELL_LISTS),
  retract(aux_list_cells(CELL_LISTS)),!.

make_row(U,GG) :-
  ( between(1,GG,V), make_cell(V,U), fail; true),!.  

make_cell(V,U) :-
  aux_list_cells(LIST),
  append(LIST,[[V,U]],LISTnew),
  retract(aux_list_cells(LIST)),
  asserta(aux_list_cells(LISTnew)),!.
   