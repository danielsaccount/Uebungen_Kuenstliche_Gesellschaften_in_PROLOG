%  rules354.pl 

:- dynamic fact/3.


act_with_rule_produce(A,R,T) :-
    periods(TT),
    fact(R,T,hist(A,[TA1,TA2,TA3])),
    TA1n is TA1+(1/TT),  TL = [TA1n,TA2,TA3],
    delta_u(A,UU),
    fact(R,T,stock(A,SA)), SAnew is SA+UU,
    retract(fact(R,T,stock(A,SA))), asserta(fact(R,T,stock(A,SAnew))),
    retract(fact(R,T,hist(A,[TA1,TA2,TA3]))),
    asserta(fact(R,T,hist(A,[TA1n,TA2,TA3]))),!.

act_with_rule_predate(A,R,T) :-
    periods(TT),
    fact(R,T,hist(A,[TA1,TA2,TA3])),
    TA2n is TA2+(1/TT), TL = [TA1,TA2n,TA3],
    delta_u(A,UU),
    fact(R,T,stock(A,SA)), SAnew is SA+UU,
    retract(fact(R,T,stock(A,SA))), asserta(fact(R,T,stock(A,SAnew))),
    retract(fact(R,T,hist(A,[TA1,TA2,TA3]))),
    asserta(fact(R,T,hist(A,[TA1,TA2n,TA3]))),
    predated(B,DU), fact(R,T,stock(B,SB)), SBnew is max(0,SB-DU),
    retract(fact(R,T,stock(B,SB))), asserta(fact(R,T,stock(B,SBnew))),
    !.

act_with_rule_protect(A,R,T) :-
    periods(TT),
    fact(R,T,hist(A,[TA1,TA2,TA3])),
    TA3n is TA3+(1/TT),  TL = [TA1,TA2,TA3n],
    retract(fact(R,T,hist(A,[TA1,TA2,TA3]))),
    asserta(fact(R,T,hist(A,[TA1,TA2,TA3n]))),!.
