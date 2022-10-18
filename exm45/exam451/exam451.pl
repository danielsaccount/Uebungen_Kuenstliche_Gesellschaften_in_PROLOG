/* exam451.pl 

Ein Beispiel für ökonomische Organisationen - als Spezialfall von 
Institutionen. 

Das hier beschriebene Programm enthält als Teil das in exam324.pl beschriebene
Programm für die Grobstruktur von Institutionen. Der institutionelle Teil, 
de in exam324.pl genau erklärt ist, wird hier nicht mehr erörtert. Hier werden 
einige ökonomische Komponenten beschreiben.

Sowohl die Gruppen als auch die individuellen Akteure haben Konten. Ein
Gruppenkonto group_account(TICK,GROUP_NUMBER,VALUE) enthält den Wert (VALUE, 
z.B. Geld) der Gruppe Nr. GROUP_NUMBER zum Zeitpunkt TICK. Genauso hat ein
individueller Akteur ACTOR ein Konto: individual_account(TICK,ACTOR,VALUE).
Mit diesen Konten können wir in einem Ablauf den Kreislauf von Werten
untersuchen und analysieren. Dabei fließen die Werte von der obersten Gruppe
(der Chefgruppe) nach unten bis zu den Gruppen des untersten Status und 
von unten wieder über "den Markt" zur Chefgruppe zurück. Am Anfang hat die 
Chefgruppe einen Gesamtbetrag (investment(...)), den sie investieren kann. 
Ein Teil dieses Betrages wird an die abhängigen Gruppen weitergegeben.
Im Baum geht dies in ähnlicher Weise weiter nach unten - "dem Baum entlang". 

Wenn der Baum am Ende eines Ticks durchlaufen ist, wird die Gesamtproduktion
ermittelt, die zu diesem Tick stattgefunden hat. Dieser Wert wird als "Angebot"
am Markt verkauft. Je nachdem, wieviel produziert wurde und wieviel der 
Ware verkauft wurde, lässt sich der Gewinn (oder Verlust) ermitteln. Weiter
wird für den nächsten Tick geplant, welcher Betrag als Investition für den 
nächsten Tick verwendet wird. 

"Den Markt" stellen wir durch zwei Konstanten dar: constants_for_market(MC1,MC2).
Mit diesen Zahlen MC1, MC2 und mit dem Wert der Gesamtproduktion TOTAL_PRODUCTION
wird der Profit in diesem Beispiel wie folgt ermittelt. In 25 und 26 wird mit 
constants_for_market(MC1,MC2) eine Intervalllänge LENGTH berechnet: 
LENGTH is MC2 - MC1; im Beispiel LENGTH = 60 - 40 = 20. Im Bereich von 1 bis 20
wird eine Zufallszahl X gezogen. Der Wert der Gesamtproduktion (zu diesem TICK)
TOTAL_PRODUCTION ist schon ermittelt. Der Profit wird dann durch

    PROFIT is ((MC1 + X)/100) * TOTAL_PRODUCTION

berechnet. D.h. der Profit liegt prozentual im Bereich von MC1+1 bis MC1+RANGE.
Im Beispiel ist der Profit exorbitant: 41 =< PROFIT =< 60. Statt MC1 und MC2 
können wir natürlich auch kleiner Werte nehmen, z.B. MC1=0, MC2=5.

In 27 - 31 wird ein Teil des Profits als Investition für den nächsten Tick 
genommen. Dazu benutzen wir zwei weitere Konstanten MAXIMAL_DIVIDEND und
MORAL_CONSTANT, die beide in der Parameterdatei para451.pl zu finden sind.
Im Bereich zwischen 1 und MAXIMAL_DIVIDEND wird in 27 eine Zufallszahl Y1
gezogen, welche die in einem Tick erwartete Dividende darstellt. Die 
MORAL_CONSTANT soll ausdrücken, wie stark eine - und in diesem Beispiel: 
jede - abhängige Gruppe bei ihrer Lohnforderung sein kann. In 28 und 29 wird
aus dem Bereich zwischen 1 und MORAL_CONSTANT eine Zufallszahl Y2 gezogen,
welche die in einem Tick aktuelle Lohnverhandlungsmacht darstellt. Aus den 
Zahlen Y1, Y2 und den zugehörigen Maximalzahlen wird in 30 ein Bruchteil K
berechnet. Je größer K ist, wird der Teil des Profits, der bei dem nächsten 
Tick verwendet wird, kleiner. Dieser Teil wird in 31 berechnet und als
Investition mit investment(T,INVEST) in die Datenbasis eingetragen.     
 
Im Ablauf eines Ticks wird die Menge von neu produzierten Waren bestimmt.
Dies geschieht wie folgt. Jede Gruppe nimmt aus dem Gesamtkapital einen
Teil davon, um die Ausgaben der Mitglieder dieser Gruppe zu bestreiten.
Jeder Gruppe GROUP hat eine Konstante PRODUCTION_CONSTANT, die am Anfang des 
Programms in create451.pl mit make_production_constants(NUMBER_OF_GROUPS) erzeugt 
wird. Jede Gruppe hat dabei eine andere Konstante: 

   production_constant(NUMBER_OF_GROUP,PRODUCTION_CONSTANT).

Je größer die Zahl PRODUCTION_CONSTANT ist, desto effektiver wird diese
Gruppe ihren Kapitalbetrag beim Unternehmen einsetzen. Dies wird hier 
am Anfang des nächsten Ticks klar, wenn die Gesamtmenge von neu produzierten 
Waren und der Verkaufserlös berechnet wird.  

Genauer wird in 14 eine rudimentäre Planung beschrieben, die in 34 auch von 
dem Status der einzelnen Gruppen abhängt. Beim Überqueren des Gruppenbaums
geschieht in 15 folgendes. In 37 wird eine Gruppennummer NUMBER_OF_A_GROUP 
und die Gruppe (Liste) der Akteure der Gruppe genommen. Aus den Konstanten
wird ein Teil (eine Prozentzahl) der Investition, nämlich 
INVSTgroup is PROGNG * INVST in 41 genommen und in 43 für die Aktivität der 
Gruppe verwendet. In 43, 49 und 50 wird dieses Kapital mit der Konstanten PGC
(production_constant(NUMBER_OF_A_GROUP,PGC)) vergrößert. Das Resultat OUTPUT
der Aktivität der Gruppe wird dem Konto dieser Gruppe in 45 gutgeschrieben.
In 42 wird die Gesamtinvestition durch den Betrag vermindert, den die Gruppe
gerade benutzt. 

In 48 wird die schon vorher bestimmte, von der Gruppe GROUP abhängige Gruppe
der Nummer NGdep aufgerufen. In 51 - 54 werden verschiedene Konstanten und Werte 
geholt. In 55 - 57 wird ein Investitionsanteil INVSTgroup der Gruppe Nr. NGdep 
berechnet und in 59 dazu benutzt, die Aktivitäten der Gruppe auszuführen. In
66 und 67 wird unterschieden, ob die Gruppe Nr. NGdep selbst produziert oder
diese Gruppe nur Manageraufgaben zu erledigen hat. Im ersten Fall wird in 66 
die Produktion durch die Gruppe beschrieben. Dies geschieht in 69 rein zufällig.
Dies ließe sich natürlich auch mit Inhalt füllen. 

In 58 wird die Gesamtinvestition - wie schon beschrieben - angepasst. In 61
wird das Resultat dem Konto der Gruppe gut (oder eben "schlecht") geschrieben.
Damit ist der Baum überquert.

PROLOG begibt sich zu 16, wo die Konten für den nächsten Tick T+1 angepasst
werden. In 11 wird nun die nächste Periode bearbeitet. Der Baum wird wieder
überquert und so weiter. Schließich haben wir in 9 noch einige Fakten als
Resultate herausgeschrieben und am Ende haben wir die Datenbasis bereinigt.
*/

