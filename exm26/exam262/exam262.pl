/* exam262 

Erzeugung von sehr einfachen Genen. 

Ein Gen besteht aus einer Liste von Nullen 0 und Einsen 1: 

   GEN = [1,1,0,1,0,0,0,...]. 

Alle Gene haben hier dieselbe Länge.

Als Fakten haben wir die Länge "length_of_one_gene" eines generischen 
Gens und die Anzahl "number_of_genes" von Genen eingetragen. 

In 3 wird die Resultatdatei res262.pl geleert. In 4 und 5 werden die
beiden Fakten aus der Datenbasis geholt. In 6 wird eine leere Hilfsliste
"list_of_genes" eingerichtet. In der Schleife 7 wird diese Liste nun
gefüllt. In einem Schleifenschritt wird in 12 zuerst eine weitere, leere
Hilfsliste "one_gen" eingerichtet. In 13 wird die im Aufbau befindliche
Liste der Gene LIST_G aus der Datenbasis geholt. In 14 wird eine Schleife
bearbeitet, in der in einem Schleifenschritt eine weitere Genkomponente
erzeugt und an das Gen angeklebt wird. In 20 wird ein im Aufbau
befindliches Gen GEN aus der Datenbasis geholt. In 20 wird eine 
Münze geworfen: eine Zufallszahl X, die 0 oder 1 sein kann. X benutzen
wird direkt als neue Genkomponente. In 21 wird die Komponente dem
Gen GEN hinzugefügt und in 22 wird GEN angepasst. 

In 15 wird ein GEN aus der Datenbasis geholt, welches vorher vollständig 
erzeugt wurde. Die Hilfsliste "one_gen" wird gelöscht. GEN ist in der 
Klause aber noch vorhanden. In 16 wird GEN der Liste "list_of_genes"
der Gene hinzugefügt. In 18 und 19 wird die Genliste "list_of_genes"
angepasst.

In 8 holt PROLOG die vollständigt erzeugte Genliste aus der Datenbasis.
In 9 wird diese Liste an die Resultatdatei res262.pl geschickt. Schließlich
wird in 10 die Genliste aus der Datenbasis gelöscht.
*/

length_of_one_gen(4).                                           /* 1 */
number_of_genes(5).                                             /* 2 */

start :- 
%   trace,
   (exists_file('res262.pl'), delete_file('res262.pl'); true),  /* 3 */
   number_of_genes(NUMBER_OF_GENES),                            /* 4 */
   length_of_one_gen(LENGTH_GEN),                               /* 5 */
   asserta(list_of_genes([])),                                  /* 6 */
   ( between(1,NUMBER_OF_GENES,G), make_one_gen(G,LENGTH_GEN),
      fail; true),                                              /* 7 */
   list_of_genes(LIST_OF_GENES),                                /* 8 */
   append('res262.pl'), write(list_of_genes(LIST_OF_GENES)), 
   write('.'), nl, told,                                        /* 9 */
   retract(list_of_genes(LIST_OF_GENES)).                       /* 10 */

make_one_gen(G,LENGTH_GEN) :-                                   /* 11 */
  asserta(one_gen([])),                                         /* 12 */
  list_of_genes(LIST_G),                                        /* 13 */
  ( between(1,LENGTH_GEN,I), add_one_component(I), fail; true), /* 14 */
  one_gen(GEN),                                                 /* 15 */
  retract(one_gen(GEN)),                                        /* 16 */
  append(LIST_G,[GEN],LIST_Gnew),                               /* 17 */
  retract(list_of_genes(LIST_G)),                               /* 18 */
  asserta(list_of_genes(LIST_Gnew)),!.                          /* 19 */

add_one_component(I) :- 
  one_gen(GEN), X is random(2),                                 /* 20 */
  append(GEN,[X],GENnew),                                       /* 21 */
  retract(one_gen(GEN)), asserta(one_gen(GENnew)),!.            /* 22 */  
