%=========================================================================
                      /*Предикаты с лекций + заметки*/ 
%=========================================================================

%---------------------------------------------------------------------
%               Лекция 3
            % произведение листа А
pr_list(A,Pr):-pr_list(A,Pr,1).
pr_list([],Pr,Pr):-!.
pr_list([Head|Tail],Pr,P):- P1 is P*Head, pr_list(Tail,Pr,P1).

no(P):-P,!,fail.
no(_).

append1([],X,X).
append1([H|T],X,[H|Z]):-append1(T,X,Z).

            % Выводит лист в столбик
w_list([]):-!.
w_list([H|T]):-write(H),nl,w_list(T).

read_word(A):-get0(X), r_w(X,A,[]).
r_w(32,A,A):-!.
r_w(X,A,B):-append(B,[X],B1), get0(X1), r_w(X1,A,B1).

% прочитать строку 
read_str(A,N):-get0(X), r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1, append(B,[X],B1), get0(X1), r_str(X1,A,B1,N,K1).

pr_lec3_1:-read_str(A,N), write("vsego "), write(N), nl, w_list(A).

/*---------------------------------------------------------------------
             Лекция 4 Встроеннные предикаты 
 var(X) - в данной переменной сейчас записано какое-нибудь значение? 
 nonvar(26) - тоже что и выше, но наоборот
 atom(X) - является ли атомом то что в скобках (атом это не константа и не делимое)
 integer(X) - целое ли число? 
 atomic (X) - проверяет, аргумент атом или константа.
 listing(предикат) - выводит то, что делает предикат (как в коде).
 clause(X) - парсит аргументы (когда каждая переменная получает значения их предикатов).

----------------------------------------------------------------------
             Лекция 5 Встроенные предикаты
functor(test(X,Y,Z), F, N) - f(название предиката), n(кол-во аргументов)
    + позволяет самим строить предикаты
name(aaa,X) - вывод: X = [97, 97, 97]. Т.е позволяет преобразовать строку в символы
*/
% Дана строка, вывести все перестановки строки 
write_str([]):-!.
write_str([H|T]):-put(H),nl,write_str(T).
build_all_razm:-read_str(A,N), b_a_p(A,N,[]).
in_list([El|_],El).
in_list([_|T],El):-in_list(A,El).

b_a_p(A,0,Perm1):-write_str(Perm1),nl,!, fail.
b_a_p(A,N,Perm):- in_list(A,El), N1 is N-1, b_a_p(A, [El,Perm]).

% или 

build_all_razm:-
    read_str(A,N),read(K),b_a_r(A,[]).
in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,T):-in_list_exlude(T,El,T).
b_a_r([],Perm1):-write_str(Perm1),nl,!,fail.
b_a_r(A,Perm):-in_list_exlude(A,El,A1),b_a_r(A1,[El|Perm]).