/* exam431.pl 

Ein Krisenprogramm, in SMASS Format. Eine kurze Beschreibung findet sich 
in krisen.pdf im selben Ordner.

Hier werden keine Wiederholungsschritte ausgeführt; in para431.pl ist die
Anzahl der Runs auf 1 gestellt: run(1). 

In diesem Programm werden am Anfang Paare [A,B] von Akteuren generiert,
so dass B ein Feind von A ist. Weiter gibt es für jeden Akteur A eine 
Geschichte ("history(ACTOR,H)". Die Geschichte H besteht aus einer Liste 
von Paaren [ACTION_TYP,ENEMY], wobei Akteur ENEMY ein Feind von ACTOR im
Term history(ACTOR,H) ist.    

In 1 wird die Liste L der Handlungstypen (modes) aus der Datenbasis
geholt. In 2 werden die Anfangsfakten erzeugt. In 2.1 wird das 
Erzeugungsprogramm create.pl geladen. In 2.2 werden für jeden
Handlungstyp die entsprechenden Fakten erzeugt. In 3 beginnt die 
Hauptschleife, die hier nur einen Schritt beinhaltet (Run, R = 1). 

In Zeile 4.1 werden die gerade erzeugten Fakten aus das Datei data431.pl geholt. 
In 4.2 werden diese Fakten "umformatiert". D.h. Fakten der Form 
fact(R,0,FACT) werden zu fact(R,1,FACT). Diese Fakten werden auch an die
Resultatdatei res4312.pl geschickt. In 5 wird die Zeitschleife bearbeitet 
und in 4.3 werden am Ende alle Fakten der Form fact(...) gelöscht.

In 5.1 wird die Anzahl AS der Akteure geholt. In 6 wird eine Liste von
Paaren [A,B] von Akteuren generiert, so dass Akteur B ein Feind von A ist.
In 7 wird über diese Liste eine Schleife gelegt. Am Ende dieser Schleife
wird in 5.4 die Feindliste enemy_list wieder gelöscht. Im 5.5 werden am Ende
eines Ticks alle Fakten, die den Tick T tragen, transformiert zu Fakten, die
den Tick T+1 tragen. 
 
In 7.1 wird die Feindliste L4 geholt und ihre Länge bestimmt. In 7.2 wird
eine Zufallszahl aus dem Bereich von 1 bis E4 gezogen und aus der Feindliste 
ein entsprechendes Feindpaar P aus der Liste herausgenommen. In 7.3 wird das
Paar bearbeitet. In 7.3 wird dieses Paar aus der Feindliste entfernt
und in 7.4 wird die Feindliste angepasst.

In 8.1 wird das Paar P in zwei Akteure A und B aufgelöst. In 9 wird ausgehend 
von dem Akteur A und "seinem" Feind B eine Krisenhandlung bearbeitet.
In 9.1 wird mit check_environment die Umgebung aus dem Blickwinkel von A
untersucht. Dazu wird die Geschichte ("history") von A aus der Datenbasis
geholt, welche in 2 erzeugt wurde oder später im Ablauf vorhanden ist.
Die Geschichte LL von A ist mit dem Wrapper fact(R,T,...) umhüllt und die
Geschichte selbst besteht aus dem Term history(A,LL). Das erste Paar der
Geschichte von A wird hier aus technischen Gründen mitgeschleppt. Die 
restlichen Paare werden im Ablauf jeweils angefügt, wenn sich A gerade in
einer Auseinandersetzung mit dem Akteur B befindet. Zum Beispiel finden 
wir die Geschichte history(3,LL) das Akteurs 3:

   LL = [[0, 0], [attack, 5], [conquer, 5], [appease, 8],...],

wobei 5 und 8 zwei Feinde sind. Die Zahlen entsprechen in der "history" der
zeitlichen Ordnung. Zum Beispiel hat 3 den Feind 5 angegriffen und 
in einem späteren Tick erobert. Die genauen Zeitpunkte der Ereignissen
sind dabei nicht notiert.

In 9.2 werden alle Handlungstypen aus dieser Geschichte gesammelt,
die  bei Auseinandersetzungen zwischen A und B stattgefunden haben. Diese
Handlungstypen werden in eine Liste ENEM geschrieben. In 9.3 wird mit 
actor_history(A,B,ENEM) diese Liste in die Datenbasis eingetragen und 
auch an die Resultatdatei geschickt. 

In 9.6 wird die Mailbox geöffnet. In diesem Programm sucht PROLOG in 
rules.pl, ob es eine Nachricht gibt. Für jeden Handlungstyp findet PROLOG 
den Term protocol(AT,A,B,R,T), in dem AT durch einen Handlungstyp 
instantiiert ist. Dieser Term wird in diesem Beispiel immer falsch. 
PROLOG findet in rules431.pl immer eine entsprechende Klause. Daher wendet 
sich PROLOG der Zeile 9.7 zu.

In 9.7 wird für A ein bestimmter Handlungstyp ausgewählt. In 9.7.1 wird die 
Ausprägung der Aggressivität ("aggression") des Akteurs A aus der Datenbasis
geholt. Die Ausprägungen von Aggressivität wurden in 2 für jeden Akteur
zufällig erzeugt. In 

   aggression(A,EMO) 

bedeutet EMO eine Ausprägung - eine Zahl zwischen 1 und 3 - der 
Aggressivität von A. Die Anzahl der Ausprägungen (hier: 3) ist in para431.pl
niedergelegt: weights(aggression,3,[50,95,101]). 3 bedeutet, dass es um 3
Ausprägungen geht und die Liste [50,95,101] drückt eine diskrete
Häufigkeitsverteilung aus. Im Beispiel sehen wir, dass die erste Ausprägung 
bei den Akteuren am häufigsten vorkommt, die zweite Häufigkeit
kommt fast genauso oft vor, während die Häufigkeit der dritten Ausprägung
nur 5 Prozent beträgt (genaueres in Abschnitt 2.3 in unserem Buch). Inhaltlich ist
in diesem Fall der Akteur A sehr aggressiv. In 9.7.3 wird die Liste L5 der 
Handlungstypen aus der Datenbasis geholt, die in actor_history(A,B,L5) 
beschrieben ist. Die Liste L5 betrifft hier nur Auseinandersetzungen 
zwischen A und B. Die Länge dieser Liste wird berechnet. 

Hier gibt es zwei Fälle. Im ersten Fall gab es bis zu dem gerade 
bearbeiteten Tick noch keine Auseinandersetzung zwischen A und B. In dem 
Fall wird in 9.10 der Akteur A eines der vier Handlungstypen wählen. Dies 
hängt von der Ausprägung der Aggression von A ab. Wenn A die höchste (hier:
dritte) Aggressionsstufe hat, wird A angreifen: "attack". Wenn A wenig 
aggressiv ist, tut A nichts "do_nothing" und bei mittlerer Aggressionstufe 
wählt A zufällig eine der drei Handlungstypen aus: threat, attack oder 
do_nothing. Die Variable M ist nun eine Zahl (zwischen 1,2,3), die in 9.10 
an choose_free(R,T,A,B,EMO,M) und dann in 9.7 an den Term 
choosemode(R,T,A,B,M) übergeben wird. 

Im zweiten Fall, wenn es schon eine Vorgeschichte über beide Kontrahenten 
gibt, wird in 9.11 eine Entscheidung für A etwas schwieriger. Dies brauchen 
wird nicht im Dateil zu beschreiben. Auch in 9.11 ist der Typ M in 9.7 
instantiiert.

In allen Fälle wird in 9.12 act_in_mode(M,A,B,R,T) aufgerufen. Dieser Term
findet sich in der Regeldatei "rules41.pl". In diesem Beispielprogramm wird
dieser Term immer positiv beenden. In anderen Programmen mit anderen
Handlungstypen kann eine Handlung auch scheitern. 
 
Wir erläutern nur eine der sieben Regel für die sieben Handlungstypen.
In act_in_mode(threat,A,B,R,T) wird in 9.12.1 in "rules431.pl" geprüft, ob
an dieser Stelle des Ablaufs eine Handlung der Art M (hier: "threat")
möglich ist. Dies ist der Fall. In 9.12.1.1 werden dazu die Stärken beider
Kontrahenten A und B aus der Datenbasis geholt: strength(A,SA) und 
strength(B,SB). Dabei sind SA und SB Zahlen zwischen 1 und 3. Diese Zahlen
sind die drei Ausprägungen der Stärke, die in "para.pl" mit
weights(strength,3,[33,66,101]) benutzt werden. Hier gibt es zwei
Möglichkeiten. In 9.12.1.1 ist Akteur A stärker als B (SB < SA). In diesem
Fall wird die Variable X auf 0 gesetzt. Im anderen Fall, wenn A nicht 
stärker als der Feind B ist, bekommt die Variable den Wert 1. In 9.12.1.2 
wird eine Klause bearbeitet, in der hier nichts passiert. In 9.12.3 wird 
die Handlung der Art "threat" (Bedrohung) ausgeführt. 

Dazu wird in 9.12.3.1 die Geschichte des Akteurs A geholt. Im Fall X=0 
greift A an. Im anderen Fall (X=1) tut A nichts, weil der Feind stärker 
als A ist. In 9.12.3.4 wird die entsprechende Information der Geschichte 
von an A hinzugefügt. Damit ist diese Handlung abgeschlossen. PROLOG wandert
von 9 und 8 zu 7, wo das nächste Feindpaar von A bearbeitet wird. Wenn alle
Feindpaare bearbeitet wurden, wird in 5 der nächste Tick bearbeitet.
Am Ende dieser Schleife wird schließlich in 4.3 der Zeitschleife beendet;
alle Fakten der Art fact(...) werden gelöscht.

Damit ist ein Run beendet. In 3 sind schließlich auch die Wiederholungen
ausgeführt. In 3.1 können wir, wenn wir wollen, die Klause make_picture
aktivieren. Diese Klause findet sich in "display431.pl". Um sie zu bearbeiten,
wird "display431.pl" mit "consult" geladen. 

In diesem Beispiel werden Sie bei graphischen Darstellung sehen, dass oft 
keine Veränderung sichtbar wird. Dies liegt daran, dass hier immer nur ein
Akteur (hier Akteur Nr. 3) dargestellt wird. Oft wird Akteur Nr.3 eben keine
Krise verursachen und wird auch nicht involviert. In solchen Fällen, können 
Sie nur einen neuen Ablauf starten und warten, ob der Akteur nun an einer 
Krise beteiligt ist. Wenn nicht, wird wieder ein neuer ABlauf gestartet.
Und so weiter. 
*/

