% rules431.pl (the action rules in SMASS)

:- dynamic fact/3 .

% RULE 1: threat 

prepare(R,T,threat) :- true.

act_in_mode(threat,A,B,R,T) :-                                         /* 9.12 */
   feasible(threat,A,B,R,T,X),                                       /* 9.12.1 */
   chooseaction(threat,A,B,R,T),                                     /* 9.12.2 */
   perform(threat,A,B,R,T,X),!.                                      /* 9.12.3 */
   
feasible(threat,A,B,R,T,X) :-                                        /* 9.12.1 */
   fact(R,T,strength(A,SA)), fact(R,T,strength(B,SB)),             /* 9.12.1.1 */
   ( SB < SA, X = 0                                                /* 9.12.1.2 */
   ;
     SA =< SB, X = 1                                               /* 9.12.1.3 */
   ),!.

chooseaction(threat,A,B,R,T) :- true.   
 
perform(threat,A,B,R,T,X) :-                                         /* 9.12.3 */
    fact(R,T,history(A,H)),                                        /* 9.12.3.1 */
    ( X = 0, append(H,[[threat,B]],Hnew)                           /* 9.12.3.2 */
    ;
      X = 1, append(H,[[do_not,B]],Hnew)                        /* 9.12.3.3 */
    ),
    retract(fact(R,T,history(A,H))), 
    asserta(fact(R,T,history(A,Hnew))),!.                          /* 9.12.3.4 */
      
protocol(threat,A,B,R,T) :- fail. 

adjust(threat,A,R,T) :- true.
adjust(threat,R,T) :- true.        

% -------------------------------------------------------------------------------

% RULE 2: appease

prepare(R,T,appea) :- true.

act_in_mode(appea,A,B,R,T) :- feasible(appea,A,B,R,T),
   chooseaction(appea,A,B,R,T), perform(appea,A,B,R,T),!.

feasible(appea,A,B,R,T) :- true.
chooseaction(appea,A,B,R,T) :- true.

perform(appea,A,B,R,T) :- 
   fact(R,T,history(A,H)), append(H,[[appea,B]],Hnew),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.

protocol(appea,A,B,R,T) :- fail.  

adjust(appea,A,R,T) :- true.
adjust(appea,R,T) :- true.

% --------------------------------------------------------------

% RULE 3: attack 

prepare(R,T,attack) :- true.

act_in_mode(attack,A,B,R,T) :- 
  feasible(attack,A,B,R,T,X),
  chooseaction(attack,A,B,R,T),
  perform(attack,A,B,R,T,X).  

feasible(attack,A,B,R,T,X) :- 
    ( fact(R,T,strength(A,SA)), fact(R,T,strength(B,SB)),
      SB/3 < SA, X = 0
    ;
      X = 1
    ),!.

chooseaction(attack,A,B,R,T) :- true.                 
    
perform(attack,A,B,R,T,X) :- 
   fact(R,T,history(A,H)), 
   ( X = 0, append(H,[[attack,B]],Hnew)
   ;
     X = 1, append(H,[[do_not,B]],Hnew)
   ),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.
  
protocol(A,R,T) :- fail.

adjust(attack,A,R,T) :- true.
adjust(attack,R,T) :- true.

% --------------------------------------------------------------------------

% RULE 4: defend

prepare(R,T,defend) :- true.

act_in_mode(defend,A,B,R,T) :- 
  feasible(defend,A,B,R,T,X),
  chooseaction(defend,A,B,R,T),
  perform(defend,A,B,R,T,X).  

feasible(defend,A,B,R,T,X) :- 
    ( fact(R,T,strength(A,SA)), fact(R,T,strength(B,SB)),
      SA < SB/3, X = 0 
    ;
      X = 1
    ),!.
  
chooseaction(defend,A,B,R,T) :- true.                 
    
perform(defend,A,B,R,T,X) :- 
   fact(R,T,history(A,H)), 
   ( X = 0, append(H,[[defend,B]],Hnew)
   ;
     X = 1, append(H,[[do_not,B]],Hnew)
   ),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.
    
protocol(defend,A,R,T) :- fail.

adjust(defend,A,R,T) :- true.

adjust(defend,R,T) :- true.

% --------------------------------------------------------------------------

% RULE 5: surrender

prepare(R,T,surren) :- true.

act_in_mode(surren,A,B,R,T) :- 
  feasible(surren,A,B,R,T),
  chooseaction(surren,A,B,R,T),
  perform(surren,A,B,R,T).  

feasible(surren,A,B,R,T) :- true.
            
chooseaction(surren,A,B,R,T) :- true.                 
    
perform(surren,A,B,R,T) :- 
   fact(R,T,history(A,H)), append(H,[[surren,B]],Hnew),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.
 
protocol(surren,A,R,T) :- fail.

adjust(surren,A,R,T) :- true.

adjust(surren,R,T) :- true.

% --------------------------------------------------------------------------

% RULE 6: conqu

prepare(R,T,conqu) :- true.

act_in_mode(conqu,A,B,R,T) :- 
  feasible(conqu,A,B,R,T,X),
  chooseaction(conqu,A,B,R,T),
  perform(conqu,A,B,R,T,X).  

feasible(conqu,A,B,R,T,X) :- 
    ( fact(R,T,strength(A,SA)), fact(R,T,strength(B,SB)),
      SA < SB/5, X = 0 
    ;
      X = 1
    ),!.
           
chooseaction(conqu,A,B,R,T) :- true.                 
    
perform(conqu,A,B,R,T,X) :- 
   fact(R,T,history(A,H)), 
   ( X = 0, append(H,[[conqu,B]],Hnew)
   ;
     X = 1, append(H,[[do_not,B]],Hnew)
   ),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.
 
protocol(conqu,A,R,T) :- fail.

adjust(conqu,A,R,T) :- true.

adjust(conqu,R,T) :- true.

% ------------------------------------------------------------------

% RULE 7: do_nothin

prepare(R,T,do_not) :- true.

act_in_mode(do_not,A,B,R,T) :- 
  feasible(do_not,A,B,R,T),
  chooseaction(do_not,A,B,R,T),
  perform(do_not,A,B,R,T).  

feasible(do_not,A,B,R,T) :- true.
            
chooseaction(do_not,A,B,R,T) :- true.                 
    
perform(do_not,A,B,R,T) :- 
   fact(R,T,history(A,H)), append(H,[[do_not,B]],Hnew),
   retract(fact(R,T,history(A,H))), asserta(fact(R,T,history(A,Hnew))),!.
  
protocol(do_not,A,R,T) :- fail.

adjust(do_not,A,R,T) :- true.

adjust(do_not,R,T) :- true.

