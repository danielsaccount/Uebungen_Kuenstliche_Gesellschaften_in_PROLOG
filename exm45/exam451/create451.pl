% create451.pl

make_a_tree :-
  asserta(tree([[1,[0,1]]])), asserta(end_line([1])),
  number_of_groups(NUMBER_OF_GROUPS), 
  number_of_decisions(NUMBER_OF_DECISIONE),
  make_a_tree(1,20,3),
  tree(TREE), end_line(ENDLINE),
  append('res4513.pl'), write(tree(TREE)), write('.'), nl, nl,
  write(end_line(ENDLINE)), write('.'), nl, nl, told,
  make_dependencies(TREE),!.

make_a_tree(GG,GG,LIST_OF_DECISIONS). 
make_a_tree(G,GG,LIST_OF_DECISIONS) :-
  G =< GG,
  add_points(G,GG,LIST_OF_DECISIONS,GY),
  Gnew is GY, 
  ( Gnew =< GG, make_a_tree(Gnew,GG,LIST_OF_DECISIONS) ; true),!.

add_points(G,GG,LIST_OF_DECISIONS,GY) :- 
  tree(TREE), end_line(END),
  length(END,E), X is random(E) + 1, nth1(X,END,G1), 
  nth1(G1,TREE,[G1,LL]), GGn is GG - 1,
  ( G = GGn, Y is 1 ; G < GGn, Y1 is min(GG - G,LIST_OF_DECISIONS),
    Y is random(Y1) + 1 ), 
  GY is G + Y,
  ( between(1,Y,Z), add_one_point(Z,G,G1), fail; true),
  end_line(END1), delete(END1,G1,ENDnew), retract(end_line(END1)),
  asserta(end_line(ENDnew)),!.

add_one_point(Z,G,G1) :-
  tree(TREE), end_line(END1),
  Gnew is G + Z,
  append(TREE,[[Gnew,[G1,Gnew]]],TREEnew),
  retract(tree(TREE)), asserta(tree(TREEnew)),
  append(END1,[Gnew],ENDnew), 
  retract(end_line(END1)), asserta(end_line(ENDnew)),!.
   
%---------------------------------------------------

make_dependencies(TREE) :- 
  length(TREE,E), 
  findall(G,nth1(X,TREE,[X,[G,X]]),LIST1), delete(LIST1,0,LIST2), 
  sort(LIST2,LIST3), length(LIST3,E3), nth1(E3,LIST3,NGmax), 
  asserta(max_driver(NGmax)), asserta(dependencies([])), 
  append('res4513.pl'), nl, write(max_driver(NGmax)), write('.'), nl, told, 
  ( between(1,E3,X), make_depend(X,LIST3,TREE), fail; true),
  dependencies(LL2), asserta(dependencies(LL2)),
  append('res4513.pl'), nl, write(dependencies(LL2)), write('.'), nl , nl,
  told,!.

make_depend(X,LIST4,TREE) :- nth1(X,LIST4,G),
  dependencies(LIST5), findall(Y,nth1(Y,TREE,[Y,[G,Y]]),LL1),
  append(LIST5,[[G,LL1]],LIST6), retract(dependencies(LIST5)),
  asserta(dependencies(LIST6)),!.  

% -----------------------------------
 
make_branches(TREE) :-
  asserta(branches([[1]])), length(TREE,E),
  ( between(1,E,X), make_branches(X,TREE), fail; true),
  branches(BL), asserta(branches(BL)),
  append('res4515.pl'), write(branches(BL)), write('.'), nl, nl, told,!.

make_branches(X,TREE) :- branches(BL), nth1(X,TREE,[A,[B,C]]),
  length(BL,EB),
  ( between(1,EB,Y),  analyse(Y,B,C,BL), fail; true),!.

analyse(Y,B,C,BL) :- nth1(Y,BL,BR), length(BR,EBR), nth1(EBR,BR,B),
  append(BR,[C],BRnew), append(BL,[BRnew],BLnew), retract(branches(BL)),
  asserta(branches(BLnew)),!.

% ---------------------------------------------

