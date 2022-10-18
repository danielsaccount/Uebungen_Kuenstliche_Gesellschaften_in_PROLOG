/* para411.pl 
Die Datei der Parameter */ 

/* Grundkonstante. Diese können nicht geändert werden. */

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

/* Graphisch wirksame Konstanten. Dies hängen von den Grundkonstanten ab. */ 

choose_run_exchange(2). 
height(exchange,175).
magnify_by(0.2). 

/* "Dynamische" Konstanten. Diese können relativ zu den Grundkonstante und zu den
Handlungstypen geändert werden. */

weights(exchange,1,[101]).  

/* Hier gibt nur einen einzigen Handlungstyp. */

domain_of_bundle(3,200).    /* Hier ist für jedes Gut die Normalverteilung anders. */
sigma_bundle(30).
domain_of_value(1,10).  
sigma_value(1). 

weights(exmin,[33,66,101]).  /* Gewichte, unabhängig von der Zahl der Warentypen. */ 
exmin_expressions(3).  

weights(exchange_character,[15,101]). 
exchange_character_expressions(2).

/* Konstante für die Bilder */

choose_run_exchange(2).
choose_actor_exchange1(2).
height(exchange1,175).
magnify_by(0.2).
% choose_actor_exchange2(3).
% height(exchange2,175).
height(exchange2,175).
choose_good(3).