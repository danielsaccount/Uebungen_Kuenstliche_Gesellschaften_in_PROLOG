% create441.pl, Fakten werden erzeugt.

:- dynamic fact/3 .

make_names :-                                                             /* 6 */
  list_of_female_names(LIST),                                           /* 6.1 */
  list_of_male_names(LIST1),                                            /* 6.2 */
  asserta(dyn_list_female(LIST)), asserta(dyn_list_male(LIST1)),
  asserta(actor_list([])),
  actors(AS),
  choose_names(AS),
  actor_list(LIST2),
  write(actor_list(LIST2)).

choose_names(AS) :- 
  ( between(1,AS,N), add_name(N), fail; true),!.

add_name(N) :- dyn_list_male(LIST11), length(LIST11,E11), 
   dyn_list_female(LIST22), length(LIST22,E22),
  ( Y is N/2, integer(Y) , X1 is random(E11), X11 is X1 + 1,
    nth1(X11,LIST11,A1),
    delete(LIST11,A1,LIST11new), retract(dyn_list_male(LIST11)),
    asserta(dyn_list_male(LIST11new)), actor_list(LIST3),
    append(LIST3,[A1],LIST3new), retract(actor_list(LIST3)),
    asserta(actor_list(LIST3new))
  ;
    X2 is random(E22), X22 is X2 + 1, nth1(X22,LIST22,A2),
    delete(LIST22,A2,LIST22new), retract(dyn_list_female(LIST22)),
    asserta(dyn_list_female(LIST22new)), actor_list(LIST3),
    append(LIST3,[A2],LIST3new), retract(actor_list(LIST3)),
    asserta(actor_list(LIST3new)) 
  ),!.
    
% --------------------------------------------

make_events :-                                                            /* 7 */
  append('res4412.pl'), 
  events(EE),                                                           /* 7.1 */
  asserta(list_of_events([preach,hear_the_word,others])),               /* 7.2 */
  EE1 is EE - 3,                                                        /* 7.3 */
  ( between(1,EE1,NE), expand_list(NE), fail; true),                    /* 7.4 */
  list_of_events(LIST),
  write(list_of_events(LIST)), write('.'), nl, told,
  asserta(list_of_events(LIST)),!.

expand_list(NE) :-                                                      /* 7.4 */
   list_of_events(LIST), concat(evt,NE,EVT),                          /* 7.4.1 */
   append(LIST,[EVT],LISTnew), retract(list_of_events(LIST)),    
   asserta(list_of_events(LISTnew)),!.  
    
% --------------------------------------------

make(sinful) :-                                                         /* 7.5 */
  actors(AS), events(EVTS), list_of_events(EVENT_LIST),
  ( between(1,AS,NA), add_events(NA,EVTS,EVENT_LIST), fail ; true ),!.

add_events(NA,EVTS,EVENT_LIST) :- 
   ( between(1,EVTS,N), make_actor_properties(NA,N,EVENT_LIST), fail ; true),!.

make_actor_properties(NA,N,EVENT_LIST) :- 
     X is random(1001), W is X/1000, nth1(N,EVENT_LIST,EVT),
     actor_list(L55), nth1(NA,L55,A),
     append('data441.pl'), write(fact(0,0,sinful(A,EVT,W))), 
     write('.'), nl, told,!.

% ------------------------------------------

make(int) :-   
  actors(AS), events(N_EVTS), 
  ( between(1,AS,NA), make_intent(NA,N_EVTS), fail; true),
  retractall(bel(XX)),!.

make_intent(NA,N_EVTS) :- 
  ( between(1,N_EVTS,INT), make_intentions(INT,NA), fail; true),!.
 
make_intentions(INT,NA) :- 
  list_of_events(LIST),
  nth1(INT,LIST,AT), 
  actor_list(LIST1), nth1(NA,LIST1,A), 
  preacher(LIST_OF_PREACHERS), 
  ( member(NA,LIST_OF_PREACHERS), 
    ( INT = 1, W is 0.9 ; INT = 2, W is 0.10 ; 2 < INT , W = 0.5 ) 
  ; 
    \+ member(NA,LIST_OF_PREACHERS), 
     ( bel([1,A,WA,AT]), W is WA ; 
             X is random(100)+1, X1 is X/100, W is X1 -(1/100) )
  ),
  append('data441.pl'), write(fact(0,0,int([A,W,AT]))), write('.'), nl, told,!.


% ----------------------------------------------

make(bel) :- 
   minimum_of_beliefs(MINB), variation_of_beliefs(VARB), 
   minimum_of_higher_beliefs(MINB2), variation_of_higher_beliefs(VARB2), 
   actors(AS), step_of_beliefs(ML),
   make_beliefs(ML,AS,MINB,VARB,MINB2,VARB2),!.

make_beliefs(ML,AS,MINB,VARB,MINB2,VARB2) :-
   ( between(1,ML,N), make_beliefs_of_level(N,AS,MINB,VARB,MINB2,VARB2),
     fail; true).

% ----------------------------------------
   
make_beliefs_of_level(N,AS,MINB,VARB,MINB2,VARB2) :- 
  N = 1,
  ( between(1,AS,NA), make_individual_beliefs(1,NA,MINB,VARB), fail; true),!.

