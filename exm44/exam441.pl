/* exam441.pl 

Ein Beispiel f�r �berzeugungs�nderung, im SMASS Format.  
Wiederholung haben wir hier nicht programmiert. 

Als Beispiel haben wir den Handlungstyp des Predigens im relig�sen Sinn
genommen.

Die grundlegenden Objekte f�r dieses Programm sind in para.pl hinterlegt.
Die Anzahlen haben wir wie folgt festgelegt: runs(1), periods(5), 
actors(7), events(13) und actions(8).
Als herausgehobene Handlungstypen verwenden wir "preach", "hear_the_word", 
und "other". Zu diesen Handlungstypen geh�ren die Pr�dikate "bel" 
(�berzeugung) und "int" (Einstellung, Intention). Beim Predigen wird 
zus�tzlich die Eigenschaft "sinful" (s�ndhaft) benutzt. 

In 1 werden Satellitendateien geladen, in 2 werden die Resultatdateien
geleert. In 3 wird die Liste L der Handlungstypen aus der Datenbasis 
geholt. In 4 werden die Anfangsfakten erzeugt. 

Dazu wird in 5 die Datei create441.pl geladen. In 6 wird die Klause make_names
aufgerufen. Hier werden Listen von echten Namen f�r die Akteure geholt,
die in der Datei para441.pl zu finden sind. Die Klause in 6 wird in create441pl
beschrieben. Dort werden in 6.1 und 6.2 zwei Listen von echten Namen aus 
der Datei para441.pl geholt. In 6 werden diese echten Namen wieder in 
nat�rliche Zahlen verwandelt. PROLOG hat nach dieser Transformation mehr 
M�glichkeiten, mit "Namen" umzugehen.

In 7 werden die Liste der Ereignisse erzeugt. In 7.1 wird die Anzahl der 
Ereignisse aus der Datenbasis geholt. Die drei explizit genannten 
Handlungstypen werden in 7.2 als Liste der Datenbasis hinzugef�gt. In 7.4
werden die restlichen (hier: 10) Elementarereignisse erzeugt und in 
die Ereignisliste eingetragen. In 7.4.1 wird an die Liste LIST von
Ereignissen das neue Elementarereignis evtNE angeh�ngt, wobei der Term 
"evt" mit der Zahl NE konkateniert wird. 

In 8 werden Intentionen, �berzeugungen und die Eigenschaft s�ndhaft zu sein
erzeugt. Die Intention eines Akteurs zu R und T notieren wir so

   fact(R,T,int([A,W,AT])).

Akteur hat mit Wahrscheinlichkeit W die Einstellung eine Handlung der Art
AT auszuf�hren. AT ist ein Handlungstyp.

�berzeugungen werden im mehreren Arten erzeugt. In der einfachsten Form 
sieht eine �berzeugung so aus

   fact(R,T,bel([1,A,W,EVT])).

D.h. zu R und T ist Akteur A mit Wahrscheinlichkeit W �berzeugt, dass
das Ereignis EVT stattfindet. "1" dr�ckt aus, dass es um eine �berzeugung
erster Stufe geht. Eine �berzeugung N-ter Stufe sieht so aus

   fact(R,T,bel([N,A,W,bel(BEL)]))).

Die ausgedr�ckte �berzeugung hat selbst die Form einer �berzeugung
bel(BEL). Im einfachsten Fall ist N = 2. F�r N = 3 wird BEL selbst
wieder ein Term bel(BEL1), also bel(BEL) = bel(bel(BEL1)).
 
In 9 beginnt die Hauptschleife. In 10 werden die Anzahlen RR von Runs und
Anzahlen TT von Ticks aus der Datenbasis geholt. In 11 wird die 
Wiederholdungschleife berbeitet. Am Ende wird die Ereignisliste, die im
Ablauf entstanden waren, wieder gel�scht. 

In einer Wiederholung wird in 13 die Datei data441.pl geladen. In 14 
werden alle Fakten der Form fact(0,0,X) in eine Liste L gesammelt. Die
L�nge dieser Liste wird bestimmt. In 15 werden all diese Fakten einerseits
an die Resultatdatei geschickt, andererseits wird jeder Fakt der Art  
fact(0,0,FACT) in fact(R,1,FACT) transformiert. D.h. all diese Fakten 
liegen nun f�r die erste Zeitschleife bereit. Die Zeitschleife wird in
16 genauer beschrieben.

In 18 werden f�r einen Tick, der in einem Schleifenschritt bearbeitet wird,
zun�chst einige Vorbereitung getroffen. In 18.1 in rules.pl werden drei
Hilfslisten eingerichtet: eine Liste von Zuh�rern (list_of_hearers), eine
Liste von Predigern (list_of_preachers) und eine Liste von weiteren 
Akteuren, die etwas anderes tun (list_of_others). Diese Listen werden zu 
diesem Tick gef�llt. Zu diesem Tick werden in der ersten Liste alle Zuh�rer
eingetragen, in die zweite Liste die Prediger, etc. Am Ende des Ticks
werden diese Hilfslisten in 34 wieder gel�scht, siehe auch in rules.pl unter
34. In 19 wird die Anzahl der Akteure geholt. In 20 wird die NUMBER_ACTORLIST
aus der Datenbasis geholt, die in create.pl in 5 erzeugt wurde. In 21 werden
diese Nummern aufgemischt. Die neue ACTORLIST wird in 22 mit 
temporal_list_of_actors in die Datenbasis eingetragen. In 23 wird die 
Akteurschleife aufgerufen. Am Schlu� dieser Schleife wird die Liste
temporal_list_of_actors wieder gel�scht.

In einem Schleifenschritt wird in 27 die tempor�re Liste L geholt und 
die L�nge E bestimmt. In 28 wird aus dieser Anzahl eine Zufallszahl Y
gezogen, welche eine Stelle auf dieser Liste angibt. Die Y-te Komponente,
eine Akteur A, wird aus dieser Liste herausgeholt. In 29 wird der Akteur A
mit active(R,T,A) aktiviert. In 30 wird dieser Akteur aus der tempor�ren
Liste gestrichen und diese Liste angepasst.

In Klause 29 werden die ersten beiden M�glichkeiten in diesem Beispiel
nicht benutzt. In 30 entscheidet der Akteur, welchen Handlungstyps TYP er 
ausw�hlt. Dazu wird in 40 die Liste und die Anzahl der Ereignisse geholt.
In 42 wird eine zun�chst leere Hilfsliste f�r Ereignisse und ihre
Wahrscheinlichkeiten eingerichtet: "list_of_random_events(...)". In 43
wird eine Schleife �ber die Zahl EVTS der Ereignisse gelegt. In einem
Schleifenschritt in 49 wird eine Nummer f�r ein Ereignis EVT aus der 
Ereignisliste geholt. In 50 wird die Hilfsliste 
UNSORTED_LIST_OF_RANDOM_EVENTS von Ereignissen geholt. In 51 wird die
Einstellung "int([A,...])" des Akteurs A aus der Datenbasis geholt. Diese
wurde in create.pl erzeugt. In 52 wird zur Hilfsliste
UNSORTED_LIST_OF_RANDOM_EVENTS das neue Paar [W,EVT], bestehend aus der
Wahrscheinlichkeit W und dem Namen EVT des Ereignisses, hinzugef�gt. Diese
Hilfsliste wird in 53 und 54 angepasst. 

Wenn die Schleife in 43 bearbeitet ist, finden wir in 44 die vollst�ndige
Hilfsliste LIST_OF_RANDOM_EVENTS. In 45 wird der Term 
list_of_random_events(LIST_OF_INTENDED_PAIRS) gel�scht. Die Liste selbst 
ist noch in der Datenbasis vorhanden. In 46 wird diese Liste sortiert. In 47 wird
die L�nge E1 der sortierten Liste bestimmt. In 48 wird aus dieser Liste
SORTED_LIST_OF_RANDOM_EVENTS die letzte Komponente [W,TYP] aus dieser Liste 
herausgeholt. Durch sortieren wurden in 45 die ersten Komponenten aus den 
Paaren der Reihe nach geordnet. In 48 wird nun der Term TYP an 31 �bergeben.

Im 30 wird der so gefundene Handlungstyp TYP mit dem Term 
act_in_type(TYP,A,R,T) in rules.pl weiter bearbeitet. D.h. eine Handlung
dieses Tps wird ausgef�hrt. Falls die Handlung scheitert, l�uft das 
Hautprogramm trotzdem weiter: (... ; true).
        
In rules.pl werden die drei Handlungstypen in 31.1, 31.2 und 31.3 beschrieben. 
In 31.1 geschieht beim Predigen nach den Vorbereitungen folgendes. Die Anzahl 
AS von Akteuren wird in 31.1.1 geholt und in 31.1.3
wird nach s�ndvollen Ereignissen EVT gesucht. Dazu wird in 31.1.6 eine
Schleife �ber die Anzahl der Akteure gelegt. Hier brauchen wir die Namen 
und Nummern der Akteure nicht zu unterscheiden. Ein bestimmter Akteur B
wird untersucht. In einem solchen Schleifenschritt wird in 31.1.12 eine 
leere Hilfsliste aux_list25([]) eingerichtet. In 31.1.13 wird die Liste 
mit einer offenen Schleife gef�llt. In 31.1.18 wird dazu eine �berzeugung
von B zu T (und R) aus der Datenbasis geholt. Die �berzeugungen von B
wurden in create441.pl erzeugt. Dort wurden auch Fakten der Art
fact(R,T,sinful(A,EVT,W)) erzeugt: "zu R und T findet Akteur A das Ereignis
EVT mit Wahrscheinlichkeit W s�ndvoll". Es geht hier um die 
subjektive Wahrscheinlichkeit, die f�r diesen bestimmten Akteur erzeugt 
wurde. In 31.1.19 wird ein Fakt aus der Datenbasis genommen, der f�r B
relevant ist. In 31.1.20 erfolgt eine Absch�tzung, ob die Wahrscheinlichkeit
W des s�ndhaften Ereignisses (f�r B) gr��er ist als ein Bruchteil WB1 der 
Wahrscheinlichkeit WB, dass f�r B das Ereignis stattgefunden hat. Wir haben
hier eine Konstante 0.2 benutzt, um einen Bruchteil zu nehmen. Dies l�sst
sich leicht realistischer machen. In 31.1.21 wird die Hilfsliste LIST
ge�ffnet. Es wird untersucht, ob das Paar [W,EVT] in dieser Liste vorhanden
ist. Wenn ja, wird 31.1.21 falsch und PROLOG springt nach 31.1.17 und 
untersucht zwei weitere Fakten, die in der Datenbasis vorhanden sind. 
Wenn PROLOG f�r B an einer Stelle alle Fakten bearbeitet hat, springt 
PROLOG zu 31.1.24 und beendet die Schleife in 31.1.13. 

Wenn in 31.1.21 das Paar [W,EVT] nicht in der Liste zu finden ist, f�gt
PROLOG dieses Paar in 22 zur Liste LIST hinzu. In 31.2.23 wird diese
Liste angepasst.     

Damit ist 31.2.13 bearbeitet. In 31.1.14 wird die nun vollst�ndig vorhandene 
Hilfsliste FACT_LIST ge�ffnet. In 31.1.15 wird die Liste L der s�ndhaften
Taten geholt. An diese Liste wird die Liste der s�ndhaften Taten f�r B
angeh�ngt und in 31.1.16 angepasst. 

Damit ist die Schleife in 31.1.6 beendet. Alle s�ndigen Taten, die im
Ged�chtnis aller Akteure zu finden waren, sind in der Liste 
list_of_sinful_deads versammelt, und zwar mit den entsprechenden 
Wahrscheinlichkeiten, jeweils von einem bestimmten Akteur gesehen. In
31.1.7 in rules441.pl wird dieser Eintrag als Term (eine Liste) aus der Datenbasis.
Die Liste LIST_OF_SINS selbst ist aber in der Datenbasis noch vorhanden.
In 31.1.8 wird diese (lange!) Liste sortiert und ihre L�nge berechnet. In
31.1.10 wird die Konstante RA mit ratio(RA) aus der Datenbasis geholt.
Weiter wird eine Zufallszahl X zwischen 1 und 100 gezogen. Im erstem
Fall in 31.1.11 ist die Konstante RA gr��er als X. In diesem Fall wird 
eine Zufallszahl Y aus dem Bereich von 1 bis E1 (d.h. inhaltlich aus der 
Liste der sortierten, s�ndhaften Ereignisse) gezogen. Das Y-te Paar
[W,EVT] ([Wahrscheinlichkeit,Ereignis]) aus dieser Liste wird genommen.
Dieses Ereignis EVT wird an 31.1.3 �bergeben. D.h. der Prediger A hat ein 
bestimmtes Ereignis EVT f�r "seine" Predigt ausgew�hlt. Die Konstante RA
dr�ckt aus, wie der Prediger vorgeht. Im Beispiel haben wir bei RA 67 
eingesetzt. D.h. ein (und in diesem Beispiel alle) Prediger w�hlt ein
Thema in zwei Dritteln seiner F�lle (RA = 67, 67/100 ist ungef�hr 2/3)
zuf�llig aus - allerdings relativ zu s�ndhaften Ereignissen. Im zweiten 
Fall in 31.1.12 w�hlt der Prediger direkt das s�ndhafteste Ereignis, das
er bei seinen Gl�ubigen findet. Wie die Konstante RA mit der Rationalit�t
von A verbunden ist, w�re interessant zu diskutieren. 

In 31.1.3 wurde ein Thema "EVT" gefunden. In 31.1.4 wird dieses Thema
zu einer Liste von Themen f�r A hinzugef�gt. Diese Liste wird angepasst.
An dieser Stelle k�nnen wir die Aktion des Predigens nicht aktivieren,
weil dies mit der hier verwendeten Schleifenstruktur kollidiert. Die Handlungen
werden alle erst am Ende des Ticks aktiviert.

Der zweite Handlungstyp hear_the_word wird in 31.2 in rules441.pl beschrieben.
In 31.2.1 wird folgende �berzeugung 

    fact(R,T,bel([2,A,W1,bel([1,B,W,preach])]))

aus der Datenbasis geholt. A glaubt, dass B glaubt, dass das Ereignis 
des Predigens stattgefunden hat. D.h. hei�t, das B vermutlich eine Predigt 
geh�rt hat. In 31.2.2 wird die Information, dass A eine Predigt geh�rt 
hat, in die Liste ("list_of_hearers") der Zuh�rer eingetragen.

Bei dem dritten Handlungstyp "other" wird in 31.3.1 die Liste der geglaubten
Ereignisse von A zu T (und R) gesammelt. In 31.3.2 wird zuf�llig eine dieser
Ereignisse aus dieser Liste genommen. In 31.3.3 wird eine M�nze geworfen.
Die Wahrscheinlichkeit f�r das Ereignis EVT (f�r A zu T) wird per M�nzwurf
entweder um den Betrag 0.05 erh�ht (falls dies m�glich ist) oder um -0.05
erniedrigt. Diese Information wird in 31.3.4 in die Liste mit
"list_of_others" eingetragen und diese Liste wird angepasst. 

PROLOG wendet sich nach Beendigung von 31 nach oben zu 29 und 23 zum Ende
der Schleife in 23. In 24 l�scht PROLOG die tempor�re Liste ACTORLIST1.
In 25 werden die Handlungen und Ereignisse am Ende des Ticks tats�chlich  
ausgef�hrt. Der Term change_data(...) wird in rules.pl ausgef�hrt.  

Dazu wird in 25.1 die Liste LIST_PR der Predigten geholt und die L�nge der
Liste berechnet. Wenn sie leer ist, passiert in 25.2 nichts. Andersfalls
wird in 25.3 die Liste LIST_H der Zuh�rer geholt und die L�nge bestimmt.
Wenn auch diese Liste leer ist (N_H = 0) passiert in 25.4 nichts. Ansonsten wird
in 25.5 eine zun�chst leere Liste ("list_of_sessions") f�r Predigten
eingerichtet. In 25.6 wird eine Schleife �ber die Anzahl der Predigten 
gelegt.
 
In 25.7 wird eine weitere Schleife �ber die Anzahl N_H der H�rer gelegt. 
In 25.8 wird ein H�rer HA aus dieser Liste genommen. Wenn diese Liste
leer ist (N_A = 0) passiert in 25.13 nichts. Im anderen Fall wird in 25.9
eine Zufallszahl aus dem Bereich von 1 bis N_H gezogen und das entsprechende
Paar bestehend aus einem Ereignis EVT mit Wahrscheinlichkeit WA aus der 
Liste LIST_PR geholt. In 25.10 wird die Liste der Predigten ("sessions")
geholt. An diese Liste wird in 25.11 das Tripel [PA,EVT,HA] angef�gt,
wobei PA der Prediger ist, der �ber das Ereignis EVT predigt und HA 
einer der Zuh�rer. In 25.12 wird die Liste von Predigten angepasst.

PROLOG wendet sich zu 25.14 und holt die nun vollst�ndige Liste LIST_SE der
Predigten. �ber diese L�nge wird eine Schleife gelegt. In einem Schleifenschritt 
wird in 25.15 aus der Liste LIST_PR eine "Predigt" [A,EVT] herausgenommen. 
In 25.26 werden alle H�rer B des Predigers A in eine Liste
LIST_H_A gesammelt. In 25.17 wird die L�nge dieser Liste berechnet. Wenn
die Liste leer ist, passiert in 25.18 nichts. Andersfalls wird in 25.19
eine Schleife �ber die Anzahl der H�rer gelegt. In 25.22 wird in einem
Schleifenschritt der NHA-te H�rer B aus der Liste LIST_H_A genommen. In
25.23 wird f�r B eine �berzeugung betreffend EVT aus der Datenbasis bestimmt:

    fact(R,T,bel([1,B,W1,EVT])).

In 25.24 wird die Wahrscheinlichkeit W1 f�r das Ereignis EVT minimal
vermindert. Im Fall, dass dies nicht geht, wird in 25.25 die Wahrscheinlichkeit
f�r dieses Ereignis auf Null gesetzt. Wenn in 25.15 keine �berzeugung dieser Art in der
Datenbasis zu finden war, geht PROLOG zu 25.27 und dann zu 25.28. Wenn
eine Intention int([B,W,EVT]) in der Datenbasis zu finden ist, wird die
Wahrscheinlichkeit f�r diese Intention minimal (W - 0.01) angepasst und auch
in der Datenbasis ver�ndert. Wenn kein entsprechender Fakt in 25.28 existiert,
geht PROLOG zu 25.32 und wendet sich zu 25.12, 25.20 und 25.15. 

In 25.17 wird die Liste der Predigten gel�scht. In 25.18 wird die Liste 
"other" der restlichen Ereignisse geholt und die L�nge berechnet. In 
25.19 wird eine Schleife �ber die L�nge dieser Liste gelegte. In 25.20 
wird schlie�lich aus der Liste der restlichen Ereignisse ein Element der
Form [A,W,Wnew,EVT] geholt. In 25.21 wird f�r den Akteur A, f�r das 
Ereignis EVT und f�r die entsprechende Wahrscheinlichkeit in der Datenbasis ein 
Fakt der Form fact(R,T,bel([1,A,W,EVT])) gesucht. Wenn dies Erfolg hat, wird 
in 25.22 dieser Fakt gel�scht. Inhaltlich glaubt A, dass das 
Ereignis EVT mit zugeh�riger Wahrscheinlichkeit W stattgefunden hat. Diese
Wahrscheinlichkeit wird zuf�llig - mit einem M�nzwurf in 25.23 - minimal
noch oben oder nach unten verschoben (wenn dies m�glich ist). Der "neue"
Fakt wird wieder in 25.26 in die Datenbasis eingef�gt. Wenn in 25.21 kein 
solcher Fakt zu finden ist, passiert in dem Schleifenschritt nichts. 

Damit wurden alle Ver�nderungen aus der �berzeugungs- und Einstellungsebene
angepasst. Wenn eine bestimmte Einstellung nach mehreren Ticks gro� genug ist,
kann dies zu einer Handlung f�hren. An dieser Stelle haben wir das Programm
hier abgebrochen. D.h. die Ausf�hrung von Handlungen wird hier nicht
beschrieben.   

Schlie�lich wird in 26 in einem Schleifenschritt in 16 die Zeit (Tick) 
angepasst. Alle Fakten, die den Tick T enthalten, werden an den n�chsten
Tick T+1 angepasst. Am Ende der Zeitschleife werden alle Fakten der Form
fact(...) wieder gel�scht, um f�r eine Wiederholung bereit zu sein.

In 12 k�nnen wir, wenn wir m�chten, die Resultate bildlich anschauen.
*/

