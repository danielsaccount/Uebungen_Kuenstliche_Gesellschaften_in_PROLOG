/* exam211

Hier wir der zentrale Prozess bei einem Akteur programmiert, der vom Empfang 
der Nachrichten bis zum Prozessor führt. 

Im Prozess werden bestimmte Fakten ständig verändert. Dabei muss der PROLOG Befehl 
"dynamic" benutzt werden.

Zur Vorbereitung sind folgende Fakten in der Datei data211.pl gespeichert
(in einem vollständigen Programm werden die meisten dieser Fakten im
Ablauf erst produziert):

  tick(3).
  actor(187). 
  mailbox(187,news([[21,3,m(8)],[157,3,m(9)]])).
  lister(3,187,[[12,3,m(14)],[88,3,m(12)]]).
  intelligence(187,2). capacity(187,5).
  message(187,[76,3,m(1)]).  message(187,[120,3,m(3)]).
  message(187,[50,3,m(2)]).  message(187,[77,3,m(4)]).
  message(187,[14,3,m(3)]).  message(187,[97,3,m(5)]).
  message(187,[5,3,m(6)]).
  action_mode(3).

Nach dem Start des Programms werden in 2 und 3 zunächst die Resultatdateien
res2111.pl und res2112.pl gelöscht. Wir tun dies, weil wir das Programm 
öfter ablaufen lassen möchten. Da in jedem Ablauf neue Daten entstehen, 
die wir in zwei Resultatdateien extern speichern, müssen wir in jeden 
neuen Ablauf die alten Resultate zunächst entfernen. Dazu schaut PROLOG 
mit "exists_file" nach, ob eine solche Datei existiert. Wenn ja wird sie mit 
"delete_file" gelöscht. Wenn eine Datei, wir z.B. res2111.pl, nicht 
existiert, wird die entsprechende Zeile mit "true" beendet. 

In 4 werden die Fakten aus data211.pl geholt und in die Datenbasis 
eingeladen und in 5 werden drei von diesen Fakten geholt, die im Folgenden 
ständig gebraucht werden. In diesem Modul geht es um einen bestimmten 
Tick T (hier: T = 3), um einen bestimmten Akteur A (hier: A = 187) und um einen 
bestimmten Handlungsmodus MODUS (hier: MODUS = 3). In 6 sind drei 
Handlungsmöglichkeiten vorgesehen. Im ersten MODUS (MODUS = 1) handelt 
A, im zweiten Modus (MODUS = 2) nimmt A etwas wahr und im dritten Modus
(MODUS = 3) empfängt A Nachrichten. Wir benutzen hier englische
Ausdrücke: act(T,A), perceive(T,A) und receive(T,A).

In 7 wird Akteur A eine Handlung nur ausführen, wenn der action_mode(MODUS)
stimmt. Als Fakt ist nur action_mode(3) zu finden (MODUS = 3). PROLOG
geht in 7 deshalb gleich zum dritten Fall, MODUS = 3, und bearbeitet
receive(T,A): A empfängt im Beispiel in 8 Nachrichten. 

In 9 werden zwei Konstanten: CAPACITY und INTELLIGENCE geholt. Als CAPACITY
für A wird hier einfach eine natürliche Zahl benutzt. Sie besagt, wie wieviele
der Nachrichten, die in einem Tick in der Mailbox stehen, weiter verarbeitet
werden. In 43 ist die Zahl CAPACITY, hier 5, also einfach die Anzahl von 
Schleifenschritten, die in 43 durchlaufen werden. INTELLIGENCE wird in 35
benutzt. Dort ist LENGTH_OF_LIST_IN_LISTER_NEW die Länge einer in den Klausen 
erzeugten Liste von Nachrichten, die im Ordner "lister" weiterverarbeitet
wird. Diese Länge wird in 35 durch INTELLIGENCE dividiert. D.h. ein bestimmter
Bruchteil von Nachrichten aus der Liste wird weiterverarbeitet. Die restlichen 
Nachrichten bleiben zunächst unberührt. Da der Bruch 
   LENGTH_OF_LIST_IN_LISTER_NEW / INTELLIGENCE
normalerweise keine natürliche Zahl ist, benutzen wir den PROLOG Befehl
"ceiling", welcher aus diesem Bruch die größte natürliche Zahl berechnet, die
kleiner oder klein als LENGTH_OF_LIST_IN_LISTER_NEW/INTELLIGENCE ist.
ceiling(LENGTH_OF_LIST_IN_LISTER_NEW /INTELLIGENCE) ist damit eine natürliche 
Zahl, die wir für eine Schleifenanzahl benutzen können: siehe 52, 50 und 36. 

In 10 wird die Mailbox von A geöffnet. Im Term news(MAILBOX_OLD) finden wir eine 
Liste von Nachrichten, die wir im Beispiel sehr stark abgekürzt haben. 
Eine Nachricht z.B. [157,3,m(9)]] enthält den Sender 157 (ein Akteur), den Tick zu dem
die Mailbox bearbeitet wird und eine Nachricht m(9), die hier die
Nummer 9 trägt. In einem vollständigen Programm würde diese Liste am Ende 
des letzten Ticks T-1 an den jetzt aktuellen Tick T übergeben werden. In 19 
geht es um Nachrichten, die im letzten Tick - aus welchen Gründen auch immer 
- nicht weiter bearbeitet wurden. Im Beispiel findet PROLOG eine Liste 
MAILBOX_OLD = [[21,3,m(8)],[157,3,m(9)]], in der 2 Nachrichten stehen:
      mailbox(187,news([[21,3,m(8)],[157,3,m(9)]])).
In 13 sammelt PROLOG alle Nachrichten an A, die in der Datenbasis als 
Fakten zu finden sind. Im Beispiel hatten wir diese Nachrichten einfach 
als Fakten in data211.pl notiert

    message(187,[76,3,m(1)]).  message(187,[120,3,m(3)]).
    message(187,[50,3,m(2)]).  message(187,[77,3,m(4)]).
    message(187,[14,3,m(3)]).  message(187,[97,3,m(5)]).
    message(187,[5,3,m(6)]).

In einem vollständigen Programm werden Nachrichten zu Tick T von 
anderen Akteuren neu geschrieben und an A gesendet. Die Nachricht z.B.
[77,3,m(4)] beinhaltet, dass Akteur des "Namens" 77 zu T ( T = 3 ) die
Nachricht m schickte, wobei 6 in m(6) einfach die Ordnungnummer dieser
Nachricht ist. In dieser Ordnung wurden diese Nachrichten zeitlich in
dieser Reihenfolge empfangen.
 
In 13 hat PROLOG all diese Terme Y (z.B. Y = [21,3,m(1)]) in eine Liste
NEWLIST getan. In 15 wird mit "append" diese Liste NEWLIST zur "alten" 
Liste MAILBOX_OLD hinzugefügt. Diese neue Liste NEWS wird in 19 an den Term
proceed_to_lister(CAPACITY,NEWS,SHIFTED_MESSAGES,MESSAGES_HOLD) übergeben, 
welcher in 42 bis 49 weiter bearbeitet wird. Die Variable CAPACITY wurde 
in 9 und 4 schon durch 5 ersetzt. Inhaltlich nimmt PROLOG die ersten 5 
Nachrichten aus der Liste und trägt sie in eine neue, dynamisch verwaltete 
Liste von "verschobenen" (shifted) Nachrichten: SHIFTED_MESSAGES ein.
Die restlichen Nachrichten trägt PROLOG in eine ebenfalls neue, dynamisch 
verwaltete Liste von "gehaltenen" (hold) MESSAGES_HOLD ein. Dies geschieht 
in 43 - 49.

In 24 und 25 wird die alte Liste aus der Mailbox entfernt und die neue
Liste der unbearbeiteten Nachrichten in die Mailbox hineingeschrieben, 
so dass die neue Liste beim nächsten Tick bereit steht.  

In 26 wird der Ordner "lister" geöffnet, in dem es eine Liste 
LIST_OLD_IN_LISTER von restlichen Nachrichten gibt, die im letzten Tick 
nicht bearbeitet wurden. In 30 wird die Restliste LIST_OLD_IN_LISTER an die
verschobene (shifted) Liste SHIFTED_MESSAGES aus der Mailbox angeklebt. Die 
resultierende Hilfsliste heißt hier AUXILIARY_LIST. Im nächsten Schritt
ordnet PROLOG in 31 die AUXILIARY_LIST mit "sort" um. Dabei werden 
Mehrfachnachrichten eliminiert und die Nachrichten werden "alphabetisch"
geordnet, wobei auch natürliche Zahlen eine Rolle spielen. Diese
neue Liste LIST_NEW_IN_LISTER wird in 32 gespeichert. In 33 wird die 
Länge dieser Liste berechnet. In 34, 35 und 45 findet PROLOG eine 
Oder-Konstruktion. In der ersten Möglichkeit ist in 34 die Länge 
LENGTH_OF_LIST_NEW_IN_LISTER Null. In diesem Fall geht PROLOG direkt
zum Ende des Programms. Der Ordner "lister" enthält keine Nachrichten,
so dass der  Akteur zu diesem Tick nichts tun kann. Die beiden vorher
beredeten Möglichkeiten wurden schon in 6 abgehandelt. 

Wenn die Länge LENGTH_OF_LIST_NEW_IN_LISTER größer als Null ist,
wird PROLOG in 36 den Anteil von Nachrichten im Ordner berechnen - wie oben
schon beschrieben. Die resultierende Zahl V wird in 37 dem
Term filter(V,LIST_TO_PROCEED,RESIDUAL_LISTER) übergeben und in 50
weiterbearbeitet. In 51 wird eine weitere Hilfsliste list_to_process 
eingerichtet, in der am Ende die Liste LIST_TO_PROCEED an den Prozessor 
übergeben wird. Weiter wird in 51 die vorher generierte Hilfsliste 
LIST_NEW_IN_LISTER (siehe 32) geholt. In der Schleife in 52 werden 
zufällig V Nachrichten aus der Liste LIST_NEW_IN_LISTER herausgepickt 
und in 59 - 63 in die Liste LIST_TO_PROCEED geschrieben. Die restlichen 
Nachrichten aus LIST_NEW_IN_LISTER kommen in die Liste RESIDUAL_LISTER,
die die "alte" Restliste im Ordner ersetzt. Die Liste RESIDUAL_LISTER
wird etwas versteckt in 63 mit asserta(list_to_process(LL4)) in die Datenbasis
eingetragen. Schließlich wird in 42 die Liste LIST_TO_PROCEED an den Prozessor
geschickt. Der Term, die Liste LIST_TO_PROCEED, der in 42 nicht weiter beschrieben 
wird, ist am Schluß leer. D.h. alle Inels sind im Prozessor gelandet. 
In 57 wird auch die Ausnahme keine Fehler verursachen.

Wenn Sie das Programm im trace-Modus anschauen möchten, entfernen Sie in 1a das
Symbol % .
*/

