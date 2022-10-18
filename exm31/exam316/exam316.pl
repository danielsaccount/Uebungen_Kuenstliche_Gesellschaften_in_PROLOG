/* exam316 

Ein Netz (net) mit Ästen (branches) und Linien (lines) wird erzeugt,
und die Entstehung des Netzes beschrieben. Bei der Entstehung benutzen
wir folgende Bedingungen. 

1) Das Netz besteht aus Ästen und ein Ast besteht aus einer Liste von
   Punkte, die durch Linien verbunden sind.
2) Am Ende eines Astes kann ein weiterer Punkt hinzugefügt werden: 
   "der Ast (und damit das Netz) wächst".
3) Ein Ast kann in drei Richtungen wachsen. (Dies lässt sich leicht verallgemeinern.)
4) Ein Ast kann sich im Wachstumsprozess verzweigen.
5) Ein Ast kann zu einem anderen Ast zusammenwachsen. 
6) Das Wachstum kann nur am Rand des Netzes stattfinden. 

In dem Programm wird ein Netz induktiv erzeugt. Die induktive Methode 
wurde im Allgmeinen in exam315 detailliert beschrieben. In exam316
ist hier der Induktionschritt komplexer. Kurz gesagt wird in einem Induktionsschritt 
ein Netz benutzt, welches in vorherigen Schritten generiert wurde. Für dieses
Netz werden nicht nur die Linien, die Äste und die Endpunkte der Äste genau
notiert und gespeichert, sondern werden weitere Eigenschaften des Netzes
benutzt, die am Anfang des Induktionsschrittes genau bestimmt werden.

Wir stellen uns ein Netz so vor, dass alle Äste vom selben Ursprung
stammen und die Äste von unten nach oben wachsen. Ein Ast hat einen "Namen"
(eine Zahl 1,...,X). Die Anzahl X der Äste ergibt sich erst im Ablauf.  

Wir beschreiben einige Bestandteile genauer:  

  branch([NAME,LENGTH,ENDPOINT,[LINI_1,...,LINE_N]]), 
   BRANCH = [NAME,LENGTH,ENDPOINT,[LINE_1,...,LINE_N]] ist ein Ast,  
   NAME = 1,2,3,... ist der "Name" des Astes,
   LENGTH = die Länge des Astes, 
   LINE_I = die I-te Linie des Astes (I = 1,...,N), 
   ENDPOINT ist der letzte Punkt P des Astes, LINE_N = [Pv,ENDPOINT],
  net(NUMBER_OF_BRANCHES,[BRANCH_1,...BRANCH_M]) ist ein Netz, 
   NUMBER_OF_BRANCHES ist die Anzahl der Äste des Netzes (hier M),
   branch(BRANCH_I) ist ein Ast (siehe oben),
  branch_structure(BRANCH_STRUCTURE),
   BRANCH_STRUCTURE = [[1,LENGTH_1,ENDPOINT_1],..
                  [I,LENGTH_I,ENDPOINT_I],..[N,LENGTH_N,ENDPOINT_N]],
     I ist der Name eines Astes, LENGTH_I die Länge des Astes und
     ENDPOINT_I der letzte Punkt des Astes Nr. I.

Im Induktionsschritt wird in der Umgebung des Astendes ein neuer Punkt 
an der richtigen "Stelle" des Astes hinzugefügt. Dazu müssen wir eine 
geometrische Umgebung für Punkte bereitstellen. Wir benutzen hier die 
Moore-Umgebung (siehe 2.4 in unserem Buch). Das Astende - ein Punkt P -
ist das Zentrum einer Moore-Umgebung, so dass P oben, links oder rechts 
an den Ast "anwachsen" kann. Die drei Zellen, die vom Moore-Zentrum 
nach unten führen, werden hier nicht benutzt.

In 1 - 3 haben wir drei Fakten bereitgestellt und in 4 werden vier 
Resultatdateien geleert. In 5 wird aus den drei Fakten ein Netz generiert.   
In 8 werden alle Punkte (als Zahlen 1,...,30) als eine Liste gespeichert.
In 9 - 11 wird der Induktionsanfang beschrieben. Zwei Äste werden
festgelegt. Ast Nr. 1 hat die Länge 1, den Endpunkt 2 und eine
einzige Linie [1,2]. Ast Nr. 2 hat ebenfalls die Länge 1, den Endpunkt 3 
und eine einzige Linie [1,3]. Das Netz besteht in 11 aus zwei Ästen und 
der Anzahl 2 der Äste.

In 12 werden alle Punkte außer 1,2,3 als eine Liste POINTS mit dem
Prädikat "freepoints" in die Datenbasis eingetragen. In 13 wird ein 
Zähler "counter1" eingerichtet und auf 0 gestellt.

In 14 wird eine Schleife über die Linien von 3 bis NUMBER_OF_LINES
(hier 35) gelegt. Für jede Linie wird das Netz an der Linie um diese
Linie, und damit auch um einen Punkt, erweitert. In 14 beginnt nun der
Induktionsschritt.

In 15 wird ein Netz, was schon generiert wurde, aus der Datenbasis geholt.
In 16 werden Vorbereitungen getroffen, um einen neuen Punkt
an der richtigen Stelle anzubringen. Die Zahl NUMBER_OF_BRANCHES der 
Äste und das Netz NET sind vorhanden. Drei weitere Zahlen MAX_LENGTH, 
NOMBS und NOOBS müssen aus dem Netz NET berechnet werden. In Zeile 16.1 unten wird 
eine leere Hilfsliste branch_structure(...) eingerichtet, die mit 
verschiedenen Daten gefüllt wird, und die für dieses Netz berechnet 
werden. In 16.2 werden alle Äste des Netzes in einer Schleife untersucht. 
In 16.5 wird der N-te Ast (BRANCH) aus dem Netz NET geholt, in 16.6 wird 
die 4-te Komponente des Astes BRANCH geholt. Sie besteht aus einer Liste 
von Linien. Die Länge dieser Liste wird berechnet. In 16.7 wird die 3-te
Komponente des Astes bestimmt: der Endpunkt des Astes. In 16.8 und 16.9 
werden diese Daten in die Hilfsliste branch_structure(...) hinzugenommen
und in 16.10 und 16.11 wird die Hilfsliste angepasst. 

Mit der in 16.3 so entstandenen Hilfsliste werden in 16.4 nun die drei
Zahlen MAX_LENGTH, NOMBS, NOOBS errechnet. In 16.4.2 wird ein weiterer
Hilfszähler count(1) eingerichtet, der am Anfang auf 1 steht. In 16.4.3 wird 
die Länge der Liste BRANCH_STRUCTURE für die Strukturdaten berechnet, die 
gerade vorher bestimmt wurden. Über diese Liste werden in 16.4.4 und in 
16.4.7 zwei Schleifen gelegt. In 16.4.4 werden alle Längen der Äste verglichen  
und die maximale Länge MAX_LENGTH von Ästen berechnet. Da es normalerweise
mehrere Äste der maximalen Länge gibt, wird in 16.4.7 eine Hilfsliste
eingerichtet, die alle Äste maximaler Länge enthält. In 16.4.8 wird dann 
die Länge der vollständigen Hilfsliste aux(LIST) bestimmt. In 16.4.9 wird 
die Anzahl NOMBS der maximal langen Äste und die Anzahl NOOBS der 
restlichen Äste eingetragen. Wir können in dieser Weise das Wachstum der 
Äste regulieren. Ein Ast BRANCH kann nur wachsen, wenn BRANCH im Induktionsschritt 
schon die maximale Länge hat, oder wenn die Länge L des 
Astes BRANCH fast maximal ist, d.h. L = MAX - 1. In 17 wird diese Information 
an die Resultatdatei res3164.pl geschickt. 

In 18 wird die Liste der freien Punkte aus der Datenbasis geholt und die
Länge bestimmt. In 19 gibt es nun 6 Möglichkeiten, wie PROLOG einen Punkt
an das Netz anfügen kann. Diese Möglichkeiten ergeben sich aus den
Vorbereitungen in prepare_net(NUMBER_OF_BRANCHES,NET,MAX_LENGTH,NOMBS,
NOOBS). Wir werden diese Fälle nicht genauer beschreiben. Die LeserInnen
könnten die Vorbereitungen z.B. bildlich darstellen und die Fälle selber
durchdenken. 

Schließlich wird in 20 das vollständige Netz an die Resultatdatei 
res3164.pl geschickt und in 21 wird "aufgeräumt".
 
Wir haben hier die Resultate auf vier Dateien res3261.pl,...,res3164.pl 
verteilt. In dieser Weise können wir die Resultate von Anfang an in 
verschiedene Arten einteilen, so dass sie in späteren Analysen effektiver
verwenden werden können und besser zu verstehen sind. Wir verwenden 
einige abkürzende Formulierungen bei "append - write", um das Programm
besser durchlesen zu können. Die Abkürzungen haben wir am Ende des Programms
formuliert.  

Abkürzungen:
NOMBS = NUMBER_OF_MAXIMAL_BRANCHES
NOOBS = NUMBER_OF_OTHER_BRANCHES
N_FRP = NUMBER_OF_FREE_POINTS
*/