:- multifile fact/3 .
:- dynamic fact/3 .


start:- 
  consult('para441.pl'), consult('pred441.pl'), consult('rules441.pl'),            /* 1 */
  ( exists_file('res4411.pl'), delete_file('res4411.pl') ; true ),        /* 2 */
  ( exists_file('res4412.pl'), delete_file('res4412.pl') ; true ), 
  ( exists_file('data441.pl'), delete_file('data441.pl') ; true ), 
  action_types(L), make_list_of_variables(L,LV),                          /* 3 */
  make_reduced_list_of_variables(L,LV,RLV),
  use_old_data(X),
  (   X = no, create_data(L,RLV)                                          /* 4 */
  ;   X = yes, consult('data441.pl') 
  ), 
  begin.                                                                  /* 9 */

make_list_of_variables(L,LV) :- asserta(list_of_variables([])), length(L,E),
   (  between(1,E,NM), build_list_of_variables(NM,L), fail ;  true ), 
   list_of_variables(LV), retract(list_of_variables(LV)),!.
 
build_list_of_variables(NM,L) :- nth1(NM,L,M), variables_in_rule(M,LM),
  list_of_variables(LVdyn), append(LVdyn,LM,Lnew),   
  retract(list_of_variables(LVdyn)), asserta(list_of_variables(Lnew)),!.

