/* exam251 

Ein Beispiel für ein Muster zum Verbindung von Handlungstypen aus dem
Bereich des Essens in einer Gaststätte: Trinken ist mit Essen verbunden.

In 1 werden drei Fakten festgelegt: ein bestimmter Tick, hier: T = 20, 
zwei Akteure, hier: 4 und 13, und das Muster für "lunch", welches beim 
Mittagessen mit den zwei Akteuren eingehalten wird.
2 enthält eine kurze Liste von Speisen und Getränken, die in einem
Gasthaus angeboten wird.

In 3 wird die Resultatdatei "res251.pl" geleert und in 4 die Datei "bundpreds.pl"
in die Datenbasis eingeladen. Einige Probleme, die beim Einladen einer Datei
entstehen können, sind in unserem Buch in Abschnitt 1.4 erörtert. Die Datei, die 
eingeladen werden soll, muss für PROLOG vom dem Ordner aus erreichen 
sein, in dem das gerade aktive Hauptprogramm liegt.

Sie öffnen mit dem Editor die Datei bundpreds.pl, um zu schauen, welche
Verbindungen vorgesehen sind. Sie gehen wie folgt vor. Sie fahren mit dem
Cursor auf die Datei bundpreds.pl und klicken 1 Mal die linke Maustaste (oder
die äquivalente Taste des Laptops). Die Datei, d.h. das Icon, wird blau
unterlegt. Sie drücken nun 1 Mal die rechte Maustaste (oder die equivalente  
Taste des Laptops). Ein Fenster mit verschiedenen Befehlen geht auf. Fahren Sie 
den Cursor zum Eintrag "Öffnen mit". Sofort wird dieser Eintrag blau unterlegt und 
ein weiteres Fenster geht auf. Wir sehen verschiedene Editoren, die in dem
benutzten Computer vorhanden sind. Wir drücken z.B. auf "Editor" und sehen den 
Text in der Datei bundpreds.pl. In diesem Beispiel sehen wir Klausen:

  bundpred(fish,ACTION_TYP) :-
    member(ACTION_TYP,[red_wine,white_white,water]).    
  bundpred(stew,ACTION_TYP) :-
    member(ACTION_TYP,[beer,water]).
  ...

"bundpred" ist das hier benutzt Verbindungsprädikat für zwei (Prädikate für)
Handlungstypen, z.B. für "eat_fish" und "drink_red_wine", wobei wir den Handlungsaspekt
unterdrückt haben. Dieses stilistische Dilemma lässt sich nicht vermeiden, weil
"Gericht" und "Getränk" eben keine Handlungen ausdrücken. 

In 5 holt PROLOG den Tick und das Paar von Akteuren von 1. In 6 holt PROLOG
von 2 das Menu. In 7 wird das Akteurspaar [A1, A2] durch eine 
Schleifenkonstruktion bearbeitet. 

In 9 wird der erste Akteur aus dem Paar [4,13] berechnet: ACTOR = 4.
In 10 wählt der Akteur in 22 sein Gericht: DISH. PROLOG liest die Liste
DISHES = [fish,stew,chicken,steak] und in 23 die Länge der Liste, hier
LENGTH = 4. Weiter zieht PROLOG eine Zufallszahl X aus dem Bereich von 1 bis
LENGTH ( = 4). In 23 berechnet PROLOG die X-te Komponente aus der Liste der
Gerichte. D.h. Akteur 4 wählt sein Gericht aus, z.B. DISH_A = chicken. 
An diese Stelle wechseln wir von den Substantiven "Gericht" und "Getränk"
zu den entsprechenden Handlungstypen, z.B. "iss_Huhn" ("eat_chicken") und
"trinke_Rotwein" ("drink_red_wine"). Dazu stellen wir vor das Substantiv
den Handlungsaspekt mit den "Vorsilben" "iss_" und "trinke_" ("eat_" und "drink_").
Dies lässt sich in PROLOG leicht mit "concat" bewerkstelligen. In 25 wird
z.B. aus "eat", "_" und "chicken" das neue Prädikat "eat_chicken". Der 
Unterstrich "_" muss aber in Anführungszeichen stehen. Das Resultat in
25 wird durch die Variable DISH ausgedrückt. 

Nun kehrt PROLOG zu 10 zurück, wobei die Variable DISH durch das gerade 
beschriebene Verfahren durch ein konkretes Gericht ersetzt wurde, z.B. 
DISH = chicken. In 11 wird das Gericht, z.B. "eat_chicken" ( = DISH) durch 
"bundpred" mit einem Getränk DRINK verbunden. PROLOG sucht z.B. nach Klausen
der Form bundpred(chicken,DRINK). 

Für die LeserInnen besteht nun folgendes Problem. Es gibt z.B. den Term  
bundpred(chicken,DRINK), er ist aber sichtbar nur(!) in der Datei
"bundpreds". Dieser Term liegt zwar auch in der Datenbasis, weil wir diese 
Datei "bundpreds" in 4 hinzugeladen haben. Dort sind diese Fakten jedoch nicht
sichtbar. Sie stehen nur in der Datenbasis. Im trace-Modus sehen wir aber,
dass PROLOG die betreffende Klause findet.  

Im Beispiel "chicken" findet PROLOG die Klause

  bundpred(eat_chicken,DRINK) :- member(DRINK,[drink_water,drink_beer]).

PROLOG nimmt im Rumpf der Klause das erste Element aus der Liste 
[drink_water,drink_beer], nämlich drink_water ( =  DRINK). In 12 wird der 
nächste Tick bearbeitet: T1 is T + 1.  In 13 ruft PROLOG den Befehl
"call" auf. 

An dieser Stelle sind die Argumente von "call" z.B. belegt durch
call(drink_water,21,4). Im Programm sehen wir in 13 allerdings nur die 
Variablen DRINK,T1 und ACTOR. PROLOG macht nun folgendes: 
1) baut PROLOG diese drei Argumente im Ablauf zu einem Term zusammen, 
z.B. zu: drink_water(21,4). 
2) sucht PROLOG nach einer Klause, die mit drink_water(21,4) beginnt.  
In diesem Programm findet PROLOG eine solche Klause in 21 und schickt
das entsprechende Resultat an die Datei res251.pl. Wenn es in 13 keinen
Anschlußpunkt gibt, geht PROLOG nach oben zu nach 8 und 7.

-------------------------------------- */

