/* exam354.pl 

Ein Teil eines Simulationsprogramms wird beschrieben, welches in der Arbeit von

Albert, A. und Balzer, W. 2000: Towards  Computational Institutional Analysis:
Discrete SImulation of a 3P Model, in: Ballot, G., Weisbuch, G. (eds.),
Applications of SImulation to Social Sciences, Hermes Science Publishing Ltd.
Oxford, 195 - 208.

zu finden ist. In diesem Beispiel sind Mittelwerte nicht für Wiederholungen 
eines Ablaufs benutzt, sondern für Berechnungen von Handlungstypen innerhalb 
eines Ablaufs. Eine kurze, inhaltliche Beschreibung befindet sich in "readmy.pdf"
im gleichen Ordner.

Mit einer Konstanten ("coeffs(...)"), die die Nutzenfunktionen regelt, wird 
hier nur ein einziger Ablauf stattfinden. In einem vollständigen Programm 
lässt sich diese Konstante automatisch ändern.   

In 1 werden einige Dateien geladen und in 2 die Resultatdateien geleert. In
3 werden die Daten generiert - oder von data354.pl geholt.
*/

:- multifile fact/3.
:- dynamic fact/3. 

start :- 
  consult('para354.pl'), consult('pred354.pl'), consult('rules354.pl'), 
%  consult('create354.pl'),                                                  /* 1 */
  ( exists_file('res3541.pl') , delete_file('res3541.pl') ; true),
  ( exists_file('res3542.pl') , delete_file('res3542.pl') ; true),
  ( exists_file('res3543.pl') , delete_file('res3543.pl') ; true),        /* 2 */
  use_old_data(X),
  (   X = no, create_data ; X = yes, consult('data354.pl') ),                /* 3 */
  begin,!.                                                                /* 4 */

create_data :-
     ( exists_file('data354.pl'), delete_file('data354.pl') ; true ),
     consult('create354.pl'), variables(L), length(L,E),
     ( between(1,E,N), nth1(N,L,VAR), make(VAR), fail ; true ), !.        /* 5 */

begin :-                                                                  /* 4 */
   runs(RR), periods(TT), actors(AS),                                     /* 6 */
   (  between(1,RR,R), mainloop(R,TT), fail;  true  ),                    /* 7 */
   statistics(Y), (Y=on, make_statistics ; true).                         /* 8 */

mainloop(R,TT) :-                                                         /* 9 */
   consult('data354.pl'), findall(X,fact(0,0,X),L),                         /* 10 */
   length(L,E),
   ( between(1,E,Y), nth1(Y,L,FACT), export_initial_facts(R,FACT),       /* 11 */
     fail; true ),
   ( between(1,TT,T), kernel(R,T), fail; true ),                         /* 13 */
   export_results(R),                                                    /* 14 */
   retract_facts, !.                                                     /* 15 */

export_initial_facts(R,FACT) :-                                          /* 11 */
   retract(fact(0,0,FACT)), asserta(fact(R,1,FACT)),
   ( R =:= 1, 
     append('res3541.pl'), write(fact(0,0,FACT)), write('. '), nl, told
   ;  true ),!.                                                          /* 12 */

retract_facts :-                                                         /* 15 */
         ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail ; true ).

kernel(R,T) :-                                                           /* 13 */
     actors(AS), findall(I,between(1,AS,I),L), asserta(actor_list(L)),   /* 16 */
     (  between(1,AS,N), choose_and_activate_actor(R,T,N,A),             /* 17 */
        fail
     ;  true
     ),
     retract(actor_list(L1)), 
     adjust(R,T),!.                                                      /* 18 */

choose_and_activate_actor(R,T,N,A) :-                                    /* 17 */
    actor_list(L), length(L,E),                                          /* 19 */
    Y is random(E)+1, nth1(Y,L,A), 
    activate(R,T,A),                                                     /* 20 */
    delete(L,A,L1), retract(actor_list(L)),                              /* 21 */
    asserta(actor_list(L1)),!.                                           /* 22 */

activate(R,T,A) :-                                                       /* 20 */
    chooserule(R,T,A,M),                                                 /* 23 */
          ( concat(act_with_rule_, M, ACT), functor(FU1,ACT,3),          /* 24 */
            arg(1,FU1,A), arg(2,FU1,R), arg(3,FU1,T), FU1,               /* 25 */
            retractall(predated(B,UU)), retractall(delta_u(A,DU))        /* 26 */
        ; true
          ),!.

