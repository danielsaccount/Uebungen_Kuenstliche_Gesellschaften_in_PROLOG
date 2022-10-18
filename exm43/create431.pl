% "create431.pl , krisen

:- dynamic fact/3 .

make_characters(AS,L) :- build_up_characters(AS,L),
   export_results(AS).

build_up_characters(AS,L) :- length(L,E), 
  ( between(1,E,X), make_distribution(X,L,E,AS), fail ; true ),
  ( between(1,AS,A), collect_characters(L,E,A), fail ; true),    
  retractall(dd_expr(M1,M2,M3)), !. 
 
make_distribution(X,L,E,AS) :- nth1(X,L,M), weights(M,EX,LIST),
  make_discrete_distribution(M,AS,EX,LIST), !.

collect_characters(L,E,A) :- asserta(character(A,[])),
  ( between(1,E,X), nth1(X,L,M), add_character(M,A), fail; true ),!.

add_character(M,A) :- dd_expr(M,A,C), character(A,L1), append(L1,[C],L2),
  retract(character(A,L1)), asserta(character(A,L2)),!.

export_results(AS) :- ( between(1,AS,A), export_res(A), fail; true),!.

export_res(A) :- character(A,L2), calculate_sum(L2,SUM), 
  append('data431.pl'),
  write(fact(0,0,character(A,L2,SUM))), write('.'), nl,  told,
  retract(character(A,L2)),!.


% ------------------------------------------------------------------------------


make(strength) :- actors(AS), weights(strength,EX,LIST),              
   make_discrete_distribution(strength,AS,EX,LIST),
   (  between(1,AS,A), dd_expr(strength,A,W), 
      append('data431.pl'),
      write(fact(0,0,strength(A,W))), write('.'), nl, told,  
      retract(dd_expr(strength,A,W)), fail
   ; true 
   ),!. 
         
make(history) :- 
   actors(AS),        
   ( between(1,AS,A), make_history(A), fail ; true),!.

make_history(A) :- 
  append('data431.pl'), write(fact(0,0,history(A,[[0,0]]))), write('.'), nl, told,!.

% bedeutet: A fuehrt eine "leere" Aktion 0 gegen (den DUmmy) 0 aus
% z.B. 0 "=" threat, 0 = B 

make(aggression) :- actors(AS), weights(aggression,EX,LIST),
    make_discrete_distribution(aggression,AS,EX,LIST),
   (  between(1,AS,A), dd_expr(aggression,A,W), 
      append('data431.pl'),
      write(fact(0,0,aggression(A,W))), write('.'), nl, told,  
      retract(dd_expr(aggression,A,W)), fail
   ; true 
   ),!. 