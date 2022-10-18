% display352.pl  The programs displaying some actions relativ to a given action type.

:- dynamic fact/3 , fact/4 .


% picture for donothin

% make_picture(donothin) :-

make_picture(donothin,DW,LN,R) :-
   VV1 = 'Picture-', concat(VV1,donothin,Vd1),
   new(@donothin, picture(Vd1)), send(@donothin, open),  
   asserta(object_list(donothin,[])), height(donothin,H),
   send(@donothin, display, new(AXISUP, line(5,5,5,175,first))),
   send(@donothin, display, new(AXISRIGHT, line(5,175,350,175,second))),
   nth1(XX,LN,periods), nth1(XX,DW,TT),  /* periods(TT), */
   nth1(XX4,LN,runs), nth1(XX4,DW,RR), /* runs(RR) */
   R =< RR, 
   make_objects(donothin,TT), 
   make_other_objects(donothin),
   activate_picture(donothin,R,H,DW,LN).    /* NM = 1, MOD = donothin, R a run */

make_objects(donothin,TT) :-  height(donothin,H),
     ( between(1,TT,A), make_dots(donothin,A,H), fail; true),!.

make_dots(donothin,A,H) :-  A1 is 5+5*A,
    send(@donothin, display, new(BT, circle(4)), point(A1,50)), 
    object_list(donothin,OL), append(OL,[BT],OL1), retract(object_list(donothin,OL)),
    asserta(object_list(donothin,OL1)),!.

make_other_objects(donothin) :- 
   send(@donothin, display, new(@W11, text('actor')), point(20,175)),
   send(@W11, flush),
   send(@donothin, display, new(@W12, text('number')), point(60,175)),
   asserta(obj(donothin,@W12)),
   send(@W12, flush),!.

activate_picture(donothin,R,H,DW,LN) :- object_list(donothin,OL), 
   nth1(XX1,LN,actors), nth1(XX1,DW,AS), /* actors(AS), */
   (  between(1,AS,A), display_run(donothin,A,OL,R,H,DW,LN), sleep(1), fail; true),!.

display_run(donothin,A,OL,R,H,DW,LN) :- 
   update(donothin,A),
   nth1(XX2,LN,periods), nth1(XX2,DW,TT), /* periods(TT), */
   ( between(1,TT,T), make_wealth_dono(R,T,A,OL,H,DW), fail
   ; true
   ),!.

make_wealth_dono(R,T,A,OL,H,DW) :-
% trace,
      write(make_wealth_dono(R,T,A,OL,H,DW)),
      fact(DW,R,T,wealth_dono(A,WA)), magnify_by(MAG), W is MAG*WA, Y1 is H-W,
      nth1(T,OL,OT), X1 is 5+5*T,
      get(OT, position, point(X,Y)),
      send(OT, position, point(X1,Y1)),
      send(OT, fill_pattern, colour(red)),
      send(OT,flush),!. 

% ------------------------------------------------------------

% schellin

make_picture(schellin,DW,LN,R) :-  
   VV2 = 'Picture-', concat(VV2,schellin,Vd2),
   new(@schellin, picture(Vd2)), send(@schellin, open), 
   nth1(XX,LN,periods), nth1(XX,DW,TT),   /* periods(TT), */ 
   make_objects(schellin,TT),!,
   make_other_objects(schellin), 
   activate_picture(schellin,R,DW,LN),!. 

make_objects(schellin,TT) :-  height(schellin,H),            /* 2 = NM , in para */
     gridwidth(G), size_of_boxes(S), GG is G*G, 
     asserta(object_list(schellin,[])),
     ( between(1,G,I), make_row(I,G,S), fail; true),!.

make_row(I,G,S) :- ( between(1,G,J), make_column(I,J,S), fail ; true),!.

make_column(I,J,S) :- I1 is (I-1)*S, J1 is (J-1)*S,
   send(@schellin, display, new(E, box(S,S)), point(I1,J1)),
   object_list(schellin,L), append(L,[E],L1), asserta(object_list(schellin,L1)),
   retract(object_list(schellin,L)),!.

make_other_objects(schellin) :- 
     send(@schellin, display, new(@W21, text('period')), point(20,162)),
     send(@W21, flush),
     send(@schellin, display, new(@W22, text('number')), point(60,162)),
     asserta(obj(schellin,@W22)),
     send(@W22, flush),!.

activate_picture(schellin,R,DW,LN) :- 
  gridwidth(G),
  nth1(XX1,LN,actors), nth1(XX1,DW,AS), /* actors(AS), */
  nth1(XX2,LN,periods), nth1(XX2,DW,TT),  /* periods(TT), */
  object_list(schellin,L),
  ( between(1,TT,T), display_period(schellin,R,T,AS,G,L,DW), sleep(1), fail ; true),
  retract(object_list(schellin,L)),!.