:- multifile fact/3 .

start:- 
  consult('para431.pl'), consult('pred431.pl'), consult('rules431.pl'), 
  check_inconsistent_parameters,
  ( exists_file('res4311.pl'), delete_file('res4311.pl') ; true ),
  ( exists_file('res4312.pl'), delete_file('res4312.pl') ; true ),
  ( exists_file('data431.pl'), delete_file('data431.pl')
  ;
    true
  ), 
  modes(L), make_list_of_variables(L,LV),                                 /* 1 */
  make_reduced_list_of_variables(L,LV,RLV),
  use_old_data(X),
  (   X = no,
      create_data(L,RLV)                                                  /* 2 */
  ;   X = yes, consult('data431.pl') 
  ), 
  begin.                                                                  /* 3 */

check_inconsistent_parameters :- true.

make_list_of_variables(L,LV) :- asserta(list_of_variables([])), 
   length(L,E),
   (  between(1,E,NM), build_list_of_variables(NM,L), fail ;  true ), 
   list_of_variables(LV), retract(list_of_variables(LV)),!.
 
build_list_of_variables(NM,L) :- nth1(NM,L,M), variables_in_rule(M,LM),
  list_of_variables(LVdyn), append(LVdyn,LM,Lnew),   
  retract(list_of_variables(LVdyn)), asserta(list_of_variables(Lnew)),!.