:- dynamic [ message/2 , mailbox/2 , lister/3 ].                        /* 1 */

start :- 
%   trace,                                                              /* 1a */
   ( exists_file('res2111.pl'), delete_file('res2111.pl') ; true),      /* 2 */
   ( exists_file('res2112.pl'), delete_file('res2112.pl') ; true),      /* 3 */
   consult('data211.pl'),                                               /* 4 */
   tick(T), actor(A), action_mode(MODUS),                               /* 5 */
   ( MODUS = 1, act(T,A) ; MODUS = 2, perceive(T,A) ;
        MODUS = 3, receive(T,A) ).                                      /* 6 */

act(T,A) :- true. perceive(T,A) :- true.                                /* 7 */

receive(T,A) :-                                                         /* 8 */
  capacity(A,CAPACITY), intelligence(A,INTELLIGENCE),                   /* 9 */
  mailbox(A,news(MAILBOX_OLD)),                                         /* 10 */
  append('res2111.pl'),                                                 /* 11 */
  write(mailbox(A,news(MAILBOX_OLD))), write('.'), nl,                  /* 12 */ 
  findall(Y,message(A,Y),NEWLIST),                                      /* 13 */
  write(new_mails(NEWLIST)), write('.'), nl, told,                      /* 14 */ 
  append(MAILBOX_OLD,NEWLIST,NEWS),                                     /* 15 */
  append('res2111.pl'),                                                 /* 16 */
  write(all_mails(NEWS)), write('.'), nl, told,                         /* 17 */
  asserta(aux_mbox([])),                                                /* 18 */
  proceed_to_lister(CAPACITY,NEWS,SHIFTED_MESSAGES,MESSAGES_HOLD),      /* 19 */
  append('res2111.pl'),                                                 /* 20 */
  write(shifted_mail_to_lister(SHIFTED_MESSAGES)), write('.'), nl,      /* 21 */ 
  write(residual_mails_for_next_tick(MESSAGES_HOLD)), write('.'), 
      nl, told,                                                         /* 22 */
  retract(aux_mbox(SHIFTED_MESSAGES)),                                  /* 23 */
  retract(mailbox(A,news(MAILBOX_OLD))),                                /* 24 */
  asserta(mailbox(A,news(MESSAGES_HOLD))),                              /* 25 */
  lister(T,A,LIST_OLD_IN_LISTER),                                       /* 26 */
  append('res2112.pl'),                                                 /* 27 */
  write(lister_old(LIST_OLD_IN_LISTER)), write('.'), nl,                /* 28 */
  write(shifted_mail_to_lister(SHIFTED_MESSAGES)), write('.'),          /* 29 */
       nl, told, 
  append(LIST_OLD_IN_LISTER,SHIFTED_MESSAGES,AUXILIARY_LIST),           /* 30 */
  sort(AUXILIARY_LIST,LIST_NEW_IN_LISTER),                              /* 31 */
  asserta(aux_lister(LIST_NEW_IN_LISTER)),                              /* 32 */
  length(LIST_NEW_IN_LISTER,LENGTH_OF_LIST_NEW_IN_LISTER),              /* 33 */
  ( LENGTH_OF_LIST_NEW_IN_LISTER = 0, true                              /* 34 */
  ;
    0 < LENGTH_OF_LIST_NEW_IN_LISTER,                                   /* 35 */
    V is ceiling(LENGTH_OF_LIST_NEW_IN_LISTER/INTELLIGENCE),            /* 36 */
    filter(V,LIST_TO_PROCEED,RESIDUAL_LISTER),                          /* 37 */ 
    append('res2112.pl'),                                               /* 38 */
    write(list_for_the_processor(LIST_TO_PROCEED)), write('.'), nl,     /* 39 */
    write(residual_items_in_the_lister_for_next_tick(RESIDUAL_LISTER)), /* 40 */
    write('.'), nl, told,                                               /* 41 */
    give_to_processor(LIST_TO_PROCEED)                                  /* 42 */
  ),!.