number_of_points(30).                                                /* 1 */
number_of_lines(35).                                                 /* 2 */ 
type_of_neighbourhood(net,moore,1).                                  /* 3 */

start :-
 (exists_file('res3161.pl'), delete_file('res3161.pl'); true),
 (exists_file('res3162.pl'), delete_file('res3162.pl'); true),
 (exists_file('res3163.pl'), delete_file('res3163.pl'); true),
 (exists_file('res3164.pl'), delete_file('res3164.pl'); true),       /* 4 */
  make_a_net.                                                        /* 5 */

make_a_net :-                                                        /* 5 */
 number_of_points(NUMBER_OF_POINTS),                                 /* 6 */
 number_of_lines(NUMBER_OF_LINES),                                   /* 7 */
 findall(P,between(4,NUMBER_OF_POINTS,P),POINTS),                    /* 8 */

 asserta(branch([1,1,2,[[1,2]]])),                                   /* 9 */
 asserta(branch([2,1,3,[[1,3]]])),                                   /* 10 */
 asserta(net(2,[  [1,1,2,[[1,2]]],[2,1,3,[[1,3]]]  ] )),             /* 11 */
 append('res3161.pl'), write1([1,1,2,[[1,2]]]), nl, 
 write1([2,1,3,[[1,3]]]), nl, told,                                  /* 12 */
 write2(1,[1,2]), write2(2,[1,3]),                                   /* 13 */
 asserta(freepoints(POINTS)),                                        /* 12 */
 asserta(counter1(0)),                                               /* 13 */
 ( between(3,NUMBER_OF_LINES,NAME_OF_A_LINE), 
      extend_net(NAME_OF_A_LINE,NUMBER_OF_LINES), 
      fail; true),                                                   /* 14 */
 retractall(freepoints(PPP)),                                       
 retract(counter1(CC)),!.

