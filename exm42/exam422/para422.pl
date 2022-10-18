% para422.pl (for theory of Heider)

actors(10).
objects(5).
periods(3).
runs(1).   /* nur 1 run funktioniert */

triades_pos_balanced([[1,1,1],[-1,1,-1],[1,-1,-1],[-1,-1,1]]).
triades_neg_balanced([[1,1,-1],[-1,1,1],[1,-1,1]]).

weights(balance,1,[101]).  
weights(balance_character,[15,101]). 
balance_character_expressions(2).

/* basic constants (cannot be changed) ------------------------ */

action_types([balance]). 
use_old_data(no). 
variables_in_rule(balance,[triade]).
 
/* graphical contants (depended on basic constants) ----------------- */

choose_run_balance(2). 
height(balance,175).
magnify_by(0.2). /* schauen?? */

/* -------------------------------------------------------
pictures */

choose_run_balance(2).
choose_actor_balance1(2).
height(balance1,175).
magnify_by(0.2).
choose_actor_balance2(3).
height(balance2,175).