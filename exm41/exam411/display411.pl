/* display411  

Das Programm stellt einige Aktionen relativ zu einem gegebenen Handlungstyp 
dar.  */

:- dynamic fact/3 .

make_picture(exchange) :- 
   make_picture(exchange1),
   make_picture(exchange2).

/* In exchange1 wird eine Funktion für die Werte für ein Güterbündel für einen 
Akteur darstellt. */

make_picture(exchange1) :- 
   choose_run_exchange(R),
   choose_actor_exchange1(A), goods(GG),
   VV1 = 'Picture-', concat(VV1,exchange1,Vd1),
   new(@exchange1, picture(Vd1)), send(@exchange1, open),  
   asserta(object_list(exchange1,[])), 
   asserta(other_object_list(exchange1,[])),
   height(exchange1,H),
   send(@exchange1, display, new(AXISUP, line(5,5,5,175,first))),
   send(@exchange1, display, new(AXISRIGHT, line(5,175,350,175,second))),
   periods(TT), 
   make_objects(exchange1,GG,A),
   make_other_objects(exchange1),
   activate_picture(exchange1,A,R,H).    /* R ist ein Wiederholung (Run) */       

make_objects(exchange1,GG,A) :-  height(exchange1,H),
     ( between(1,GG,G), make_dots(exchange1,G,A,H), fail; true),!.

make_dots(exchange1,G,A,H) :-  G1 is 5+5*G,
    send(@exchange1, display, new(BT, circle(4)), point(G1,50)), 
    object_list(exchange1,OL), append(OL,[BT],OL1), retract(object_list(exchange1,OL)),
    asserta(object_list(exchange1,OL1)),!.

make_other_objects(exchange1) :- 
   ( between(1,4,N), make_other_obj(exchange1,N), fail ; true),
    other_object_list(exchange1,OOL1),
   ( between(1,4,N), nth1(N,OOL1,OV), send(OV,flush), fail; true),!.
   
make_other_obj(exchange1,N) :- other_object_list(exchange1,OOL),
    make_o_obj(exchange1,N,OV), append(OOL,[OV],OOL1), 
    retract(other_object_list(exchange1,OOL)),
    asserta(other_object_list(exchange1,OOL1)),!.

make_o_obj(exchange1,1,@W11) :- 
   send(@exchange1, display, new(@W11, text('bundle for actor')), point(20,175)).
make_o_obj(exchange1,2,@W12) :- 
   send(@exchange1, display, new(@W12, text('number')), point(122,175)).
make_o_obj(exchange1,3,@W13) :- 
   send(@exchange1, display, new(@W13, text(' , at tick')), point(200,175)).
make_o_obj(exchange1,4,@W14) :- 
   send(@exchange1, display, new(@W14, text('number')), point(250,175)).

activate_picture(exchange1,A,R,H) :-  
   object_list(exchange1,OL), 
   goods(GG), periods(TT), 
   ( between(1,TT,T), display_run(exchange1,T,GG,A,OL,R,H) , sleep(1), fail
   ; true
   ),!.

display_run(exchange1,T,GG,A,OL,R,H) :- 
   update(exchange1,T,A), 
   fact(R,T,bundle(A,LIST)), length(LIST,E),
   ( between(1,GG,G), update_bundle(G,R,T,A,OL,H,LIST,E), fail
   ; true
   ),!.

update_bundle(G,R,T,A,OL,H,LIST,E) :-  
    nth1(G,LIST,Q),
    magnify_by(MAG), W is MAG*Q, Y1 is H-W,
    nth1(G,OL,OG), X1 is 5+5*G,
    get(OG, position, point(X,Y)),
    send(OG, position, point(X1,Y1)),
    Z = colour(colour1,00344,32210,54333), 
           /* das ist die genaue Farbtönung, colour1 ist ein selbst 
              vergebener Name für eine Farbe */
    send(OG, fill_pattern, Z),
%   send(OG, fill_pattern, colour(red)), 
           /* einige einfache Farben werden direkt durch Prädikate vergeben */ 
    send(OG,flush),!. 

update(exchange1,R,A) :- 
  other_object_list(exchange1,OOL), nth1(2,OOL,OV2),
  send(OV2,string,A), send(OV2,flush),
  nth1(4,OOL,OV4), send(OV4,string,R), send(OV4,flush),!. 

/* -------------------------------------------------------------------------------

In diesem Bild werden für jeden Akteur A ein Balken eingezeichnet. Die Höhe eines
Balkens stellt die Menge einer bestimmten Warenart dar, die ein Akteur A besitzt. */

