% bundpreds251.pl


bundpred(eat_fish,DRINK) :-
   member(DRINK,[drink_red_wine,drink_white_white,drink_water]). 
  
bundpred(eat_stew,DRINK) :-
   member(DRINK,[drink_beer,drink_water]).

bundpred(eat_chicken,DRINK) :-
   member(DRINK,[drink_water,drink_beer]).

bundpred(eat_steak,DRINK) :- 
   member(DRINK,[drink_water,drink_red_wine]).



