/* exam353

F�r ein Pr�dikat "pred" werden in einem Zahlenbereich verschiedene Zahlen in eine 
Liste gesammelt, auf die das Pr�dikat in einem vollst�ndigen Programm zugreifen kann.

Der Fakt in 3 bedeutet folgendes. UPPER ist die obere Grenze des Zahlenbereichs.
Der Zahlenbereich ist im Beispiel also [1,...,40], 40 = UPPER. LOWER die untere 
Grenze f�r den Bereich: [LOWER,...,UPPER]. COARSE ("degree of coarseness") besagt,
wie grob die n�chste Zahl ausgew�hlt wird. D.h. in einem Schritt wird eine 
Zahl I in die Liste aufgenommen und im n�chsten Schritt wird die Zahl I + COARSE
genommen.

In 4 wird die Anzahl der Zahlen berechnet, die generiert werden sollen. 
Inhaltlich, wird einfach die L�nge des Zahlenintervalls in mehrere 
Unterintervalle geteilt. Die L�nge eines Unterintervalls ist gerade die Zahl
COARSE. In 5 wird eine Liste f�r Zahlen eingerichtet, in der am Anfang nur die
Zahl f�r die linke Grenze steht. In 6 wird eine Schleife �ber die Anzahl  
NUMBER_OF_ARGUMENTS gelegt. Im N-ten Schleifenschritt wird die n�chste Zahl
X berechnet. In 10 wird diese Zahl in die Liste aufgenommen und die Liste
in 11 angepasst.
*/

meta_preds(2,40,2).                                                       /* 1 */

start :- 
  make_meta_fakt(pred,LIST).                                              /* 2 */

make_meta_fakt(pred,LIST) :-                                              /* 2 */
  meta_preds(LOWER,UPPER,COARSE),                                         /* 3 */
  NUMBER_OF_ARGUMENTS is ceiling((UPPER - LOWER)/COARSE),                 /* 4 */
  asserta(aux_list(pred,[LOWER])),                                        /* 5 */
  ( between(1,NUMBER_OF_ARGUMENTS,N), make_and_add_para(N,LOWER,COARSE), 
    fail; true),                                                          /* 6 */
  aux_list(pred,LIST1), retract(aux_list(pred,LIST1)),                    /* 7 */
  write(aux_list(pred,LIST1)).

make_and_add_para(N,LOWER,COARSE) :-                                      /* 6 */
  aux_list(pred,LIST),                                                    /* 8 */
  X is LOWER + (N * COARSE),                                              /* 9 */
  append(LIST,[X],LISTnew),                                              /* 10 */
  retract(aux_list(pred,LIST)), asserta(aux_list(pred,LISTnew)),!.       /* 11 */