% -------------------

extend_net(NAME_OF_A_LINE,NUMBER_OF_LINES) :-                        /* 14 */
% trace,
  net(NUMBER_OF_BRANCHES,NET),                                       /* 15 */
  prepare_net(NUMBER_OF_BRANCHES,NET,MAX_LENGTH,NOMBS,NOOBS),        /* 16 */
  append('res3164.pl'),     write(prepare_net(NUMBER_OF_BRANCHES,NET,MAX_LENGTH,NOMBS,NOOBS)), 
  write('.'), nl, told,                                              /* 17 */
  freepoints(FREEPOINTS), length(FREEPOINTS,N_FRP),                  /* 18 */
  ( 0 < N_FRP, NOOBS = 0, W is random(2) + 1,
     ( W = 1, case1ext(NAME_OF_A_LINE)                             /* 19.1 */
     ;
       W = 2, case1int(NAME_OF_A_LINE)                             /* 19.2 */
     )
  ;
    0 = N_FRP, NOOBS = 0, case2(NAME_OF_A_LINE)                    /* 19.3 */
  ;
    0 = N_FRP, 0 < NOOBS, case3(MAX_LENGTH,NAME_OF_A_LINE)         /* 19.4 */
  ;
    0 < N_FRP, 0 < NOOBS, W is random(2) + 1,
      ( W = 1, case4ext(NAME_OF_A_LINE,MAX_LENGTH)                 /* 19.5 */
      ;
        W = 2, case4int(NAME_OF_A_LINE,MAX_LENGTH)                 /* 19.6 */
      )
  ),
  ( NAME_OF_A_LINE = NUMBER_OF_LINES, 
   append('res3164.pl'), write(net(NUMBER_OF_BRANCHES,NET)), write('.'), 
   nl, told                                                          /* 20 */
  ; true
  ),
  retractall(branch_structure(STTT)),!.                              /* 21 */
  