proceed_to_lister(CAPACITY,NEWS,SHIFTED_MESSAGES,MESSAGES_HOLD) :-       /* 43 */
  ( between(1,CAPACITY,X), take(X,NEWS), fail; true),                    /* 44 */
  aux_mbox(SHIFTED_MESSAGES), 
  subtract(NEWS,SHIFTED_MESSAGES,MESSAGES_HOLD),!.                       /* 45 */

take(X,NEWS) :-                                                          /* 46 */
   aux_mbox(LIST),                                                       /* 47 */
   nth1(X,NEWS,MESS), append(LIST,[MESS],LIST1),                         /* 48 */
   retract(aux_mbox(LIST)), asserta(aux_mbox(LIST1)),!.                  /* 49 */

filter(V,LIST_TO_PROCEED,RESIDUAL_LISTER) :-                             /* 50 */
  asserta(list_to_process([])), aux_lister(LIST_NEW_IN_LISTER),          /* 51 */
  ( between(1,V,Y), add_item(Y), fail ; true ),                          /* 52 */ 
  list_to_process(LIST_TO_PROCEED),                                      /* 53 */
  retract(list_to_process(LIST_TO_PROCEED)),                             /* 54 */
  aux_lister(RESIDUAL_LISTER),   retract(aux_lister(RESIDUAL_LISTER)),!. /* 55 */ 

