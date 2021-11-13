man(alexandr).
man(alexey).
man(sergey).
man(max).
man(miron).

woman(tomara).
woman(anna).
woman(olga).
woman(mira).
woman(arina).
woman(luba).

child(anna, alexandr).
child(olga, alexandr).
child(anna, tomara).
child(olga, tomara).
child(miron, alexey).
child(arina, alexey).
child(luba, alexey).
child(miron, olga).
child(arina, olga).
child(luba, olga).
child(max, anna).
child(mira, anna).
child(max, sergey).
child(mira, sergey).

married(X,Y):-child(Z,Y), !, child(Z,X), not(X=Y).

mother(X,Y):-child(Y,X),woman(X).   %Задание 3
mother(X):-mother(Y,X),write(Y).
father(X,Y):-child(Y,X),man(X). %Задание 4
father(X):-father(Y,X),write(Y).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z).  %Задание 5
wife(X,Y):-child(Z,Y), !, child(Z,X), not(X=Y),woman(X).    %Задание 6
wife(X):- wife(Y,X), write(Y).
b_s(X,Y):-brother(X,Y),!.   %задание 7
grand_pa(X, Y) :- child(Z, X), child(Y, Z), man(X). %Задание 8
grand_pas(X) :- grand_pa(Y, X), write(Y).
grand_da(X, Y):-child(Z, Y), child(X, Z), woman(X). %Задание 9
grand_dats(X) :- grand_da(Y, X), write(Y).
grand_pa_and_son(X, Y) :- child(Z, X), child(Y, Z), man(X), man(Y). %Задание 10
%grand_ma_and_son(X,Y) :- child(Z,X). child(Y,Z), woman(X), man(Y).  %Задание 11
uncle(X, Y) :- child(Y, Z), brother(Z, X).  %Задание 12
uncle(X) :- uncle(Y, X), write(Y).
nephew(X,Y):-man(X),child(X,Z), is_br_si(Z,Y).  %Задание 13

son(X,Y):- child(X,Y), man(X).
douter(X,Y):-child(X,Y), woman(X).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z).
sister(X,Y):-woman(X),not(X=Y),child(X,Z),!,child(Y,Z).
is_br_si(X,Y):-sister(X,Y).
uncle(X,Y):-man(X),child(Y,M),is_br_si(Z,M),married(X,Z).
aunt(X,Y):-woman(X),child(Y,M),is_br_si(Z,M),married(X,Z).
