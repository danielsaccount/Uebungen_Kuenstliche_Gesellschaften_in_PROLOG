/* exam232.pl 

Die Charakteure aller Akteure werden durch diskret und kumulativ verteilte
Häufigkeiten erzeugt, wobei ein Charakter vier Komponenten enthält.

Als Fakten stellen wir bereit: die Anzahl der Akteure (hier 10), die Anzahl 
der Charakterkomponenten (hier 4) und vier Listen, die diskrete und kumulative
Verteilungen erzeugen. All diese Verteilungen beziehen sich auf die Anzahl der
Akteure. 

In 8 und 9 werden die Anzahlen von 1 und 2 geholt. Eine erste Schleife in
10 und 11 läuft über die vier Charakterkomponenten und die zweite Schleife 
über die (Anzahl der) Akteure. 

In 16 wird eine Liste von Ausprägungen geholt, die zur Nummer NUMBER dieser
Liste ghört, siehe 3 - 6, z.B. list(3,[15,30,60,80,100]),  NUMBER = 3,
LIST = [15,30,60,80,100]. In 17 wird die Länge LENGTH dieser Liste bestimmt.
In 18 werden alle Komponenten aus der Liste LIST der Länge LENGTH mit  
make_sum(LIST,LENGTH,SUM) addiert, so dass die Summe SUM ausgegeben wird.

Dies wird unten in 48 - 54 beschrieben. Diese beiden Klausen werden oft in 
Sim-Programmen benutzt, siehe auch exam52 - Hilfsklausen - Summe.pl . 

In 19 wird relativ zur einer Charakterkomponente (d.h. relativ zu einer  
Liste der Number NUMBER) eine Häufigkeitsverteilung von Werten für diese
Charakterkomponente über die Akteure erzeugt. Dabei wird auch die gerade
errechnete Summe SUM benutzt. Dazu wird in 21 und 22 eine Liste über die
Akteure und in 23 ein Schleifenschritt für einen Akteur gelegt. 

In 24 wird eine Zufallszahl von 1 bis SUM gezogen und ein Hilfszähler
"aux_sum" eingerichtet. Die Länge der Liste LIST der Ausprägungen in 25 wird
bestimmt: LENGTH. In 26 wird eine offene Schleife über die Länge dieser Liste
eröffnet. In 27 wird an der X-ten Stelle der Liste (X_TH_POSITION_OF_LIST)
eine Zahl DISTINCT_COMPONENT bestimmt. Dazu wird in 33 der Hilfszähler 
"aux_sum" mit dem Stand VAR geholt und in 34 die X-te Komponente aus der Liste 
LIST bestimmt. In 35 wird schließlich DISTINCT_COMPONENT bestimmt, nämlich:
DISTINCT_COMPONENT is VAR + X_TH_COMPONENT_OF_LIST. In 36 wird der Hilfszähler 
"aux_sum" upgedatet.

PROLOG geht zurück zu 27 und prüft die Ungleichung in 28. Hier gibt es zwei 
Fälle. Wenn in 28 Z =< DISTINCT_COMPONENT ist, wird die offenen Schleife in 
26 beendet. Der Hilfszähler wird in 29 gelöscht und der erwartete Fakt 
- eine bestimmte Charakterkomponente für A - wird als Resultat in 30 nach 
res232.pl geschickt. In 31 wird dieser Fakt in einem vollständigen Programm auch 
gleich in die Datenbasis des Hauptprogramms eingetragen. Solche Fakten über 
den Charakter werden oft benutzt. 

Wenn die Ungleichung in 28 falsch ist, geht PROLOG in 26 zurück und berechnet
in 26 den nächsten Schleifenschritt. Da diese Konstruktion so angelegt ist,
dass in 28 am Ende immer eine Ungleichung steht, die richtig ist, kehrt PROLOG 
am Schluß nach 26, 23, 22, 21 und wendet sich dem nächsten Akteur zu. Wenn die
Schleife 20 abgeschlossen ist, geht PROLOG zurück zu 15 und 11. Wenn auch diese
Schleife beendet ist, wendet sich PROLOG der Schleife in 12 zu.

In dieser Schleife werden in 12 für jeden Akteur A die Charakterkomponenten 
für A zu einer Liste zusammengefügt. Dazu wird in 37 für einen Akteur A in 38
eine Hilfsliste "aux_list" eingerichtet, die durch die Schleife in 39 zur
Liste der Charakterkomponenten von A und damit zum Charakter von A wird.
In 40 wird diese Liste an die Resultatdatei res232.pl geschickt. Schließlich
wird in 42 die Hilfsliste gelöst und in 14 eliminieren wir auch wieder die 
Fakten, um unser Beispiel nicht mit alten Fakten zu belasten.

Wenn Sie das Programm im trace-Modus anschauen möchten, entfernen Sie in 6a das
Symbol % .
*/

