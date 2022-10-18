/* para431.pl  */


runs(2).
periods(20).
actors(5).
max_strength(100).

use_old_data(no). 
modes([threat,appea,attack,defend,surren,conqu,do_not]).
use_old_data(no). 
variables_in_rule(threat,[strength,aggression,history]).
variables_in_rule(appease,[strength,aggression,history]).
variables_in_rule(attack,[strength,aggression,history]).
variables_in_rule(defend,[strength,aggression,history]).
variables_in_rule(surrender,[strength,aggression,history]).
variables_in_rule(conquer,[strength,aggression,history]).
variables_in_rule(do_nothin,[strength,aggression,history]).

weights(threat,2,[50,101]). 
weights(appease,2,[50,101]).
weights(attack,3,[33,66,101]).
weights(defend,2,[50,101]).
weights(surrender,2,[50,101]).
weights(conquer,2,[50,101]).
weights(do_nothin,1,[101]).

weights(strength,3,[33,66,101]). 
weights(aggression,3,[50,95,101]).

escalate(do_nothin,threat).
escalate(threat,attack).
escalate(attack,conquer).
escalate(attack,surrender).
deescal(do_nothin,do_nothin).
deescal(defend,appease).
deescal(surrender,appease).
deescal(conquer,do_nothin).

choose_run_crises(2).
choose_actor(3). 
height(250).
number_of_action_typs(7).

