/* create354.pl 

Erzeugungsprogramm für Daten bei dem 3p Modell */

:- dynamic fact/3.

make(character) :- coeffs(Pprod,Pred,K1,K2,K3,K4,K5,K6,K7,K8,K9),
  actors(AS),
  append('data354.pl'), X is integer((Pprod/100)*AS),
  ( between(1,X,A), write(fact(0,0,char(A,[100,0,0]))), write('.'), nl, 
    asserta(char(A,[100,0,0])), 
   fail; true), Y1 is X+1,
   Z is integer(Pred/100*AS), Y2 is X+Z,
  ( between(Y1,Y2,B), write(fact(0,0,char(B,[0,100,0]))), write('.'), nl, 
    asserta(char(B,[0,100,0])), 
    fail; true),
    Y3 is Y2+1,
  ( between(Y3,AS,B), write(fact(0,0,char(B,[0,0,100]))), write('.'), nl, 
    asserta(char(B,[0,0,100])), 
    fail; true),
  told,!.

make(ut_coeffs) :- actors(AS), append('data354.pl'),
   ( between(1,AS,A), make_ut_coeffs(A), fail; true), told,!.

make_ut_coeffs(A) :- char(A,L), retract(char(A,L)),
   coeffs(Prod,Pred,K1,K2,K3,K4,K5,K6,K7,K8,K9),
   nth1(1,L,C), nth1(2,L,CC),
   (   ( C=100, C1 is K1, C2 is K2, C3 is K3
    ; CC=100, C1 is K4, C2 is K5, C3 is K6
       )
   ; C1 is K7, C2 is K8, C3 is K9 ),
   write(fact(0,0,ut_coeffs(A,[C1,C2,C3]))), write('.'), nl,!.

make(stock) :- actors(AS), append('data354.pl'),
   ( between(1,AS,A), write(fact(0,0,stock(A,1))), write('.'), nl,
     fail ; true), told.

make(hist) :- actors(AS), append('data354.pl'),
   ( between(1,AS,A), write(fact(0,0,hist(A,[0,0,0]))),
     write('.'), nl, fail; true), told.