make_status(GG,DEP_L) :-
  branches(BRLIST), asserta(aux_list([])),
  ( between(1,GG,NG), add_lengths(NG,BRLIST), fail; true),
  aux_list(LL), sort(LL,LLnew), length(LLnew,E1), nth1(E1,LLnew,MAX),
  retract(aux_list(LL)),
  ( between(1,GG,NG), make_one_status(NG,BRLIST,MAX), fail; true),!.

make_one_status(NG,BRLIST,MAX) :- nth1(NG,BRLIST,BR), length(BR,E),
  nth1(E,BR,G),
  S is MAX - (E - 1),
  asserta(status(G,S)), 
  append('res4515.pl'), write(status(G,S)), write('.'), nl, told,!.

add_lengths(NG,BRLIST) :- aux_list(L), nth1(NG,BRLIST,BR), length(BR,E),
  append(L,[E],Lnew), retract(aux_list(L)), asserta(aux_list(Lnew)),!.

% -----------------------------------------------------

make_actorlists(AA,GG,INTERVALS) :-
  asserta(dyn1([1,AA])), DY is GG - 1,
  ( between(1,DY,N), add_one_random_number(N,AA), fail; true),
  dyn1(LIST), sort(LIST,LISTn), length(LISTn,En), 
  ( En = AA, asserta(intlists([[1,1]]))
  ;
    En < AA, nth1(2,LISTn,B), asserta(intlists([[1,B]]))
  ),
  ( between(2,GG,Y), calcul(Y,AA,LISTn), fail; true),
  intlists(INTERVALS), retract(intlists(INTERVALS)),
  retract(dyn1(DDD)),
  append('res4512.pl'), write(actor_intervals(INTERVALS)), write('.'), nl, 
  nl, told,!.

calcul(Y,AA,LISTn) :- intlists(INTLISTS),
   nth1(Y,LISTn,IY), IYnew is IY + 1, Ynew is Y + 1,
   nth1(Ynew,LISTn,IYnn),
   append(INTLISTS,[[IYnew,IYnn]],INTLISTSn), retract(intlists(INTLISTS)),
   asserta(intlists(INTLISTSn)),!.

add_one_random_number(N,AA) :- 
  dyn1(LIST), 
  repeat, X is random(AA) + 1, 
  \+ nth1(J,LIST,X), 
  append(LIST,[X],LISTnew), retract(dyn1(LIST)), asserta(dyn1(LISTnew)),!. 

% -------------------------------------------------------

fill_groups(AA,GG,INTERVALS) :- 
  asserta(aux_actorlist([])), asserta(list_of_groups([])),
  ( between(1,GG,N), make_group_list(N,AA,INTERVALS),fail; true),!,
  aux_actorlist(AAA),  retract(aux_actorlist(AAA)),
  list_of_groups(GGG), asserta(list_of_groups(GGG)),
  append('res4512.pl'), write(list_of_groups(GGG)), write('.'), nl, 
  nl, told,!.

make_group_list(N,AA,INTERVALS) :- 
  aux_actorlist(ACTORLIST), asserta(aux_list([])),
  make_sublist(N,INTERVALS,AA), aux_list(LIST), retract(aux_list(LIST)), 
  list_of_groups(GLIST),
  append(GLIST,[LIST],GLISTnew), retract(list_of_groups(GLIST)),
  asserta(list_of_groups(GLISTnew)), append(ACTORLIST,LIST,ACTORLISTnew),
  retract(aux_actorlist(ACTORLIST)),
  asserta(aux_actorlist(ACTORLISTnew)),!.

make_sublist(N,INTERVALS,AA) :- 
  nth1(N,INTERVALS,[K1,K2]),
  ( between(K1,K2,X), add_one_actor(X,AA), fail; true),!.
 
add_one_actor(X,AA) :- aux_actorlist(ACTORLIST),
  repeat,
  A is random(AA) + 1, \+ member(A,ACTORLIST), 
  aux_list(LIST), append(LIST,[A],LISTnew),
  retract(aux_list(LIST)), asserta(aux_list(LISTnew)),
  append(ACTORLIST,[A],ACTORLISTnew),   retract(aux_actorlist(ACTORLIST)), 
  asserta(aux_actorlist(ACTORLISTnew)),!.

% ------------------------------------------------------

