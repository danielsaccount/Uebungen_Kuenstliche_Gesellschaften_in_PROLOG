% para363.pl (file of parameters for SMASS)

% proper constants ---------------------------

runs(2). 
periods(5).
number_of_actors(7).
gridwidth(4).  
exist_min(20).
size_of_boxes(10).


% boolean constants  -----------------------------------------
 
modes([takeweak]).
use_old_data(no). 
variables_in_rule(takeweak,[location,strength,wealth]).

weights(takeweak,1,[101]).  
type_of_neighbourhood(takeweak,von_Neumann,2).
choose_run(2).

% constants relative to an action type -----------------------
       
magnify_by(6).
domain_of_wealth_take(100,200).
sigma_wealth_take(30). 
expressions(strength,2).
weights(strength,[70,101]).
domain_of_values(20).  /* a better name ?? */
height(takeweak,200).


