/* exam352.pl 

Hier wird ein erster Schritt für die Erzeugung einer Analyseschleife
getan. In diesem Beispiel werden nur Parameter automatisch variiert,
deren zugehöriges Prädikat einstellig ist.

Eine solche Liste von einstelligen Prädikaten ist am Anfang bereitgestellt 

(1)   list_of_names([runs,periods,actors,exist_min,domain_of_values]). 

Weiter wird für jedes dieser Prädikate ein Bereich von Zahlen ("Inter-
vallen") festgelegt

(2)   list_of_intervals([[1,2,5],[2,5,6],[4,7,10],[5,20],[10,20]]).

Ein solcher Bereich besteht aus einer Liste von Zahlen. In einem Ablauf,
der durch eine bestimmte Menge von Parametern gesteuert wird, ist eine 
bestimmte Zahl I aus dem Bereich INT_J ein Wert für den Parameter, der
"an der richtigen Stelle" in dem Parameterset steht.

Für jedes Prädikat in (1) nehmen wir eine Zahl in (2), die zu diesem 
Prädikat gehört. Zum Beispiel nehmen wir das "zweite" Prädikat aus der Liste
in (1): periods. In Liste (2) nehmen wir nun aus der zugehörige, "zweite" 
Liste [2,5,6] ein bestimmte Zahl, etwa 5. Prologisch wird mit dem Prädikat 
"periode" und der Zahl "5" der Term periode(5) zusammengebaut.

Allgemein gesprochen wählen wir eine Kombination von 5 Zahlen aus (2) 
und binden diese Zahlen "an der richtigen Stelle" an das "richtige"
Prädikat. In dieser Weise erhalten wir schon aus dieser einfachen Liste 
(2) viele Kominationen. Aus einer bestimmte Kombination, wie z.B. 
[1,6,7,5,10] entsteht eine Liste von Parametern

   [runs(1),periods(6),actors(7),exist_min(5),domain_of_values(10)].

Aus einer(!) solchen Parameterliste wird ein Ablauf für ein Sim-Programm
ausgeführt.

Diese hier beschriebene Analyseschleife funktioniert, wenn wir verschiedene
Satellitendateien bereitstellen. In 2 werden drei Satellitendateien 
dazugeladen. autopara352.pl enthält alle Parameter, die hier nicht(!) variiert
werden. pred352.pl enthält einige Hilfsprogramme und rules352.pl die Handlungsregeln,
die in dem Sim-Programm benutzt werden. In diesem Beispiel gibt es drei
Handlungsmuster "donothing"; "schelling" und "takeweak", die einfach aus dem
SMASS Programm (Balzer, 2000) übernommen wurden. In 3 wird die Resultatdatei 
res352.pl und die Datei data352.pl geleert; es herrscht "tabula rasa".  

In 4 wird die Klause ":- dynamic fact/3 , fact/4 ." buchstabiert, so dass
sie in der Datei res352.pl vorhanden ist. Diese Klause ist dazu da, Fakten
auch wieder in das Hauptprogramm zu schicken und dort zu verwenden. 

In 5 und 6 werden die zwei Listen, die wir oben erklärt haben, aus der 
Datenbasis geholt, welche in der Datei "autopara352.pl" zu finden sind. In 7 wird
aus die Liste LIST_OF_DOMAINS alle(!) möglichen Kombinationen von Zahlen
erzeugt. D.h. LIST_OF_PARA_COMBINATIONS =[COMBINATION_OF_PARAS_1,..., 
COMBINATION_OF_PARAS_N], wobei COMBINATION_OF_PARAS_I = [PARA_M1,...,PARA_MK]
und PARA_MJ eine Zahl ist, die an der richtigen Stelle der Liste der Prädikate
verwendet werden kann. Noch anders gesagt, wird aus einer Liste 
[PARA_M1,...,PARA_MK] eine Liste 

    [runs(PARA_M1),periods(PARA_M2),...,domain_of_values(PARA_MK)]
 
von Parametern. Die Liste LIST_OF_PARA_COMBINATIONS ist normalerweise kaum 
lesbar. Wir haben diese Liste nur aus Sicherheitsgründen an die Resultatdatei
geschickt. In der Datei "pred" der Hilfsprogramme findet sich ein Programm, 
welches mit dem Term in 7 die Liste LIST_OF_PARA_COMBINATIONS erzeugt.

In 9 wird die Länge dieser Liste bestimmt. In 10 wird eine Schleife über diese
Länge dieser Liste gelegt. In einem Schleifenschritt wird in 10 eine bestimmte
Nummer ONE_COMBINATION_NUMBER aus dieser Liste bearbeitet. D.h. PROLOG wählt
aus der Liste das ONE_COMBINATION_NUMBER-te Element aus der Liste aus:
A_COMBINATION_OF_PARAS. Dieses Element ist also eine Art von Datei für 
Parameter.   

In 11 wird aus dieser Liste A_COMBINATION_OF_PARAS der Parameter und aus der Liste
LIST_OF_PREDICATES der Prädikate eine bestimmte "Welt" erzeugt, die in dem nun
bearbeiteten Ablauf simuliert wird.

In 17 wird zunächst die Datei "para352.pl" geleert. In 18 - 26 wird diese Datei
wieder neu gefüllt. In 19 werden "abgeleitete" Parameter "A(PARAMETER_I)" 
gesammelt, die wir in diesem Beispiel in "autopara" direkt hineingeschrieben 
hatten. Die Datei "autopara352.pl" wurde zwar gerade geleert, die Terme 
"A(PARAMETER_I)" sind aber in der Datenbasis noch vorhanden. LIST enthält
genau die Einträge "a(weights(donothin,2,[50,101])). ...", die in "autopara352.pl" 
zu finden sind. In 19 wird die Länge der Liste bestimmt. In 20 wird eine
Schleife über diese Liste gelegt. In einem Schleifenschritt wird ein FACT, also 
ein Parameter, aus der Liste LIST in die "para352.pl" eingetragen. Am Ende dieser
Schleife enthält die Datei "para352.pl" wieder eine vollständige Liste von 
Parametern. Nur die Argumente bei den Parametern wurden durch andere Zahlen 
ersetzt, die in einer A_COMBINATION_OF_PARAS gefunden wurden. In 23 wird der
Stream zur Datei "para352.pl" wieder geschlossen.

In 24 wird nun das Simulations-Hauptprogramm "dynsim352.pl" geladen. Dieses
Hauptprogramm beginnt nicht mit dem hier üblichen "start", sondern mit dem
Kopf "dynstart(A_COMBINATION_OF_PARAS)". Erstens wurde "start" schon in diesem
Beispielprogramm am Anfang benutzt. Deshalb mussten wir ein anderes Prädikat
wählen. Zweitens trägt der Anfangskopf eine Variable. In der Schleife in 11 
wird diese Variable bearbeitet. D.h. es werden viele verschiedene Abläufe
ausgeführt, die jeweils von anderen Parameterkombinationen gestartet werden.
In 26 wird am Ende eines Ablaufs einer Simulation die Parameterdatei wieder 
geleert: delete_file('para352.pl'). 

Genauer werden in 22 die beiden Listen A_COMBINATION_OF_PARAS und 
LIST_OF_PREDICATES geholt und aus beiden Listen an derselben Stelle
INDEX_NUMBER die jeweils betreffende Komponente herausgenommen und in 29
zu einem Term zusammengebaut.

In 12 wird schließlich das Graphikprogramm geladen, mit welchem aus den 
Resultaten aus res352.pl drei Bildsequenzen generiert werden. Jede Bildsequenz
gehört zu einer der drei Handlungstypen, die in diesem Beispiel verwendet wird. 
In 13 wird die Liste der Handlungstypen modes(LIST_OF_ACTIONTYPS) geholt, die
in autopara.pl zu finden ist.

In 14 haben wir eine bestimmte Kombination von Parameterargumenten per Hand
eingetragen: display_world([3,2,5,5,10],2). [3,2,5,5,10] ist eine Kombination
von Parameterargumenten und das zweite Argument, hier 2, ist die Nummer eines 
Runs, der vorher abgelaufen war. Aus den Resultaten werden also nur die
Resultate benutzt, die von dem 2.ten Run stammen. Im Prinzip ließe sich auch 
für jeden Ablauf die zugehörigen Bildsequenzen ausführen. Allerdings führt 
dies zu rein praktischen Klausen, die uns hier nicht interessieren.  

In 16 wird eine Schleife über die Handlungstypen gelegt. Für einen Handlungstyp 
ACTION_TYP und für einen bestimmten Run ONE_RUN wird die zugehörige Bildsequenz
erscheinen - relativ zu den beiden Listen.

LENGTH_PC = LENGTH_OF_PARAMETER_COMBINATIONS
LENGTH_AT = LENGTH_OF_THE_LIST_OF_ACTIONTYPS
NUMBER_OF_dPARA = NUMBER_OF_A_DERIVED_PARAMETER
*/

