/* rules411.pl */

:- dynamic fact/3 .

% "rules" (the action rules in SMASS)

% RULE 1: `exchange'. Die Person versucht, zu tauschen. 

% domain_of_exmin(50,500). sigma_exmin(20). ...

prepare(R,T,exchange) :- true.

act_in_type(exchange,A,R,T) :- feasible(exchange,A,R,T),      
   chooseaction(exchange,A,R,T), perform(exchange,A,R,T),!.  
   
feasible(exchange,A,R,T) :- make_offer(A,R,T,OFFER), 0 < OFFER,!. 

chooseaction(exchange,A,R,T) :- true,!.   
 
perform(exchange,A,R,T) :- 
    make_offer(A,R,T,OFFER),
    fact(R,T,location(A,I,J)),
    type_of_neighbourhood(exchange,moore,2),   
/* moore und 2 kann man hier leicht variabel halten */    
    make_nbh(moore,2,I,J,L),
    length(L,E), asserta(list_of_neighbors_A([])),
    ( between(1,E,Y), add_list_of_neighbors_A(Y,L), fail ; true),
    list_of_neighbors_A(LIST_OF_NEIGHS),
    length(LIST_OF_NEIGHS,EN),
    make_random_list_of_neighs(LIST_OF_NEIGHS,EN,NEWLIST_OF_NEIGHS),
    asserta(negotiation_counter(0)),
    (  between(1,EN,NAME_OF_NEIGH_B), 
       negotiation(A,NAME_OF_NEIGH_B,R,T,NEWLIST_OF_NEIGHS,OFFER), fail
    ; true
    ),
    retract(list_of_neighbors_A(LN)), retract(negotiation_counter(NN1)),!.

make_random_list_of_neighs(LIST_OF_NEIGHS,EN,NEWLIST_OF_NEIGHS) :-
   asserta(newlist([])),
   ( between(1,EN,N), add_neighbor(N,EN,LIST_OF_NEIGHS), fail; true),!,
   newlist(NEWLIST_OF_NEIGHS), retract(newlist(NEWLIST_OF_NEIGHS)),!.

add_neighbor(N,EN,LIST_OF_NEIGHS) :- newlist(LIST),
    X is random(EN) + 1, nth1(X,LIST_OF_NEIGHS,B), append(LIST,[B],LISTnew),
    retract(newlist(LIST)), asserta(newlist(LISTnew)),!.
     
add_list_of_neighbors_A(Y,L) :- list_of_neighbors_A(LN),
  nth1(Y,L,CELL), CELL = [I,J], fact(R,T,location(B,I,J)),
  append(LN,[B],LNnew), retract(list_of_neighbors_A(LN)),
  asserta(list_of_neighbors_A(LNnew)),!.
  
make_offer(A,R,T,OFFER) :- 
   goods(GG),
   fact(R,T,bundle(A,BUNDLE_A)),  
   fact(R,T,value(A,VALUES_A)), 
   fact(R,T,exmin(A,EXMINS_A)), 
   asserta(offer_list([])),
   ( between(1,GG,X), make_offer_list(X,A,BUNDLE_A,VALUES_A,EXMINS_A,NG), fail
   ;    
     true
   ),!,
   offer_list(L), length(L,E), 
   ( E = 0, OFFER = 0
   ;
     0 < E, nth1(E,L,[D1,D2,D3]), OFFER = D1
   ),
   retract(offer_list(L)),!.

make_offer_list(X,A,BUNDLE_A,VALUES_A,EXMINS_A,NG) :-
   offer_list(L),
   nth1(X,BUNDLE_A,QX), nth1(X,VALUES_A,WX), nth1(X,EXMINS_A,MX),
   MX < QX,       

/* das Existenzminumum MX fuer A bei Gueterart X ist kleiner als die Quantitaet
QX, die A gerade hat. D.h. A kann eine Einheit der Art X anbieten. */ 
   length(L,E), 
   ( E = 0 , Lneu = [[X,MX,WX]]   
/* Die Angebotsliste ist am Anfang leer. Hier wird die Gueterart X
(zusammen mit Existenzminimum und Wert von X) in die Angebotsliste aufgenommen */  
   ;
     0 < E , nth1(E,L,[D1,D2,D3]), L2 = [X,MX,WX],
     ( WX =< D3 , append([L2],L,Lneu)
     ;
       D3 < WX , append(L,[L2],Lneu)
     )
/* Hier wird entschieden, ob die Gueterart X links oder rechts an die
Angebotsliste angehaangt wird. Die Angebotsliste ist nach den Werten der
Gueterarten angeordnet. D.h. wenn der Wert WX von X kleiner oder gleich dem letzten
Wert D3 aus der offer_list ist, wird WX (plus D1 und D2) an die Liste
links angehaengt. Andersfalls kommt der Wert an die rechte Seite der Liste. */
   ),
   retract(offer_list(L)), asserta(offer_list(Lneu)),!.

negotiation(A,NAME_OF_NEIGH_B,R,T,NEWLIST_OF_NEIGHS,OFFER_A) :- 
   negotiation_counter(COUNT1),
   ( 
     COUNT1 = 0, 
     nth1(NAME_OF_NEIGH_B,NEWLIST_OF_NEIGHS,B), 
     fact(R,T,exchange_character(B,C)), exchange_character_expressions(EX),
     ( C = 1
     ;
       C > 1 , C =< EX, 
       make_offer(B,R,T,OFFER_B),
% append(test), write(verhandlung(A,OFFER_A,B,OFFER_B)), nl, told,
       ( OFFER_B = OFFER_A           /* die Verhandlung ist gescheitert */
       ; 
         exchange(R,T,A,B,OFFER_A,OFFER_B)
       )
     )
   ;
     COUNT1 > 0 , true
   ),! .
/* Weitere Characterkomponenten koennten hier eingebaut werden. */

exchange(R,T,A,B,NA,NB) :- 
   fact(R,T,bundle(A,LA)), nth1(NA,LA,Q1), Q1neu is Q1 - 1,
   nth1(NB,LA,Q2), Q2neu is Q2 + 1,
   fact(R,T,bundle(B,LB)), nth1(NA,LB,Q3), Q3neu is Q3 + 1,
   nth1(NB,LB,Q4), Q4neu is Q4 - 1,
   exchan(LA,NA,NB,LAneu), exchan(LB,NA,NB,LBneu),
   retract(fact(R,T,bundle(A,LA))), asserta(fact(R,T,bundle(A,LAneu))),
   retract(fact(R,T,bundle(B,LB))), asserta(fact(R,T,bundle(B,LBneu))),!.

exchan(LIST,U1,U2,LIST2) :- replace_mi(LIST,U1,LIST1),    replace_pl(LIST1,U2,LIST2),!.
          
% --------------------------------------------------

protocol(exchange,A,R,T) :- fail.      
adjust(exchange,A,R,T) :- true.  
adjust(exchange,R,T) :- true.  