% ---------------------------------------------------------


start :-
  (exists_file('res4511.pl'), delete_file('res4511.pl'); true),               /* 1 */
  (exists_file('res4512.pl'), delete_file('res4512.pl'); true),
  (exists_file('res4513.pl'), delete_file('res4513.pl'); true),
  (exists_file('res4514.pl'), delete_file('res4514.pl'); true),
  (exists_file('res4515.pl'), delete_file('res4515.pl'); true),
  consult('para451.pl'), consult('pred451.pl'),
  number_of_ticks(TICKS), number_of_actors(AA), number_of_groups(NUMBER_OF_GROUPS), 
  number_of_decisions(NUMBER_OF_DECISIONS), calibration_constant(CC), 
  moral_constant(MC), production_constants_max(PC), investment(INVEST_C), 
  constants_for_market(MC1,MC2), maximal_dividend(DC),                         /* 2 */
  consult('create451.pl'),                                                        /* 3 */
  make_a_tree, tree(TREE), make_branches(TREE), 
  make_dependencies(TREE), dependencies(LIST_OF_DEPENDENCIES), 
  make_status(NUMBER_OF_GROUPS,LIST_OF_DEPENDENCIES),
  make_actorlists(AA,NUMBER_OF_GROUPS,INTERVALS), 
  fill_groups(AA,NUMBER_OF_GROUPS,INTERVALS),
  list_of_groups(LIST_OF_GROUPS),
  make_exist_minimum(NUMBER_OF_GROUPS),                                        /* 4 */
  make_production_constants(NUMBER_OF_GROUPS),                                 /* 5 */
  make_action_typs(NUMBER_OF_GROUPS),                                          /* 6 */
  make_individual_accounts(AA), make_group_accounts(NUMBER_OF_GROUPS,AA,LIST_OF_GROUPS),
  begin(TICKS,NUMBER_OF_GROUPS,AA).                                            /* 7 */

