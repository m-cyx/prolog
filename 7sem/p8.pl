in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).

read_str(A, N) :- get0(X), r_str(X, A, [], N, 0).
r_str(10, A, A, N, N) :- !.
r_str(X, A, B, N, K) :- K1 is K+1, append(B, [X], B1), get0(X1), r_str(X1, A, B1, N, K1).

write_str([]) :- !.
write_str([H|Tail]) :- put(H), write_str(Tail).

in_list_include(El, [El|T], [El|Result]) :- in_list_include(El, T, Result), !.
in_list_include(El, List, [El|List ]).
in_list_include(El, [H|T], [H|Result]) :- in_list_include(El, T, Result).

in_list_exclude([El|T], El, T).
in_list_exclude([H|T], El, [H|Tail]) :- in_list_exclude(T, El, Tail).
% 1-1
pr1_1 :- read_str(A, _), read(K), arrangements(A, K, []).
arrangements(_, 0, Perm1) :- write_str(Perm1), nl, !, fail.
arrangements(A, N, Perm) :- in_list(A, El), N1 is N-1, arrangements(A, N1, [El|Perm]).
% 1-2
pr1_2 :- read_str(A, _), permutations(A, []).
permutations([], Perm1) :- write_str(Perm1), nl, !, fail.
permutations(A, Perm) :- in_list_exclude(A, El, A1), permutations(A1, [El|Perm]).
% 1-3
pr1_3 :- read_str(A, _), read(K), p_arrangements(A, K, []). 
p_arrangements(_, 0, Perm1) :- write_str(Perm1), nl, !, fail.
p_arrangements(A, N, Perm) :- in_list(A, El), N1 is N-1, p_arrangements(A, N1, [El|Perm]).
% 1-4
sub_set([], []).
sub_set([H|Sub_set], [H|Set]) :- sub_set(Sub_set, Set).
sub_set(Sub_set, [_|Set]) :- sub_set(Sub_set, Set).
pr1_4 :- read_str(A, _), sub_set(B, A), write_str(B), nl, fail.
% 1-5
combinations([], 0, _) :- !.
combinations([H|Sub_set], K, [H|Set]) :- K1 is K-1, combinations(Sub_set, K1, Set).
combinations(Sub_set, K, [_|Set]) :- combinations(Sub_set, K, Set).
pr1_5 :- read_str(A, _), read(K), combinations(B, K, A), write_str(B), nl, fail.
% 1-6
p_combinations([], 0, _) :- !.
p_combinations([H|Sub_set], K, [H|Set]) :- K1 is K-1, p_combinations(Sub_set, K1, [H|Set]).
p_combinations(Sub_set, K, [_|Set]) :- p_combinations(Sub_set, K, Set).
pr1_6 :- read_str(A, _), read(K), p_combinations(B, K, A), write_str(B), nl, fail.
% 2
pr2 :- tell('p8.txt'), pr2_1([b, c, d, e, f], 3, 2), told.

pr2_1(List, N, M):- pr2_2(List, 0, N, [], M).
pr2_2(_, Counter, N, _, _):- Counter > N, !, fail.
pr2_2(_, N, N, CurList, M):- insert_2(CurList, a, M).
pr2_2([], _, _, _, _):- !, fail.
pr2_2(List, Counter, N, CurList, M):-
    in_list(List,El), 
    Counter1 is Counter + 1, 
    pr2_2(List, Counter1, N, [El|CurList], M).

insert_2(List, Char1, N1):- insert_2(Char1, 1, N1, List).
insert_2(_, CurN1, N1, CurList):- CurN1 > N1, write_str(CurList), write("\n"),  !, fail.
insert_2(Char1, Counter1, N1, CurList):- 
    in_list_include(Char1, CurList, CurList1),
    NewCounter1 is Counter1 + 1, 
    insert_2(Char1, NewCounter1, N1, CurList1).
% 3
pr3 :- tell('p8.txt'), pr3_1([b, c, d, e, f], 3, 2), told.

