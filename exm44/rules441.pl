/* rules441.pl  */

:- dynamic fact/3 .

% RULE 1: preach. the person preaches. 

prepare(R,T) :-                                                          /* 18 */
   asserta(list_of_hearers([])),                                       /* 18.1 */
   asserta(list_of_preachings([])),
   asserta(list_of_others([])).

act_in_type(preach,A,R,T) :-                                           /* 31.1 */
   feasible(preach,A,R,T),                                             
   chooseaction(preach,A,R,T),                                
   perform(preach,A,R,T),!.                                          /* 31.1.1 */                                               
   feasible(preach,A,R,T) :- 
   fact(R,T,bel([1,B,W,hear_the_word])), 0.30 =< W,!.                 

chooseaction(preach,A,R,T) :- true,!.   
 
perform(preach,A,R,T) :-                                             /* 31.1.1 */
   actors(AS),                                                       /* 31.1.1 */
   asserta(list_of_sinful_deads([ ])),                               /* 31.1.2 */
   search_sinful_event(R,T,A,AS,EVT),                                /* 31.1.3 */
   list_of_preachings(L), append(L,[[A,EVT]],L1),                    /* 31.1.4 */
   retract(list_of_preachings(L)), 
   asserta(list_of_preachings(L1)),!.                                /* 31.1.5 */
 
search_sinful_event(R,T,A,AS,EVT) :-                                 /* 31.1.3 */
   ( between(1,AS,NB), search_sins(NB,R,T), fail; true),             /* 31.1.6 */
   list_of_sinful_deads(LIST_OF_SINS), 
   retract(list_of_sinful_deads(LIST_OF_SINS)),                      /* 31.1.7 */
   sort(LIST_OF_SINS,LISTnew),                                       /* 31.1.8 */
   length(LISTnew,E1),                                               /* 31.1.9 */
   ( 0 < E1,
      ratio(RA), X is random(101),                                  /* 31.1.10 */
      ( X < RA , Y is random(E1) + 1, nth1(Y,LISTnew,[W,EVT])       /* 31.1.11 */
      ;   
        X < 101, nth1(E1,LISTnew,[W,EVT])                           /* 31.1.12 */ 
      )
   ;
     0 = E1, list_of_events(EVENTLIST), length(EVENTLIST, LENGTH),
     Z is random(LENGTH) + 1, nth1(Z,EVENTLIST,EVT)
   ),!.

search_sins(NB,R,T) :-                                               /* 31.1.6 */
   asserta(aux_list25([])), actor_list(ACTORLIST),                  /* 31.1.12 */
   nth1(NB,ACTORLIST,B),                                          /* 31.1.12.1 */
   complete_aux_list25(R,T,B,WB,EVT),                               /* 31.1.13 */
   aux_list25(FACT_LIST),                                           /* 31.1.14 */
   list_of_sinful_deads(L), append(L,FACT_LIST,Lnew),               /* 31.1.15 */
   retract(list_of_sinful_deads(L)),                                /* 31.1.16 */
   asserta(list_of_sinful_deads(Lnew)),!.
 
complete_aux_list25(R,T,B,WB,EVT) :-                                /* 31.1.13 */
   repeat,                                                          /* 31.1.17 */
   ( fact(R,T,bel([1,B,WB,EVT])),                                   /* 31.1.18 */
     fact(R,T,sinful(B,EVT,W)),                                     /* 31.1.19 */
     WB1 is 0.2*WB, WB1 =< W,                                       /* 31.1.20 */
     aux_list25(LIST), \+ member([W,EVT],LIST),                     /* 31.1.21 */ 
     append(LIST,[[W,EVT]],LISTnew),                                /* 31.1.22 */
     retract(aux_list25(LIST)), asserta(aux_list25(LISTnew)), fail  /* 31.1.23 */
   ; true),!.                                                       /* 31.1.24 */