begin(TICKS,NUMBER_OF_GROUPS,AA) :-                                            /* 7 */
  dependencies(LIST_OF_DEPENDENCIES),  
  ( between(1,TICKS,T), periode(T,AA,NUMBER_OF_GROUPS,LIST_OF_DEPENDENCIES), 
      fail; true),                                                             /* 8 */
  store_group_accounts(TICKS,NUMBER_OF_GROUPS),                                /* 9 */
  retractall(individual_account(TTT,TTT1,TTT2)),
  retractall(group_account(FFF1,FFF2,FFF3)), retract(dependencies(LIST_OF_DEPENDENCIES)), 
  retract(tree(TREE)), retract(end_line(END)),!.                              /* 10 */

periode(T,AA,NUMBER_OF_GROUPS,LIST_OF_DEPENDENCIES) :-                        /* 11 */
  production_and_investment(T,TOTAL_PRODUCTION,NUMBER_OF_GROUPS),             /* 12 */
  investment(T,INVST),                                                        /* 13 */
  planning(NUMBER_OF_GROUPS,T,INVST,AA),                                      /* 14 */
  length(LIST_OF_DEPENDENCIES,EDL),  
  ( between(1,EDL,NCOMP), traverse_tree(NCOMP,AA,T,LIST_OF_DEPENDENCIES),     /* 15 */
     fail; true),
  T1 is T+1,                                                                  /* 16 */
  repeat,                                                                     /* 17 */
   ( group_account(T,X2,X3), retract(group_account(T,X2,X3)), 
     asserta(group_account(T1,X2,X3)),
     append('res4511.pl'), write(group_account(T1,X2,X3)), write('.'), nl, told,
     fail
   ; true 
   ),!.

