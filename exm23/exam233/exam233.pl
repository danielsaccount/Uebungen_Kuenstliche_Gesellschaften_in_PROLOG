/* exam233.pl

Erzeugung von Fakten, die in einer Gauss'schen Glockenkurve verteilt sind. 

N ist ein hier nicht weiter benutzer Name f�r die Art der Fakten, die hier 
erzeugt werden. AS ist die Anzahl der Fakten, die erzeugt werden. Zum Beispiel
ist AS die Anzahl der Akteure und f�r jeden Akteur wird eine Auspr�gung erzeugt.

L und U sind untere ("low") und obere ("upper") Grenzen, an denen die 
Glockenkurve nicht weitergef�hrt wird. SI ist der statistisch Sigmawert
(Signifikantswert), welche bildlich die "Breite" der Glockenkurve angibt. 

In 1 wird der Mittelwert MU berechnet. In 2 wird eine Schleife �ber die
Objekte (z.B. �ber die Akteure) gelegt.

In 2 wird A auch als Schleifenschritt benutzt. In einem Schleifenschritt A
wird in 6 eine weitere, offene Schleife er�ffnet. In 7 wird mir random eine 
Zufallszahl aus dem Bereich zwischen 1 und 10 000 gezogen. In 8 - 13 wird
der Wert Y der Dichtefunktion berechnet, wie sie in der Statistikliteratur 
nachzulesen ist. Diese rein mathematischen Zeilen m�chten wir hier nicht genauer 
erl�utern.

In 14 wird eine Zufallszahl W1 zwischen 1 und 10 000 gezogen und in 15
wird W1 auf 1 normiert. Statt W1 wird nun mit Z weitergerechnet. 
In 16 wird gepr�ft, ob Z =< Y ist oder nicht. Wenn diese Ungleichung
zutrifft, wird in 9 die Zahl W anstelle der Zahl X4 als neue Variable eingef�hrt.
Zeile 8 funktioniert wird in diesem Programm nur, wenn die untere und obere 
Grenzen L und U ganze Zahlen sind. Im positiven Fall bei 16 wird in 17 weiter
gepr�ft, ob W zwischen den unteren und oberen Grenzen liegt. Wenn ja, wird die
Zahl W als Auspr�gung des Objekts A genommen und in 18 in die Datenbasis 
eingetragen.

Wenn die Ungleichung in 16 falsch ist, geht PROLOG zur�ck nach 6 und
beginnt einen n�chsten Schleifenschritt. Dies wird immer positiv zu einem
Ergebnis f�hren, es sei denn dass die Berechnung die Computerkapazit�t des 
Computers �berschreitet. In diesem Fall wird eine Fehlermeldung erscheinen.

Nach Zeile 1 k�nnen Sie wie in den vorherigen Beispielen den trace-Modus 
einf�gen:  trace,
*/

normal_distribution(N,AS,L,U,SI) :- 
   MU is L + (0.5 * (U-L)),                                     /* 1 */
   ( between(1,AS,A), determine_nd_value(N,MU,SI,L,U,A), fail   /* 2 */
     ;                                                          /* 3 */
     true                                                       /* 4 */                         
   ),!.                                                         /* 5 */

determine_nd_value(N,MU,SI,L,U,A) :-                            /* 2 */
   repeat,                                                      /* 6 */
   X is random(10001)+1,                                        /* 7 */
   X4 is (1/10000) * (((X-1) * U)+(10001-X) * L),               /* 8 */ 
   W is integer(X4),                                            /* 9 */
   PI is pi, X1 is 2*(PI * (SI * SI)),                         /* 10 */
   X2 is (1 / sqrt(X1)),                                       /* 11 */
   X3 is (-((W-MU)*(W-MU))) / (SI*SI),                         /* 12 */
   Y is X2 * exp(X3),                                          /* 13 */
   W1 is random(10001)+1,                                      /* 14 */
   Z is (W1-1)/10000,                                          /* 15 */
   Z =< Y,                                                     /* 16 */
   between(L,U,W),                                             /* 17 */
   asserta(nd_expr(N,A,W)), !.                                 /* 18 */
