:- dynamic stored/2.

% pred422.pl (for theory of Heider)


make_pot_pairs(AS) :- 
  asserta(list_pot_pairs([])),
  ( between(1,AS,A), make1_pot_pair(A,AS), fail; true),!,
  list_pot_pairs(LIST),
  asserta(list_pot_pairs(LIST)).
  
make1_pot_pair(A,AS) :- AA is AS - A,
   ( between(1,AS,B), make2_pot_pair(A,B,AA), fail; true),!.

make2_pot_pair(A,B,AA) :- A < B, list_pot_pairs(LIST), 
   append(LIST,[[A,B]],LISTnew),
   retract(list_pot_pairs(LIST)), asserta(list_pot_pairs(LISTnew)),!. 

look_from_one_side(TR,A,SG) :- TR = [Nr,[A1,B1,Ob],[X,Y,Z]],
  ( A = A1, SG = 0 ; A = B1, SG = 1 ).

% -------------------------------------------------

normal_distribution(N,AS,L,U,SI) :- MU is L + (0.5 * (U-L)),
   ( between(1,AS,A), determine_nd_value(N,MU,SI,L,U,A), fail; true),!.

determine_nd_value(N,MU,SI,L,U,A) :- repeat, X is
   random(10001)+1,
   X4 is (1/10000) * (((X-1) * U)+(10001-X) * L), W is integer(X4),
   PI is pi, X1 is 2*(PI * (SI * SI)), X2 is (1 / sqrt(X1)),
   X3 is (-((W-MU)*(W-MU))) / (SI*SI), Y is X2 * exp(X3),
   W1 is random(10001)+1, Z is (W1-1)/10000, Z =< Y, between(L,U,W),
   asserta(nd_expression(N,A,W)), !.

make_discrete_distribution(N,AS,EX,LIST) :-
  (  between(1,AS,A), determine_dd_value(N,A,EX,LIST), fail; true ),!.

determine_dd_value(N,A,EX,LIST) :- X is random(100)+1,
  between(1,EX,Z), nth1(Z,LIST,W_Z), X < W_Z, 
  assert(dd_expression(N,A,Z)),!.

calculate_sum(L,S) :- asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !.    

make_nbh(moore,N,I,J,L) :- gridwidth(G), ( N=1, moore_nbh_1(G,I,J,L)
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

decompose(Y,I,J,G) :- between(1,G,Z), Y =< Z*G, Z1 is Z-1, I is Z,
  J is Y-(Z1*G),!.

replace_mi(L,X,L1) :- nth1(X,L,Y), X2 is Y - 1, /* minus one */
   ( X2 < 0, X1 is Y ; X1 is Y-1 ),
   length(L,E),
   asserta(list([])),
   ( between(1,E,Z), replace(Z,L,X,X1), fail; true),
   list(L1), retract(list(L1)). 

replace_pl(L,X,L1) :- nth1(X,L,Y), X1 is Y + 1, length(L,E), /* plus one */
   asserta(list([])),
   ( between(1,E,Z), replace(Z,L,X,X1), fail; true),
   list(L1), retract(list(L1)).

replace(Z,L,X,X1) :- list(L2),   
  ( Z = X, append(L2,[X1],L3)
  ;
    nth1(Z,L,Y1), append(L2,[Y1],L3)
  ),
  retract(list(L2)), asserta(list(L3)),!.