make_reduced_list_of_variables(L,LV,RLV) :-
  length(LV,EV), asserta(list_of_variables([])), 
  ( between(1,EV,NV), minimize_list_of_variables(NV,LV), fail ; true),!,             
  list_of_variables(RLV), 
  retract(list_of_variables(RLV)),!.

minimize_list_of_variables(NV,LV) :- list_of_variables(LVdyn),
   nth1(NV,LV,V),                                                                     
   (  member(V,LVdyn)                                                                 
   ;
      append(LVdyn,[V],LVnew),
      retract(list_of_variables(LVdyn)),                
      asserta(list_of_variables(LVnew))                                               
    ),!.
   
create_data(L,RLV) :-                                                     /* 4 */
  consult('create441.pl'),                                                   /* 5 */
  make_names,                                                             /* 6 */
  make_events,                                                            /* 7 */
  length(RLV,EV),                                                                
  ( between(1,EV,NV), nth1(NV,RLV,VAR), make(VAR), fail  ; true ),!.      /* 8 */      

% ------------------------------------------------------------------------        

begin :-                                                                  /* 9 */
   runs(RR), periods(TT),                                                /* 10 */
   (  between(1,RR,R), mainloop(R,TT), fail;  true ), !,                 /* 11 */
   retractall(list_of_events(LIST111)).

