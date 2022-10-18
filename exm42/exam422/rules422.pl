% rules422.pl (for theory of Heider)

act_in_type(balance,ACTOR,RUN,TICK) :-                                   /* 10 */ 
  stored(RUN,TICK,list_of_triades(LIST_TR)), length(LIST_TR,Length1),    /* 11 */
  (  between(1,Length1,Nr),                                              /* 12 */
     nth1(Nr,LIST_TR,TR1),                                               /* 13 */
     nth1(2,TR1,COMP), nth1(1,COMP,A1),                                  /* 14 */
                                    /* TR1 = [Nr,[A1,B1,Ob1],[X1,Y1,Z1]] */
     ACTOR = A1,                                                         /* 15 */
          ( between(1,Length1,Nr1),                                      /* 16 */
            nth1(Nr1,LIST_TR,TR2),                                       /* 17 */
            \+ TR1 = TR2, TR2 = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2]],            /* 18 */
            signs_are_imbalanced(TR1,TR2),                               /* 19 */
            change(RUN,TICK,ACTOR,TR1,TR2,TR1new,TR2new)                     /* 20 */
          ;
            true                                                         /* 22 */
          )
  ;
    true
  ),!.

signs_are_imbalanced(TR1,TR2) :-                                         /* 19 */
   triades_pos_balanced(LIST_SIG1), 
   triades_neg_balanced(LIST_SIG2), 
   ( nth1(3,TR1,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR2,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG1 = SIG2
   ;
     nth1(3,TR2,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR1,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG1 = SIG2
   ),!.

change(RUN,TICK,ACTOR,TR1,TR2,TR1new,TR2new) :-                              /* 20 */
  TR1 = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1]],
  TR2 = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2]],
  append('res4222.pl'), 
  ( B1 = B2, X1 = X2, 
    ( \+ Y1 = Y2, K2 is random(2)+1,
      ( K2 = 1, Y1n is -Y1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1n,Z1]],
        TR2new = TR2, write(changed(RUN,TICK,ACTOR,nr,Nr1)), write('.'), nl
      ; K2 = 2, Y2n is -Y2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2n,Z2]],  
        TR1new = TR1, write(changed(RUN,TICK,ACTOR,nr,Nr2)), write('.'), nl
      )
      ; true
    ),
    ( \+ Z1 = Z2, K3 is random(2)+1, 
      ( K3 = 1, Z1n is -Z1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1n]],
        TR2new = TR2, write(changed(RUN,TICK,ACTOR,nr,Nr1)), write('.'), nl
      ; K3 = 2, Z2n is -Z2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2n]],  
        TR1new = TR1, write(changed(RUN,TICK,ACTOR,nr,Nr2)), write('.'), nl
      )
      ; true
    )
  ;
     Ob1 = Ob2, Y1 = Y2,
     ( \+ X1 = X2, K2 is random(2)+1,
       ( K2 = 1, X1n is -X1, TR1new = [Nr1,[A1,B1,Ob1],[X1n,Y1,Z1]],
         TR2new = TR2, write(changed(RUN,TICK,ACTOR,nr,Nr1)), write('.'), nl
       ; K2 = 2, X2n is -X2, TR2new = [Nr2,[A2,B2,Ob2],[X2n,Y2,Z2]],  
         TR1new = TR1, write(changed(RUN,TICK,ACTOR,nr,Nr2)), write('.'), nl
       )
       ; true
     ),
     ( \+ Z1 = Z2, K3 is random(2)+1, 
       ( K3 = 1, Z1n is -Z1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1n]],
         TR2new = TR2, write(changed(RUN,TICK,ACTOR,nr,Nr1)), write('.'), nl
       ; K3 = 2, Z2n is -Z2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2n]],  
         TR1new = TR1, write(changed(RUN,TICK,ACTOR,nr,Nr2)), write('.'), nl
       )
       ; true
     )
  ), told,
  append('res4221.pl'), 
  stored(RUN,TICK,list_of_triades(LISTL)),                                   /* 21 */
  ( TR1 = TR1new,
    delete(LISTL,TR2,LISTL1), 
    append(LISTL1,[TR2new],LISTL2),
    nl, write(stored(RUN,TICK,list_of_triades(LISTL2))), write('.'), nl 
  ;
    TR2 = TR2new,
    delete(LISTL,TR1,LISTL1), 
    append(LISTL1,[TR1new],LISTL2),
    nl, write(stored(RUN,TICK,list_of_triades(LISTL2))), write('.'), nl
  ),
  told,
  retract(stored(RUN,TICK,list_of_triades(LISTL))),
  asserta(stored(RUN,TICK,list_of_triades(LISTL2))),!.