make_individual_beliefs(1,NA,MINB,VARB) :- 
  3 =< MINB, 
  X is random(VARB)+1, NB is MINB + X, 
  list_of_events(EVT_LIST), 
  subtract(EVT_LIST,[preach,hear_the_word,other],LIST),
  asserta(aux_list23(LIST)),
  ( between(1,NB,Z), make_beliefs(Z,NA,NB), fail; true),
  retract(aux_list23(LISTnew)),!.

make_beliefs(Z,NA,NB) :- 
   preacher(LIST_OF_PREACHERS), 
   Q is random(1001),
   ( member(NA,LIST_OF_PREACHERS), 
       ( ( Z=1, W is 0.95 , EVT = preach
         ; 
           1 < Z, Z =< 3, Z1 is Z-1, nth1(Z1,[hear_the_word,other],EVT), 
           W is Q/1000
         )
       ; 
         3 < Z, aux_list23(LIST), length(LIST,E11), 
         Y is random(E11)+1, nth1(Y,LIST,EVT),
         delete(LIST,EVT,LIST1), retract(aux_list23(LIST)),
         asserta(aux_list23(LIST1)), W is Q/1000
       )
   ; 
     \+ member(NA,LIST_OF_PREACHERS),
        ( Z =< 3, nth1(Z,[preach,hear_the_word,other],EVT), W is Q/1000
        ; 
          3 < Z, aux_list23(LIST), length(LIST,E11), 
          Y is random(E11)+1, nth1(Y,LIST,EVT),
          delete(LIST,EVT,LIST1), retract(aux_list23(LIST)),
          asserta(aux_list23(LIST1)), W is Q/1000
        )
   ),
   actor_list(LIST33), nth1(NA,LIST33,A), 
   asserta(bel([1,A,W,EVT])), 
   append('data441.pl'), write(fact(0,0,bel([1,A,W,EVT]))), 
   write('.'), nl, told,!.



% -----------------------------------------------------------

make_beliefs_of_level(N,AS,MINB,VARB,MINB2,VARB2) :- 
   1 < N,
   ( between(1,AS,NA), make_individual_beliefs(N,NA,AS,MINB2,VARB2), 
     fail; true),!.

make_individual_beliefs(N,NA,AS,MINB2,VARB2) :- 
  X is random(VARB2)+1, NB2 is MINB2 + X, 
  ( between(1,AS,NB), make_special_beliefs(NA,NB,N,NB2), fail; true).

make_special_beliefs(NA,NB,N,NB2) :- 
   N1 is N-1, actor_list(L44), nth1(NB,L44,B),
   asserta(aux_list24([])),
   complete_aux_list(N1,B,W,EVT),
   aux_list24(LIST), 
   ( between(1,NB2,Z), make_beliefs(Z,N,NA,B), fail; true),
   retract(aux_list24(LIST1new)),!.

complete_aux_list(N1,B,W,EVT) :-
   repeat, 
   ( bel([N1,B,W,EVT]), aux_list24(LIST), \+ member([N1,B,W,EVT],LIST),  
     append(LIST,[[N1,B,W,EVT]],LISTnew),
     retract(aux_list24(LIST)), asserta(aux_list24(LISTnew)), fail
   ; true),!.

make_beliefs(Z,N,NA,B) :- 
   Q is random(1001), W is Q/1000,
   aux_list24(LIST1), length(LIST1,E1), 
   Y is random(E1)+1, nth1(Y,LIST1,BEL),
   delete(LIST1,BEL,LIST2), retract(aux_list24(LIST1)),
   asserta(aux_list24(LIST2)), actor_list(LIST45), nth1(NA,LIST45,A),
   asserta(bel([N,A,W,bel(BEL)])), 
   append('data441.pl'), write(fact(0,0,bel([N,A,W,bel(BEL)]))), 
   write('.'), nl, told ,!.

% ----------------------------------------
   
make_beliefs_of_level(1,AS,MINB,VARB,MINB2,VARB2) :- 
  ( between(1,AS,NA), make_individual_beliefs(1,NA,MINB,VARB), fail; true),!.

make_individual_beliefs(1,NA,MINB,VARB) :- 
  3 =< MINB, 
  X is random(VARB)+1, NB is MINB + X, 
  list_of_events(EVT_LIST), 
  subtract(EVT_LIST,[preach,believe,other],LIST),
  asserta(aux_list23(LIST)),
  ( between(1,NB,Z), make_beliefs(Z,NA), fail; true),
  retract(aux_list23(LISTnew)),!.

make_beliefs(Z,NA) :- 
   Q is random(1001), W is Q/1000,
   ( Z =< 3, nth1(Z,[preach,believe,other],EVT)
   ;
     3 < Z, aux_list23(LIST), length(LIST,E11), 
     Y is random(E11)+1, nth1(Y,LIST,EVT),
     delete(LIST,EVT,LIST1), retract(aux_list23(LIST)),
     asserta(aux_list23(LIST1))
   ),
   actor_list(L33), nth1(NA,L33,A),
   asserta(bel([1,A,W,EVT])), 
   append('data441.pl'), write(fact(0,0,bel([1,A,W,EVT]))), write('.'), 
   nl, told,!.








 