% -----------------------------

prepare_net(NUMBER_OF_BRANCHES,NET,MAX_LENGTH,NOMBS,NOOBS) :-         /* 16 */
  asserta(branch_structure([])),                                    /* 16.1 */
  ( between(1,NUMBER_OF_BRANCHES,N_TH_BRANCH), add_steps(N_TH_BRANCH,NET), 
      fail ; true),                                                 /* 16.2 */
  branch_structure(BRANCH_STRUCTURE),                               /* 16.3 */
  make_max(BRANCH_STRUCTURE,MAX_LENGTH,NOMBS,NOOBS),!.              /* 16.4 */ 
    
add_steps(N_TH_BRANCH,NET) :-                                       /* 16.2 */
  nth1(N_TH_BRANCH,NET,BRANCH),                                     /* 16.5 */
  nth1(4,BRANCH,LIST_OF_LINES), length(LIST_OF_LINES,LENGTH),       /* 16.6 */
  nth1(3,BRANCH,ENDPOINT),                                          /* 16.7 */
  branch_structure(BRANCH_STRUCTURE1),                              /* 16.8 */
  append(BRANCH_STRUCTURE1,[[N_TH_BRANCH,LENGTH,ENDPOINT]],BRANCH_STRUCTUREnew),
                                                                    /* 16.9 */ 
  retract(branch_structure(BRANCH_STRUCTURE1)),                    /* 16.10 */
  asserta(branch_structure(BRANCH_STRUCTUREnew)),!.                /* 16.11 */

make_max(BRANCH_STRUCTURE,MAX_LENGTH,NOMBS,NOOBS) :-              /* 16.4.1 */
  asserta(count(1)),                                              /* 16.4.2 */
  length(BRANCH_STRUCTURE,LENGTH1),                               /* 16.4.3 */
  ( between(1,LENGTH1,X1), add_max(X1,BRANCH_STRUCTURE), fail; 
    true ),                                                       /* 16.4.4 */
  count(MAX_LENGTH), retract(count(MAX_LENGTH)),                  /* 16.4.5 */
  asserta(aux([])),                                               /* 16.4.6 */
  ( between(1,LENGTH1,W), add_aux(W,BRANCH_STRUCTURE,MAX_LENGTH), fail; 
    true ),                                                       /* 16.4.7 */  
  aux(LIST), length(LIST,EL), retract(aux(LIST)),                 /* 16.4.8 */
  NOMBS = EL, NOOBS is LENGTH1 - EL,!.                            /* 16.4.9 */
  
add_max(X1,BRANCH_STRUCTURE) :- 
  nth1(X1,BRANCH_STRUCTURE,K), K = [X1,LENGTH,X2],
  count(MAX1), 
  ( LENGTH =< MAX1, MAX2 = MAX1 ; MAX1 < LENGTH, MAX2 = LENGTH),
  retract(count(MAX1)), asserta(count(MAX2)),!. 

add_aux(W,BRANCH_STRUCTURE,MAX_LENGTH) :- 
  aux(LI), nth1(W,BRANCH_STRUCTURE,M),
  nth1(2,M,LENGTH), LENGTH = MAX_LENGTH, append(LI,[W],LInew), 
  retract(aux(LI)), asserta(aux(LInew)),!.

 
% -----------------------------------------
case1ext(NAR) :- net(E,NET),                                        /* 19.1 */
   freepoints(FRPTS), length(FRPTS,NFR),
   X is random(E) + 1,
   nth1(X,NET,BR), BR = [N,ST,ENDP,ARLIST], 
   Y is random(NFR) + 1, nth1(Y,FRPTS,P),
   append(ARLIST,[[ENDP,P]],ARLISTnew), STnew is ST + 1,
   write2(NAR,[ENDP,P]), 
   BRnew = [N,STnew,P,ARLISTnew],
   write1(BRnew),
   replace(NET,X,BRnew,NETnew), 
   retract(net(E,NET)), asserta(net(E,NETnew)),
   write3(E,NETnew),
   delete(FRPTS,P,FRPTSnew), retract(freepoints(FRPTS)),
   asserta(freepoints(FRPTSnew)),!.