mainloop(R,TT) :-                                                        /* 11 */
  consult('data441.pl'),                                                 /* 13 */
  findall(X,fact(0,0,X),L), length(L,E),                                 /* 14 */
  (   between(1,E,Z), nth1(Z,L,FACT), 
      append('res4412.pl'),
      write(fact(R,1,FACT)), write('.'), nl, told,                       /* 15 */
      asserta(fact(R,1,FACT)), retract(fact(0,0,FACT)), fail
  ;   true 
  ), append('res4412.pl'), nl, told,
  (  between(1,TT,T), kernel3(R,T), fail;  true ),                       /* 16 */
  retract_facts,!.                                                       /* 17 */        
retract_facts :- ( fact(X,Y,Z), retract(fact(X,Y,Z)), fail; true ).

/* --------------------------------------------------------------
Die Kernel3-Variante mit echten Namen. Die Namensliste wird in create
aus den weiblichen und m�nnlichen Namen mit 'make_names' erzeugt. 
-----------------------------------------------------------------*/

kernel3(R,T) :-                                                          /* 16 */
  prepare(R,T),                                                          /* 18 */
  actors(AS),                                                            /* 19 */
  actor_list(NUMBER_ACTORLIST),                                          /* 20 */
  randomize(NUMBER_ACTORLIST,ACTORLIST),                                 /* 21 */ 
  asserta(temporal_list_of_actors(ACTORLIST)),                           /* 22 */
  ( between(1,AS,N), choose_and_activate_actor(R,T,N), fail              /* 23 */
  ;
     true 
  ), 
  retract(temporal_list_of_actors(ACTORLIST1)),                          /* 24 */
  change_data(R,T),                                                      /* 25 */
  adjust_the_kernel(R,T),!.                                              /* 26 */

