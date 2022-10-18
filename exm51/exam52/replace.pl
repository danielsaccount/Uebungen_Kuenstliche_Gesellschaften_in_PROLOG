% replace (exam522) 

/* an der richtigen Stelle NR der Liste LIST1 wird X durch Y ersetzt.
Das Resultat ist die Liste LIST2. */  


replace(NR,X,LIST1,Y,LIST2) :-
   nth1(Z,LIST1,X),
   NR = Z, 
   asserta(list1([])), asserta(list2(LIST1)),
   ( between(1,Z,N), make_list1(L,N,NR,Y,LIST1), fail; true),
   list1(L5), list2(L6), append(L5,L6,LIST2).

make_list1(L,N,NR,Y,LIST1) :- 
  list1(L1), nth1(N,LIST1,K), list2(L3),
  ( N < NR, K1 = K ; N = NR, K1 = Y ),
  append(L1,[K1],L2), L3 = [H|Tail], L4 = Tail,
  retract(list1(L1)), asserta(list1(L2)),
  retract(list2(L3)), asserta(list2(L4)),!.

