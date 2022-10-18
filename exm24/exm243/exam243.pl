/* exam243

In einem zweidimensionalen Zellraster werdenn die Orte "positions" der
Akteure erzeugt.

Dazu werden zwei Fakten benutzt: die Anzahl (hier: 5) der Akteure in 1 und 
die Anzahl der Zellen, die in 2 durch die Zahl GG * GG definiert wird. 
D.h. spacelength(6) in 2 besagt, dass das Zellraster in jeder der beiden 
Richtungen 6 Zelle "hoch" und "breit" ist.
 
In 3 wird die Resultatdatei res243.pl geleert und in 4 und 5 werden die Orte
für die Akteure generiert. Dazu wird in 6 die Anzahl der Akteure geholt:
number_of_actors(AA), AA = 5 und die spacelength(GG), GG = 6. In 8 wird
eine Liste von freien Zellen LIST_OF_FREE_CELLS erzeugt. Dies geschieht 
in 22. Dazu wird in 23 eine Hilfszellenliste "aux_celllist" eingerichtet.

In 24 wird eine erste Schleife über die Reihen ("row") von Zellen gelegt,
deren Anzahl GG inzwischen durch 6 belegt ist. D.h. In 24 werden 6 Reihen
von Zellen erzeugt. In 27 wird mit "make_row" eine solche Reihe generiert.
Dazu wird in 28 eine zweite Schleife über die spacelength(6) gelegt, so
dass in 29 mit make_cell(V,U) eine Zelle erzeugt wird, die gerade die 
Koordinate [V,U] hat. D.h. die Schleifenindizes U in 25 und V in 28 werden
direkt als Koordinaten einer Zelle benutzt.
 
In 30 wird die Hilfszellliste LIST aufgerufen. Wir fügen in 31 die neue 
Koordinate [V,U] an diese Liste LIST hinzu. In 32 und 33 wird diese Liste
dann zu LISTnew upgedated.

In 25 wird diese vollständige Liste aux_celllist(LIST_OF_FREE_CELLS) geholt.
In der Klause 22 wird die Variable LIST_OF_FREE_CELLS an dieser Stelle nun
ersetzt durch die entstandene Liste, die wir hier im trace-Modus herausge-
schrieben haben:

aux_celllist([[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[1,2],[2,2],[3,2],[4,2],
[5,2],[6,2],[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],[1,4],[2,4],[3,4],[4,4],
[5,4],[6,4],[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],[1,6],[2,6],[3,6],[4,6],
[5,6],[6,6]]). 
D.h.
LIST_OF_FREE_CELLS = [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[1,2],[2,2],
[3,2],[4,2],[5,2],[6,2],[1,3],[2,3],[3,3],[4,3],[5,3],[6,3],[1,4],[2,4],
[3,4],[4,4],[5,4],[6,4],[1,5],[2,5],[3,5],[4,5],[5,5],[6,5],[1,6],[2,6],
[3,6],[4,6],[5,6],[6,6]].

Wir haben den "append" Befehl und die zugehörige Zeile nach 25 nur als 
Kommentar hingeschrieben. Wenn wir den einfachen "write" Befehl an dieser 
Stelle benutzen, sehen wir im trace-Modus nicht die vollständige Liste, 
sondern nur die ersten Komponenten der Liste. PROLOG kürzt solche größeren 
Listen automatisch ab, PROLOG gibt einfach einige Pünktchen aus. Wenn wir 
aber die Resultatdatei res243.pl öffnen, sehen wir die vollständige Liste.

Nach diesen Vorbereitungen in 8 geht PROLOG zu 9 und schreibt die nun 
mit Inhalt gefüllt Liste LIST_OF_FREE_CELLS in die Datenbasis. In 10
findet PROLOG eine Schleife über die Anzahl AA der Akteure, in der
für jeden Akteure einen Ort generiert wird. In 14 wird die gerade
aufgeschriebene Hilfsliste  aux_list_of_free_cells(LIST_OF_FREE_CELLS)
geholt. In 15 wird die Länge dieser Liste berechnet. Am Anfang ist
diese Zahl NUMBER einfach 36 ( NUMBER = 6 * 6).  In 16 wird eine 
Zufallszahl X aus dem Bereich von 1 bis NUMBER gezogen. In 17 wird die
X-te Komponente der Liste LIST_OF_FREE_CELLS berechnet: eine Zelle CELL.
In 18 wird diese Zelle aus der Liste entfernt. Die Liste wird in 19 und 20
abgedatet und an 21 in die Resultatdatei res243.pl geschickt.
*/

number_of_actors(5).                                        /* 1 */
spacelength(6).                                             /* 2 */

start :- 
%  trace,
  ( exists_file('res243.pl'), delete_file('res243.pl') ; 
         true ),                                            /* 3 */
   make_positions.                                          /* 4 */

make_positions :-                                           /* 5 */
  number_of_actors(AA),                                     /* 6 */
  spacelength(GG),                                          /* 7 */
  make_list_of_cells(GG,LIST_OF_FREE_CELLS),!,              /* 8 */
  asserta(aux_list_of_free_cells(LIST_OF_FREE_CELLS)),      /* 9 */ 
  ( between(1,AA,A), make_a_position(A), fail ; true ),!,   /* 10 */
  aux_list_of_free_cells(AUXLC),                            /* 11 */
  retract(aux_list_of_free_cells(AUXLC)).                   /* 12 */

make_a_position(A) :-                                       /* 13 */
  aux_list_of_free_cells(LIST_OF_FREE_CELLS),               /* 14 */ 
  length(LIST_OF_FREE_CELLS,NUMBER),                        /* 15 */
  X is random(NUMBER) + 1,                                  /* 16 */
  nth1(X,LIST_OF_FREE_CELLS,CELL),                          /* 17 */
  delete(LIST_OF_FREE_CELLS,CELL,LIST_OF_FREE_CELLSnew),     /* 18 */
  retract(aux_list_of_free_cells(LIST_OF_FREE_CELLS)),      /* 19 */
  asserta(aux_list_of_free_cells(LIST_OF_FREE_CELLSnew)),   /* 20 */
  append('res243.pl'), write(position(1,A,CELL)), 
      write('.'), nl, told,!.                               /* 21 */

make_list_of_cells(GG,LIST_OF_FREE_CELLS) :-                /* 22 */
  asserta(aux_celllist([])),                                /* 23 */
  ( between(1,GG,U), make_row(U,GG), fail; true),!,         /* 24 */
  aux_celllist(LIST_OF_FREE_CELLS),                         /* 25 */
     /* append('res243.pl'), write(aux_celllist(LIST_OF_FREE_CELLS)),
        write('.'), nl, told, */ 
  retract(aux_celllist(LIST_OF_FREE_CELLS)),!.              /* 26 */

make_row(U,GG) :-                                           /* 27 */
  ( between(1,GG,V), make_cell(V,U), fail; true),!.         /* 28 */ 

make_cell(V,U) :-                                           /* 29 */
  aux_celllist(LIST),                                       /* 30 */
  append(LIST,[[V,U]],LISTnew),                             /* 31 */
  retract(aux_celllist(LIST)),                              /* 32 */
  asserta(aux_celllist(LISTnew)),!.                         /* 33 */
   
