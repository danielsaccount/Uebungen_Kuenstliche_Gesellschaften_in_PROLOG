/* exam 222.pl

Wir beschreiben in einem Beispiel wie der "findall" Befehl funktioniert.

In der Datenbasis haben wir eine Menge von Fakten der Art "action_typ"
eingeladen. Das erste Argument in einem Handlungstyp ist ein Tick und das zweite 
Argument ein Akteur. Das dritte Argument ist der Anfangszustand und das vierte
Argument der Endzustand einer Handlung des entsprechenden Typs. Wir haben
die Zustände stark abgekürzt, so dass ein Zustand durch ein Wort für einen
elementaren Handlungstyp beschrieben wird. Eine Handlung des Typs 
"action_typ" beschreibt also, dass zu einem Tick durch einen Akteur ein
Anfangszustand in einen Endzustand umgewandelt wird. 
*/
 

action_typ(1,23,walk,sit).
action_typ(1,2,sleep,wake_up).
action_typ(2,23,walk,sit).
action_typ(2,2,wake_up,see).
action_typ(3,23,walk,sit).
action_typ(3,35,drink,eat).
action_typ(4,23,talk).
action_typ(4,36,walk,sit).
actor(23). actor(36). 

start :- 
  trace ,
  (exists_file('res222.pl'), delete_file('res222.pl'); true),  
  actor(A),
  findall(TICK,action_typ(TICK,A,walk,sit),TICK_LIST),
  write(list_of_ticks(TICK_LIST,23,walk,sit)),
  append('res222.pl'), write(list_of_ticks(TICK_LIST,23,walk,sit)), write('.'),
  nl, told. 



