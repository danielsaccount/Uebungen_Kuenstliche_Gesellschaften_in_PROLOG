/* exam411 

Hier wird die Veränderung von Warenwerten in der Form von SMASS (Balzer, 
W. 2000: SMASS: A Sequential Multi-Agent System for Social Simulation. In 
R.Suleiman, R., Troitzsch, K.G., Gilbert, N. (eds.), Tools and Techniques for 
Social Science Simulation, Heidelberg, Physica Verlag, 65-82) programmiert 
und in zwei Weisen grafisch dargestellt.

In SMASS wurden zum Hauptprogramm Dateien dazugeladen, die "in alter Zeit"
keine Endungen tragen mussten. Diese Dateien haben wir hier mit der Endung 
".pl" versehen. Wir haben die Variablen hier knapp gehalten. Wenn beim Lesen
nicht mehr klar ist, was eine Variable bedeutet, haben wir am Anfang des
Programms eine Liste von "Lexikoneinträgen" zusammengestellt. 

In 1 werden die Fakten, die hier mit der Hülle fact(R,T,...) umgeben werden, 
dynamisch gehalten (siehe Abschnitt 2.5 unseres Buches). In 2 werden diese
ausgelagerten Dateien geladen. In 3 werden Daten aus den Parametern erzeugt.
In 4 werden diese Daten nicht erzeugt; sie sind schon verhanden. Sie werden
mit "consult" geladen.
 
In 6 werden die Anzahlen von Wiederholungsrunden ("runs", RR) und von Ticks
("periods", TT) aus der Datenbasis geholt. In der Schleife in 7a werden RR
Wiederholungen des "Hauptprogramms" ausgeführt. Am Ende dieser Wiederholungen 
wird in 7b das Programm "make_pictures" gestartet. Die Resultate existieren 
zu diesem Zeitpunkt. Aus den Resultaten werden zwei Figuren gezeichnet, mit 
denen diese Resultate besser zu verstehen sind. 

In einer Wiederholung in 7a werden in 8 die Originaldaten wieder aus der 
externen Datei data411.pl geholt, in 9 werden all diese Daten mit der Hülle 
fact(R,1,...) umgeben und in die Datenbasis eingetragen. 

In 10 finden wir die Zeitschleife und in 11 werden am Ende der Zeitschleife 
alle Daten der Art fact(...) wieder gelöscht. In einem Schleifenschritt wird
kernel(...)  bearbeitet. Zur Vorbereitung wird in 11 und damit in 12 eine
Schleife über die Anzahl der Handlungstypen gelegt. In 12 findet PROLOG den
Term prepare(R,T,MOD) - MOD bedeutet hier Handlungstyp. Dieser Term findet 
sich in der Datei rules.pl. Diese Datei wurde am Anfang in das Hauptprogramm
geladen. In dem Beispiel passiert hier gar nichts (siehe rules.pl).  
In 13 wird die Liste L aller Akteure generiert und in die Datenbasis 
eingetragen. In 14a findet PROLOG die Akteurschleife. In dieser Schleife werden 
alle Akteure bearbeitet. Am Ende dieser Schleife werden in 14b die Daten aus 
dem Tick T an den nächsten Tick T+1 angepasst.

In 14a und 15 wird die Akteurliste geholt. In 16a wird ein Akteur A aus der 
Liste L zufällig gezogen. Der Term activate(R,T,A) beschreibt eine Handlung
zu R und T, die A ausführt. Am Ende von 16a wird dieser Akteur aus dieser
Liste gelöscht. In 16b wird diese Liste angepasst.

Der Term activate(R,T,A) spielt in 16a eine Schlüsselrolle. Das Programm 
hat mehrere Möglichkeiten weiterzugehen. Zunächst schaut in 17 der Akteur 
auf die Umgebung. Wenn im Programm etwas Wichtiges zu finden ist,
wird der Akteur sofort reagieren. Im Beispiel gibt es keine solche Information.
In 18 muss sich der Akteur entscheiden, aber er seine Briefe oder
andere Nachrichten anschaut ("execute_protocols"), oder ob A in 19 gleich in
eine andere Phase eintritt. Im ersten Fall in 18 liest A seine e-Mail. In 18
findet PROLOG den Term protocol(...), der in rules.pl niedergelegt ist und
der am Anfang in das Hauptprogramm geladen wurde. In rules.pl sehen Sie, dass
dieser Term falsch wird. Inhaltlich gesprochen bekommt A keine Mail. PROLOG 
wendet sich daher zu Zeile 19.

In 19 wird ein Handlungstyp (MODUS, M) bestimmt - eventuell durch einen
komplexen Entscheidungsprozeß. In 19.1 wird der Charakter C des Akteurs A
geholt. Dieser Charakter wurde am Anfang in create.pl erzeugt (siehe Zeile 3.1 oben). 
In 19.2 wird die Liste der Handlungstypen action_types(L) geholt. Diese Liste
ist in para.pl zu finden - und dann auch in 2.1. In 19.2 wird eine Zufallszahl
Z gezogen und mit dieser in 19.3 mit calculate(...) in 19.3.1 die Zahl Y
bestimmt. Mit C, Z und Y wird aus der Liste L der entsprechende Handlungstyp
M festgelegt. In 20 wird dann eine Handlung des Typs M ausgeführt. Der Term
act_in_type(M,A,R,T) findet sich in rules.pl .
 
In diesem Beispiel geht es um den Handlungstyp "exchange". In 20.1 in rules.pl 
wird zuerst geprüft, ob dieser Handlungstyp möglich ist. Im Beispiel muss der 
Akteur A ein Angebot machen. OFFER in 20.4 ist ein Wert einer bestimmten Quantität 
einer Warenart. Dies führt in die ökonomischen Details, die wir hier nicht 
ausbreiten. Wenn der Handlungstyp möglich ist, wird eine bestimmte Handlung 
ausgewählt. Im Beispiel passiert nichts; eine Handlung ist ausgewählt. Schließlich
wird in 20.3 die Handlung ausgeführt. Auch dies wird hier nicht weiter erklärt.
Am Schluß kommt es in 20.6 zu einem Tausch exchange(R,T,A,B,NA,NB), in dem 
zwischen dem Akteur A und dem Akteur B etwas getauscht wird.    

In 20 wird am Schluß immer ein Notausgang offen gelassen. Eine Handlung kann
oft nicht so wie vorgesehen zu Ende geführt werden. In solchen Fällen kann 
PROLOG die Klause in 16a trotzdem positiv beenden. Dies ist wichtig, um das 
Gesamtprogramm an dieser Stelle nicht gleich zu beenden.
                                       
In 14.b werden alle umhüllten Fakten angepasst. Dies passiert sowohl für
Fakten, die für einen Akteur bestimmt sind, als auch für Fakten
allgemeinerer Art. Wenn 14b beendet wird, geht PROLOG über 10a und 7a zu 7b.

PROLOG wendet sich dem Graphikprogramm in "display" zu. Diese Datei wurde am
Anfang eingeladen. PROLOG findet den Term make_picture. 
*/

