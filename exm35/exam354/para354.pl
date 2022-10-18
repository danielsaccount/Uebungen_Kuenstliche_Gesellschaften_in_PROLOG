/* para354.pl 

Parameter für das 3p Modell */

:- dynamic fact/3.

use_old_data(no). /* Sollte man hier benutzen. */
statistics(on).

runs(2).
periods(50).
export_all_periods(every(5)).
actors(10).

rules([produce,predate,protect]).
variables([character,ut_coeffs,hist,stock]).

/* coeffs(K1,...,K7): K1 = Prozent von Produkten (produces), 
   K2,K3,K4 = Nutzenkoeffizienten für Produzenten (producers), 
   K5,K6,K7 = Nutzenkoeffizienten für Räuber (predators)  */

coeffs(35,60,1,0,0,0,1,0,0.4,0.3,0.3).
expo(0.5).