make_production_constants(GG) :-                                          /* 1 */
  production_constants_max(MIN), MPP is 100 - MIN,                      /* 1.1 */
  append('res4513.pl'), nl, nl, told, 
  ( between(1,GG,NG), make_prod_const(NG,MPP), fail; true),!.

make_prod_const(NG,MPP) :- PGC is random(MPP) + 1, 
  asserta(production_constant(NG,PGC)),                                 /* 1.2 */
  append('res4513.pl'), write(production_constant(NG,PGC)), write('.  '), told,!. 

% --------------------------------------------
  
make_individual_accounts(AA) :- 
  calibration_constant(RC), moral_constant(MC), 
  list_of_groups(GGG), length(GGG,EG), 
  ( between(1,EG,NG), make_gen_account(NG,RC,MC,GGG), fail; true),!.

make_gen_account(NG,RC,MC,GGG) :-  
  nth1(NG,GGG,G), length(G,L), 
  (  between(1,L,NA), make_individual_account(NA,RC,MC,NG,G), fail; true),!.

make_individual_account(NA,RC,MC,NG,G) :- nth1(NA,G,A), X is random(MC) + 1,
  status(NG,S), W is X * S, asserta(individual_account(1,A,W)),
  append('res4512.pl'), write(individual_account(1,A,W)), write('.'), nl, told,!.

% -----------------------------------------------

make_exist_minimum(GG,GGG) :- 
  ( between(1,GG,NG), make_group_eximin(NG,GGG), fail; true),!.
make_group_eximin(NG,GGG) :- nth1(NG,GGG,LG), length(LG,EXIMIN), 
 asserta(exist_minimum(NG,EXIMIN)),!. 

% ------------------------------------------------

make_group_accounts(GG,AA,GGG) :- 
 list_of_groups(GGG), length(GGG,EL), 
 ( between(1,EL,NG), nth1(NG,GGG,G), length(G,E), 
   make_group_account(G,E,NG), fail; true),!.

make_group_account(G,E,NG) :- asserta(aux_list(0)),
   ( between(1,E,NA), add_group_account(NA,G), fail; true),
   aux_list(SUM), production_constant(NG,P), WG is SUM * P,
   asserta(group_account(1,NG,WG)),
   append('res4513.pl'), write(group_account(1,NG,WG)), write('.'), nl, told,!.

add_group_account(NA,G) :-  nth1(NA,G,A), individual_account(1,A,W), aux_list(SUM),
  SUMnew is SUM + W, retract(aux_list(SUM)), asserta(aux_list(SUMnew)),!.

% ------------------------------------
 
make_action_typs(GG) :- 
  dependencies(DEP_L), length(DEP_L,E), asserta(list_of_agtyps([])),
  ( between(1,E,NC), make_typs(NC,DEP_L), fail; true),
  list_of_agtyps(LL), asserta(list_agtyps(LL)),
  append('res4513.pl'), nl, nl, write(list_agtyps(LL)), write('.'), nl, told,!.

make_typs(NC,DEP_L) :- nth1(NC,DEP_L,COMP), COMP = [G,LG], length(LG,ELG),
  asserta(comp([actup(G),[]])),
  ( between(1,ELG,NGC), add_typ(NGC,LG), fail; true),
  comp(CC), list_of_agtyps(LAGT), append(LAGT,[CC],LAGTnew),
  retract(comp(CC)), retract(list_of_agtyps(LAGT)), 
  asserta(list_of_agtyps(LAGTnew)),!.  

add_typ(NGC,LG) :- nth1(NGC,LG,G1), comp([X,LL]), append(LL,[atcdo(G1)],LLnew),
  retract(comp([X,LL])), asserta(comp([X,LLnew])),!. 

% --------------------------------------

make_exist_minimum(NUMBER_OF_GROUPS) :- 
  minimal_existence(MIN),
  append('res4513.pl'), nl, nl, told,  
  ( between(1,NUMBER_OF_GROUPS,NG), make_exist_ming(NG,MIN), fail; true),!.
make_exist_ming(NG,MIN) :- status(NG,S), X is random(MIN) + 1,
  EX is X * S, asserta(exist_minimum(NG,EX)),
  append('res4513.pl'), write(exist_minimum(NG,EX)), write('.  '), told,!.  

% --------------------------------------------------- 

