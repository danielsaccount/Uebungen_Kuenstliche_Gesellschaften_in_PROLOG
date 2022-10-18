% display431.pl

make_a_picture :- 
% trace,
   choose_run_crises(R), choose_actor(A),               
   modes(MODES), length(MODES,LENGTH),
   consult('res4312.pl'),
   VV3 = 'Picture-', concat(VV3,crises,Vd3),
   new(@crises, picture(Vd3)), send(@crises, open),  
   send(@crises, display, new(AXISUP, line(5,5,5,160,first))),
   send(@crises, display, new(AXISRIGHT, line(5,160,370,160,second))),
   asserta(object_list([])), height(H),
   asserta(other_object_list([])), 
   periods(TT),                             
   make_objects(TT,R,A,LENGTH,MODES), 
   make_other_objects,
   activate_picture(R,A,LENGTH),
   retractall(object_list(DDD)), retractall(other_object_list(GGG)),
   retractall(object(BBB,CCC)),
   ask_for_end, destroy(Answer). 

make_objects(TT,R,A,LENGTH,MODES) :- 
  object_list(LIST),
  ( between(1,LENGTH,NTYP), make_cell(NTYP,R,A,MODES), fail ;true),
  send(@crises,flush),
  object_list(L), asserta(object_list(L)), !.

make_cell(NTYP,R,A,MODES) :-
   J is 140, I is 10 + (NTYP-1)*40, 
   send(@crises, display, new(E, box(40,20)), point(I,J)),
   send(@crises, flush),
   object_list(L), append(L,[E],L1),
   asserta(object_list(L1)),
   retract(object_list(L)),!.

make_other_objects :-
   modes(MODES), 
   ( between(1,13,N), make_one_object(N), fail ; true),!.
  
make_one_object(N) :- other_object_list(OOL),
   ( N =< 6, make_object(N,OV)
   ; 6 < N, make_object1(N,OV) ),
    append(OOL,[OV],OOL1), 
    retract(other_object_list(OOL)),
    asserta(other_object_list(OOL1)),!.

make_object(1,@W31) :-
   send(@crises, display, new(@W31,text('numbers of')), point(10,10)),
   send(@W31,flush).
make_object(2,@W32) :-
   send(@crises, display, new(@W32,text('actions')), point(10,23)),
   send(@W32,flush).
make_object(3,@W33) :-
   send(@crises, display, new(@W33,text('actor nr.')), point(150,10)),
   send(@W33,flush).
make_object(4,@W34) :-
   send(@crises, display, new(@W34,text('number')), point(205,10)),
   asserta(object(4,@W34)), send(@W34,flush).
make_object(5,@W35) :-
   send(@crises, display, new(@W35,text('tick')), point(300,10)),
   send(@W35,flush).
make_object(6,@W36) :-
   send(@crises, display, new(@W36,text('number')), point(325,10)),
   asserta(object(6,@W36)), send(@W36,flush).

make_object1(N,OV) :- 
   modes(MODES), Nnew is N - 6, nth1(Nnew,MODES,ATYP),
   J is 170, I is 10 + (Nnew-1)*40, 
   send(@crises, display, new(OV,text(ATYP)), point(I,J)), 
   send(OV,flush),!.

activate_picture(R,A,LENGTH) :- 
   periods(TT),
   make_maxima(R,TT,A), 
   ( between(1,TT,T), depict_period(T,LENGTH,R,A), fail ; true),!,
   ask_for_end, destroy(Answer),!.

depict_period(T,LENGTH,R,A) :- 
   update(R,A,T),
   ( between(1,LENGTH,NTYP), update(R,T,A,NTYP), fail; true),!,
   send(@crises,flush), sleep(0.5),!.

% ----------------------------------------------------------------------

make_maxima(R,TT,A) :- 
   fact(R,TT,history(A,HISTORY)), length(HISTORY,LENGTH),
   MAX is ceiling(160/LENGTH), asserta(max_val(MAX)),!. 

update(R,A,T) :- 
   object(4,O4), send(O4,string,A), send(O4,flush),
   object(6,O6), send(O6,string,T), send(O6,flush),!.

update(R,T,A,NTYP) :-
   object_list(OBL1), nth1(NTYP,OBL1,OBOX), 
   modes(MODES), nth1(NTYP,MODES,TYP),
% ( R = 2, T = 4, trace; true),
   fact(R,T,history(A,HISTORY)),
   asserta(aux_list([])), 
   calculate1(HISTORY,TYP),
   aux_list(AUXLISTnew),  
   length(AUXLISTnew,Q), retract(aux_list(AUXLISTnew)),
   max_val(MAX),
   get(OBOX, position, point(X1,Y1)), 
   (Q = 0, V = 3 ; Q > 0, V is Q*MAX ),
   Y2 is 160-V,
   ZZ is 5001 + NTYP*5000, ZZ1 is 55000 - NTYP*3000,
   send(OBOX, position, point(X1,Y2)), send(OBOX,height,V),
   send(OBOX, fill_pattern, colour(NTYP,ZZ,ZZ1,55000)), 
   send(OBOX,flush),!.
   
calculate1(HISTORY,TYP) :- 
   length(HISTORY,LENGTH),
   ( between(1,LENGTH,X), add_typ(X,TYP,HISTORY), fail; true),!.

add_typ(X,TYP,HISTORY) :-
   ( nth1(X,HISTORY,K), nth1(1,K,TYP),
     aux_list(AUXLIST), append(AUXLIST,[TYP],AUXLISTnew),
     retract(aux_list(AUXLIST)), asserta(aux_list(AUXLISTnew))
   ; true),!.

ask_for_end :-
  new(@d, dialog('Display')),
  send(@d, append, new(TI, text_item(type_End, ''))),
  send(@d, append, button(ok, message(@d,return,TI?selection))),
  get(@d, confirm, Answer),
  send(@d, destroy),!.

destroy(Answer) :- send(@crises, destroy). 