protocol(preach,A,R,T) :- fail.
adjust(preach,A,R,T) :- true.  
  
 % --------------------------------------------------

/* RULE 2 hear_the_word */

act_in_type(hear_the_word,A,R,T) :-                                    /* 31.2 */
   feasible(hear_the_word,A,R,T),      
   chooseaction(hear_the_word,A,R,T), perform(hear_the_word,A,R,T),!.  
   
feasible(hear_the_word,A,R,T) :- 
   fact(R,T,bel([2,A,W1,bel([1,B,W,preach])])), 0.60 =< W,!.         /* 31.2.1 */

chooseaction(hear_the_word,A,R,T) :- true,!.   
 
perform(hear_the_word,A,R,T) :-  
   list_of_hearers(LIST1), 
   append(LIST1,[A],LIST2), retract(list_of_hearers(LIST1)),         /* 31.2.2 */
   asserta(list_of_hearers(LIST2)),!.   /* A ist der Hörer, B ist ein Prediger */
      
protocol(heard_the_word,A,R,T) :- fail.
adjust(hear_the_word,A,R,T) :- true.

% -------------------------------------------------------

/* RULE 3 other */

act_in_type(other,A,R,T) :-                                            /* 31.3 */
   feasible(other,A,R,T),      
   chooseaction(other,A,R,T), perform(other,A,R,T),!.  
   
feasible(other,A,R,T) :- true.

chooseaction(other,A,R,T) :- true,!.   
 
perform(other,A,R,T) :-                                                /* 31.3 */
   findall(X,( fact(R,T,bel([1,A,W,EVT])), X = [W,EVT]),LIST),       /* 31.3.1 */
   length(LIST,E),  
   ( 0 < E,
     X is random(E)+1, nth1(X,LIST,[W,EVT]),                         /* 31.3.2 */
     Y is random(2),                                                 /* 31.3.3 */
     ( Y = 0, Waux is W + 0.05, ( 1 =< Waux, Wnew = 1 ; Wnew = Waux)  
     ; 
       Y = 1, Waux is W - 0.05, ( Waux < 0 , Wnew = 0 ; Wnew = Waux) 
     ),
     list_of_others(LIST_OTH),
     append(LIST_OTH,[[A,W,Wnew,EVT]],LIST_OTHnew),                  /* 31.3.4 */
     retract(list_of_others(LIST_OTH)),
     asserta(list_of_others(LIST_OTHnew))                            /* 31.3.5 */
   ;
     0 = E, true
   ),!.

protocol(other,A,R,T) :- fail.      
adjust(other,A,R,T) :- true.  
  
% -----------------------------------------------------------------

change_data(R,T) :-                                                      /* 25 */
    list_of_preachings(LIST_PR), length(LIST_PR,E),                    /* 25.1 */
    ( E = 0, true                                                      /* 25.2 */
    ;
      list_of_hearers(LIST_H), length(LIST_H,N_H),                     /* 25.3 */
      ( N_H = 0, true                                                  /* 25.4 */
      ;
        asserta(list_of_sessions([])),                                 /* 25.5 */
        make_list_of_sessions(LIST_PR,E,LIST_H,N_H),                   /* 25.6 */
        list_of_sessions(LIST_SE),                                    /* 25.14 */
        ( between(1,E,N1), make_adjust(N1,R,T,LIST_PR,LIST_SE),       /* 25.15 */
          fail; true),                                                /* 25.16 */
        retract(list_of_sessions(LIST_SE))                            /* 25.17 */
      )
    ),
    list_of_others(LIST_OTH), length(LIST_OTH,E1),                    /* 25.18 */
    ( between(1,E1,N2), adjust_N2(N2,R,T,LIST_OTH), fail; true).      /* 25.19 */

