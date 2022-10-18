/* Summe (exam523)

Eine Summe wird gebildete aus Zahlen aus einer Liste L. S ist die
Summe. N ist der Zählindex.
*/


sum(N,L,S) :- 
  asserta(counter(0)),
  length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true),
  counter(S), retract(counter(S)).

auxpred(L,X) :- nth1(X,L,N), counter(C), 
  C1 is C+N, retract(counter(C)), 
  asserta(counter(C1)),!.


/* Z.B. 
sum(7,[3,4,2,13,2.342,0,1],SUMME) :- 
  asserta(counter(0)),
  length(L,E),
  ( between(1,E,X), auxpred(L,X) , fail ; true),
  counter(SUMME), retract(counter(SUMME)).

auxpred(L,X) :- nth1(X,L,N), counter(C), 
  C1 is C+N, retract(counter(C)), 
  asserta(counter(C1)),!.
*/

