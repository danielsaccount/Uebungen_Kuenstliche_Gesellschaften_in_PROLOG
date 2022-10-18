% dynsim352.pl (basic programm for SMASS)
% some new lines unite the list of variables  

:- dynamic fact/3 .
% :- multifile fact/3 .


dynstart(VWK):- 
  consult('para352.pl'),
  check_inconsistent_parameters,
  ( exists_file('data352.pl'), delete_file('data352.pl') ; true ), 
  modes(L), make_list_of_variables(L,LV), 
  make_reduced_list_of_variables(L,LV,RLV),
  use_old_data(X),
  (   X = no, create_data(L,RLV) 
  ;   X = yes, consult('data352.pl') 
  ), 
  begin(VWK).

check_inconsistent_parameters :- actors(AS), gridwidth(G), G1 is G*G, 
   ( AS =< G1
   ;
     G1 < AS, write(too_many_actors_for_the_grid), fail
   ).

make_list_of_variables(L,LV) :- asserta(list_of_variables([])), length(L,E),
   (  between(1,E,NM), build_list_of_variables(NM,L), fail ;  true ), 
   list_of_variables(LV), retract(list_of_variables(LV)),!.
 
build_list_of_variables(NM,L) :- nth1(NM,L,M), variables_in_rule(M,LM),
  list_of_variables(LVdyn), append(LVdyn,LM,Lnew),   
  retract(list_of_variables(LVdyn)), asserta(list_of_variables(Lnew)),!.

make_reduced_list_of_variables(L,LV,RLV) :-
  length(LV,EV), asserta(list_of_variables([])),                                              
  ( between(1,EV,NV), minimize_list_of_variables(NV,LV), fail ; true),!,                           
  list_of_variables(RLV), retract(list_of_variables(RLV)),!.

minimize_list_of_variables(NV,LV) :- list_of_variables(LVdyn),                           
      nth1(NV,LV,V),                                                                         
     (  member(V,LVdyn)                                                                     
     ;
        append(LVdyn,[V],LVnew),
        retract(list_of_variables(LVdyn)),                
        asserta(list_of_variables(LVnew))       
     ),!.
   
create_data(L,RLV) :-
  consult('create352.pl'),
  make_global_data(L),
  length(RLV,EV),   
  ( between(1,EV,NV), nth1(NV,RLV,VAR), make(VAR), fail  ; true ),
  retractall(int_loc(WW1,WW2,WW3)),  
  !.      

make_global_data(L) :- actors(AS), make_characters(AS,L).     

% ---------------------------------------------------------

begin(VWK) :- 
   runs(RR), periods(TT),
   (  between(1,RR,R), mainloop(R,TT,VWK), fail;  true ), !.

mainloop(R,TT,VWK) :- 
  consult('data352.pl'),
  findall(X,fact(0,0,X),L), length(L,E),
  (   between(1,E,Z), nth1(Z,L,FACT), append('res352.pl'),
      write(fact(VWK,R,1,FACT)), write('.'), nl, told, 
      asserta(fact(R,1,FACT)), retract(fact(0,0,FACT)), fail
  ;   true 
  ), append('res352.pl'), nl, told,
  (  between(1,TT,T), kernel(R,T,VWK), fail;  true ),
  retract_facts,!.

retract_facts :- ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail; true ).

kernel(R,T,VWK) :- 
  prepare_indivi(R,T),
  actors(AS), findall(I,between(1,AS,I),L),
  asserta(actor_list(L)),
  ( between(1,AS,N), choose_and_activate_actor(R,T,N), fail
  ;
    true 
  ), retract(actor_list(L1)),
  adjust_dyn(R,T,VWK),!.

prepare_indivi(R,T) :- modes(LM), length(LM,EM),
  ( between(1,EM,NM), nth1(NM,LM,MOD), prepare(R,T,MOD), fail ; true),!.

choose_and_activate_actor(R,T,N) :- actor_list(L), length(L,E),
  Y is random(E)+1, nth1(Y,L,A), activate(R,T,A), delete(L,A,L1),
   retract(actor_list(L)), asserta(actor_list(L1)),!.

activate(R,T,A) :- check_environment(R,T,A),
  (   execute_protocols(R,T,A)                 
  ;                                                      
      choosemode(R,T,A,M),                
      ( act_in_mode(M,A,R,T) ; true)        
   ),!.                                           

check_environment(R,T,A) :- true.                             

execute_protocols(R,T,A) :- protocol(M,A,R,T).

adjust_dyn(R,T,VWK) :- modes(L), length(L,E), actors(AS),
 ( between(1,E,X), individual_adjust(X,R,T,AS,L), fail; true ),
  global_adjust_dyn(R,T,VWK), append('res352.pl'), nl, told,!.

individual_adjust(X,R,T,AS,L) :- nth1(X,L,Z),
  ( between(1,AS,A), adjust(Z,A,R,T), fail ; true),!,
  adjust(Z,R,T).          

global_adjust_dyn(R,T,VWK) :- T1 is T+1, repeat,
   ( fact(R,T,FACT), retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),
     append('res352.pl'), write(fact(VWK,R,T1,FACT)), write('.'), nl, told,
     fail
  ; true 
  ),!.

choosemode(R,T,A,M) :- 
   fact(R,T,character(A,C,SUM)), length(C,K),
   modes(L), Z is random(SUM * 1000)+1, asserta(aux_sum(0)),    
   between(1,K,X), do1(X,Z,C,Y), Z =< Y , nth1(X,L,M),
   retract(aux_sum(SS)),!.                           
   
do1(X,Z,C,Y) :- aux_sum(S), nth1(X,C,C_X), Y is S + (C_X * 1000),
   retract(aux_sum(S)), asserta(aux_sum(Y)),!.  





