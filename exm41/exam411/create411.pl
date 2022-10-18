/* create411.pl

Dies Modul generiert den Character und weitere Daten. */

:- dynamic fact/3 .

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
  append('data411.pl'),
  write(fact(0,0,character(A,L2,SUM))), write('.'), nl,  told,
  retract(character(A,L2)),!.

% ---------------------------------------------------------------------------------

make(bundle) :- goods(NG), actors(AS),
   ( between(1,NG,G), make_bundle(G,NG), fail ; true),
   ( between(1,AS,A), build_list_bundle(A,NG), fail ; true),
   retractall(nd_expression(bundle,XG,XA,XEXM)),!.

make_bundle(G,NG) :-
   actors(AS), domain_of_bundle(L,U), sigma_bundle(SI), 
   normal_distribution(bundle,AS,L,U,SI),
   ( between(1,AS,A), insert_bundle(A,G), fail; true),!.

insert_bundle(A,G) :-  
     nd_expression(bundle,A,EXM), retract(nd_expression(bundle,A,EXM)),
     asserta(nd_expression(bundle,G,A,EXM)),!. 

build_list_bundle(A,NG) :- asserta(bundle_list([])),   
   ( between(1,NG,X), build_bundle(X,A), fail; true),
   bundle_list(L),
   append('data411.pl'), write(fact(0,0,bundle(A,L))), write('.'), nl, told,!.
       
build_bundle(X,A) :- bundle_list(L), 
   nd_expression(bundle,X,A,EXM), append(L,[EXM],Lneu), 
   retract(bundle_list(L)), asserta(bundle_list(Lneu)),!.

make(value) :- goods(NG), actors(AS),
   ( between(1,NG,G), make_value(G,NG), fail ; true),!,
   ( between(1,AS,A), build_list_value(A,NG), fail ; true),
   retractall(nd_expression(value,XG,XA,XEXM)),!.

make_value(G,NG) :-
   actors(AS), domain_of_value(L,U), sigma_value(SI), 
   normal_distribution(value,AS,L,U,SI),
   ( between(1,AS,A), insert_value(A,G), fail ; true),!.

insert_value(A,G) :-  
     nd_expression(value,A,EXM), retract(nd_expression(value,A,EXM)),
     asserta(nd_expression(value,G,A,EXM)),!. 

build_list_value(A,NG) :- asserta(list_value([])),   
   ( between(1,NG,X), build_value(X,A), fail; true),
   list_value(L),
   append('data411.pl'), write(fact(0,0,value(A,L))), write('.'), nl, told,!.
       
build_value(X,A) :- list_value(L), 
   nd_expression(value,X,A,EXM), append(L,[EXM],Lneu), 
   retract(list_value(L)), asserta(list_value(Lneu)),!.
 
make(exmin) :- actors(AS), goods(NG), 
    weights(exmin,LIST),
    exmin_expressions(EX),
    ( between(1,AS,A), make_exmin(A,NG,LIST,EX), fail ; true),!,
    ( between(1,AS,A), build_list_exmin(A,NG), fail ; true),
    retractall(dd_expression(exmin,XG,XA,XEXM)),!.

make_exmin(A,NG,LIST,EX) :-
    make_discrete_distribution(exmin,NG,EX,LIST),
    ( between(1,NG,G), insert_actor(A,G), fail ; true),!.

insert_actor(A,G) :-
      dd_expression(exmin,G,EXM), retract(dd_expression(exmin,G,EXM)),
      asserta(dd_expression(exmin,G,A,EXM)),!.
  
build_list_exmin(A,NG) :- asserta(list_exmin([])),
   ( between(1,NG,X), build_exmin(X,A), fail; true),
   list_exmin(L),
   append('data411.pl'), write(fact(0,0,exmin(A,L))), write('.'), nl, told,!.
       
build_exmin(X,A) :- list_exmin(L), 
   dd_expression(exmin,X,A,EXM), append(L,[EXM],Lneu), 
   retract(list_exmin(L)), asserta(list_exmin(Lneu)),!.

make(location) :- 
   actors(AS), gridwidth(G), G1 is G*G,    
   findall(X,between(1,G1,X), L), asserta(cell_list(L)),         
   ( between(1,AS,A), locate(A), fail ; true), 
   retractall(cell_list(L2)),
   asserta(fact(0,0,location_created)),!.

locate(A) :- cell_list(L), length(L,E), X is random(E)+1, nth1(X,L,Y),
  gridwidth(G), decompose(Y,I,J,G), 
  append('data411.pl'), write(fact(0,0,location(A,I,J))), write('.'), nl, told,
  asserta(fact(0,0,location(A,I,J))),
  delete(L,Y,L1),
  retract(cell_list(L)), asserta(cell_list(L1)),!.

make(exchange_character) :- actors(AS),
   weights(exchange_character,LIST), 
   exchange_character_expressions(EX),
   make_discrete_distribution(exchange_character,AS,EX,LIST),
   (  between(1,AS,A), dd_expression(exchange_character,A,CH), 
      append('data411.pl'),
      write(fact(0,0,exchange_character(A,CH))), write('.'), nl, told,  
      retract(dd_expression(exchange_character,A,CH)), fail
   ; true 
   ),!. 