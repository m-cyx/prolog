% 1
r_list(A,N):-r_list(A,N,0,[]).
r_list(A,N,N,A):-!.
r_list(A,N,K,B):-read(X),append(B,[X],B1),K1 is K+1,r_list(A,N,K1,B1).

write_list([]) :- !.
write_list([H|T]) :- write(H), write(" "), write_list(T).
% 2
sum_list_down :-
    write("Enter the number of members of list: "), read(N),
    write("Enter list: "), nl, r_list(List, N),
    sum_list_down(List, Summ),
    write("Summ = "), write(Summ).
sum_list_down([], 0) :- !.
sum_list_down([Head|Tail], Summ) :- Head_1 is Head, sum_list_down(Tail, Summ_1), Summ is Summ_1 + Head_1.
% 3
sum_list_up(List, Summ) :- sum_list_up(List, Summ, 0).
sum_list_up([], Summ, Summ).
sum_list_up([Head|Tail], Summ, P) :- P1 is P + Head, sum_list_up(Tail, Summ, P1).
% 4, 5
list_el_numb :-
    write("Enter the number of members of list: "), read(N),
    write("Enter list: "), nl, r_list(List, N),
    write("Enter the elem: "), read(Elem),
    list_el_numb(Number, List, Elem),
    write("Number = "), write(Number).

list_el_numb_1 :-
    write("Enter the number of members of list: "), read(N),
    write("Enter list: "), nl, r_list(List, N),
    write("Enter the number: "), read(Number),
    list_el_numb(Number, List, Elem),
    write("Elem = "), write(Elem).

list_el_numb(Number, List, Elem) :- 
(
    integer(Number)
    ->  list_el_numb_det(Number, List, Elem)
    ;   var(Number)
    ->  List = [H|T],
    list_el_numb(T, Elem, H, 0, Number)
    ;   must_be(integer, Number)
).
list_el_numb_det(0, [Elem|_], Elem) :- !.
list_el_numb_det(1, [_,Elem|_], Elem) :- !.
list_el_numb_det(2, [_,_,Elem|_], Elem) :- !.
list_el_numb_det(3, [_,_,_,Elem|_], Elem) :- !.
list_el_numb_det(4, [_,_,_,_,Elem|_], Elem) :- !.
list_el_numb_det(5, [_,_,_,_,_,Elem|_], Elem) :- !.
list_el_numb_det(N, [_,_,_,_,_,_   |Tail], Elem) :- M is N - 6, M >= 0, list_el_numb_det(M, Tail, Elem).
list_el_numb(_, Elem, Elem, Base, Base).
list_el_numb([H|Tail], Elem, _, N, Base) :- succ(N, M), list_el_numb(Tail, Elem, H, M, Base).
% 6, 8
min_list_up :-
    write("Enter the number of members of list: "), read(N),
    write("Enter list: "), nl, r_list(List, N),
    sum_list_down(List, Min),
    write("Min = "), write(Min).
min_list_up([Head|Tail], Min) :- min_list_up([Head|Tail], Min, Head).
min_list_up([], Min, Min).
min_list_up([Head|Tail], Min, Head_Prev) :- 
    (Head_Prev < Head -> New_Min is Head_Prev; New_Min is Head),
    min_list_up(Tail, Min, New_Min).
% 7
min_list_down([], 32000) :- !.
min_list_down([Head|Tail], Min) :- 
    Head_1 is Head, 
    min_list_down(Tail, Min_1), 
    (Min_1 < Head_1 -> Min is Min_1; Min is Head_1).
% 9
member(El, [H|T]) :- member_(T, El, H).
member_(_, El, El).
member_([H|T], El, _) :- member_(T, El, H).
% 10
reverse(Xs, Ys) :- reverse(Xs, [], Ys, Ys).
reverse([], Ys, Ys, []).
reverse([X|Xs], Rs, Ys, [_|Bound]) :- reverse(Xs, [X|Rs], Ys, Bound).
% 11
p([], _) :- true.
p([E|R], List) :- memberchk(E, List), p(R, List).
% 12
copy(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).

delete_el_by_index(List, Number, T) :- copy(List, List1), list_el_numb(Number, List1, El), in_list_exclude(List, El, T).
in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]) :- in_list_exclude(T,El,Tail).
% 13
delete_els_as_el([], _, []).
delete_els_as_el([Elem|Tail], Del, Result) :-
(   \+ Elem \= Del
->  delete_els_as_el(Tail, Del, Result)
;   Result = [Elem|Rest],
    delete_els_as_el(Tail, Del, Rest)
).
% 14
all_diff(L) :- \+ (append(_,[X|R],L), memberchk(X,R)).
% 15
list_of_unique(List, Set) :-
      must_be(list, List),
      number_list(List, 1, Numbered),sort(1, @=<, Numbered, ONum),
      remove_dup_keys(ONum, NumSet),
      sort(2, @=<, NumSet, ONumSet),
      pairs_keys(ONumSet, Set).
number_list([], _, []).
number_list([H|T0], N, [H-N|T]) :-
    N1 is N+1,  number_list(T0, N1, T).
remove_dup_keys([], []).
remove_dup_keys([H|T0], [H|T]) :-
    H = V-_,
    remove_same_key(T0, V, T1), remove_dup_keys(T1, T).
remove_same_key([V1-_|T0], V, T) :-
    V1 == V,
    !,
    remove_same_key(T0, V, T).
remove_same_key(L, _, L).
% 16
element_counter(List, Elem, Counter) :- element_counter_1(List, Elem, Counter, 0).
element_counter_1([], Elem, Counter, Counter).
element_counter_1([Head|Tail], Elem, Counter, X) :-
    (Head = Elem -> Counter1 is X + 1; Counter1 is X),
    element_counter_1(Tail, Elem, Counter, Counter1).
% 17
list_length(List, Elem, Counter) :- list_length_1(List, Elem, Counter, 0).
list_length_1([], Elem, Counter, Counter).
list_length_1([Head|Tail], Elem, Counter, X) :-
    Counter1 is X + 1,
    list_length_1(Tail, Elem, Counter, Counter1).