/* exam161

Die Einbindung einer Schleife in die Umgebung des Programms. 

In der Datei data161.pl sind drei Fakten vorhanden, die Zeile 1 mit
"consult" in die Datenbasis eingeladen werden.

Sie öffnen sicherheitshalber die Datei data161.pl, indem Sie genau ein Mal
die rechte Maustaste (oder die entsprechende Tastaturtaste) drücken. Es öffnet 
sich ein Fenster, in dem verschiedene Befehle zu sehen sind. Sie drücken
den Befehl "Öffnen mit" (oder einen ähnlich lautenden) Befehl. Sie sehen verschiedene 
Namen für Editoren. Sie drücken z.B. genau ein Mal auf "Editor" - dies ist der Standard-
Editor von DOS aus alter Zeit - und die Datei data161.pl öffnet sich. Ein anderer,
nicht verschnörkelter Editor ist "WordPad" (oder ähnlich).

Sie sehen in data161.pl drei Fakten: 

namelist([peter,karl,udo,uta,otto]).                      /* a */
social(peter).                                            /* b */
social(uta).                                              /* c */

Wenn wir mit der rechten Maustaste zwei Mal auf die Datei data161.pl 
drücken, wird PROLOG aufgerufen; was aber für uns wenig Sinn macht. 

Sie öffnen stattdessen die Datei exam161.pl, indem Sie die rechte 
Maustaste (oder die entsprechende Tastaturtaste) zwei(!) Mal drücken. Die Datei
exam161.pl ist eingeladen und bereit. Sie tippen wie in Zeile 1 unten  
"start." ein.

In 2 wird der "trace" Modus eingeschaltet, so dass wir das Programm
schrittweise ansehen können. 

In 3 wird die Datei data161.pl in die Datenbasis eingeladen. Diese Datei 
existiert, wie Sie gerade überprüft haben. In der neuen PROLOG Version,
die durch Internet-Regularien und Thread-Konstruktionen mehrere Sicher-
heitsbarrieren überwinden muss, um diese Datei einzuladen, gibt PROLOG
verschiedene Zeile aus, die uns hier nicht weiter interessieren. Nach
einigen Zeilen sehen Sie eine Zeile 
    Exit: (7) consult(user:'data161.pl') ? creep
Diese besagt, dass PROLOG die Datei data161.pl in die Datenbasis eingeladen 
hat.

In 4 findet PROLOG den Term namelist(ACTORLIST) und schaut, ob
in der Datenbasis ein Fakt dieser Form zu finden ist. PROLOG findet
namelist([peter,karl,udo,uta,otto]), was Sie auch im Ablauf im
nächsten Schritt auf dem Bildschirm sehen können. Weiter wird in 4
mit "length" die Länge dieser Liste berechnet: LENGTH = 5.
In 5 wird ein Hilfszähler eingerichtet, indem der Term counter(0)
in die Datenbasis einladen wird. Der Zähler steht also am Anfang auf 0.

In 6 trifft PROLOG eine Schleife. PROLOG setzt I in "between" auf 1
und geht zu do(I,ACTORLIST). I ist mit 1 und ACTORLIST mit
[peter,karl,udo,uta,otto] belegt.

PROLOG springt zu 8 und holt aus der Akteurliste die ersten Komponente,
also ACTOR = peter. In 9 trifft PROLOG eine Oder-Konstruktion.
PROLOG merkt sich die Anfangsklammer "(" in 9, das "Oder" findet PROLOG
in 13 und die Endklammer ")" der Konstrukion in 15. In 9 findet PROLOG
den Term social(ACTOR), wobei ACTOR = peter ist. PROLOG sucht in der
Datenbasis nach einem Fakt dieser Form, und wird fündig. social(peter)
wurde als Fakt aus data161.pl in unser Programm gerade dazugeladen. 
PROLOG befasst sich nun mit dem Zähler counter(C), wobei C = 0 ist.
In 19 löscht PROLOG mit "retract" den Term counter(0)aus der Datenbasis.
In 11 addiert PROLOG die Zahl C (d.h. an diesem Punkt: 0) um 1: 
     Cnew is C + 1 = 0 + 1 = 1. 
In 12 lädt PROLOG diesen Term counter(Cnew), d.h. counter(1), in die 
Datenbasis ein. Damit ist 8 richtig bearbeitet. PROLOG geht daher nach
oben zu 6, und trifft "fail". PROLOG geht zurück zu "between" und
ersetzt 1 (1=I) durch 2 (2=I). PROLOG geht wieder nach rechts zu "do"
und bearbeitet do(2,...).

In dem zweiten Schleifenschritte do(2,...) ist in 8 die zweite Komponente
der Akteur "karl". Für Karl gibt es aber in der Datenbasis keinen Fakt 
social(karl). PROLOG setzt daher den linken Oder-Teil auf "falsch" und 
geht zum rechten Teil in 13 - 15. D.h. der Hilfszähler wird in diesem
Schleifenschritt nicht benutzt; der Zählerstand  bleibt gleich. PROLOG
geht zu 6 und bearbeitet den nächsten Schleifenschritt. Und so weiter.

Dies geht so lange, bis der 5-te Schleifenschritt beendet wurde. In 6 hat 
PROLOG gerade do(5,...) bearbeitet und trifft "fail". PROLOG geht nach 
links zu "between" und versucht, I um Eins zu erhöhen. I ist aber nun 
5 und I + 1 = 6, so dass I + 1 nicht mehr zwischen 1 und 5 liegt. PROLOG 
erkennt dies und sieht, dass der linke Teil
    between(1,LENGTH,I), do(I,ACTORLIST), fail 
der Oder-Konstruktion in 6 falsch ist. PROLOG geht daher zu "true".

Damit ist die Schleife beendet. In 7 holt PROLOG den Hilfszähler
und schreibt den Zählerstand mit "write" heraus. Schließlich
löscht PROLOG den Term counter(C) aus der Datenbasis. Wir machen dies
vorsorglich, weil wir eventuell dieses Programm noch ein Mal laufen
lassen möchten. 
*/

start :-                                                  /* 1 */
  trace,                                                  /* 2 */
  consult('data161.pl'),                                  /* 3 */
  namelist(ACTORLIST), length(ACTORLIST,LENGTH),          /* 4 */
  asserta(counter(0)),                                    /* 5 */
  ( between(1,LENGTH,I), do(I,ACTORLIST), fail ; true ),!,/* 6 */
  counter(C), write(counter(C)), retract(counter(C)).     /* 7 */

do(I,ACTORLIST) :- nth1(I,ACTORLIST,ACTOR),               /* 8 */
  ( social(ACTOR), counter(C),                            /* 9 */
    retract(counter(C)),                                  /* 10 */
    Cnew is C + 1,                                        /* 11 */
    asserta(counter(Cnew))                                /* 12 */
  ;                                                       /* 13 */
    fail                                                  /* 14 */
  ),!.                                                    /* 15 */
 