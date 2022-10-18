/* write (exam524) 

Eine Abkürzung mit "write"
*/


writein(datei,pred(X,Y)) :-
   append('datei.pl'), write(pred(X,Y)), write('.'), nl, told.


/* z.B.
writein(res341,pred(X,Y)) :-
   append('res341.pl'), write(pred(X,Y)), write('.'), nl, told.
*/