adjust(R,T) :-  global_adjust(R,T),!.                                    /* 18 */

global_adjust(R,T) :-                                                    /* 18 */
   T1 is T+1, findall(Z,fact(R,T,Z),L), length(L,E), 
   append('res3542.pl'),                                                 /* 27 */
   export_all_periods(every(N)),                                         /* 28 */
     ( between(1,E,Y), nth1(Y,L,FACT),                                   /* 29 */
       retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),                /* 30 */
       ( Z is T mod N, Z=:=0, write(fact(R,T,FACT)), write('. '), nl     /* 31 */
       ;  true
       ),
       fail
     ; true), told, !.

chooserule(R,T,A,M) :-                                                   /* 23 */
   fact(R,T,hist(A,[TA1,TA2,TA3])),                                      /* 32 */
   calculate_util_increments(R,T,A,[TA1,TA2,TA3],L),                     /* 33 */
   sort(L,L1), nth1(3,L1,X), X=[UU,I], rules(RL), nth1(I,RL,M),          /* 34 */
   asserta(delta_u(A,UU)),!.                                             /* 35 */

make_means(R,T,A,AA,M) :- AS is AA+1,  asserta(aux(0)),                  /* 36 */
  ( between(1,AS,B), B=\=A, add_aux(R,T,B,AA), fail; true),              /* 37 */
  aux(C), retract(aux(C)), M is C/AA,!.                                  /* 38 */

add_aux(R,T,B,AA) :-                                                     /* 37 */
  fact(R,T,ut_coeffs(B,[UB1,UB2,UB3])), fact(R,T,stock(B,S)),            /* 39 */
  fact(R,T,hist(B,[TB1,TB2,TB3])), expo(EX),                             /* 40 */
  X is UB2*(TB2**EX),                                                    /* 41 */
  aux(C), Cn is C+X, retract(aux(C)), asserta(aux(Cn)),!.                /* 42 */

calculate_util_increments(R,T,A,[TA1,TA2,TA3],L) :-                      /* 33 */
    actors(AS), AA is AS-1, fact(R,T,ut_coeffs(A,[UA1,UA2,UA3])),        /* 43 */
    fact(R,T,stock(A,S)),                                                /* 44 */
    DUA1 is UA1,                                                         /* 45 */
    findall(X,between(1,AS,X),L1), delete(L1,A,L2),                      /* 46 */
    Z is random(AA)+1,                                                   /* 47 */
    nth1(Z,L2,B), fact(R,T,stock(B,SB)),                                 /* 48 */
    fact(R,T,ut_coeffs(B,[UB1,UB2,UB3])),                                /* 49 */
    fact(R,T,hist(B,[TB1,TB2,TB3])),                                     /* 50 */
    ( UA2 > UB2, DUA2 is UA2*SB*(1-UB3*TB3),                             /* 51 */
           asserta(predated(B,DUA2))                                     /* 52 */
    ;
      DUA2 is 0                                                          /* 53 */
    ),
    make_means(R,T,A,AA,M),                                              /* 54 */
    DUA3 is M*S*UA3,                                                     /* 55 */
    L=[[DUA1,1],[DUA2,2],[DUA3,3]],!.                                    /* 56 */

export_results(R) :-                                                     /* 14 */
   consult('res3542.pl'), 
   append('res3543.pl'),                                                 /* 57 */
   actors(AS), periods(TT),                                              /* 58 */
  ( between(1,AS,A), exp_actor(R,TT,A), fail; true), told,!.             /* 59 */

exp_actor(R,TT,A) :-                                                     /* 59 */
   fact(R,TT,ut_coeffs(A,LA)),                                           /* 60 */
   fact(R,TT,hist(A,[T1,T2,T3])),                                        /* 61 */
   write(ut_coeffs(R,A,LA)), write('.'), nl,                             /* 62 */
   write(times(R,A,T1,T2,T3)), write('.'), nl, !.                        /* 63 */

make_statistics :-                                                        /* 8 */
  consult('stat354.pl'), 
%  sign(X1,X2,X3,X4), proplist(L), nth1(X4,L,KK), 
   begin_statistics.                     