case1int(NAR) :- net(E,NET),                                        /* 19.2 */
   freepoints(FRPTS), length(FRPTS,NFR),
   X is random(E) + 1,
   nth1(X,NET,BR), BR = [N,ST,ENDP,ARLIST], length(ARLIST,ELI),
   nth1(ELI,ARLIST,[P0,P1]), 
   Y is random(NFR) + 1, nth1(Y,FRPTS,P),
   delete(ARLIST,[P0,P1],ARLISTred),
   append(ARLISTred,[[P0,P]],ARLISTnew),
   write2(NAR,[P0,P]), Nnew is E + 1,
   BRnew = [Nnew,ST,P,ARLISTnew], write1(BRnew),
   append(NET,[BRnew],NETnew), Enew is E + 1,
   retract(net(E,NET)), asserta(net(Enew,NETnew)),
   write3(Enew,NETnew),
   delete(FRPTS,P,FRPTSnew), retract(freepoints(FRPTS)),
   asserta(freepoints(FRPTSnew)),!.

case2(NAR) :-                                                       /* 19.3 */
  net(E,NET),
  X is random(E) + 1, nth1(X,NET,BRX), 
  BRX = [NX,STX,ENDPX,ARLISTX], 
  length(ARLISTX,ELX), nth1(ELX,ARLISTX,[P1,ENDPX]),
  findall(W,between(1,E,W),NLIST), delete(NLIST,X,NLIST1),
  Emin is E - 1, 
  W is random(Emin) + 1, nth1(W,NLIST1,NY), 
  nth1(NY,NET,BRY), BRY = [NY,STY,ENDPY,ARLISTY],
  length(ARLISTY,ELY), nth1(ELY,ARLISTY,[PY1,ENDPY]),
  ( \+ P1 = PY1, \+ P1 = ENDPY,  
    append(ARLISTX,[[P1,ENDPY]],ARLISTXnew), Enew is E + 1,
    BRXnew = [Enew,STY,ENDPY,ARLISTXnew],
    write1(BRXnew), write2(NAR,[P1,ENDPY]),
    append(NET,[BRXnew],NETnew), 
    write3(Enew,NETnew), 
    retract(net(E,NET)), asserta(net(Enew,NETnew))
  ; 
    counter1(C), Cnew is C + 1, retract(counter1(C)), 
    asserta(counter1(Cnew)),
    append('res3162.pl'), write(counter1(Cnew)), write('.'),nl, told
  ),!.

/* In letzten Fall wird keine Linie gebildet, d.h. das Netz enthält 
   weniger Linien als vorgesehen - es gibt eine "Blokade". */

 case3(MAX,NAR) :- MAXmin is MAX - 1,                               /* 19.4 */
  net(E,NET), 
  findall(U, ( branch_structure(BRANCH_STRUCTURE),nth1(U,BRANCH_STRUCTURE,K), 
               K = [U,MAXmin,X3]
             ), LISTMIN),
  length(LISTMIN,EMIN), X1 is random(EMIN) + 1,
  nth1(X1,LISTMIN,X), nth1(X,NET,BRX),  
  BRX = [X,STX,ENDPX,ARLISTX], 
  findall(V, ( branch_structure(BRANCH_STRUCTURE), nth1(V,STEPLIST,K1),
               K1 = [V,MAX,X4]
             ), LIST2),
  length(LIST2,EL2), Y2 is random(EL2) + 1, nth1(Y2,LIST2,Y),
  nth1(Y,NET,BRY), BRY = [NY,STY,ENDPY,ARLISTY], 
  length(ARLISTY,ELY), nth1(ELY,ARLISTY,[PY1,PY2]),
  ( \+ ENDPX = PY1, \+ ENDPX = ENDPY,
    append(ARLISTX,[[ENDPX,ENDPY]],ARLISTXnew), 
    STnew is STX + 1,
    BRnew = [X,STnew,ENDPY,ARLISTXnew],
    write1(BRnew), write2(NAR,[ENDPX,ENDPY]),
    replace(NET,X,BRnew,NETnew), 
    retract(net(E,NET)), asserta(net(E,NETnew)),
    write3(E,NETnew)
  ;
    counter1(C), Cnew is C + 1, retract(counter1(C)), 
    asserta(counter1(Cnew)),
    append('res3162.pl'), write(counter1(Cnew)), write('.'),nl, told
  ),!.                          /* "Blokade" */