production_and_investment(T,TOTAL_PRODUCTION,NUMBER_OF_GROUPS) :-             /* 18 */
 ( T = 1, investment(INVC), asserta(investment(T,INVC))                       /* 19 */
 ; 
   1 < T,                                                                     /* 20 */
   asserta(total_production(0)),                                              /* 21 */                             
   ( between(1,NUMBER_OF_GROUPS,NG), add_products(T,NUMBER_OF_GROUPS,NG),     /* 22 */
     fail; true),
   total_production(TOTAL_PRODUCTION),                                        /* 23 */
   retract(total_production(TOTAL_PRODUCTION)),                               /* 24 */
   constants_for_market(MC1,MC2), LENGTH is MC2 - MC1,                        /* 25 */
   X is random(LENGTH) + 1, PROFIT is ((MC1 + X)/100) * TOTAL_PRODUCTION,     /* 26 */                         
   maximal_dividend(MAXIMAL_DIVIDENT), Y1 is random(MAXIMAL_DIVIDENT) + 1,    /* 27 */
   moral_constant(MORAL_CONSTANT),                                            /* 28 */
   Y2 is random(MORAL_CONSTANT) + 1,                                          /* 29 */
   K is (Y1 + Y2)/(MAXIMAL_DIVIDENT + MORAL_CONSTANT),                        /* 30 */             
   INVEST is (1 - K) * PROFIT,                                                /* 31 */     
   asserta(investment(T,INVEST))                                              /* 32 */
 ),!.

add_products(T,NUMBER_OF_GROUPS,NG) :- 
  total_production(TOTAL_PRODUCTION),
  ( product(T,NG,PRODUCTION_NG), 
    TOTAL_PRODUCTIONnew is TOTAL_PRODUCTION + PRODUCTION_NG, 
    retract(total_production(TOTAL_PRODUCTION)), 
    asserta(total_production(TOTAL_PRODUCTIONnew)) 
  ; true ),!.

planning(NUMBER_OF_GROUPS,T,INVST,AA) :-                                      /* 14 */
  asserta(aux3(0)),
  ( between(1,NUMBER_OF_GROUPS,NG), add_productivity(T,NUMBER_OF_GROUPS,NG),  /* 33 */
    fail; true),
  aux3(PP), retract(aux3(PP)),
  findall(X,status(GY,X),LL), sort(LL,LLnew), length(LLnew,Enew),             /* 34 */
  nth1(Enew,LLnew,MAXS),                                                      /* 35 */
  GLPROD is PP + MAXS + AA, asserta(global_productivity(GLPROD)),!.           /* 36 */

add_productivity(T,NUMBER_OF_GROUPS,NG) :- 
  production_constant(NG,PRO), aux3(PP), PPnew is PP + PRO,
  retract(aux3(PP)), asserta(aux3(PPnew)),!. 

traverse_tree(NCOMP,AA,T,LIST_OF_DEPENDENCIES) :-                             /* 15 */
% trace,
  investment(T,INVST),
  nth1(NCOMP,LIST_OF_DEPENDENCIES,COMP), nth1(1,COMP,NUMBER_OF_A_GROUP), 
  nth1(2,COMP,LCOM), length(LCOM,EC), 
  ( between(1,EC,Y), nth1(Y,LCOM,NGdep), 
    go_down(NUMBER_OF_A_GROUP,htyp1,NGdep,T,AA),                              /* 37 */
    fail; true),!.
   
go_down(NUMBER_OF_A_GROUP,htyp1,NGdep,T,AA) :-                                /* 37 */
  list_of_groups(LIST_OF_GROUPS), nth1(NUMBER_OF_A_GROUP,LIST_OF_GROUPS,GROUP), 
  length(GROUP,E),     /* 38 */
  R1 is E/AA, status(NUMBER_OF_A_GROUP,S), 
  production_constant(NUMBER_OF_A_GROUP,PGC),                                 /* 39 */
  global_productivity(GLPROD), investment(T,INVST),                           /* 40 */
  X is (PGC/GLPROD) + S + R1, (X = 0, PROGNG is 0 ; X > 0, PROGNG is X/100 ),
  INVSTgroup is PROGNG * INVST, INVSTnew is INVST - PROGNG * INVST,           /* 41 */
  retract(investment(T,INVST)), asserta(investment(T,INVSTnew)),              /* 42 */
  htyp1(T,NUMBER_OF_A_GROUP,htyp2,INVSTgroup,OUTPUT),                         /* 43 */
  exist_minimum(NUMBER_OF_A_GROUP,EXMIN), 
  group_account(T,NUMBER_OF_A_GROUP,Mold),                                    /* 44 */
  Mnew is min(Mold + (OUTPUT - INVSTgroup),EXMIN),                            /* 45 */
  retract(group_account(T,NUMBER_OF_A_GROUP,Mold)), 
  asserta(group_account(T,NUMBER_OF_A_GROUP,Mnew)),                           /* 46 */
  append('res4511.pl'), write(group_account(T,NUMBER_OF_A_GROUP,Mold)), 
  write('.'), nl,                                                             /* 47 */
  write(htyp1(T,NUMBER_OF_A_GROUP,NGdep,htyp2,INVSTgroup,OUTPUT)), write('.'), nl, 
  write(group_account(T,NUMBER_OF_A_GROUP,Mnew)), write('.'), nl, told,
  activate_a_dependent_group(htyp2,T,NGdep),!.                                /* 48 */