display_period(schellin,R,T,AS,G,L,DW) :- G1 is G*G,
    update(schellin,T),
    ( between(1,G1,X), nth1(X,L,OB), send(OB, fill_pattern, colour(white)), 
      send(OB, flush), fail
    ; true
    ),!,
    ( between(1,AS,A), display(schellin,R,T,G,L,A,DW), fail ; true),!.

display(schellin,R,T,G,L,A,DW) :- 
   fact(DW,R,T,colour(A,C)),
   fact(DW,R,T,location(A,I,J)), N is (I-1)*G+J, nth1(N,L,OB),
   ( C = black, X = colour(black) 
   ; 
     C = white, X = colour(blue) 
   ),
   send(OB, fill_pattern, X), send(OB, flush),!.


% -------------------------------------------------------------------------------

% picture for takeweak

make_picture(takeweak,DW,LN,R) :- 
   VV3 = 'Picture-', concat(VV3,takeweak,Vd3),
   new(@takeweak, picture(Vd3)), send(@takeweak, open),  
   send(@takeweak, display, new(AXISUP, line(5,5,5,160,first))),
   send(@takeweak, display, new(AXISRIGHT, line(5,160,400,160,second))),
   asserta(object_list(takeweak,[])), height(takeweak,H),
   nth1(XX,LN,periods), nth1(XX,DW,TT),  /* periods(TT), */ 
   make_objects(takeweak,TT,R,DW,LN), 
   make_other_objects(takeweak),
   activate_picture(takeweak,R,DW,LN). 

make_objects(takeweak,TT,R,DW,LN) :- 
  nth1(XX1,LN,actors), nth1(XX1,DW,AS),  /* actors(AS), */ 
  asserta(oblist(takeweak,[])),
  ( between(1,AS,B), make_cell(B,R), fail ;true),
  send(@takeweak,flush),
  oblist(takeweak,L), asserta(oblist(takeweak,L)), !.

make_cell(B,R) :-
   J is 140, I is 5 + (B-1)*20, I1 is I + 10,
   send(@takeweak, display, new(E, box(10,20)), point(I,J)),
   send(@takeweak, display, new(F, box(10,20)), point(I1,J)),
   send(@takeweak, flush),
   oblist(takeweak,L), append(L,[[E,F]],L1),
   asserta(oblist(takeweak,L1)),
   retract(oblist(takeweak,L)),!.

make_other_objects(takeweak) :-
     send(@takeweak, display, new(@W1, text('period')), point(20,162)),
     send(@W1, flush),
     send(@takeweak, display, new(@W2, text('number')), point(60,162)),
     asserta(obj(takeweak,@W2)),
     send(@W2, flush),!.

activate_picture(takeweak,R,DW,LN) :- 
     make_maxima(R,DW),         /* R the run in para */
     nth1(XX2,LN,periods), nth1(XX2,DW,TT), /* periods(TT), */
     nth1(XX3,LN,actors), nth1(XX3,DW,AS),  /* actors(AS), */
     ( between(1,TT,T), depict_period(takeweak,T,AS,R,DW), fail ; true),!,
     ask_for_end, destroy(Answer),!.

depict_period(takeweak,T,AS,R,DW) :- 
   update(takeweak,T),
   ( between(1,AS,A), update(takeweak,T,A,R,DW), fail; true),!,
   send(@takeweak,flush), sleep(1),!.

update(MOD,T) :- obj(MOD,O), send(O,string,T), send(O,flush),!.

update(takeweak,T,A,R,DW) :-
   oblist(takeweak,OBL1), nth1(A,OBL1,[OA1,OA2]), 
   fact(DW,R,T,strength(A,SA)), SA1 is 5*SA, 
   get(OA1, position, point(X,Y)), Y1 is 160 - SA1,
   send(OA1, position, point(X,Y1)), send(OA1,height,SA1),
   send(OA1, fill_pattern, colour(green)), 
   send(OA1,flush),
   fact(DW,R,T,wealth_take(A,V1)), max_val(MAX), 
   get(OA2, position, point(X2,Y2)),
   ( V1 =< 0, V is 0; V is (V1/MAX)*20 ), Y3 is 160-V,
   send(OA2, position, point(X2,Y3)),send(OA2,height,V),
   send(OA2, fill_pattern, colour(blue)), 
   send(OA2,flush),!.

make_maxima(R,DW) :-
   findall(V,fact(DW,R,T,wealth_take(A,V)),L1), sort(L1,L2),
   length(L2,E2), nth1(E2,L2,MAX1), asserta(max_val(MAX1)),!.

ask_for_end :-
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(@takeweak, destroy).










