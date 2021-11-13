man(tom).
man(john).
man(bob).
man(mark).
man(steve).
man(robert).
man(ash).

woman(maria).
woman(liz).
woman(marta).
woman(ann).
woman(margo).




child(liz, tom).
child(liz, maria).
child(bob, tom).
child(bob, maria).
child(mark, tom).
child(mark,maria).
child(steve,ann).
child(steve,mark).
child(margo,liz).
child(margo,john).
child(robert,liz).
child(robert,john).
child(ash,bob).
child(ash,marta).

married(X,Y):-child(Z,Y), !, child(Z,X), not(X=Y).

mother(X,Y):-child(Y,X),woman(X)./*Задание 3*/
mother(X):-mother(Y,X),write(Y).
father(X,Y):-child(Y,X),man(X)./*Задание 4*/
father(X):-father(Y,X),write(Y).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z)./*Задание 5*/
wife(X,Y):-child(Z,Y), !, child(Z,X), not(X=Y),woman(X)./*Задание 6*/
wife(X):- wife(Y,X), write(Y).
b_s(X,Y):-brother(X,Y),!./*задание 7*/
grand_pa(X, Y) :- child(Z, X), child(Y, Z), man(X)./*Задание 8*/
grand_pas(X) :- grand_pa(Y, X), write(Y).
grand_da(X, Y):-child(Z, Y), child(X, Z), woman(X)./*Задание 9*/
grand_dats(X) :- grand_da(Y, X), write(Y).
grand_pa_and_son(X, Y) :- child(Z, X), child(Y, Z), man(X), man(Y)./*Задание 10*/
grand_ma_and_son(X,Y) :- child(Z,X). child(Y,Z), woman(X), man(Y)./*Задание 11*/
uncle(X, Y) :- child(Y, Z), brother(Z, X)./*Задание 12*/
uncle(X) :- uncle(Y, X), write(Y).
nephew(X,Y):-man(X),child(X,Z), is_br_si(Z,Y)./*Задание 13*/



son(X,Y):- child(X,Y), man(X).
douter(X,Y):-child(X,Y), woman(X).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z).
sister(X,Y):-woman(X),not(X=Y),child(X,Z),!,child(Y,Z).
is_br_si(X,Y):-sister(X,Y).





uncle(X,Y):-man(X),child(Y,M),is_br_si(Z,M),married(X,Z).
aunt(X,Y):-woman(X),child(Y,M),is_br_si(Z,M),married(X,Z).