:- multifile fact/3 .                                                    /* 1 */
:- dynamic fact/3 .


start:- 
  consult('para411.pl'), consult('pred411.pl'), consult('rules411.pl'),           /* 2 */
  consult('display411.pl'),
  check_inconsistent_parameters,
  ( exists_file('res411.pl'), delete_file('res411.pl') ; true ), 
  ( exists_file('data411.pl'), delete_file('data411.pl') ; true ), 
  action_types(L), make_list_of_variables(L,LV),                       /* 2.1 */
  make_reduced_list_of_variables(L,LV,RLV),
  use_old_data(X),
  (   X = no, create_data(L,RLV)                                         /* 3 */
  ;   X = yes, consult('data411.pl')                                        /* 4 */
  ), 
  begin.                                                                 /* 5 */

check_inconsistent_parameters :- 
   actors(AS), 
   gridwidth(G), G1 is G*G, 
   ( AS =< G1
   ;
     G1 < AS, write(too_many_actors_for_the_grid), fail
   ).

make_list_of_variables(L,LV) :- asserta(list_of_variables([])), length(L,E),
   (  between(1,E,NM), build_list_of_variables(NM,L), fail ;  true ), 
   list_of_variables(LV), retract(list_of_variables(LV)),!.
 
build_list_of_variables(NM,L) :- nth1(NM,L,M), variables_in_rule(M,LM),
  list_of_variables(LVdyn), append(LVdyn,LM,Lnew),   
  retract(list_of_variables(LVdyn)), asserta(list_of_variables(Lnew)),!.

make_reduced_list_of_variables(L,LV,RLV) :-
  length(LV,EV), asserta(list_of_variables([])),                                        
  ( between(1,EV,NV), minimize_list_of_variables(NV,LV), fail ; true),!,
  list_of_variables(RLV), retract(list_of_variables(RLV)),!.

minimize_list_of_variables(NV,LV) :- 
  list_of_variables(LVdyn), nth1(NV,LV,V),
  (  member(V,LVdyn)                                                                    
  ;
    append(LVdyn,[V],LVnew), retract(list_of_variables(LVdyn)),                
    asserta(list_of_variables(LVnew))                                                 
  ),!.
   
