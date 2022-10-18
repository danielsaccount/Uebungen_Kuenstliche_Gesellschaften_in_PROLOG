/* exam253
 
In einer Gruppe wird eine Gruppenhandlung ausgewählt.

In 1 - 3 werden einige Fakten bereitgestellt. Es geht in 1 um einen
bestimmten Tick 656 und um einen bestimmten Akteur "peter", der durch den
Term group_mood(_) von einer "normalen" Handlungsart zum Gruppenmodus umgestellt
werden kann. In diesem Modus handelt "peter" für die Gruppe, zu der er gehört.
In einem vollständigen Programm würde ein Akteur wie "peter" mit 
individual_mood(peter) zu dem individuellen Handlungsmodus zurückkehren.  
In 2 wird eine Gruppe des Names "group47" bestimmt, die durch zwei
Gruppenhandlungen "act1" und "act2" charakterisiert wird. Der Inhalt dieser
Handlungstypen wird nicht weiter beschrieben. In 3 wird die Gruppe "group47"
explizit als eine Liste [karl,uschi,peter,udo,renate] von Mitgliedern definiert.
 
In 4 wird die Resultatdatei res253.pl geleert, in 5 wird der Akteur und der Tick 
von 1 geholt. In 6 wird Akteur A zu T aktiviert, A = peter, T = 656.
In 7 wird der Akteur auf Gruppenmodus umgestellt und in 8 wird die
Liste der Mitglieder von 3 geholt. In 9 wird überprüft, ob A ein 
Mitglieder dieser Gruppe ist. Die beiden Voraussetzungen in 7 und 9 sind
nur hinzugefügt, um zu sehen, wie sich dieses lokale Programm in ein 
vollständiges Programm einbinden lässt.  

In 10 - 12 werden dem Akteur zwei Möglichkeiten eröffnet, die er zufällig
auswählen kann. In 11 öffnet A seine Mailbox und findet eine Nachricht
INEL und in 12 handelt A selbstständig, allerdings schon im Gruppenmodus.
Wenn diese beiden Möglichkeiten nicht funktionieren, ist in 13 eine
weitere Handlungsart möglich, die in 50 ohne Inhalt ausgeführt wird.

Bei der ersten Möglichkeit wird in 14 zunächst in 15 die 
Liste LIST_OF_ACTIONTYPS der Gruppe geholt. In 16 wird ein Kommentar 
hinzugefügt, den wir in einer anderen Variante verwenden können (siehe
unten). In 19, 17 und 20 werden zwei Fälle beschrieben. Im ersten Fall
in 17 ist die Nachricht INEL kein Element der Liste der Handlungstypen.
D.h. die Nachricht ist keine Anweisung, mit der ein für die Gruppe 
charakteristischen Handlungstyp ausgeführt werden soll. In diesem 
Fall tut Akteur A gar nichts. Dies wird in 18 an die Resultatdatei 
res253.pl geschickt. Danach kommt PROLOG über 18, 14 und 6 zu "start" zurück.

Im zweiten Fall findet PROLOG in 20, dass die Nachricht INEL eine der
Gruppenhandlungen beinhaltet. In 21 wird beraten, ob die Gruppe diese
Handlung ausführen soll. In 26 und 27 wird die Liste der Gruppenmitglieder 
geholt. In 28 wird eine leere Hilfsliste "voting_list" eingerichtet. Diese 
wird zu einer expliziten Befragung der Mitglieder gebraucht. Sollen diese 
den Handlungstyp INEL mehrheitlich unterstützen oder nicht?

Dazu haben wir in 29 als Beispiel den PROLOG Befehl forall(_,_) benutzt. 
Hier läuft in "forall" die Variable B über die Akteure.
Im "wenn"-Teil des Befehls wird geprüft, ob der Akteur B ein Gruppenmitglied
ist und im "dann"-Teil wählt der Akteur B. Ist er für oder gegen diese
Handlung. Der "dann"-Teil wird in 35 - 39 genauer beschrieben.
Zunächst wird in 35 die Hilfsliste VOTING_LIST geholt und in 36 wird 
"eine Münze geworfen". Der Akteur B wählt entweder in 37 "yes" (X = yes)
oder in 38 "no" (X = no). In 39 wird diese Hilfsliste upgedatet. 
In 30 findet PROLOG nun die vollständige Hilfsliste der Stimmen ("yes" und
"no") und berechnet die Länge LENGTH dieser Liste. In 31 werden alle
Ja-Stimmen aus dieser Liste gesammelt und in eine neue Liste YES_LIST
geschrieben. In 32 wird die Anzahl L dieser Ja-Stimmen berechnet. Wenn die
Mehrheit in 33 für "Ja" gestimmt hat, wird die Variable auf "yes" gesetzt 
und an 26 weitergereicht. Genauso wird in 34 Z auf "no" gesetzt, wenn die
Ja-Stimmen in der Minderheit sind. 

PROLOG wandert nach 21 zurück und in 22 - 25 werden je nach Abstimmung 
der Handlungstyp INEL ausgeführt oder nicht. Wenn Z mit "yes"
besetzt ist, wird in 23 das INEL ausgeführt. In diesem Fall kehrt PROLOG 
über 14 und 7 zu "start" zurück. Wenn Z mit "no" besetzt ist, geschieht in 
25 folgendes. 14 und damit 11 wird falsch und PROLOG geht nach 12 und
bearbeitet den Term choose_group_action(T,A). PROLOG holt in 41 die Liste
der Handlungstypen LIST_OF_ACTIONTYPS und bestimmt die Länge LL dieser 
Liste. In 42 wird eine Zufallszahl V aus dem Bereich von 1 bis LL gezogen 
und in 43 wird der Handlungstyp ACT_TYP aus dieser Liste an der richtigen 
Stelle geholt. In 44 entscheidet A gemeinschaftlich  mit den Mitgliedern
der Gruppe, ob der Handlungstyp ACT_TYP ausgeführt wird. Dies geschieht
in 21 genau wie gerade beschrieben. Wenn die Mehrheit der Mitglieder für
"yes" und damit für diese Handlung gestimmt hat, wird A in 46 diese Handlung 
ausführen. Dies geschieht in 49 ohne Inhalt. Im anderen Fall, wenn die
Mehrheit gegen diesen Handlungstyp gestimmt hat, passiert inhaltlich nichts.
PROLOG findet, dass 40 falsch ist und damit auch 6. PROLOG endet bei "start"
mit "false".

In 16 haben wir auch den Fall vorgesehen, in dem die Nachricht INEL
einen Handlungstyp "act3" betrifft, welcher für die Gruppe nicht
charakteristisch ist. Dieser Fall tritt ein, wenn Sie am Anfang von 16
das Kommentarzeichen "%" entfernt haben. 
*/