pr3_1(List, N, M):- pr3_2(List, 0, N, [], M).
pr3_2(_, Counter, N, _, _):- Counter > N, !, fail.
pr3_2(_, N, N, CurList, M):- insert_3(CurList, a, M).
pr3_2([], _, _, _, _):- !, fail.
pr3_2(List, Counter, N, CurList, M):-
    in_list_exclude(List,El,List1), 
    Counter1 is Counter + 1, 
    pr3_2(List1, Counter1, N, [El|CurList], M).

insert_3(List, Char1, N1):- insert_3(Char1, 1, N1, List).
insert_3(_, CurN1, N1, CurList):- CurN1 > N1, write_str(CurList), write("\n"),  !, fail.
insert_3(Char1, Counter1, N1, CurList):- 
    in_list_include(Char1, CurList, CurList1),
    NewCounter1 is Counter1 + 1, 
    insert_3(Char1, NewCounter1, N1, CurList1).
% 4
pr4:- tell('p8.txt'), pr4_1([a, b, c, d, e, f]), told.

pr4_1([]) :- !.
pr4_1(List):- in_list_exclude(List, El, List1), in_list_exclude([a,b,c,d,e,f], El, List2), pr4_2(List2, 3, 2, El), pr4_1(List1).

pr4_2(List, N, M, El):- pr4_3(List, 0, N, [], M, El).
pr4_3(_, Counter, N, _, _, _):- Counter > N, !, fail.
pr4_3(_, N, N, CurList, M, El):- insert_4(CurList, El, M).
pr4_3([], _, _, _, _, _):- !, fail.
pr4_3(List, Counter, N, CurList, M, El1):-
    in_list_exclude(List,El,List1), 
    Counter1 is Counter + 1, 
    pr4_3(List1, Counter1, N, [El|CurList], M, El1).

insert_4(List, Char1, N1):- insert_4(Char1, 1, N1, List).
insert_4(_, CurN1, N1, CurList):- CurN1 > N1, write_str(CurList), write("\n"),  !, fail.
insert_4(Char1, Counter1, N1, CurList):- 
    in_list_include(Char1, CurList, CurList1),
    NewCounter1 is Counter1 + 1, 
    insert_4(Char1, NewCounter1, N1, CurList1).
% 5
pr5 :- tell('p8.txt'), pr5_1([a, b, c, d, e, f]), told.

pr5_1([]) :- !.
pr5_1(List):-
    in_list_exclude(List, El, List1),
    in_list_exclude(List1, El2, List2),
    in_list_exclude([a,b,c,d,e,f], El, List3),
    in_list_exclude(List3, El2, List4),
    pr5_2(List4, 2, 2, 2, El, El2),
    pr5_1(List2).

pr5_2(List, N, M, M2, El, El2):- pr5_3(List, 0, N, [], M, M2, El, El2).
pr5_3(_, Counter, N, _, _, _, _, _):- Counter > N, !, fail.
pr5_3(_, N, N, CurList, M, M2, El, El2):- insert_5(CurList, El, El2, M, M2).
pr5_3([], _, _, _, _, _, _, _):- !,fail.
pr5_3(List, Counter, N, CurList, M, M2, El, El2):-
    in_list_exclude(List,El_,List1), 
    Counter1 is Counter + 1, 
    pr5_3(List1, Counter1, N, [El_|CurList], M, M2, El,El2).

insert_5(List, Char1, Char2, N1, N2):- insert_5(Char1, 0, N1, Char2, 0, N2, List).
insert_5(_, CurN1, N1, _, _, _, _):- CurN1 > N1, !, fail.
insert_5(_, N1, N1, _, N2, N2, CurList):- write_str(CurList), write("\n"), !, fail.
insert_5(_, N1, N1, Char2, Counter2, N2, CurList):- in_list_include(Char2, CurList, CurList1), NewCounter2 is Counter2 + 1, insert_5(_, N1, N1, Char2, NewCounter2, N2, CurList1), !.
insert_5(Char1, Counter1, N1, Char2, 0, N2, CurList):- in_list_include(Char1, CurList, CurList1), NewCounter1 is Counter1 + 1, insert_5(Char1, NewCounter1, N1, Char2, 0, N2, CurList1).