add_item(Y) :- aux_lister(LL1), length(LL1,L2),                          /* 56 */
  ( L2 = 0 , true                                                        /* 57 */
  ;
    0 < L2,                                                              /* 58 */
    U is random(L2)+1, nth1(U,LL1,Mes),                                  /* 59 */
    delete(LL1,Mes,LL2), retract(aux_lister(LL1)),                       /* 60 */
    asserta(aux_lister(LL2)),                                            /* 61 */
    list_to_process(LL3), append(LL3,[Mes],LL4),                         /* 62 */
    retract(list_to_process(LL3)), asserta(list_to_process(LL4))         /* 63 */
  ),!.

% ------------------------

give_to_processor(LISTER_TO_PROCEED) :- true.


% ------------------------


/* Wir haben hier die Resultatsübertragung weggelassen. Sie sehen sofort, dass
das Programm schlanker wird. 

:- dynamic [ message/2 , mailbox/2 , lister/3 ].

tick(3).
actor(187). 
mailbox(187,news([[6,7,3,m(8)],[9,11,3,m(9)]])).
lister(3,187,[[6,1,3,m(14)],[13,12,3,m(12)]]).
intelligence(187,2). capacity(187,5).
 message(187,[1,2,3,m(1)]).  message(187,[2,2,3,m(3)]).
 message(187,[1,1,3,m(2)]).  message(187,[1,6,3,m(4)]).
 message(187,[2,2,3,m(3)]).  message(187,[4,6,3,m(5)]).
 message(187,[5,6,3,m(6)]).
action_mode(3).

start :- 
   tick(T), actor(A), action_mode(X), 
   ( X = 1, act(T,A) ; X = 2, perceive(T,A) 
     ; X = 3, receive(T,A) ). 

act(T,A) :- true. perceive(T,A) :- true.

receive(T,A) :- 
  capacity(A,Q), intelligence(A,IG), 
  mailbox(A,news(MBOX_OLD)),
  findall(Y,message(A,Y),NEWLIST),
  append(MBOX_OLD,NEWLIST,NEWS),
  asserta(aux_mbox([])),
  proceed_to_lister(Q,NEWS,SHIFTED_MS,HOLD_MS),
  retract(aux_mbox(SHIFTED_MS)),
  retract(mailbox(A,news(MBOX_OLD))), asserta(mailbox(A,news(HOLD_MS))),
  lister(T,A,LISTER_OLD),
  append(LISTER_OLD,SHIFTED_MS,LISTER_AUX),
  sort(LISTER_AUX,AUX_LISTER), 
  asserta(aux_lister(AUX_LISTER)),
  length(AUX_LISTER,L1), 
  ( L1 = 0, true 
  ;
    0 < L1, V is ceiling(L1/IG), 
    filter(V,LIST_TO_PROCEED,HOLD_LISTER),
    give_to_processor(LIST_TO_PROCEED)
  ),!.


filter(V,LIST_TO_PROCEED,HOLD_LISTER) :-
  asserta(aux_proc([])), aux_lister(AUX_LISTER),
  ( between(1,V,Y), add_item(Y), fail ; true ),
  aux_proc(LIST_TO_PROCEED), retract(aux_proc(LIST_TO_PROCEED)),  
  aux_lister(HOLD_LISTER), retract(aux_lister(HOLD_LISTER)),!.  

add_item(Y) :- aux_lister(LL1), length(LL1,L2),
  ( L2 = 0 , true
  ;
    0 < L2, 
    U is random(L2)+1, nth1(U,LL1,Mes), 
    delete(LL1,Mes,LL2), retract(aux_lister(LL1)), asserta(aux_lister(LL2)),
    aux_proc(LL3), append(LL3,[Mes],LL4), retract(aux_proc(LL3)),
    asserta(aux_proc(LL4))
  ),!.
 

give_to_processor(LISTER_TO_PROCEED) :- true.

proceed_to_lister(Q,NEWS,SHIFTED_MS,HOLD_MS) :- 
  ( between(1,Q,X), take(X,NEWS), fail; true),
  aux_mbox(SHIFTED_MS), subtract(NEWS,SHIFTED_MS,HOLD_MS),!.

take(X,NEWS) :- 
   aux_mbox(LIST), 
   nth1(X,NEWS,MESS), append(LIST,[MESS],LIST1),
   retract(aux_mbox(LIST)), asserta(aux_mbox(LIST1)),!.
*/


  
