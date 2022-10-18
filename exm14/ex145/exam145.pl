/* exam145

Ein Fakt soll in einem Ablauf ver�ndert werden und der ver�nderte,also "neue" Fakt soll 
extern gespeichert werden. 

Sie geben "start." ein. In 4 wird gepr�ft, ob die Resultatdatei res145.pl
existiert. Da sie existiert, wird sie gel�scht.
In 5 wird die "mag"-Beziehung geholt und durch "write" sichtbar gemacht.
In 6 wird dann dieser Term aus der Datenbasis gel�scht.
In 7 wird die Datei data145.pl geholt und ge�ffnet. Dies l�sst sich hier sowohl
mit als auch ohne Anf�hrungszeichen formulieren, also: "consult(data145)" oder  
"consult('data145.pl')". Wegen Internetregularien, empfehlen wir Ihnen die zweite
Variante, also mit Anf�hrungszeichen (auch wenn dies f�r Sie mehr Arbeit bedeutet).
 
Sie sehen nun mehrere Zeilen, die wir hier nicht er�rtern. PROLOG �berpr�ft,
ob es - im allgemeinen gesprochen - Terme aus data145 in das Hauptprogramm
laden kann. PROLOG sieht, das das Pr�dikat "mag/2" dynamisch behandelt werden
kann. Sie sehen, dass die Datei data145.pl einladen wurde:
% data145.pl compiled 0.02 sec, 3 clauses

Wenn Sie im trace-Modus Zeilen weiter oben, die nicht mehr zu sehen sind,
wieder anschauen wollen, k�nnen Sie den rechten Balkenschieber benutzen. Der
Text verschiebt sich noch oben oder nach unten. 

In 8 sucht PROLOG nach einer "mag"-Beziehung. V und W sind frei Variable.
Es gibt in der Datenbasis genau eine solche "mag"-Beziehung. Sie stammt aus der 
Datei data145.pl: mag(peter,uta).
Sie �ffnen die Datei data145.pl, um zu sehen was dort steht.

In 9 tr�gt PROLOG nun eine neue "mag"-Beziehung mit "asserta" ein. Im trace-Modus
sehen Sie, dass die Variable W mit "uta" belegt ist (siehe 8 und siehe data145.pl)
und dass X in 5 und damit in 3 mit "peter" belegt ist. PROLOG gibt also aus:
 Exit: (7) asserta(mag(peter, uta)) 

In 9 wird dieser gerade neu entstandenen Fakt in die Datenbasis geladen:
asserta(mag(peter, uta)).  

Schlie�lich wird in 10 dieser Fakt auch an die Resultatdatei res145.pl geschickt.

Auch diese Datei res145.pl sollten Sie �ffnen, um das gerade Gesagte zu verifizieren.
*/

 :- multifile mag/2.                                          /* 1 */
 :- dynamic mag/2.                                            /* 2 */

mag(peter,hans).                                              /* 3 */

start :- 
  trace,
  (exists_file('res145.pl'), delete_file('res145.pl'); true), /* 4 */  
  mag(X,Y), write(mag(X,Y)),                                  /* 5 */
  retract(mag(X,Y)),                                          /* 6 */
  consult('data145.pl'),                                      /* 7 */
  mag(V,W),                                                   /* 8 */
  asserta(mag(X,W)),                                          /* 9 */  
  append('res145.pl'), write(mag(X,W)), write('.'), nl, told. /* 10 */

 