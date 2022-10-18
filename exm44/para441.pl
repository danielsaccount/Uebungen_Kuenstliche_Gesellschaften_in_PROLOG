% para441.pl 

runs(1). 
periods(5).
actors(7). 
events(13).    
actions(8).

action_types([preach,hear_the_word,other]).
variables_in_rule(preach,[bel,int,sinful]).
variables_in_rule(hear_the_word,[bel,int]).
variables_in_rule(other,[bel,int]).
use_old_data(no). 

ratio(67).        /* Rationalität der Priesters, alle werden 
                     gleich behandelt) */
preacher([2,4]).  /* eine Liste von ("Namen" von) Priestern */

% ------------------------------------------------------ 

minimum_of_beliefs(4).
variation_of_beliefs(2).
minimum_of_hear_the_word(4).
variation_of_hear_the_word(2).
minimum_of_higher_beliefs(2).
variation_of_higher_beliefs(1).
step_of_beliefs(2).

weights(preach,2,[80,101]).
weights(hear_the_word,2,[20,101]).
weights(other,2,[50,101]). 
  
% ------- Listen von weiblichen und männlichen Namen ---------

list_of_female_names([mia, hannah, hanna, lena, lea, leah, emma, anna, 
leonie, leoni, lilli, lilly, lili, emilie, emily, lina, laura, marie, sarah, 
sara, sophia, sofia,
lara, sophie, sofie, maja, maya, amelie, luisa, louisa, johanna, emilia,
nele, neele, clara, klara, leni, alina, charlotte, julia, lisa, zoe, pia,
paula, melina, finja, finnja, ida, lia, liah, lya, greta, jana, josefine,
josephine, jasmin, yasmin, lucy, lucie, victoria, viktoria, emely, emelie,
katharina, fiona, stella, pauline, amy, antonia, mara, marah, annika, nina,
matilda, mathilda, helena, marlene, lotta, isabel, isabell, isabelle,
theresa, teresa, chiara, kiara, frieda, frida, eva, maria, celine, selina,
jule, celina, vanessa, ronja, luise, louise, romy, isabella, ella,
franziska, elisa, magdalena, carla, karla, luna, sina, sinah, angelina,
milena, helene, merle, jolina, joelina, melissa, mila, nora, jette,
miriam, carlotta, carlotta, elena, kim, michelle, aylin, eileen, aileen,
ayleen, lynn, linn, mira, carolin, caroline, caroline, kimberly, kimberley,
julie, juli, alicia, kira, kyra, vivien, vivienne, lana, paulina, linda,
larissa, annabelle, annabell, annabel, anabel, elina, samira, leyla,
nelli, nelly, lucia, alexandra, tamina, laila, layla, elisabeth, lenja,
lenya, anny, anni, annie, diana, natalie, nathalie, martha, marta, mina,
jessica, jessika, valentina, alisa, leticia, letizia, olivia, christina,
lotte, samantha, fabienne, nisa, zoey, mariella, svea, cheyenne, chayenne,
annalena, carolina, carolina, ela, leona, tabea, aliyah, josy, josie,
rebekka, alissa, alyssa, anastasia, marleen, marlen, elif, anne, carina,
karina, dana, noemi, lene, milla, rosalie, luana, evelyn, evelin, eveline,
fenja, tessa, xenia, marla, alessia, mona, saskia, joline, joeline,
alexa, aurelia, ceylin, helen, jennifer, tamara, ecrin, leana, elli, elly,
nayla, florentine, henriette, lorena, veronika, felicitas, liana, livia,
malin, marit, melanie, josephin, josefin, emmi, emmy, tuana, dilara,
maike, meike, thea, ashley, linea, linnea, marina, lilian, lillian,
amina, jill, jil, sarina, giulia, janne, talia, thalia, alea, rieke,
rike, svenja, liliana, janina, nicole, selma, alisha, ava, kaja, kaya,
caja, liv, rosa, valeria, heidi, joyce, selin, ina, aleyna, enya, jamie,
naomi, patricia, amira, amalia, anouk, aliana, hermine, joy, juliana,
romina, azra, franka, melek, melinda, freya, marieke, marike, mary,
sonja, ayla, elaine, alma, eda, elin, lola, melia, miley, nike, philine,
cora, daria, jenny, jonna, yara, zeynep, cassandra, kassandra, esila,
felicia, malia, smilla, alena, amelia, aurora, ceyda, juliane, leandra,
lilith, madita, melisa, nika, summer, fatima, ilayda, joleen, malina,
sandra, jasmina, katja, medina, annelie, juna, valerie, madlen, madleen,
aliya, charlotta, eleni, hailey, mailin, denise, fine, flora,
madeleine, sena, vivian, ann, annemarie, asya, christin, kristin,
jara, jenna, julina, maren, soraya, tara, viola, alia, ellen, enie,
lydia, milana, nala, adriana, aimee, anja, chantal, elise, elsa, gina,
joanna, judith, malea, marisa, mayra, talea, thalea, tilda, delia,
joana, kiana, melis, meryem, sude, amanda, enna, esther, holly, irem,
marlena, mirja, phoebe, rahel, verena, alexia, bianca, bianka, cara,
friederike, catrin, katrin, kathrin, lavinia, lenia, nadine,
stefanie, stephanie, ada, asmin, bella, cecilia, clarissa, esma,
jolie, maila, mareike, selena, soey, ylvi, ylvie, zara, abby,
ayse, claire, helin, jona, jonah, lilia, luzi, luzie, nila, sally,
samia, sidney, sydney, tina, tyra, alice, anisa, belinay, cecile,
fee, inga, janna, jolien, levke, nia, ruby, stine, sunny, tamia,
tiana, alara, charleen, collien, fanny, fatma, felina, ines, jane,
maxima, tarja, adelina, alica, dila, elanur, elea, gloria, jamila,
kate, loreen, lou, maxi, melody, nela, rania, sabrina, ariana,
charline, christine, cosima, leia, leya, leonora, lindsay, megan,
naemi, nahla, sahra, saphira, serafina, stina, toni, tony, yaren,
abigail, ece, evelina, frederike, inka, irma, kayra, mariam,
marissa, salome, violetta, yagmur, celin, eleonora, felia, femke,
finia, hedda, hedi, henrike, jody, juline, lieselotte, lilliana,
luca, luka, maira, naila, naima, natalia, neela, salma, scarlett,
seraphine, shirin, tia, wiebke, alexis, alisia, angelique, anneke,
edda, elia, gabriela, geraldine, giuliana, ilaria, janin, janine,
joelle, malak, mieke, nilay, noelle, yuna, adele, ceren, chelsea,
daniela, evangeline, miz, maggie, malena, marielle, marietta,
mathea, mathilde, melike, merve, rafaela, raphaela, sandy, sienna ]).


