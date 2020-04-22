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

    % Лекция 5 комбинаторные приколы (Задачи полного перебора)
% Является ли последовательность подпоследовательностью заданной 
sub_posl([],_):-!.
sub_posl(_,[]):-fail,!.
sub_posl([H|Sub_list],[H,List]):-sub_posl(Sub_list,List),!.
sub_posl(Sub_list,[_,List]):-sub_posl(Sub_list,List).
% Этот же предикат проверяет, является ли первый аргумент комбинаторным объектом, составленныи из первого аргумента 
% Напишем предикат, который построить все подмножества 
% Применение: sub_set(A,[1,2,3]).
sub_set([],_).
sub_set(_,[]):-fail.
sub_set([H|Sub_set],[H,Set]):-sub_set(Sub_set,Set).
sub_set(Sub_set,[H,Set]):-sub_set(Sub_set,Set).


%английская задача 
sprava_next(A,B,[C]):-fail.
sprava_next(A,B,[A|[B|Tail]]).
sprava_next(A,B,[_|List]):-sprava_next(A,B,List).

sleva_next(A,B,[C]):-fail.
sleva_next(A,B,[B|[A|Tail]]).
sleva_next(A,B,[_|List]):-sleva_next(A,B,List).

next_to(A,B,List):-sprava_next(A,B,List).
next_to(A,B,List):-sleva_next(A,B,List).



/*---------------------------------------------------------------------
             Лекция 7 Графы (Удобно писать полный перебор)
        1) Матрица смежности
        2) Список смежности
        3) Список вершин и сприсок рёбер - самый удобный в прологе
 

 Предикат получания графа get_graph_adges, где get_V(V) - получить вершины 
 name - из атома в список символов и обратно
 read_str - список символов
 check_vertex - есть ли вершина в списке вершин 
 Перечисляем вершины, затем рёбра 
*/

read_str(A):-get0(X),r_str(X,A,[]).

del_1st([H|T],T).

r_str(10,A,A):-!.
r_str(X,A,B):-append(B,[X],B1),get0(X1),r_str(X1,A,B1).

get_graph_edges(V,E):-get_V(V),write(V),nl,write("Edges"),get_edges(V,E).
get_V(V):-read(N),write("Vertexes"),nl,N1 is N+1,get_V(V1,N1),del_1st(V1,V).
get_V([],0):-!.
get_V([H|T],N):-read_str(X),name(H,X),N1 is N-1,get_V(T,N1).

get_edges(V,E):-read(M),get0(X),get_edges(V,E,[],M,0).
get_edges(V,E,E,M,M):-!.
get_edges(V,E,Edges,M,Count):-get_edge(V,Edge),append(Edges,[Edge],E1),
							Count1 is Count+1,get_edges(V,E,E1,M,Count1).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

append1([],X,X):-!.
append1([H|T],X,[H |Z]):-append1(T,X,Z).							

check_vertex([V1|_],V1):-!.
check_vertex([_|T],V1):-check_vertex(T,V1).
							
get_edge(V,[V1,V2]):-write("Edge"),nl,read_str(X),name(V1,X),check_vertex(V,V1),
						read_str(Y),name(V2,Y),check_vertex(V,V2).


             %Построить гамельтонов цикл. (Строим перестановку и проверяем есть ли такое рёбра)
             %кол-во вершин, перечисление, кол-во рёбер, перечисление (прим. a enter с enter)
gamilton:-get_graph_edges(V,E),gamilton(V,E).

gamilton(V,E):-b_a_r(V,W,Way),way_check(Way,E),write(Way).

way_check([H|T],E):-append1([H|T],[H],Way),w_c(Way,E).
w_c([_],_):-!.
w_c([V1,V2|T],E):-in_list(E,[V1,V2]),w_c([V2|T],E).

in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,[H|Tail]):-in_list_exlude(T,El,Tail).

b_a_r([],Perm1,Perm1).
b_a_r(A,Perm,Perm1):-in_list_exlude(A,El,A1),b_a_r(A1,[El|Perm],Perm1).

euler:-get_graph_edges(V,E),euler(V,E).
euler(V,E):-b_a_r(E,W,Way),way_edge_check(Way),write(Way).
way_edge_check([H|T]):-append1([H|T],[H],Way),w_e_c(Way).
w_e_c([_]):-!.
w_e_c([[_,X]|[[X|Y]|Tail]]):-w_e_c([[X|Y]|Tail]).


euler_N:-get_graph_edges(V,E),euler_N(V,E).
euler_N(V,E):-b_a_r(E,W,Way),way_edge_check_N(Way),write(Way).
way_edge_check_N([H|T]):-append1([H|T],[H],Way),w_e_c_N(Way).
w_e_c_N([_]):-!.
w_e_c_N([[_,X]|[[X,Y]|Tail]]):-w_e_c_N([[X,Y]|Tail]).
w_e_c_N([[_,X]|[[Y,X]|Tail]]):-w_e_c_N([[X,Y]|Tail]).

in_list1([El|_],El):-!.
in_list1([_|T],El):-in_list1(T,El).
raskras(K):-get_graph_edges(V,E),make_ar(K,C),raskras(V,E,C,[],Itog),write(Itog).
make_ar(0,[]):-!.
make_ar(K,[K|Tail]):-K1 is K-1,make_ar(K1,Tail).
raskras([],_,C,Itog,Itog).
raskras([V|Vtail],E,C,Ras,Itog):-
	in_list(C,Color),check_color(V,E,Color,Ras),append1(Ras,[[V,Color]],Ras1),
	raskras(Vtail,E,C,Ras1,Itog).

check_color(_,_,_,[]):-!.
check_color(V,E,C1,[[_,C2]|Tail]):-C1\=C2,check_color(V,E,C1,Tail),!.
check_color(V,E,Col,[[Ver,Col]|Tail]):-
	not(in_list1(E,[V,Ver])),not(in_list1(E,[Ver,V])),
	check_color(V,E,Col,Tail).

make_way:-
	get_graph_edges(V,E),write("Otkuda"),nl,read_str(X),name(I,X),
	write("Kuda"),nl,read_str(Y),name(S,Y),make_way(V,E,I,S,Way),
	write_way(Way).

make_way(V,E,I,S,Way):-in_list_exlude(V,I,Tail),make_way(Tail,E,I,S,[I],Way).
make_way(_,_,S,S,Way,Way). %показать ! здесь
make_way(V,E,I,S,Cur_Way,Way):-	in_list_exlude(V,X,Tail),in_list1(E,[I,X]),
								append1(Cur_Way,[X],C_W),make_way(Tail,E,X,S,C_W,Way).

write_way([V]):-write(" "),write(V),write("."),!.
write_way([V|Tail]):-write(" "),write(V),write(" -"),write_way(Tail).

list_len([],0):-!.
list_len([X|T],L):-list_len(T,L1),L is L1+1.

short_way:-get_graph_edges(V,E),write("Otkuda"),nl,read_str(X),name(I,X),
	write("Kuda"),nl,read_str(Y),name(S,Y),list_len(V,Len),
	not(short_way(V,E,I,S,Way,Len)),write_way(Way).

short_way(V,E,I,S,Way,Len):-
	make_way(V,E,I,S,Cur_Way),list_len(Cur_Way,L),L<Len,Way = Cur_Way,fail.
