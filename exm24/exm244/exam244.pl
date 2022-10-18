/* exam244.pl 

Wir erzeugen hier die Orte, "positions", der Akteure in einer 
eindimensonalen Zellwelt.

Die zwei Fakten sind dieselben wie in exam243.pl.
In 1 wird die Zellwelt durch eine Zeile erzeugt. CELL_LIST 
enthält genau die Zahlen von 1 bis AA, hier also von 1 bis 5. Jede Zelle
kann in der eindimensionalen Welt einfach durch eine Liste von Zahlen 
dargestellt werden. Der Zellname, die Zahl, ist zusätzlich auch noch
die Koordinate der Zelle.

In 2 wird nach der Generierung aller Zellen die Orte in derselben 
Weise wie in exam243 erzeugt.

In 3 haben wir den PROLOG Befehl "subtract" benutzt. Alle Komponenten aus
der zweiten Liste AUXLIST werden von der ersten Liste CELL_LIST entfernt.
Das Resultat ist die Liste FREECELLS. 
*/


number_of_actors(5).
number_of_cells(7).

start :- 
  ( exists_file('res244.pl'), delete_file('res244.pl') ; true ),
%  trace,
  make_positions.

make_positions :- 
  number_of_actors(AA), 
  number_of_cells(NU_OF_CELLS), 
  findall(CE,between(1,NU_OF_CELLS,CE), CELL_LIST),                 /* 1 */
  asserta(aux_list([])), 
  ( between(1,AA,A), make_a_position(A,CELL_LIST), fail             /* 2 */
         ; true  ),!, 
  aux_list(AUXLIST),  
  retract(aux_list(AUXLIST)). 

make_a_position(A,CELL_LIST) :- 
  aux_list(AUXLIST),
  subtract(CELL_LIST,AUXLIST,FREECELLS),                            /* 3 */
  length(FREECELLS,NUMBER),
  X is random(NUMBER) + 1, 
  nth1(X,FREECELLS,CELL),  
  append(AUXLIST,[CELL],AUXLISTnew), 
  retract(aux_list(AUXLIST)),
  asserta(aux_list(AUXLISTnew)), 
  append('res244.pl'), write(position(1,A,[CELL])), write('.'), nl, told,!. 