create_data(L,RLV) :-                                                    /* 3 */
  consult('create411.pl'),
  make_global_data(L),
  length(RLV,EV),                                                                
  ( between(1,EV,NV), nth1(NV,RLV,VAR), make(VAR), fail  ; true ),!.      

make_global_data(L) :- actors(AS), make_characters(AS,L).              /* 3.1 */ 

% -------------------------------------------------------------------------- 
       
begin :-                                                                 /* 5 */
   runs(RR), periods(TT),                                                /* 6 */
   (  between(1,RR,R), mainloop(R,TT), fail;  true ), !,                /* 7a */
   make_pictures.                                                       /* 7b */

mainloop(R,TT) :-                                                       /* 7a */
  consult('data411.pl'),                                                    /* 8 */
  findall(X,fact(0,0,X),L), length(L,E),
  (   between(1,E,Z), nth1(Z,L,FACT), append('res411.pl'),
      write(fact(R,1,FACT)), write('.'), nl, told, 
      asserta(fact(R,1,FACT)), retract(fact(0,0,FACT)), fail             /* 9 */
  ;   true 
  ), append('res411.pl'), nl, told,
  (  between(1,TT,T), kernel(R,T), fail;  true ),                      /* 10a */
  retract_facts,!.                                                     /* 10b */

retract_facts :- ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail; true ).

kernel(R,T) :-                                                         /* 10a */
  prepare_individually(R,T),                                            /* 11 */
  actors(AS), findall(I,between(1,AS,I),L),                             /* 13 */
  asserta(actor_list(L)),
  ( between(1,AS,N), choose_and_activate_actor(R,T,N), fail            /* 14a */
  ;
    true 
  ), retract(actor_list(L1)),
  adjust(R,T),!.                                                       /* 14b */

prepare_individually(R,T) :- action_types(LM), length(LM,EM),           /* 11 */
  ( between(1,EM,NM), nth1(NM,LM,MOD), prepare(R,T,MOD), fail           /* 12 */
  ; true),!.

choose_and_activate_actor(R,T,N) :-                                    /* 14a */
  actor_list(L), length(L,E),                                           /* 15 */
  Y is random(E)+1, nth1(Y,L,A), activate(R,T,A), delete(L,A,L1),      /* 16a */
   retract(actor_list(L)), asserta(actor_list(L1)),!.                  /* 16b */

activate(R,T,A) :-                                                     /* 16a */
  check_environment(R,T,A),                                             /* 17 */
  (   execute_protocols(R,T,A)                                          /* 18 */        
  ;                                                      
      choose_action_type(R,T,A,M),                                      /* 19 */            
      ( act_in_type(M,A,R,T) ; true)                                    /* 20 */      
  ),!.                                           

check_environment(R,T,A) :- true.                                       /* 17 */                           
execute_protocols(R,T,A) :- protocol(M,A,R,T).                          /* 18 */

adjust(R,T) :-                                                         /* 14b */
 action_types(L), length(L,E), actors(AS),
 ( between(1,E,X), adjust_individually(X,R,T,AS,L), fail; true ),
  adjust_generally(R,T), append('res411.pl'), nl, told,!.

adjust_individually(X,R,T,AS,L) :- nth1(X,L,Z),
  ( between(1,AS,A), adjust(Z,A,R,T), fail ; true),!,
  adjust(Z,R,T).          

adjust_generally(R,T) :- T1 is T+1, repeat,
   ( fact(R,T,FACT), retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),
     append('res411.pl'), write(fact(R,T1,FACT)), write('.'), nl, told,
     fail
  ; true 
  ),!.

choose_action_type(R,T,A,M) :-                                          /* 19 */
   fact(R,T,character(A,C,SUM)), length(C,K),                         /* 19.1 */
   action_types(L), Z is random(SUM * 1000)+1, asserta(aux_sum(0)),   /* 19.2 */
   between(1,K,X), calculate(X,Z,C,Y), Z =< Y , nth1(X,L,M),          /* 19.3 */
   retract(aux_sum(SS)),!.                                            /* 19.4 */
   
calculate(X,Z,C,Y) :- aux_sum(S), nth1(X,C,C_X),                    /* 19.3.1 */
   Y is S + (C_X * 1000),
   retract(aux_sum(S)), asserta(aux_sum(Y)),!.  



% -------------------------------------------------------------------------------------

make_pictures :- 
  action_types(LM), length(LM,EM), 
  consult('res411.pl'),  /* this file should be reduced */ 
  ( between(1,EM,NM), nth1(NM,LM,MOD), make_picture(MOD), fail ; true),!.