number_of_actors(10).                                               /* 1 */
number_of_character_components(4).                                  /* 2 */
list(1,[10,80,100]).                                                /* 3 */
list(2,[100]).                                                      /* 4 */
list(3,[15,30,60,80,100]).                                          /* 5 */
list(4,[100]).                                                      /* 6 */

start :-
 % trace,                                                           /* 6a */
  ( exists_file('res232.pl'), delete_file('res232.pl') ; true ),    /* 7 */
  number_of_character_components(NUMB_of_CHAR_COMPONENTS),          /* 8 */
  number_of_actors(AA),                                             /* 9 */
  ( between(1,NUMB_of_CHAR_COMPONENTS,NUMBER),                      /* 10 */
             make_actor_loop(NUMBER,AA), fail; true),               /* 11 */
  ( between(1,AA,A), add_features(A,NUMB_of_CHAR_COMPONENTS), fail; /* 12 */
             true),!,                                               /* 13 */
   retractall(feature(AAA,III,XXX)),!.                              /* 14 */

make_actor_loop(NUMBER,AA) :-                                       /* 15 */
  list(NUMBER,LIST),   /* NUMBER hier ist nicht id mit NUMBER unten */                                             /* 16 */
  length(LIST,LENGTH),                                              /* 17 */
  make_sum(LIST,LENGTH,SUM),                                        /* 18 */
  make_function_randomly(feature,AA,LIST,NUMBER,SUM),!.             /* 19 */

make_function_randomly(feature,AA,LIST,NUMBER,SUM) :-               /* 20 */
  ( between(1,AA,A),                                                /* 21 */
      generate_one_random_number(A,LIST,NUMBER,SUM),fail; true),!.  /* 22 */

generate_one_random_number(A,LIST,NUMBER,SUM) :-                    /* 23 */
 % trace,
   Z is random(SUM) + 1, asserta(aux_sum(0)),                       /* 24 */
   length(LIST,LENGTH),                                             /* 25 */
   between(1,LENGTH,X_TH_POSITION_OF_LIST),                         /* 26 */
   calculate(X_TH_POSITION_OF_LIST,LIST,DISTINCT_COMPONENT),        /* 27 */
   Z =< DISTINCT_COMPONENT ,                                        /* 28 */
   retractall(aux_sum(_)),!,                                        /* 29 */
   append('res232.pl'), write(feature(A,NUMBER,
         X_TH_POSITION_OF_LIST)), write('.'), nl, told,             /* 30 */
   asserta(feature(A,NUMBER,X_TH_POSITION_OF_LIST)),!.  /* 31 */

calculate(X_TH_POSITION_OF_LIST,LIST,DISTINCT_COMPONENT) :-         /* 32 */
   aux_sum(VAR),                                                    /* 33 */
   nth1(X_TH_POSITION_OF_LIST,LIST,X_TH_COMPONENT_OF_LIST),         /* 34 */
   DISTINCT_COMPONENT is VAR + X_TH_COMPONENT_OF_LIST,              /* 35 */
   retract(aux_sum(VAR)), asserta(aux_sum(DISTINCT_COMPONENT)),!.   /* 36 */

add_features(A,NUMB_of_CHAR_COMPONENTS) :-                          /* 37 */
  asserta(aux_list(A,[])),                                          /* 38 */
  ( between(1,NUMB_of_CHAR_COMPONENTS,NUMBER), 
                 add_feature(A, NUMBER), fail; true),!,             /* 39 */
  aux_list(A,LIST_OF_CHAR_COMPONENTS),                              /* 40 */
  append('res232.pl'), write(character(A,LIST_OF_CHAR_COMPONENTS)), 
          write('.'),  nl, told,                                    /* 41 */                     
  retractall(aux_list(A,LL)) ,!.                                    /* 42 */

add_feature(A,NUMBER) :-                                            /* 43 */
  feature(A,NUMBER,X_TH_POSITION_OF_LIST),                          /* 44 */ 
  aux_list(A,LOF),                                                  /* 45 */
  append(LOF,[X_TH_POSITION_OF_LIST],LOFnew),                       /* 46 */
  retract(aux_list(A,LOF)), asserta(aux_list(A,LOFnew)),!.          /* 47 */

make_sum(LIST,LENGTH,SUM) :-                                        /* 48 */
  asserta(auxsum(0)),                                               /* 49 */
  ( between(1,LENGTH,N), add(N,LIST), fail; true),                  /* 50 */
  auxsum(SUM), retract(auxsum(SUM)).                                /* 51 */

add(N,LIST) :-                                                      /* 52 */
  auxsum(W), nth1(N,LIST,K), W1 is W + K,                           /* 53 */
  retract(auxsum(W)), asserta(auxsum(W1)),!.                        /* 54 */