case4ext(NAR,MAX)  :-                                               /* 19.5 */
  MAXmin is MAX - 1, freepoints(FRPTS), length(FRPTS,NFR),
  net(E,NET),  
  findall(U, ( branch_structure(BRANCH_STRUCTURE),nth1(U,BRANCH_STRUCTURE,K), 
               K = [U,MAXmin,X3]
             ),LISTMIN ),
  length(LISTMIN,EMIN), X1 is random(EMIN) + 1,
  nth1(X1,LISTMIN,X), nth1(X,NET,BRX),  
  BRX = [X,STX,ENDPX,ARLISTX], 
  length(ARLISTX,ELX), nth1(ELX,ARLISTX,[P1,ENDPX]),
  Z is random(NFR) + 1, nth1(Z,FRPTS,P),
  append(ARLISTX,[[ENDPX,P]],ARLISTXnew), STXnew is STX + 1,  
  BRXnew = [X,STXnew,P,ARLISTXnew], 
  write1(BRXnew), write2(NAR,[ENDPX,P]),
  replace(NET,X,BRXnew,NETnew),
  retract(net(E,NET)), asserta(net(E,NETnew)),
  write3(E,NETnew),
  delete(FRPTS,P,FRPTSnew), retract(freepoints(FRPTS)),
  asserta(freepoints(FRPTSnew)),!.

case4int(NAR,MAX) :- MAXmin is MAX - 1,                             /* 19.6 */     
  net(E,NET),  
  findall(U, ( branch_structure(BRANCH_STRUCTURE),nth1(U,BRANCH_STRUCTURE,K), 
             K = [U,MAXmin,X3]
           ), LISTMIN),
  length(LISTMIN,EMIN), X1 is random(EMIN) + 1,
  nth1(X1,LISTMIN,X), nth1(X,NET,BRX),  
  BRX = [X,STX,ENDPX,ARLISTX], 
  findall(V, ( branch_structure(BRANCH_STRUCTURE),nth1(V,BRANCH_STRUCTURE,K1), 
               K1 = [V,MAX,X4]
             ),LISTMAX ),
  length(LISTMAX,EMAX), X2 is random(EMAX) + 1,
  nth1(X2,LISTMAX,Y), nth1(Y,NET,BRY),  
  BRY = [NY,STY,ENDPY,ARLISTY], 
  length(ARLISTY,ELY), nth1(ELY,ARLISTY,[PY1,PY2]),
  ( \+ ENDPX = PY1,
    append(ARLISTX,[[ENDPX,ENDPY]],ARLISTXnew), 
    STnew is STX + 1,
    BRnew = [X,STnew,ENDPY,ARLISTXnew],
    write1(BRnew), write2(NAR,[ENDPX,ENDPY]),
    replace(NET,X,BRnew,NETnew), 
    retract(net(E,NET)), asserta(net(E,NETnew)),
    write3(E,NETnew)
  ;
    counter1(C), Cnew is C + 1, retract(counter1(C)), 
    asserta(counter1(Cnew)),
    append('res3162.pl'), write(counter1(Cnew)), write('.'),nl, told
  ),!.                        /* "Blokade" */

% -------------------------------------------  

replace(LIST,PLACE,COMPONENT,LISTnew) :- 
  asserta(list([])), length(LIST,E), 
  ( between(1,E,X), replace_component(X,PLACE,COMPONENT,LIST), fail; true ),
  list(LISTnew), retract(list(LISTnew)),!.
replace_component(X,PLACE,COMPONENT,LIST) :-   
  list(LIST1),  
  ( X = PLACE, append(LIST1,[COMPONENT],LISTnew)
  ; 
    nth1(X,LIST,COMP), append(LIST1,[COMP],LISTnew)
  ),
  retract(list(LIST1)), asserta(list(LISTnew)),!.

% --------------------------------

write1([N,STEP,ENDP,ARL]) :- append('res3161.pl'),                
  write(branch(N,STEP,ARL)), write('.'), nl, told.
write2(NUM,LINE) :- append('res3162.pl'), write(line(NUM,LINE)), 
  write('.'), nl, told.            
write3(Enext,NETnext) :- append('res3163.pl'), write(net(Enext,NETnext)), 
  write('.'), nl, told.

