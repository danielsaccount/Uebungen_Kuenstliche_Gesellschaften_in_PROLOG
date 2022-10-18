% para362.pl (file of parameters for SMASS)

% proper constants ---------------------------

runs(2). 
periods(5).
actors(7).
gridwidth(4).  
exist_min(20).
size_of_boxes(10).


% boolean constants  -----------------------------------------

% modes( [takeweak,donothin,schellin ]). 
modes([donothin,schelling,takeweak]).
% modes([takeweak]).
use_old_data(no). 
variables_in_rule(donothin,[wealth_dono]).
variables_in_rule(schelling,[location,colour]).
variables_in_rule(takeweak,[location,strength,wealth_take]).

weights(donothin,2,[50,101]). 
weights(schelling,1,[101]).
weights(takeweak,1,[101]). 
type_of_neighbourhood(schelling,moore,1).  
type_of_neighbourhood(takeweak,von_Neumann,2).
choose_run(1).

% constants relative to an action type -----------------------
       
domain_of_wealth_dono(50,500). sigma_wealth_dono(20). 
height(donothin,175).
magnify_by(0.2).


height(shelling,170).


domain_of_wealth_take(100,200).
sigma_wealth_take(30). 
expressions(strength,2).
weights(strength,[70,101]).
domain_of_values(20).  /* a better name ?? */
height(takeweak,200).


