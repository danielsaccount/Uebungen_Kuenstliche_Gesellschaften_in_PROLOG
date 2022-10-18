/* exam241  

Eine Liste von Handlungstypen für verschiedene Muster (roles) wird reduziert,
so dass jeder Handlungstyp nur ein Mal vorkommen, und so dass für jedes
Muster aus der reduzierten Liste die "richtigen" Handlungstypen für
das Muster in der "richtigen" Reihenfolge zusammengestellt wird.

Die drei Muster beinhalten folgendes. Das erste Muster "donothing" besagt, dass ein 
Akteur zu einem Tick gar nichts tut. Das zweite Muster "schelling" besagt, dass
Akteur in einem Tick die Handlungen aus führt, die in dem Schelling Modell
ausgeführt werden. Im dritten Muster "only_get" werden Handlungen ausgeführt, mit
denen "ärmere" Akteure systematisch ausgeraubt werden. Diese Muster sind in 1 
vorhanden.

Zum Muster "donothing" wird in 2 genau ein Handlungstyp (tue nichts, wealth_donothing) 
angegeben, zum Muster "schelling" in 3 zwei Handlungstypen: location und colour, und
zum Muster "only_get" drei Handlungstypen: location,strength,take_wealth. Sie sehen,
dass ein Handlungstyp, nämlich "location" in zwei Muster verwendet wird. In diesem Modul
werden Handlungstypen, die mehrfach verwendet werden, in einer reduzierten Liste von
Handlungstypen zusammengefasst.

In 5 wird eine Liste alle Handlungstypen zusammengestellt, die in den Mustern
verwendet werden. Diese Liste LIST_OF_VARIABLES hat im Beispiel die Form
[wealth_donothing,location,colour,location,strength,take_wealth]. In 6
wird diese Liste zu der reduzierte Liste REDUCED_LIST_OF_VARIABLES. Sie hat am
Ende die Form
[wealth_donothing,location,colour,strength,take_wealth]. 
*/

list_of_roles([donothing,schelling,only_get]).                                     /* 1 */
variables_in_role(donothing,[wealth_donothing]).                                   /* 2 */
variables_in_role(schelling,[location,colour]).                                    /* 3 */
variables_in_role(only_get,[location,strength,take_wealth]).                       /* 4 */

start:- 
  trace,
  list_of_roles(LIST_OF_ROLES), 
  make_list_of_variables(LIST_OF_ROLES,LIST_OF_VARIABLES),                         /* 5 */
  make_reduced_list_of_variables(LIST_OF_ROLES,LIST_OF_VARIABLES,REDUCED_LIST_OF_VARIABLES),
                                                                                   /* 6 */
  asserta(reduced_list_of_variables(REDUCED_LIST_OF_VARIABLES)).
 
make_list_of_variables(LIST_OF_ROLES,LIST_OF_VARIABLES) :- 
  asserta(list_of_variables([])), length(LIST_OF_ROLES,LENGTH),
  (  between(1,LENGTH,NUMBER_OF_ONE_ACTION_TYP), 
     build_list_of_variables(NUMBER_OF_ONE_ACTION_TYP,LIST_OF_ROLES), fail 
  ;  
     true 
  ), 
  list_of_variables(LIST_OF_VARIABLES), retract(list_of_variables(LIST_OF_VARIABLES)),!.
 
build_list_of_variables(NUMBER_OF_ONE_ACTION_TYP,LIST_OF_ROLES) :- 
  nth1(NUMBER_OF_ONE_ACTION_TYP,LIST_OF_ROLES,TYP), 
  variables_in_role(TYP,LIST_OF_VARIABLES),
  list_of_variables(LIST_OF_VARIABLESdyn), 
  append(LIST_OF_VARIABLESdyn,LIST_OF_VARIABLES,LISTnew),   
  retract(list_of_variables(LIST_OF_VARIABLESdyn)), 
  asserta(list_of_variables(LISTnew)),!.

make_reduced_list_of_variables(LIST_OF_ROLES,LIST_OF_VARIABLES,REDUCED_LIST_OF_VARIABLES) :-
  length(LIST_OF_VARIABLES,LENGTH1), asserta(list_of_variables([])),                                              
  ( between(1,LENGTH1,VARIABLE_OF_ONE_NUMBER), 
  minimize_list_of_variables(VARIABLE_OF_ONE_NUMBER,LIST_OF_VARIABLES), fail ; true),!,                           
  list_of_variables(REDUCED_LIST_OF_VARIABLES), retract(list_of_variables(REDUCED_LIST_OF_VARIABLES)),!.

minimize_list_of_variables(VARIABLE_OF_ONE_NUMBER,LIST_OF_VARIABLES) :- 
   list_of_variables(LIST_OF_VARIABLESdyn),                                    
   nth1(VARIABLE_OF_ONE_NUMBER,LIST_OF_VARIABLES,VARIABLE),                                                                                         
   (  member(VARIABLE,LIST_OF_VARIABLESdyn)                                                                                   
   ;
      append(LIST_OF_VARIABLESdyn,[VARIABLE],LIST_OF_VARIABLESdynnew),
      retract(list_of_variables(LIST_OF_VARIABLESdyn)),                
      asserta(list_of_variables(LIST_OF_VARIABLESdynnew))                                                      
   ),!.
   