:- multifile fact/3 , fact/4 .                                              /* 1 */

start :- 
   consult('autopara352.pl'), consult('pred352.pl'), consult('rules352.pl'), /* 2 */
   ( exists_file('res352.pl'), delete_file('res352.pl') ; true ),          /* 3a */
   ( exists_file('data352.pl'), delete_file('data352.pl') ; true ),        /* 3b */
   append('res352.pl'), write(':'), write('-'), write(' '), 
   write(dynamic), write(' '), write(fact), write('/'), write(3), 
   write(' '), write(','), write(' '), write(fact), write('/'), write(4), 
   write(' '), write('.'), nl, told,                                        /* 4 */
   list_of_predicates(LIST_OF_PREDICATES),                                  /* 5 */
   list_of_domains(LIST_OF_DOMAINS),                                        /* 6 */
   cartprod(LIST_OF_DOMAINS,LIST_OF_PARA_COMBINATIONS),                     /* 7 */
   append('res352.pl'), write(list_of_constants(LIST_OF_PARA_COMBINATIONS)),
      write('.'), nl, told,                                                 /* 8 */
   length(LIST_OF_PARA_COMBINATIONS,LENGTH_PC),                             /* 9 */
   ( between(1,LENGTH_PC,ONE_COMBINATION_NUMBER),
        nth1(ONE_COMBINATION_NUMBER,LIST_OF_PARA_COMBINATIONS,
             A_COMBINATION_OF_PARAS),                                      /* 10 */
       make_a_world(A_COMBINATION_OF_PARAS,LIST_OF_PREDICATES),            /* 11 */
       fail
   ;      
       true
   ),!,
   consult('display352.pl'),                                               /* 12 */
   consult('res352.pl'),
   modes(LIST_OF_ACTIONTYPS), length(LIST_OF_ACTIONTYPS,LENGTH_AT),        /* 13 */
   display_world(ONE_SPECIAL_COMBINATION,ONE_RUN),                         /* 14 */
   ( between(1,LENGTH_AT,A_NUMBER_OF_AN_ACTIONTYP),
       nth1(A_NUMBER_OF_AN_ACTIONTYP,LIST_OF_ACTIONTYPS,ACTION_TYP),       /* 15 */
       make_picture(ACTION_TYP,ONE_SPECIAL_COMBINATION,LIST_OF_PREDICATES,ONE_RUN),                                                                               /* 16 */  
     fail 
   ; true
   ),!. 