list_of_male_names([leon, lucas, lukas, ben, finn, fynn, jonas, paul, 
luis, louis, maximilian, luca, luka, felix, tim, timm, elias,
max, noah, philip, philipp, niclas, niklas,
julian, moritz, jan, david, fabian, alexander,
simon, jannik, yannik, yannick, yannic, tom, nico, 
niko, jacob, jakob, eric, erik, linus, florian,
lennard, lennart, nils, niels, henri, henry, nick,
joel, rafael, raphael, benjamin, marlon, jonathan,
hannes, jannis, janis, yannis, jason, anton, emil,
johannes, leo, mika, sebastian, dominic, dominik,
daniel, adrian, vincent, tobias, samuel, julius,
till, lenny, lenni, constantin, konstantin, timo,
lennox, robin, aaron, oscar, oskar, colin, collin,
jona, jonah, justin, carl, karl, leonard, joshua,
ole, matteo, jamie, marvin, marwin, john, kilian,
lasse, mattis, mathis, matthis, levin, marc, mark,
liam, maxim, maksim, gabriel, theo, bastian, johann,
damian, noel, levi, phil, justus, malte, tyler,
tayler, valentin, benedikt, silas, lars, mats, 
mads, jeremy, michael, oliver, pascal, toni, tony,
dennis, bennet, bennett, artur, arthur, luke, luc,
luk, jayden, finnley, finley, finlay, connor,
conner, tristan, richard, marcel, diego, marius,
mohammed, muhammad, manuel, jannes, fabio, maik, meik,
mike, julien, frederic, frederik, frederick, marco, 
marko, kevin, matti, ian, maurice, franz, arne,
nicolas, nikolas, ali, leandro, kai, kay, leopold,
martin, elia, sam, dean, henrik, pepe, len, lenn,
hendrik, emilio, cedric, cedrik, milan, theodor,
timon, jasper, malik, matthias, hugo, leander, michel,
andreas, laurens, laurenz, bruno, konrad, arda,
neo, lorenz, marcus, markus, torben, thorben, magnus,
robert, can, milo, clemens, klemens, nikita, domenic, 
domenik, emilian, laurin, willi, willy, alessio, devin,
fiete, friedrich, deniz, ruben, thomas, eddi, eddy, lion,
luan, kian, lian, lias, mert, patrick, chris, ilias, ilyas,
kaan, nevio, quentin, yusuf, christoph, dustin, joris, gustav,
jaden, adam, fritz, henning, ryan, ferdinand, lionel, nino,
piet, yasin, alex, carlo, karlo, charlie, charly, leonardo,
peter, ahmed, ahmet, benno, efe, enes, iven, yven, josef, 
joseph, miguel, william, emir, marian, alessandro, antonio,
brian, bryan, jerome, kerem, ludwig, arian, rene, christopher,
jaron, stefan, stephan, sven, victor, viktor, carlos, dario,
sandro, jean, mehmet, bjarne, etienne, anthony, hans, mustafa,
darius, leif, georg, kjell, maddox, roman, thore, tore,
danny, mohamed, titus, andre, damien, leonhard, ricardo,
riccardo, semih, janne, melvin, valentino, cem, jannek, janek,
korbinian, romeo, taylor, jack, rayan, thilo, curt, kurt,
darian, jermaine, steven, albert, angelo, eren, eymen, hamza,
sascha, dave, sean, umut, wilhelm, edgar, giuliano, arjen, bela,
hennes, logan, lutz, marten, batuhan, danilo, enrico, fabrice,
lean, sami, tamino, tizian, amir, claas, klaas, xaver, armin,
denny, ibrahim, karim, sinan, soeren, tommy, yunus, emanuel,
gregor, jon, joost, jost, merlin, tamme, berkay, edward, jim,
lino, mick, mikail, miran, nicolai, nikolai, oemer, ron, tammo,
tjark, emre, jordan, leonidas, mario, quirin, eduard, hassan,
jano, kimi, taha, baran, berat, caspar, gianluca, jarne, jarno,
jonte, lucian, lucien, mailo, nathan, nelson, tino, calvin,
dorian, emirhan, furkan, ilja, lio, marek, mio, rico, damon,
janosch, jesper, juri, kerim, shawn, tiago, timur, elian,
ethan, gian, kenan, amin, arvid, enno, falk, jens, johnny,
keanu, mirco, mirko, pierre, santino, bjoern, eike, elijah,
emin, gerrit, hasan, jake, jakub, james, juan, kenny, peer,
raik, ramon, rocco, tarik, vitus, yigit, younes, bilal, dylan,
edwin, georgios, jesse, koray, lewis, nikola, stanley, taylan,
vinzenz, burak, corvin, dejan, keno, nathanael, neven, ahmad,
andrej, davin, dion, eray, erwin, francesco, mattes, brandon,
cornelius, ensar, fabien, giulio, hanno, ivan, jamal, jeremias,
joe, kim, kolja, marlo, miko, milow, omar, paolo, salih, samir,
tilo, timmy, vin, abdullah, adem, alan, alperen, ansgar, aras,
arno, azad, bo, giovanni, ismail, jaro, jendrik, jimmy, kirill,
otto, quinn, sercan, sidney, sydney, tyron, adriano, aiden, amon,
benny, carsten, karsten, dan, dante, hagen, harun, jayson, kalle,
leonas, levent, lorik, loris, mirac, onur, raul, samuele, severin, 
simeon, vincenzo, yassin, yves, alejandro, alfred, bendix, demian, enzo]).