make_picture(exchange2) :- 
   choose_run_exchange(R), choose_good(G),             /* siehe para.pl */
   VV3 = 'Picture-', concat(VV3,exchange2,Vd3),
   new(@exchange2, picture(Vd3)), send(@exchange2, open),  
   send(@exchange2, display, new(AXISUP, line(5,5,5,160,first))),
   send(@exchange2, display, new(AXISRIGHT, line(5,160,400,160,second))),
   asserta(object_list(exchange2,[])), height(exchange2,H),
   asserta(other_object_list(exchange2,[])), 
   periods(TT),                               /* siehe para.pl */
   make_objects(exchange2,TT,R), 
   make_other_objects(exchange2),
   activate_picture(exchange2,G,R),
   retractall(object_list(EEE,DDD)), retractall(other_object_list(FFF,GGG)),
   retractall(object(BBB,CCC,AAA)),
   ask_for_end, destroy(Answer). 

make_objects(exchange2,TT,R) :- 
  actors(AS),  object_list(exchange2,LIST),
  ( between(1,AS,B), make_cell(B,R), fail ;true),
  send(@exchange2,flush),
  object_list(exchange2,L), asserta(object_list(exchange2,L)), !.

make_cell(B,R) :-
   J is 140, I is 10 + (B-1)*10, 
   send(@exchange2, display, new(E, box(10,20)), point(I,J)),
   send(@exchange2, flush),
   object_list(exchange2,L), append(L,[E],L1),
   asserta(object_list(exchange2,L1)),
   retract(object_list(exchange2,L)),!.

make_other_objects(exchange2) :- 
   ( between(1,4,N), make_one_object(exchange2,N), fail ; true),
    other_object_list(exchange2,OOL1),
   ( between(1,4,N), nth1(N,OOL1,OV), send(OV,flush), fail; true),!.
   
make_one_object(exchange2,N) :- other_object_list(exchange2,OOL),
    make_object(exchange2,N,OV), append(OOL,[OV],OOL1), 
    retract(other_object_list(exchange2,OOL)),
    asserta(other_object_list(exchange2,OOL1)),!.

make_object(exchange2,1,@W31) :-
   send(@exchange2, display, new(@W31, 
        text('the values for all actors for good')), point(20,163)).
make_object(exchange2,2,@W32) :- 
   send(@exchange2, display, new(@W32, text('number')), point(205,163)),
   asserta(object(exchange2,1,@W32)).
make_object(exchange2,3,@W33) :- 
   send(@exchange2, display, new(@W33, text(' , time')), point(220,163)).
make_object(exchange2,4,@W34) :- 
   send(@exchange2, display, new(@W34, text('number')), point(260,163)),
   asserta(object(exchange2,2,@W34)).


activate_picture(exchange2,G,R) :-
     object(exchange2,1,O1), send(O1,string,G), send(O1,flush),!,
     make_maxima(R,G),         
     periods(TT), actors(AS), 
     ( between(1,TT,T), depict_period(exchange2,T,AS,R,G), fail ; true),!,
     ask_for_end, destroy(Answer),!.

depict_period(exchange2,T,AS,R,G) :- 
   update(exchange2,R,T),
   ( between(1,AS,A), update(exchange2,R,T,A,G), fail; true),!,
   send(@exchange2,flush), sleep(1),!.

% ----------------------------------------------------------------------

update(exchange2,R,T) :- object(exchange2,2,O), send(O,string,T), 
   send(O,flush),!.

update(exchange2,R,T,A,G) :-
   object_list(exchange2,OBL1), nth1(A,OBL1,OA1), 
   fact(R,T,bundle(A,LIST)), nth1(G,LIST,Q), 
   max_val(MAX1),
   get(OA1, position, point(X,Y)), 
   ( Q =< 0, V is 0; V is (3.5 * Q/MAX1)*20 ), Y1 is 160-V,
   send(OA1, position, point(X,Y1)), send(OA1,height,V),
   send(OA1, fill_pattern, colour(green)), 
   send(OA1,flush),!.
 
make_maxima(R,G) :- 
   findall(Q,(fact(R,T,bundle(A,LIST)), nth1(G,LIST,Q)),L1),
   sort(L1,L2),
   length(L2,E2), nth1(E2,L2,MAX1), asserta(max_val(MAX1)),!. 

ask_for_end :-
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(@exchange2, destroy). 











