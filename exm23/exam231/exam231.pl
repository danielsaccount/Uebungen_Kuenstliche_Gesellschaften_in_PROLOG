/* exam231.pl

Mit einem Programmmodul werden verteilte Häufigkeiten ("discrete 
frequencies") einer Funktion erzeugt.

In 1 - 3 müssen drei Fakten bereit liegen: erstens die Anzahl der Funktionswerte
"number_of_values", die erzeugt werden sollen, der Name der Funktion "function_name"  
und die zugehörige Wahrscheinlichkeitsverteilung [20,50,65,100] - eine
Liste von kumulierten Ausprägungstypen.

In 3 holt PROLOG die Anzahl NUMBER von 1 und in 4 der Funktionsname 
FUNCTION_NAME und die Liste der Ausprägungen LIST_OF_EXPRS von 2. In 5
wird die Resultatdatei "res231.pl" leergeräumt. In 6 wird die zentrale
Erzeugungsschleife aufgerufen.

In 9 und 11 wird ein Schleifenschritt aus dieser Schleife bearbeitet.
In 12 wird die Länge LENGTH der Liste von Ausprägungen bestimmt, hier
LENGTH = 4. 

In 13 wird aus dem Bereich 1 - 80 eine Zufallszahl RANDOM gezogen. In 14
wird diese Zahl prozentiell normiert. Die resultierende Zahl FUNCTION_VALUE
liegt zwischen 1 und 100. Da in 14 dividiert wird, ist die Zahl 
FUNCTION_VALUE normalerweise keine natürliche Zahl.

In 15 wird eine offene Schleife angelegt, die über die Länge LENGTH der 
Liste der Ausprägungen geht (hier LENGTH = 4). Die Indexvariable in "between"
besagt, dass in einem Schritt die X-te Stelle der Liste bearbeitet wird: 
X_TH_POSITION_OF_LIST. In 16 wird also die X-te Stelle (X_TH_POSITION_OF_LIST)
der Liste LIST_OF_EXPRS berechnet und die X-te Komponente X_TH_COMPONENT aus 
der Liste ausgegeben. In 17 wird die in 14 berechnete Zahl FUNCTION_VALUE mit
der X-ten Komponente der Liste (X_TH_COMPONENT) der Ausprägungen verglichen.

Z.B. könnte FUNCTION_VALUE die Zahl 56.25 und X_TH_COMPONENT die Zahl 65 sein. 
In diesem Fall wäre 17 erfüllt: 56.25 =< 65. In diesem Fall nimmt PROLOG in 18 
die Komponente, die an der X-ten Stelle X_TH_POSITION_OF_LIST der Liste der 
Ausprägungen LIST_OF_EXPRS steht, z.B. in nth1(3,[20,50,65,100],65) die Komponente 65. 
In 19 und 20 wird dann der Funktionswert FUNCTION_VALUE an die Rasultatdatei
geschickt.

Wenn in 17 die Ungleichung nicht stimmt, geht PROLOG zu 15 zurück und dann
wieder nach unten. PROLOG nimmt in 16 die nächste X_TH_POSITION_OF_LIST.
Diese Variable wurde mit "between" um Eins erhöht. Wenn in 17 nun die
Ungleichung stimmt, wird 11 richtig. Ansonsten geht PROLOG wieder nach 15.
PROLOG wiederholt die offene SChleife in 15 so lange bis die Ungleichung in 
17 erfüllt wird. Dies wird aus theoretischen Gründen immer positiv ausgehen.

Wenn Sie das Programm im trace-Modus anschauen möchten, entfernen Sie in 2a das
Symbol % .

*/


number_of_values(80).                                            /* 1 */
cumulative_frequencies_of(function_name,[20,50,65,100]).         /* 2 */

start :- 
%  trace,                                                        /* 2a */
  number_of_values(NUMBER),                                      /* 3 */
  cumulative_frequencies_of(FUNCTION_NAME,LIST_OF_EXPRS),        /* 4 */
  (exists_file('res231.pl'), delete_file('res231.pl'); true),    /* 5 */
  make_function_dd(FUNCTION_NAME,LIST_OF_EXPRS,NUMBER).          /* 6 */

make_function_dd(FU_NAME,LIST_OF_EXPRS,NUMBER) :-                /* 7 */
  ( between(1,NUMBER,N),                                         /* 8 */
    generate_one_dd_number(N,FU_NAME,LIST_OF_EXPRS,NUMBER), fail /* 9 */
  ;
    true                                                         /* 10 */
  ). 

generate_one_dd_number(N,FU_NAME,LIST_OF_EXPRS,NUMBER) :-        /* 11 */ 
  length(LIST_OF_EXPRS,LENGTH),                                  /* 12 */
  RANDOM is random(NUMBER) + 1,                                  /* 13 */
  FUNCTION_VALUE is (RANDOM/NUMBER) * 100,                       /* 14 */
  between(1,LENGTH,X_TH_POSITION_OF_LIST),                       /* 15 */
  nth1(X_TH_POSITION_OF_LIST,LIST_OF_EXPRS,X_TH_COMPONENT),      /* 16 */
  FUNCTION_VALUE =< X_TH_COMPONENT,                              /* 17 */
  nth1(X_TH_POSITION_OF_LIST,LIST_OF_EXPRS,EXPR),                /* 18 */ 
  append('res231.pl'),                                           /* 19 */
  write(fact(FU_NAME,N,FUNCTION_VALUE)), write('.'), nl, told,!. /* 20 */
                           