htyp1(T,NUMBER_OF_A_GROUP,htyp2,INVSTgroup,OUTPUT) :-                         /* 43 */
  production_constant(NUMBER_OF_A_GROUP,PGC),                                 /* 49 */
  OUTPUT is INVSTgroup + (PGC * INVSTgroup).                                  /* 50 */

activate_a_dependent_group(htyp2,T,NGdep) :-                                  /* 48 */
  list_of_groups(LIST_OF_GROUPS), nth1(NGdep,LIST_OF_GROUPS,G),               /* 51 */
  length(G,E), 
  number_of_actors(AA), R1 is E/AA, status(NGdep,S),                          /* 52 */
  production_constant(NGdep,PGC), global_productivity(GLPROD),                /* 53 */
  investment(T,INVST),                                                        /* 54 */
  X is (PGC/GLPROD) + S + R1,                                                 /* 55 */
  (X = 0, PROGNG is 0 ; X > 0, PROGNG is X/100 ),                             /* 56 */
  INVSTgroup is PROGNG * INVST, INVSTnew is INVST - PROGNG * INVST,           /* 57 */
  retract(investment(T,INVST)), asserta(investment(T,INVSTnew)),              /* 58 */
  htyp2(T,NGdep,INVSTgroup,PROD),                                             /* 59 */
  exist_minimum(NGdep,EXMIN), group_account(T,NGdep,Mold),                    /* 60 */
  Mnew is min(Mold + (PROD - INVSTgroup),EXMIN),                              /* 61 */
  retract(group_account(T,NGdep,Mold)), 
  asserta(group_account(T,NGdep,Mnew)),                                       /* 62 */
  append('res4511.pl'), write(group_account(T,NGdep,Mold)), write('.'), nl,   /* 63 */
  write(produce(T,NGdep,INVSTgroup,PROD)), write('.'), nl, 
  write(group_account(T,NGdep,Mnew)), write('.'), nl, told,
  asserta(product(T,NGdep,PROD)),!.                                           /* 64 */

% -----------------------------
htyp2(T,NGdep,INVSTNG,OUTPUT) :-                                              /* 59 */ 
  end_line(ENDLINE), production_constant(NGdep,PGC),                          /* 65 */
  ( nth1(V,ENDLINE,NGdep), production(T,NGdep,INVSTNG,PGC,OUTPUT)             /* 66 */
  ;
    OUTPUT is INVSTNG + (PGC * INVSTNG)                                       /* 67 */
  ),
  append('res4513.pl'), write(product(T,NGdep,OUTPUT)), write('.'), nl, told,!.
 
production(T,NGdep,INVSTNG,PGC,OUTPUT) :-                                     /* 66 */
  X is random(100) + 1, Y is random(2),  (Y = 0, Z is 1; Y = 1, Z is -1),     /* 68 */
  OUTPUT is INVSTNG + (Z * max((X/100) * INVSTNG * PGC,INVSTNG)),             /* 69 */
  asserta(product(T,NGdep,OUTPUT)),!.

% ---------------------------------------------

store_group_accounts(TICKS,NUMBER_OF_GROUPS) :- 
  ( between(1,NUMBER_OF_GROUPS,NG), store_group_acc(TICKS,NG), fail; true),!.
store_group_acc(TICKS,NG) :- 
  TICKS1 is TICKS + 1, group_account(TICKS1,NG,W),
  append('res4514.pl'), write(group_account(TICKS1,NG,W)), write('.'), nl, told,!.





 

