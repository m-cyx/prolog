:- dynamic f1/2,f2/2,f3/2,f4/2,f5/2.

launch :-
    see('p2_db.txt'),
    readCharacter,
    seen,
    q1(A1),
    q2(A2),
    q3(A3),
    q4(A4),
    q5(A5),
    check(A1,A2,A3,A4,A5), !.

readCharacter :-
    readln(Character),
    Character \= [],
    readln(Digits),
    assert1(Character, Digits),
    readCharacter.
readCharacter :- !.

assert1(_, []) :- !.
assert1(Character, [H|T]) :- asserta(f1(Character, H)), assert2(Character, T).

assert2(_, []) :- !.
assert2(Character, [H|T]) :- asserta(f2(Character, H)), assert3(Character, T).

assert3(_, []) :- !.
assert3(Character, [H|T]) :- asserta(f3(Character, H)), assert4(Character, T).

assert4(_, []) :- !.
assert4(Character, [H|T]) :- asserta(f4(Character, H)), assert5(Character, T).

assert5(_, []) :- !.
assert5(Character, [H|T]) :- asserta(f5(Character, H)).

q1(Answer):-
    write('What team character belongs?'), nl,
    write('0. Team Sonic'), nl,
    write('1. Team Dark'), nl,
    write('2. Team Rose'), nl,
    write('3. Team Chaotix'), nl,
    write('4. None of them'), nl,
    read(Answer).

q2(Answer):-
    write('What characteristics/role they is?'), nl,
    write('0. Positive/protagonist'), nl,
    write('1. Negative/antagonist'), nl,
    write('2. Neutral'), nl,
    read(Answer).

q3(Answer):-
    write(''), nl,
    write('What type of character is?'), nl,
    write('0. Speed'), nl,
    write('1. Flight'), nl,
    write('2. Power'), nl,
    write('3. None of them'), nl,
    read(Answer).

q4(Answer):-
    write(''), nl,
    write('Was they kidnapped?'), nl,
    write('0. No'), nl,
    write('1. Yes'), nl,
    read(Answer).

q5(Answer) :-
    write(''), nl,
    write('First appeared in the series in this game?'), nl,
    write('0. No'), nl,
    write('1. Yes'), nl,
    read(Answer).

check(A1,A2,A3,A4,A5) :-
    f1(C,A1),
    f2(C,A2),
    f3(C,A3),
    f4(C,A4),
    f5(C,A5),
    write('You asked '), write_str(C),
    deleteFacts, !.
check(A1,A2,A3,A4,A5) :-
    write('There is no character in database. Do you want to add them?\n0. Yes\n1. No\n'),
    read(Answer),
    checkUsersAnswer(Answer, [A1,A2,A3,A4,A5]),
    deleteFacts.

checkUsersAnswer(0, List) :-
    write('Enter the name of the character: '),
    read_str(CharName),
    name(Character, CharName),
    addCharacter(Character, List), !.
checkUsersAnswer(1,_) :- !.

deleteFacts :- 
    repeat, (f1(X, Y) -> retract(f1(X, Y)), fail; X = nil, Y = nil, !),
    repeat, (f2(X, Y) -> retract(f2(X, Y)), fail; X = nil, Y = nil, !),
    repeat, (f3(X, Y) -> retract(f3(X, Y)), fail; X = nil, Y = nil, !),
    repeat, (f4(X, Y) -> retract(f4(X, Y)), fail; X = nil, Y = nil, !),
    repeat, (f5(X, Y) -> retract(f5(X, Y)), fail; X = nil, Y = nil, !).

addCharacter(CharName, List) :-
    append('p2_db.txt'),
    nl, write(CharName), nl,
    write_list(List), told.

write_list([]) :- !.
write_list([H|T]) :- write(H), write(" "), write_list(T).

write_str([]) :- !.
write_str([H|T]) :- write(H), write_str(T).

read_str(A) :- get0(X), get0(X1), r_str(X1, A, []).
r_str(10, A, A) :- !.
r_str(X, A, B) :- append(B, [X], B1), get0(X1), r_str(X1, A, B1).