choose_and_activate_actor(R,T,N) :-                                      /* 23 */
  temporal_list_of_actors(L), length(L,E),                               /* 27 */
  Y is random(E)+1, nth1(Y,L,A),                                         /* 28 */
  activate(R,T,A),                                                       /* 29 */
  delete(L,A,L1),                                                        /* 30 */
  retract(temporal_list_of_actors(L)),
  asserta(temporal_list_of_actors(L1)),!.                                /* 31 */

activate(R,T,A) :-                                                       /* 29 */
  check_environment(R,T,A),                         /* wird hier nicht benutzt */
  (   execute_protocols(R,T,A)                      /* wird hier nicht benutzt */       
  ;                                                      
      choose_action_type(R,T,A,TYP),                                     /* 30 */       
      ( act_in_type(TYP,A,R,T) ; true)                                   /* 31 */
  ),!.                                           

check_environment(R,T,A) :- true.                             

execute_protocols(R,T,A) :- protocol(M,A,R,T).

adjust_the_kernel(R,T) :-                                                /* 26 */
  action_types(L), length(L,E), actors(AS),                              /* 32 */
  ( between(1,E,X), adjust_individually(X,R,T,AS,L), fail; true ),       /* 33 */
  adjust(R,T),                                                           /* 34 */
  adjust_the_time(R,T), append('res4412.pl'), nl, told,!.                /* 35 */