adjust_N2(N2,R,T,LIST_OTH) :-                                         /* 25.19 */
   nth1(N2,LIST_OTH,[A,W,Wnew,EVT]),                                  /* 25.20 */
   ( 
     fact(R,T,bel([1,A,W,EVT])),                                      /* 25.21 */
     retract(fact(R,T,bel([1,A,W,EVT]))),                             /* 25.22 */
     Y is random(2),                                                  /* 25.23 */
     ( Y = 0, Waux is W + 0.05, ( 1 =< Waux, Wnew = 1 ; Wnew = Waux)  /* 25.24 */ 
     ; 
       Y = 1, Waux is W - 0.05, ( Waux < 0 , Wnew = 0 ; Wnew = Waux)  /* 25.25 */
     ),
     asserta(fact(R,T,bel([1,A,Wnew,EVT])))
     
   ; 
     true                                                             /* 25.26 */
   ),!.

make_list_of_sessions(LIST_PR,E,LIST_H,N_H) :-                         /* 25.6 */
   ( between(1,N_H,NH), add_hearers(NH,LIST_H,LIST_PR,E),              /* 25.7 */
     fail; true),!.

add_hearers(NH,LIST_H,LIST_PR,E) :-                                    /* 25.7 */
   nth1(NH,LIST_H,HA),                                                 /* 25.8 */
   ( 0 < E, X is random(E)+1, nth1(X,LIST_PR,[PA,EVT]),                /* 25.9 */
     list_of_sessions(LIST_SE),                                       /* 25.10 */
     append(LIST_SE,[[PA,EVT,HA]],LIST_SEnew),                        /* 25.11 */
     retract(list_of_sessions(LIST_SE)),                              /* 25.12 */
     asserta(list_of_sessions(LIST_SEnew))
   ;
     E = 0, true                                                      /* 25.13 */
   ),!.
  
make_adjust(N1,R,T,LIST_PR,LIST_SE) :-                                /* 25.15 */
   nth1(N1,LIST_PR,[A,EVT]),                                          /* 25.15 */
   findall(B,
        ( list_of_sessions(LIST_SE),member([A,EVT,B],LIST_SE) )       /* 25.16 */
            ,LIST_H_A),
   length(LIST_H_A,EA),                                               /* 25.17 */
   ( EA = 0, true                                                     /* 25.18 */
   ;
     0 < EA,                                                          /* 25.19 */
     ( between(1,EA,NHA), adjust_NHA(R,T,NHA,LIST_H_A,EVT),           /* 25.20 */
       fail; true)
   ),!.

adjust_NHA(R,T,NHA,LIST_H_A,EVT) :-                                   /* 25.21 */
   nth1(NHA,LIST_H_A,B),                                              /* 25.22 */
   ( fact(R,T,bel([1,B,W1,EVT])),                                     /* 25.23 */
     W1aux is W1 - 0.01 ,                                             /* 25.24 */
     ( W1aux =< 0,  W1new = 0 ; W1new = W1aux),                       /* 25.25 */
     retract(fact(R,T,bel([1,B,W1,EVT]))),                            /* 25.26 */     
     asserta(fact(R,T,bel([1,B,W1new,EVT])))
   ; 
     true                                                             /* 25.27 */
   ),
   ( fact(R,T,int([B,W,EVT])),                                        /* 25.28 */
     Waux is W - 0.01 ,                                               /* 25.29 */
     ( Waux =< 0,  Wnew = 0 ; Wnew = Waux),                           /* 25.30 */
     retract(fact(R,T,int([B,W,EVT]))),                               /* 25.31 */
     asserta(fact(R,T,int([B,Wnew,EVT])))
   ;
     true                                                             /* 25.32 */
   ),!.

adjust(R,T) :-                                                           /* 34 */
   list_of_hearers(LLL1),
   retract(list_of_hearers(LLL1)),
   list_of_preachings(LLL2),
   retract(list_of_preachings(LLL2)),
   list_of_others(LLL3),
   retract(list_of_others(LLL3)),!.



 