protocol(M,A,R,T) :- fail.



/*
act_in_type(balance,A,R,T) :-
  stored(R,T,list_of_triades(LIST_TR)), length(LIST_TR,Length1),
    (  between(1,Length1,Nr), nth1(Nr,LIST_TR,TR1),
       look_from_one_side(TR1,A,XSG),
       find_second_suitable_triade(T,A,TR1,SG,LIST_TR,Length1)
   ;
       true
   ),!.

find_second_suitable_triade(T,A,TR1,SG,LIST_TR,Length1) :-
  ( SG = 0,
    ( between(1,Length1,Nr1), nth1(Nr1,LIST_TR,TR2),
      \+ TR1 = TR2, 
      look_from_one_side(TR2,A,1),
      signs_are_imbalanced(TR1,TR2),
      change(T,A,TR1,TR2,TR1new,TR2new)
    ;
      true
    )
  ;
    SG = 1,
    ( between(1,Length1,Nr1), nth1(Nr1,LIST_TR,TR2),
      \+ TR1 = TR2, 
      look_from_one_side(TR2,A,0),
      signs_are_imbalanced(TR1,TR2),
      change(T,A,TR1,TR2,TR1new,TR2new)
    ;
      true
    )
  ),!.

signs_are_imbalanced(TR1,TR2) :-
   triades_pos_balanced(LIST_SIG1), 
   triades_neg_balanced(LIST_SIG2), 
   ( nth1(3,TR1,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR2,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG2 = SIG2
   ;
     nth1(3,TR2,SIG1), member(SIG1,LIST_SIG1),
     nth1(3,TR1,SIG2), member(SIG2,LIST_SIG2),
     \+ SIG1 = SIG2
   ),!.

change(T,A,TR1,TR2,TR1new,TR2new) :-
  TR1 = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1]],
  TR2 = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2]],
  append('res4222.pl'), 
  ( \+ X1 = X2, K1 is random(2)+1,
    ( K1 = 1, X1n is -X1, TR1new = [Nr1,[A1,B1,Ob1],[X1n,Y1,Z1]],
      TR2new = TR2, write(changed(T,A,nr,Nr1)), write('.'), nl
    ; K2 = 2, X2n is -X2, TR2new = [Nr2,[A2,B2,Ob2],[X2n,Y2,Z2]],  
      TR1new = TR1, write(changed(T,A,nr,Nr2)), write('.'), nl
    )
  ; true
  ),
  ( \+ Y1 = Y2, K2 is random(2)+1,
    ( K2 = 1, Y1n is -Y1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1n,Z1]],
      TR2new = TR2, write(changed(T,A,nr,Nr1)), write('.'), nl
    ; K2 = 2, Y2n is -Y2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2n,Z2]],  
      TR1new = TR1, write(changed(T,A,nr,Nr2)), write('.'), nl
    )
  ; true
  ),
  ( \+ Z1 = Z2, K3 is random(2)+1, 
    ( K3 = 1, Z1n is -Z1, TR1new = [Nr1,[A1,B1,Ob1],[X1,Y1,Z1n]],
      TR2new = TR2, write(changed(T,A,nr,Nr1)), write('.'), nl
    ; K3 = 2, Z2n is -Z2, TR2new = [Nr2,[A2,B2,Ob2],[X2,Y2,Z2n]],  
      TR1new = TR1, write(changed(T,A,nr,Nr2)), write('.'), nl
    )
  ; true
  ),
  stored(R,T,list_of_triades(LISTL)),
  append('res4221.pl'),
  ( TR1 = TR1new,
    delete(LISTL,TR2,LISTL1), 
    append(LISTL1,[TR2new],LISTL2),
    nl, write(stored(R,T,list_of_triades(LISTL2))), write('.'), nl 
  ;
    TR2 = TR2new,
    delete(LISTL,TR1,LISTL1), 
    append(LISTL1,[TR1new],LISTL2),
    nl, write(stored(R,T,list_of_triades(LISTL2))), write('.'), nl
  ),
  told,
  retract(stored(R,T,list_of_triades(LISTL))),
  asserta(stored(R,T,list_of_triades(LISTL2))),!.
*/