make_reduced_list_of_variables(L,LV,RLV) :-
  length(LV,EV), 
  asserta(list_of_variables([])),                                              
  ( between(1,EV,NV), minimize_list_of_variables(NV,LV), fail ; true),!,             
  list_of_variables(RLV), retract(list_of_variables(RLV)),!.

minimize_list_of_variables(NV,LV) :- list_of_variables(LVdyn),                        
      nth1(NV,LV,V),                                                                     
     (  member(V,LVdyn)                                                                 
     ;
        append(LVdyn,[V],LVnew),
        retract(list_of_variables(LVdyn)),                
        asserta(list_of_variables(LVnew))                                              
     ),!.
   
create_data(L,RLV) :-
  consult('create431.pl'),                                                 /* 2.1 */
  length(RLV,EV),                                                                
  ( between(1,EV,NV), nth1(NV,RLV,VAR), make(VAR), fail  ; true ),!.    /* 2.2 */      

% ------------------------------------------------------------------------------         

begin :- runs(RR), periods(TT),                                           /* 3 */
   (  between(1,RR,R), mainloop(R,TT), fail;  true ), 
   consult('display431.pl'),
   make_a_picture,!.                                                    /* 3.1 */

mainloop(R,TT) :-                                                         /* 4 */
  consult('data431.pl'),                                                   /* 4.1 */
  findall(X,fact(0,0,X),L), length(L,E),                                /* 4.2 */
  (   between(1,E,Z), nth1(Z,L,FACT), append('res4312.pl'),
      write(fact(R,0,FACT)), write('.'), nl, told, 
      asserta(fact(R,1,FACT)), retract(fact(0,0,FACT)), fail
  ;   true 
  ), append('res4312.pl'), nl, told,
  (  between(1,TT,T), kernel2(R,T), fail;  true ),                        /* 5 */
  retract_facts,!.                                                      /* 4.3 */