adjust_individually(X,R,T,AS,L) :-                                       /* 33 */
  nth1(X,L,Z),
  ( between(1,AS,A), adjust(Z,A,R,T), fail ; true),!.                    /* 36 */
                                                        
/* ----------------------------------------------------
Hier werden am Ende einer Periode T alle zeitabh�ngigen Daten 
ver�ndert. T1 is T+1
------------------------------------------------------- */

adjust_the_time(R,T) :-                                                  /* 34 */
   T1 is T+1, repeat,                                                    /* 38 */
   ( fact(R,T,FACT), retract(fact(R,T,FACT)), asserta(fact(R,T1,FACT)),  /* 39 */
     append('res4411.pl'), write(fact(R,T1,FACT)), write('.'), nl, told,
     fail
   ; true 
   ),!.

/* ---------------------------------------------------
Eine Variante, die Handlungstypen auszuw�hlen. Eine Liste von 
INTENDED_PAIRS, bestehend aus einer Wahrscheinlichkeit W und einem 
Handlungstypen TYP, wird erzeugt.  Wie wahrscheinlich - im 
Grad W - ist es, die Intention des Akteurs A, int([A,W,TYP]), zu T die 
Handlung des Typs TYP auszuf�hren. Die Intentionen wurden am Anfang erzeugt.
Alle Paare von Wahrscheinlichkeiten und Handlungstypen f�r einen AKteur A 
werden gesammelt. Das Paar mit der gr��ten Wahrscheinlichkeit wird ausgew�hlt.
------------------------------------------------------ */

