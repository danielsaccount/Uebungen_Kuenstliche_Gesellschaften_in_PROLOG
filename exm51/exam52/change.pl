/* change (exam521)

Aus einer Liste LIST wird ein Element c entfernt. Später wird ein Element f hinzugefügt.
*/

:- dynamic pred/1.

pred([a,b,c,d]). fact1(c). fact2(f).

start :- 
trace,
  pred(LIST), fact1(X),
  change(delete,LIST,X),
  pred(LIST1), fact2(Y), 
  change(append,LIST1,Y).

change(delete,LIST,X) :- 
  delete(LIST,X,LISTnew), 
  retract(pred(LIST)), asserta(pred(LISTnew)),
  write(pres(LISTnew)),!.

change(append,LIST1,Y) :- 
  append(LIST1,[Y],LIST1new), 
  retract(pred(LIST1)), asserta(pred(LIST1new)),!.