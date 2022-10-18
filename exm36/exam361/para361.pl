/* para361.pl 
Die Datei der Parameter */ 

/* Grundkonstante. Diese k�nnen nicht ge�ndert werden. */

action_types([exchange]). 
use_old_data(no). 
variables_in_rule(exchange,[exmin,bundle,value,location,exchange_character]).
type_of_neighbourhood(exchange,moore,2).  

/* "Echte" Konstante  */

runs(2). 
periods(6).
actors(15).
goods(4).
gridwidth(4).  
size_of_boxes(10).

/* Graphisch wirksame Konstanten. Dies h�ngen von den Grundkonstanten ab. */ 

height(exchange,175).
magnify_by(0.2). 

/* "Dynamische" Konstanten. Diese k�nnen relativ zu den Grundkonstante und zu den
Handlungstypen ge�ndert werden. */

weights(exchange,1,[101]).  

/* Hier gibt nur einen einzigen Handlungstyp. */


weights(exchange_character,[15,101]). 
exchange_character_expressions(2).

/* Konstante f�r die Bilder */

height(exchange1,175).
magnify_by(0.2).

choose_good(3).  /* ?? */