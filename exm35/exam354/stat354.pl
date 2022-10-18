/* stat354.pl für exam354 */


:- dynamic [producer/1, predator/1, protector/1, balanced/1, 
   mean_coeffs/2, mean_group_time/2 ].

begin_statistics :-   
   consult('res3543.pl'), consult('para354.pl'),
   runs(RR), make_means(RR),!.

make_means(RR) :- actors(AS), append('res3544.pl'),    
   ( between(1,AS,A), make_mean(A,RR), fail; true),
   make_big_groups(AS),
   told,!.

make_mean(A,RR) :- asserta(aux_mean(A,0,0,0)),
   ( between(1,RR,R), add_to_mean(R,A), fail; true),
   aux_mean(A,C1,C2,C3),
   retract(aux_mean(A,C1,C2,C3)), C1n is C1/RR, C2n is C2/RR, C3n
   is C3/RR, asserta(times_spent(A,C1n,C2n,C3n)),!.

add_to_mean(R,A) :- times(R,A,T1,T2,T3),
    aux_mean(A,C1,C2,C3), C1n is C1+T1, C2n is C2+T2, C3n is
    C3+T3, retract(aux_mean(A,C1,C2,C3)),
    asserta(aux_mean(A,C1n,C2n,C3n)),!.

make_group_mean(X,L,M4n,M5n,M6n) :- 
   length(L,E), asserta(aux([0,0,0,0,0,0])),
   ( between(1,E,C), add_group_mean(C,L), fail; true),
   aux([M1,M2,M3,M4,M5,M6]), M1n is M1/E, M2n is M2/E, M3n is M3/E,
   M4n is M4/E, M5n is M5/E, M6n is M6/E,
   write(mean_coeffs(X,[M1n,M2n,M3n])), write('.'), nl,
   write(mean_group_time(X,[M4n,M5n,M6n])), write('.'), nl,
   asserta(mean_coeffs(L,[M1n,M2n,M3n])),
   asserta(mean_group_time(L,[M4n,M5n,M6n])),
   retract(aux([M1,M2,M3,M4,M5,M6])),!.

add_group_mean(C,L) :- nth1(C,L,A), ut_coeffs(1, A, [U1, U2, U3]),
   times_spent(A,T1,T2,T3), aux([M1,M2,M3,M4,M5,M6]), M1n is M1+U1,
   M2n is M2+U2, M3n is M3+U3, M4n is M4+T1, M5n is M5+T2, M6n is
   M6+T3, retract(aux([M1,M2,M3,M4,M5,M6])),
   asserta(aux([M1n,M2n,M3n,M4n,M5n,M6n])),!.

protector(_) :- fail.
producer(_) :- fail.
predator(_) :- fail.
balanced(_) :- fail.

make_big_groups(AS) :-
  ( between(1,AS,A), insert_in_group(A), fail; true),
  findall(A,balanced(A),L4), length(L4,E4),
  ( between(1,E4,X), nth1(X,L4,A), insert2_in_group(A),
    fail; true),
  findall(A,producer(A),L1), (length(L1,E1), 
  asserta(alength(E1)), E1=\=0,
  make_group_mean(prod,L1,M1,M2,M3); true), 
  findall(A,predator(A),L2),
  (length(L2,E2), asserta(blength(E2)), E2=\=0, 
   make_group_mean(pred,L2,N1,N2,N3); true),
  findall(A,protector(A),L3), (length(L3,E3), 
  asserta(clength(E3)), E3=\=0,
  make_group_mean(prot,L3,K1,K2,K3); true), alength(E1m), 
  blength(E2m),
  clength(E3m), retract(alength(E1m)), retract(blength(E2m)),
  retract(clength(E3m)),
  calculate_sum([E1m,E2m,E3m],S), X is 100/S, E1n is X*E1m, E2n is X*E2m,
  E3n is X*E3m,
  write(group_proportions(E1n,E2n,E3n)), write('.'), nl,
  ( E1m=\=0, M1n is M1; M1n is 0 ), (E2m=\=0, N2n is N2; N2n is 0 ),
  ( E3m =\= 0, K3n is K3; K3n is 0 ),
  write(mean_times(M1n,N2n,K3n)), write('.'), nl,nl,!.

insert_in_group(A) :- times_spent(A,T1,T2,T3),
(  (   ( 0.6 < T1, asserta(producer(A))
       ; 0.6 < T2, asserta(predator(A))
       )
   ; 0.6 < T3, asserta(protector(A))
   )
;  asserta(balanced(A))
),!.

insert2_in_group(A) :- times_spent(A,T1,T2,T3),
     L = [[T1,1],[T2,2],[T3,3]], sort(L,L1),
     L1=[[T1n,X1],[T2n,X2],[T3n,X3]],
  (  (  ( T1n=T3n, asserta(producer(A))
        ; T1n=T2n, disentangle(A,X2)
        )
     ;  T2n=T3n, disentangle(A,X2)
     )
  ; disentangle(A,X3)
  ),!.
disentangle(A,X) :- ( ( X=1, asserta(producer(A))
                      ; X=2, asserta(predator(A))
                      )
                    ; X=3, asserta(protector(A))
                    ),!.

calculate_sum(L,S) :- asserta(counter(0)), length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true), counter(S),
  retract(counter(S)).
auxpred(L,X) :- nth1(X,L,N), counter(C), C1 is C+N,
    retract(counter(C)), asserta(counter(C1)), !.