make_a_world(A_COMBINATION_OF_PARAS,LIST_OF_PREDICATES) :-                 /* 11 */
    ( exists_file('para352.pl'), delete_file('para352.pl') ; true ),       /* 17 */
    append('para352.pl'),                                                  /* 18 */
    findall(X,a(X),LIST), length(LIST,LENGTH),                             /* 19 */
    ( between(1,LENGTH,NUMBER_OF_aPARA), nth1(NUMBER_OF_aPARA,LIST,FACT), 
        write(FACT), write('.'), nl, fail                                  /* 20 */
    ;   true
    ),!,
    length(A_COMBINATION_OF_PARAS,LENGTH1),                                /* 21 */
    ( between(1,LENGTH1,INDEX_NUMBER), 
         read_to_para(INDEX_NUMBER,A_COMBINATION_OF_PARAS,
                      LIST_OF_PREDICATES),                                 /* 22 */
      fail; true ),!, 
    told,                                                                  /* 23 */
    consult('dynsim352.pl'),                                               /* 24 */
    dynstart(A_COMBINATION_OF_PARAS),                                      /* 25 */
    delete_file('para352.pl'),!.                                           /* 26 */ 

read_to_para(INDEX_NUMBER,A_COMBINATION_OF_PARAS,
         LIST_OF_PREDICATES) :-                                            /* 22 */
    nth1(INDEX_NUMBER,A_COMBINATION_OF_PARAS,ARGUMENT),                    /* 27 */
    nth1(INDEX_NUMBER,LIST_OF_PREDICATES,Pred),                            /* 28 */
    write(Pred), write('('), write(ARGUMENT), write(')'), 
    write('.'), nl,!.                                                      /* 29 */
 
