/* Eine ältere Version von SMASS */

:- multifile fact/3 .


% "sim" (basic programm for SMASS)
/* some new lines unite the list of variables  */

start:- 
  consult(para), consult(pred), consult(rules), consult(display),

  check_inconsistent_parameters,
  ( exists_file(results), delete_file(results)
  ;
    true
  ), 
  ( exists_file(data), delete_file(data)
  ;
    true
  ), 

  modes(L), make_list_of_variables(L,LV), 


  make_reduced_list_of_variables(L,LV,RLV),
  use_old_data(X),
  (   X = no,

              create_data(L,RLV)
  ;   X = yes, consult(data) 
  ), 
  begin.

check_inconsistent_parameters :- actors(AS),
    gridwidth(G), G1 is G*G, 
   ( AS =< G1
   ;
     G1 < AS, write(too_many_actors_for_the_grid), fail
   ).

make_list_of_variables(L,LV) :- asserta(list_of_variables([])), 
   length(L,E),
   (  between(1,E,NM), build_list_of_variables(NM,L), fail ;  true ), 
   list_of_variables(LV), retract(list_of_variables(LV)),!.
 
build_list_of_variables(NM,L) :- nth1(NM,L,M), variables_in_rule(M,LM),
  list_of_variables(LVdyn), append(LVdyn,LM,Lnew),   
  retract(list_of_variables(LVdyn)), asserta(list_of_variables(Lnew)),!.

make_reduced_list_of_variables(L,LV,RLV) :-
  length(LV,EV), 
  asserta(list_of_variables([])),                                              
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
  consult(create),
  make_global_data(L),
  length(RLV,EV),                                                                
  ( between(1,EV,NV), nth1(NV,RLV,VAR), make(VAR), fail  ; true ),
  retractall(int_loc(WW1,WW2,WW3)),  /* muss verallgemeinert werden */
  !.      

make_global_data(L) :- actors(AS), make_characters(AS,L).     

% ----------------------------------------------------------------------------------------------------         

begin :- runs(RR), periods(TT),
   (  between(1,RR,R), mainloop(R,TT), fail;  true ), !,
    make_pictures.

mainloop(R,TT) :-
  consult(data),
  findall(X,fact(0,0,X),L), length(L,E),
  (   between(1,E,Z), nth1(Z,L,FACT), append(results),
      write(fact(R,1,FACT)), write('.'), nl, told, 
      asserta(fact(R,1,FACT)), retract(fact(0,0,FACT)), fail
  ;   true 
  ), append(results), nl, told,
  (  between(1,TT,T), kernel(R,T), fail;  true ),
  retract_facts,!.


retract_facts :- ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail; true ).

kernel(R,T) :- 
  prepare_indivi(R,T),
  actors(AS), findall(I,between(1,AS,I),L),
  asserta(actor_list(L)),
  ( between(1,AS,N), choose_and_activate_actor(R,T,N), fail
  ;
    true 
  ), retract(actor_list(L1)),
  adjust(R,T),!.

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
   ), !.                                           

check_environment(R,T,A) :- true.                             

execute_protocols(R,T,A) :- protocol(M,A,R,T).

adjust(R,T) :- modes(L),
  length(L,E), actors(AS),
  ( between(1,E,X), individual_adjust(X,R,T,AS,L), fail; true ),
  global_adjust(R,T),
  append(results), nl, told,!.

individual_adjust(X,R,T,AS,L) :- nth1(X,L,Z),
  ( between(1,AS,A), adjust(Z,A,R,T), fail ; true),!,
  adjust(Z,R,T).          

global_adjust(R,T) :- T1 is T+1, repeat,
   ( fact(R,T,FACT), retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),
     append(results), write(fact(R,T1,FACT)), write('.'), nl, told,
     fail
  ; true 
  ),!.

choosemode(R,T,A,M) :- 
   fact(R,T,character(A,C,SUM)), length(C,K),
   modes(L),
   Z is random(SUM * 1000)+1, asserta(aux_sum(0)),    
   between(1,K,X), do1(X,Z,C,Y), Z =< Y , nth1(X,L,M),
   retract(aux_sum(SS)),!.                           
   
do1(X,Z,C,Y) :- aux_sum(S), nth1(X,C,C_X), Y is S + (C_X * 1000),
   retract(aux_sum(S)), asserta(aux_sum(Y)),!.  

% -------------------------------------------------------------------------------------

make_pictures :- modes(LM), length(LM,EM), 
  consult(results),  /* this file should be reduced */ 
  ( between(1,EM,NM), nth1(NM,LM,MOD), make_picture(MOD), fail ; true),!.

