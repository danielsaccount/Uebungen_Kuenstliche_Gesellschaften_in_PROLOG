/* pred354.pl

Hilfsprogramme für das 3p Modell */

:- dynamic fact/3.

normal_distribution(N,AS,L,U,SI) :- MU is L + (0.5 * (U-L)),
   ( between(1,AS,A), determine_nd_value(N,MU,SI,L,U,A), fail; true),!.
   determine_nd_value(N,MU,SI,L,U,A) :- repeat, X is random(10001)+1,
   W is (1/10000)*(((X-1)*U)+(10001-X)*L),
   PI is pi, X1 is 2*(PI*(SI*SI)), X2 is (1 / sqrt(X1)),
   X3 is (-((W-MU)*(W-MU))) / (SI*SI), Y is X2 * exp(X3),
   W1 is random(10001)+1, Z is (W1-1)/10000, Z =< Y,
   asserta(nd_expr(N,A,W)), !.

make_discrete_distribution(N,AS,EX,LIST) :-
  (  between(1,AS,A), determine_dd_value(N,A,EX,LIST), fail; true ),!.

determine_dd_value(N,A,EX,LIST) :- X is random(100)+1,
  between(1,EX,Z), nth1(Z,LIST,W_Z), X < W_Z, assert( dd_expr(N,A,Z)),!.

calculate_sum(L,S) :- asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !.

make_nbh(moore,N,I,J,L) :- gridwidth(G), (  N=1, moore_nbh_1(G,I,J,L)
   ; 1 < N, moore_nbh_1(G,I,J,L2), asserta(auxlist(I,J,L2)),
     length(L2,K), (  between(1,K,X), mnbh(X,L2,N,G,I,J), fail ; true),
     auxlist(I,J,L5), delete(L5,[I,J],L6), sort(L6,L),
     retractall(auxlist(A,B,L8))
   ),!.

mnbh(X,L2,N,G,I,J) :- nth1(X,L2,Y), Y=[I1,J1], N1 is N-1,
  make_nbh(moore,N1,I1,J1,L3), auxlist(I,J,L4), append(L4,L3,L5),
  retract(auxlist(I,J,L4)), asserta(auxlist(I,J,L5)), !.

moore_nbh_1(G,I,J,L) :- recalculate_neg(G,I,1,Im),
  recalculate_neg(G,J,1,Jm), recalculate_pos(G,I,1,Ip),
  recalculate_pos(G,J,1,Jp),
  L = [[I,Jm],[Im,Jm],[Im,J],[Im,Jp],[I,Jp],[Ip,Jp],[Ip,J],[Ip,Jm]].

recalculate_neg(G,I,H,I1) :- X is I-H, (  (  0 < X, I1 is X
  ; 0 =:= X, I1 is G ) ; X < 0, I1 is (G+I)- H ),!.
    recalculate_pos(G,I,H,I1) :- X is I+H, (  ( I < G, X =< G, I1 is X
  ; I =:= G, (H > 0, I1 is H; H =:= 0, I1 is G) ) ; I < G, X > G,
    I1 is (H+I)-G ),!.

make_nbh(von_Neumann,N,I,J,L) :- gridwidth(G), (  N=1,
   von_Neumann_nbh_1(G,I,J,L) ; 1 < N, von_Neumann_nbh_1(G,I,J,L2),
   asserta(auxlist(I,J,L2)), length(L2,K),
   (  between(1,K,X), vNnbh(X,L2,N,G,I,J), fail ; true),
   auxlist(I,J,L5), delete(L5,[I,J],L6), sort(L6,L),
   retractall(auxlist(A,B,L8))  ),!.

vNnbh(X,L2,N,G,I,J) :- nth1(X,L2,Y), Y=[I1,J1], N1 is N-1,
   make_nbh(von_Neumann,N1,I1,J1,L3), auxlist(I,J,L4), append(L4,L3,L5),
   retract(auxlist(I,J,L4)), asserta(auxlist(I,J,L5)), !.

von_Neumann_nbh_1(G,I,J,L) :- recalculate_neg(G,I,1,Im),
  recalculate_neg(G,J,1,Jm), recalculate_pos(G,I,1,Ip),
  recalculate_pos(G,J,1,Jp), L = [[I,Jm],[Im,J],[I,Jp],[Ip,J]].
  decompose(Y,I,J,G) :- between(1,G,Z), Y =< Z*G, Z1 is Z-1, I is Z,
  J is Y-(Z1*G),!.

% die K-th Komponente der Liste L wir durch X ersetzt, mit Resultat L1

replace(L,K,X,L1) :- asserta(auxlist([])), length(L,E),
  ( between(1,E,Y), repl(L,K,X,Y), fail; true), auxlist(L1),
  retract(auxlist(L1)),!.

repl(L,K,X,Y) :-  nth1(Y,L,Z), ( Y =:= K, X1 is X; X1 is Z),
   auxlist(L1), append(L1,[X1],L2), retract(auxlist(L1)),
   asserta(auxlist(L2)),!.

euclid_dist(N,X,Y,D) :- asserta(count_dist(0)),
   ( between(1,N,Z), add_dist(Z,X,Y), fail; true), count_dist(C),
   D is sqrt(C), retract(count_dist(C)),!.

add_dist(Z,X,Y) :- nth1(Z,X,XZ), nth1(Z,Y,YZ), S is (XZ-YZ)*(XZ-YZ),
   count_dist(C), C1 is C+S, retract(count_dist(C)),
   asserta(count_dist(C1)),!.