choose_action_type(R,T,A,TYP) :-                                         /* 30 */
   list_of_events(EVENT_LIST), events(EVTS),                             /* 40 */
   asserta(list_of_random_events([])),                                   /* 42 */
   ( between(1,EVTS,NUMBER),      
     make_random_event(NUMBER,A,R,T,EVENT_LIST), fail                    /* 43 */
   ; 
     true
   ),
   list_of_random_events(LIST_OF_RANDOM_EVENTS),                         /* 44 */
                    /* [W,TYP] eine Komponente */ 
   retract(list_of_random_events(LIST_OF_RANDOM_EVENTS)),                /* 45 */
   sort(LIST_OF_RANDOM_EVENTS,SORTED_LIST_OF_RANDOM_EVENTS),             /* 46 */ 
   length(SORTED_LIST_OF_RANDOM_EVENTS,E1),                              /* 47 */

/* Die letzte Komponente der Liste hat den gr��ten 
Wahrscheinlichkeitsgrad W */

   nth1(E1,SORTED_LIST_OF_RANDOM_EVENTS,[W,TYP]),!.                      /* 48 */
         
make_random_event(NUMBER,A,R,T,EVENT_LIST) :-                            /* 43 */
   nth1(NUMBER,EVENT_LIST,EVT),                                          /* 49 */
   list_of_random_events(UNSORTED_LIST_OF_RANDOM_EVENTS),                /* 50 */ 
   fact(R,T,int([A,W,EVT])),                                             /* 51 */
   append(UNSORTED_LIST_OF_RANDOM_EVENTS,[[W,EVT]],NEW_LIST),            /* 52 */
   retract(list_of_random_events(UNSORTED_LIST_OF_RANDOM_EVENTS)),       /* 53 */
   asserta(list_of_random_events(NEW_LIST)),!.                           /* 54 */
                            
 

