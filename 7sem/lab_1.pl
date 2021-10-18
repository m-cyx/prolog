% Lab_1 tree
%========================================================================
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
son(X,Y):- child(X,Y), man(X).
douter(X,Y):-child(X,Y), woman(X).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z).
sister(X,Y):-woman(X),not(X=Y),child(X,Z),!,child(Y,Z).
is_br_si(X,Y):-brother(X,Y),!.
is_br_si(X,Y):-sister(X,Y).
uncle(X,Y):-man(X),child(Y,M),is_br_si(Z,M),married(X,Z).
aunt(X,Y):-woman(X),child(Y,M),is_br_si(Z,M),married(X,Z).
father(X,Y):- child(Y,X), man(X).
men(X):- man(X).

plem(X,Y):- man(X), child(X,Z), is_br_si(Z,Y).