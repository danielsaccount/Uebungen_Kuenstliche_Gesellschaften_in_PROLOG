:- dynamic fact/3 .


% autopara352.pl (file of parameters for SMASS, which can partially automatically generated)


% basic constants (cannot be changed) ------------------------
  
modes([donothin,schellin,takeweak]).
use_old_data(no). 
variables_in_rule(donothin,[wealth_dono]).
variables_in_rule(schellin,[location,colour]).
variables_in_rule(takeweak,[location,strength,wealth_take]).
type_of_neighbourhood(schellin,moore,1).  
type_of_neighbourhood(takeweak,von_Neumann,2).


% proper constants ---------------------------

list_of_predicates([runs,periods,actors,exist_min,domain_of_values]).
list_of_domains([[2,3],[2,3],[4,5],[5],[10,11]]).
display_world([3,2,5,5,10],2). /* ...],Y), Y is the chosen run number  Y */

/* a variant
list_of_vectors([[1,2,5],[2,5,6],[4,7,10],[5,20],[10,20]]). */

% graphical contants (depended on basic constants) -----------------------

height(donothin,175).
height(schellin,170).
height(takeweak,200).
magnify_by(0.2).
gridwidth(4). 
size_of_boxes(10).



% dynamic constants (are changed relatively to the basic constants, and relative to
% an action type) 
%--------------------------------------------------

a(weights(donothin,2,[50,101])). 
a(weights(schellin,1,[101])).
a(weights(takeweak,1,[101])). 
a(domain_of_wealth_dono(50,500)). a(sigma_wealth_dono(20)). 
a(domain_of_wealth_take(100,200)). a(sigma_wealth_take(30)). 
a(weights(strength,[70,101])).

a(expressions(strength,2)).




