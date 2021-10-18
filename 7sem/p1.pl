man(anatoliy).
man(dimitriy).
man(vladimir).
man(zahar).
man(artem).
woman(vera).
woman(fjokla).
woman(dasha).
woman(liza).
woman(lida).
child(dimitriy, anatoliy).
child(dimitriy, vera).
child(vladimir, anatoliy).
child(vladimir, vera).
child(zahar, fjokla).
child(zahar, dimitriy).
child(dasha, fjokla).
child(dasha, dimitriy).
child(liza, lida).
child(liza, vladimir).
child(artem, lida).
child(artem, vladimir).
parent(X, Y) :- child(Y, X).
mother(X, Y):- child(Y, X), woman(X).
father(X, Y):- child(Y, X), man(X).
brother(X, Y) :- child(X, Z), !, child(Y, Z), X \= Y, man(Y), !.
sister(X, Y) :- child(X, Z), !, child(Y, Z), X \= Y , woman(Y), !.
son(X, Y) :- child(X, Y), man(X).
daughter(X, Y) :- child(X, Y), woman(X).
wife(X, Y) :- child(Z, X), child(Z, Y), woman(X).
wife(X) :- wife(Y, X), write(Y).
br_s(X, Y) :- brother(X, Y), !.
br_s(X, Y) :- sister(X, Y).
grand_pa(X, Y) :- child(Z, X), child(Y, Z), man(X).
grand_pa(X) :- grand_pa(Y, X), write(Y).
grand_ma(X, Y):-child(Z, X), child(Y, Z), woman(X).
grand_ma(X) :- grand_ma(Y, X), write(Y).
grand_pa_and_son(X, Y) :- child(Z, X), child(Y, Z), man(X), man(Y).
grand_pa_and_son(X) :- grand_pa_and_son(Y, X), write(Y).
grand_ma_and_son(X, Y) :- child(Z, X), child(Y, Z), woman(X), man(Y).
grand_ma_and_son(X) :- grand_ma_and_son(Y, X), write(Y).
uncle(X, Y) :- child(Y, Z), brother(Z, X).
uncle(X) :- uncle(Y, X), write(Y).
nephew(X, Y) :- child(X, Z), brother(Z, Y).
nephew(X) :- nephew(Y, X), write(Y).