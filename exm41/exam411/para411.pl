/* para411.pl 
Die Datei der Parameter */ 

/* Grundkonstante. Diese k�nnen nicht ge�ndert werden. */

action_types([exchange]). 
use_old_data(no). 
variables_in_rule(exchange,[exmin,bundle,value,location,exchange_character]).
type_of_neighbourhood(exchange,moore,2).  

/* "Echte" Konstante  */

runs(2). 
periods(5).
actors(15).
goods(10).
gridwidth(4).  
size_of_boxes(10).

/* Graphisch wirksame Konstanten. Dies h�ngen von den Grundkonstanten ab. */ 

choose_run_exchange(2). 
height(exchange,175).
magnify_by(0.2). 

/* "Dynamische" Konstanten. Diese k�nnen relativ zu den Grundkonstante und zu den
Handlungstypen ge�ndert werden. */

weights(exchange,1,[101]).  

/* Hier gibt nur einen einzigen Handlungstyp. */

domain_of_bundle(3,200).    /* Hier ist f�r jedes Gut die Normalverteilung anders. */
sigma_bundle(30).
domain_of_value(1,10).  
sigma_value(1). 

weights(exmin,[33,66,101]).  /* Gewichte, unabh�ngig von der Zahl der Warentypen. */ 
exmin_expressions(3).  

weights(exchange_character,[15,101]). 
exchange_character_expressions(2).

/* Konstante f�r die Bilder */

choose_run_exchange(2).
choose_actor_exchange1(2).
height(exchange1,175).
magnify_by(0.2).
% choose_actor_exchange2(3).
% height(exchange2,175).
height(exchange2,175).
choose_good(3).