tick(656). actor(peter). group_mood(peter).                       /* 1 */
group(group47,[act1,act2]).                                       /* 2 */
groupmembers(group47,[karl,uschi,peter,udo,renate]).              /* 3 */
 
% -------------------------------

start :-  
  (exists_file('res253.pl'), delete_file('res253.pl'); true),     /* 4 */
  trace,  
  actor(A), tick(T),                                              /* 5 */
  activate(T,A).                                                  /* 6 */

activate(T,A) :-           
  ( group_mood(A),                                                /* 7 */
    groupmembers(GROUPNAME,MEMBERLIST),                           /* 8 */
    member(A,MEMBERLIST),                                         /* 9 */
    X is random(2),                                               /* 10 */
    ( X = 0, T > 1, open_mailbox(T,A,INEL)                        /* 11 */
    ; X = 1, choose_group_action(T,A)                             /* 12 */
    )
  ;
    act(T,A)                                                      /* 13 */
  ),!.
  
open_mailbox(T,A,INEL) :-                                         /* 14 */
   group(GROUPNAME,LIST_OF_ACTIONTYPS),                           /* 15 */
%   INEL = act3,                                                  /* 16 */
  ( \+ member(INEL,LIST_OF_ACTIONTYPS),                           /* 17 */
    append('res253.pl'), write(mail_is_used(nothing_done)), write('.'), 
       nl, told                                                   /* 18 */
  ;                                                               /* 19 */
    member(INEL,LIST_OF_ACTIONTYPS),                              /* 20 */                  
    decide_together(T,A,INEL,Z),                                  /* 21 */
    ( Z = yes,                                                    /* 22 */
      execute_actiontyp(T,A,INEL),                                /* 23 */
      append('res253.pl'), write(mail_is_used(INEL)), write('.'),   
      nl, told                                                    /* 24 */
    ; 
      Z = no, fail                                                /* 25 */                  )
  ),!.    

decide_together(T,A,INEL,Z) :-                                    /* 26 */
  groupmembers(GROUPNAME,MEMBERLIST),                             /* 27 */
  asserta(voting_list([])),                                       /* 28 */
  forall(member(B,MEMBERLIST),vote(B,INEL)),                      /* 29 */
  voting_list(VOTING_LIST), length(VOTING_LIST,LENGTH),           /* 30 */
  findall(Y,(nth1(Z,VOTING_LIST,Y),Y=yes),VOTELIST),              /* 31 */
  length(VOTELIST,L),                                             /* 32 */
  ( LENGTH/2 < L, Z = yes                                         /* 33 */
  ; 
    L =< LENGTH/2, Z = no                                         /* 34 */
  ),!.  
                               
vote(B,INEL) :- voting_list(VOTING_LIST),                         /* 35 */
  X is random(2),                                                 /* 36 */
  ( X = 0, append(VOTING_LIST,[yes],VOT_LIST)                     /* 37 */
  ; X = 1, append(VOTING_LIST,[no],VOT_LIST)                      /* 38 */
  ),
  retract(voting_list(VOTING_LIST)),                              /* 39 */
  asserta(voting_list(VOT_LIST)). 

choose_group_action(T,A) :-
  group(GROUPNAME,LIST_OF_ACTIONTYPS),                            /* 40 */
  length(LIST_OF_ACTIONTYPS,LL),                                  /* 41 */
  V is random(LL) + 1,                                            /* 42 */ 
  nth1(V,LIST_OF_ACTIONTYPS,ACT_TYP),                             /* 43 */
  decide_together(T,A,ACT_TYP,Z),                                 /* 44 */
  ( Z = yes,                                                      /* 45 */              
    execute_actiontyp(T,A,ACT_TYP),                               /* 46 */
    append('res253.pl'), write(mail_is_used(ACT_TYP)), write('.'),   
      nl, told                                                    /* 47 */
  ; 
    Z = no, fail                                                  /* 48 */              
  ),!.                              
   
execute_actiontyp(T,A,ACTION_TYP) :- true.                        /* 49 */
act(T,A) :- true.                                                 /* 50 */               