tick(20). actor_pair([4,13]). lunch(20,[4,13]).                      /* 1 */
menu(dishes([fish,stew,chicken,steak]),
         drinks([white_wine,water,beer])).                           /* 2 */

% ------------------------------------

start :-
 (exists_file('res251.pl'), delete_file('res251.pl'); true),         /* 3 */ 
  consult('bundpreds251.pl'),                                        /* 4 */
trace,
  tick(T), actor_pair([ACTOR1,ACTOR2]),                              /* 5 */
  menu(dishes(DISHES),drinks(DRINKS)),                               /* 6 */
  ( between(1,2,ACTOR_NUMBER), act(ACTOR_NUMBER,T,[ACTOR1,ACTOR2],DISHES,DRINKS), 
    fail; true).                                                     /* 7 */

act(ACTOR_NUMBER,T,PAIR,DISHES,DRINKS) :-                            /* 8 */
  nth1(ACTOR_NUMBER,PAIR,ACTOR),                                     /* 9 */
  choose(T,ACTOR,DISHES,DISH),                                       /* 10 */
  bundpred(DISH,DRINK),                                              /* 11 */   
  T1 is T + 1,                                                       /* 12 */
  call(DRINK,T1,ACTOR),!.                                            /* 13 */

eat_fish(T1,A) :- writein('res251.pl',eat_fish(T1,A)).               /* 14 */
eat_stew(T1,A) :- writein('res251.pl',eat_stew(T1,A)).               /* 15 */
eat_chicken(T1,A) :- writein('res251.pl',eat_chicken(T1,A)).         /* 16 */
eat_steak(T1,A) :- writein('res251.pl',steak_fish(T1,A)).            /* 17 */

drink_red_wine(T,A) :- writein('res251.pl',drink_red_wine(T,A)).     /* 18 */
drink_white_wine(T,A) :- writein('res251.pl',drink_white_wine(T,A)). /* 19 */
drink_beer(T,A) :- writein('res251.pl',drink_beer(T,A)).             /* 20 */
drink_water(T,A) :- writein('res251.pl',drink_water(T,A)).           /* 21 */

choose(T,A,DISHES,DISH) :-                                           /* 22 */
  length(DISHES,LENGTH), X is random(LENGTH) + 1,                    /* 23 */
  nth1(X,DISHES,DISH_A),                                             /* 24 */
  concat(eat,'_',X1), concat(X1,DISH_A,DISH).                        /* 25 */

% -------------------------

writein(X,Y) :- append(X), write(Y), write('.'), nl, told.           /* 26 */