% 6
pr6 :- tell('p8.txt'), pr6_1([a, b, c, d, e, f]), told.

pr6_1([]) :- !.
pr6_1(List):-
    in_list_exclude(List, El, List1),
    in_list_exclude(List1, El2, List2),
    in_list_exclude([a,b,c,d,e,f], El, List3),
    in_list_exclude(List3, El2, List4),
    pr5_2(List4, 3, 3, 2, El, El2),
    pr6_1(List2).

% 7
combinationsRepeats(List, N, Combination) :-
    comb_rep(N, List, Combination).

comb_rep(0,_,[]).
comb_rep(N,[X|T],[X|RComb]):-N>0,N1 is N-1,comb_rep(N1,[X|T],RComb).
comb_rep(N,[_|T],RComb):-N>0,comb_rep(N,T,RComb).

permutationsRepeats([], []).

permutationsRepeats(List, Permutation) :-
    permutationsRepeats(List, Permutation, []).

permutationsRepeats(List, Permutation, Acc) :-
    list_to_set(List, Set),
    member(X, Set),
    selectOnlyFirst(X, List, NextList),
    permutationsRepeats(NextList, Permutation, [X|Acc]).

permutationsRepeats([], Permutation, Permutation).

selectOnlyFirst(Element, List, Result) :-
    select(Element, List, Result), !.

variationsRepeats(List, N, Variation) :-
    combinationsRepeats(List, N, Combination),
    permutationsRepeats(Combination, Variation).

findLetterWith(Letter, String, N) :-
    list_to_set(String, Set),
    findLetterWith(Letter, String, N, Set).

findLetterWith(_, _, _, []) :- fail.

findLetterWith(Letter, String, N, [H|_]) :-
    countLetter(H, String, N), Letter = H.

findLetterWith(Letter, String, N, [_|T]) :-
    findLetterWith(Letter, String, N, T).

countLetter(Letter, String, Count) :- count(Letter, String, Count), !.

count(_, [], 0).
count(X, [X | T], N) :- !, count(X, T, N1), N is N1 + 1.
count(X, [_ | T], N) :- count(X, T, N).

pr7 :- tell('p8.txt'), pr7_1([a,b,c,d,e,f], 9), told.
pr7_1(Alphabet, WordLen) :-
    forall(
        variationsRepeats(Alphabet, WordLen, Word),
        (
            findall(X, findLetterWith(X, Word, 2), Letters2),
            findall(Y, findLetterWith(Y, Word, 3), Letters3),
            (
                length(Letters2, 2),
                length(Letters3, 1),
                append(Letters2, Letters3, AllLetters),
                subtract(AllLetters, Word, WordOutAllLetters),
                list_to_set(WordOutAllLetters, WordOutAllLetters)
            -> (
                write_str(Word), 
                nl
               );
                true
            )
        )
    ).
% 8
pr8 :- tell('p8.txt'), pr8_1([a,b,c,d,e,f], 4), told.
pr8_1(Alphabet, WorldLen) :-
    forall(
        variationsRepeats(Alphabet, WorldLen, Word),
        (
            countLetter(97, Word, ACount),
            ( (ACount > 2 ) -> (write_str(Word), nl); true)
        )
    ).

% 9
pr9 :- tell('p8.txt'), pr8_1([a,b,c,d,e,f], 9), told.
% 10
pr10 :- tell('p8.txt'), pr10_1([a,b,c,d,e,f], 7), told.
pr10_1(Alphabet, WorldLen) :-
    forall(
        variationsRepeats(Alphabet, WorldLen, Word),
        (
            list_to_set(Word, WordSet),
            ( ( length(WordSet, 4) ) -> (write_str(Word), nl); true)
        )
    ).
