% data211.pl

:- dynamic [ message/2 , mailbox/2 , lister/3 ].

tick(3).
actor(187). 
mailbox(187,news([[21,3,m(8)],[157,3,m(9)]])).
lister(3,187,[[12,3,m(14)],[88,3,m(12)]]).
intelligence(187,2).
capacity(187,5).
 message(187,[76,3,m(1)]).  message(187,[120,3,m(3)]).
 message(187,[50,3,m(2)]).  message(187,[77,3,m(4)]).
 message(187,[14,3,m(3)]).  message(187,[97,3,m(5)]).
 message(187,[5,3,m(6)]).
action_mode(3).