retract_facts :- ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail; true ).

kernel2(R,T) :-                                                           /* 5 */
   actors(AS),                                                          /* 5.1 */
   make_enemy_list(AS,L1),                                                /* 6 */
   length(L1,E1),
   ( between(1,E1,N), choose_and_activate_actor(R,T,N), fail              /* 7 */
   ;
     true 
   ),
   retract(enemy_list(L2)),                                             /* 5.4 */
   adjust(R,T),!.                                                       /* 5.5 */

make_enemy_list(AS, L1) :- 
  asserta(enemy_list([])),
  ( between(1,AS,A), find_enemy(A,AS), fail ; true),
  enemy_list(L1),!. 

find_enemy(A,AS) :- findall(B,between(1,AS,B),L3), delete(L3,A,L3new),
   E3 is AS - 1, Y is random(E3) + 1, 
   nth1(Y,L3new,B), enemy_list(LIST), append(LIST,[[A,B]],LISTnew),
   retract(enemy_list(LIST)), asserta(enemy_list(LISTnew)),!.

choose_and_activate_actor(R,T,N) :-                                       /* 7 */
   enemy_list(L4), length(L4,E4),                                       /* 7.1 */
   Y is random(E4)+1, nth1(Y,L4,P),                                     /* 7.2 */
   activate_pair(R,T,P),                                                  /* 8 */
   delete(L4,P,L4new),                                                  /* 7.3 */
   retract(enemy_list(L4)), asserta(enemy_list(L4new)),!.               /* 7.4 */

