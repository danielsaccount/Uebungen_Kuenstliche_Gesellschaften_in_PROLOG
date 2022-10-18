% create422.pl (for theory of Heider)

make(triade) :-
   actors(AS), objects(OO),
   NP is ceiling((1/2)*((AS*AS)-AS)), 
   make_pot_pairs(AS),
   asserta(list_of_pairs([])),
   asserta(list_of_triades([])),
   ( between(1,NP,N), generate_a_pair(N,NP,AS,OO), fail; true),!,
   list_of_pairs(LIST1), list_of_triades(LIST_TR),
   append('data422.pl'), 
   write(stored(0,0,list_of_triades(LIST_TR))), write('.'), nl,nl,
   told,
   retract(list_of_pairs(LIST1)).

generate_a_pair(N,NP,AS,OO) :-
  list_of_pairs(LIST1), list_pot_pairs(LIST2), length(LIST2,E2),
  S is random(E2)+1, nth1(S,LIST2,[A,B]),
  expand_to_a_triade([A,B],OO,N),
  delete(LIST2,[A,B],LIST2new), retract(list_pot_pairs(LIST2)), 
  asserta(list_pot_pairs(LIST2new)),
  append(LIST1,[[A,B]],LIST1new),
  retract(list_of_pairs(LIST1)),
  asserta(list_of_pairs(LIST1new)),!.

expand_to_a_triade([A,B],OO,N) :-
   Ob is random(OO)+1,
   Q1 is random(2)+1, Q2 is random(2)+1, Q3 is random(2)+1,
   list_of_triades(LIST_TR), 
   (Q1 = 1 , W1 is 1 ; Q1 = 2, W1 is -1),
   (Q2 = 1 , W2 is 1 ; Q2 = 2, W2 is -1),
   (Q3 = 1 , W3 is 1 ; Q3 = 2, W3 is -1),
   TR = [N,[A,B,Ob],[W1,W2,W3]],
   append(LIST_TR,[TR],LIST_TRnew),
   retract(list_of_triades(LIST_TR)), 
   asserta(list_of_triades(LIST_TRnew)),!.
  
% ---------------------------------------------------

make_characters(AS,L) :- build_up_characters(AS,L), export_results(AS).

build_up_characters(AS,L) :- length(L,E),
  ( between(1,E,X), make_distribution(X,L,E,AS), fail ; true ),
  ( between(1,AS,A), collect_characters(L,E,A), fail ; true),    
  retractall(dd_expr(M1,M2,M3)), !. 
 
make_distribution(X,L,E,AS) :- nth1(X,L,M), weights(M,EX,LIST),
  make_discrete_distribution(M,AS,EX,LIST), !.

collect_characters(L,E,A) :- asserta(character(A,[])),
  ( between(1,E,X), nth1(X,L,M), add_character(M,A), fail; true ),!.

add_character(M,A) :- dd_expression(M,A,C), character(A,L1), append(L1,[C],L2),
  retract(character(A,L1)), asserta(character(A,L2)),!.

export_results(AS) :- ( between(1,AS,A), export_res(A), fail; true),!.

export_res(A) :- character(A,L2), calculate_sum(L2,SUM), 
  append('data422.pl'),
  write(stored(0,0,character(A,L2,SUM))), write('.'), nl,  told,
  retract(character(A,L2)),!.