activate_pair(R,T,P) :-    
  P = [A,B],                                                              /* 8 */
  activate(R,T,A,B),!.                                                    /* 9 */

activate(R,T,A,B) :-                                                      /* 9 */
  check_environment(R,T,A,B),                                           /* 9.1 */
  (   execute_protocols(R,T,A)                                          /* 9.6 */
  ;                                                      
      choosemode(R,T,A,B,M),                                            /* 9.7 */       
     ( act_in_mode(M,A,B,R,T) ; true)                                  /* 9.12 */   
  ),
  retractall(actor_history(A,B,LIST1)),!.       
                              
check_environment(R,T,A,B) :-                                           /* 9.1 */
  fact(R,T,history(A,LL)),                                              /* 9.2 */
  findall(TYP,nth1(X,LL,[TYP,B]),ENEM),                                 /* 9.3 */
  asserta(actor_history(A,B,ENEM)),                                     /* 9.4 */
  append('res4311.pl'), write(actor_history(R,T,A,B,ENEM)),             /* 9.5 */
  write('.'), nl, told,!.
     
execute_protocols(R,T,A) :- protocol(A,R,T).                            /* 9.6 */
 
choosemode(R,T,A,B,M) :-                                                /* 9.7 */ 
   fact(R,T,aggression(A,EMO)),                                         /* 9.8 */
   actor_history(A,B,L5), length(L5,E5),                                /* 9.9 */
   ( E5 = 0 , choose_free(R,T,A,B,EMO,M)                               /* 9.10 */
   ;
     0 < E5, choose_constrainted(R,T,A,B,L5,EMO,M)                     /* 9.11 */
   ),!.

choose_free(R,T,A,B,EMO,M) :-                                          /* 9.10 */
   ( EMO = 3, M = attack
   ;
      ( EMO = 2, LLL = [threat, attack, do_nothin],
        X is random(3) + 1, nth1(X,LLL,M)
      ;
        EMO = 1, M = do_nothin
      )
   ),!.

choose_constrainted(R,T,A,B,LIST5,EMO,M) :-                            /* 9.11 */
   length(LIST5,E5), nth1(E5,LIST5,TYP), 
   ( EMO = 3, M = attack
   ;
     (  EMO = 2, findall(TYP1,escalate(TYP,TYP1),LIST6),
        length(LIST6,E6), 
        ( 0 < E6, Y is random(E6) + 1, nth1(Y,LIST6,M)
        ; 
          0 = E6, choose_free(R,T,A,B,EMO,M)
        )  

     ;   
        EMO = 1, 
          ( TYP = attack, M = defend
          ;
            findall(TYP2,deescal(TYP,TYP2),LIST7),
            length(LIST7,E7),
            ( 0 < E7,  Y is random(E7) + 1, nth1(Y,LIST7,M)
            ;
              0 = E7, choose_free(R,T,A,B,EMO,M)
            )
          )
     )
   ),!. 

adjust(R,T) :- modes(L),
  length(L,E), actors(AS),
  ( between(1,E,X), individual_adjust(X,R,T,AS,L), fail; true ),
  global_adjust(R,T),
  append('res4312.pl'), nl, told,!.

individual_adjust(X,R,T,AS,L) :- nth1(X,L,Z),
  ( between(1,AS,A), adjust(Z,A,R,T), fail ; true),!,
  adjust(Z,R,T).         

global_adjust(R,T) :- T1 is T+1, 
   repeat,
   ( fact(R,T,FACT), 
     append('res4312.pl'), write(fact(R,T,FACT)), write('.'), nl, told,
     retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),
     fail
   ; true 
   ),!.



% --------------------------------------------------------------------------------

make_pictures :- modes(LM), length(LM,EM), 
  consult('res4312.pl'),  consult('res4311.pl'),
  ( between(1,EM,NM), nth1(NM,LM,MOD), make_picture(MOD), fail ; true),!.

