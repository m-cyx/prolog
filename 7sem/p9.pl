/*Функция ввода*/
minimum_spanning_tree:-
    write("Amount of edges: "),read(EdgeNumber),nl,
    write("Edges, write edge like: edge(vertex1, vertex2, weight)."), read_list(Graph,EdgeNumber),
    insertion_sort(Graph,SortGraph),minimum_spanning_tree(SortGraph,[MST]),
    write("Minimal spanning tree:"),nl,write_list(MST).

read_list(A,N):-r_1([],A,0,N).
r_1(A,A,N,N):-!.
r_1(B,A,I,N):-I1 is I+1,read(X),append(B,[X],B1),r_1(B1,A,I1,N).

write_list([]):-!.
write_list([H|T]):-write(H),nl,write_list(T).

/*Cортировка ребер*/
insertion_sort(List,SortList):-insertion_sort(List,[],SortList).
insertion_sort([],SortList,SortList):-!.
insertion_sort([Head|Tail],SortSublist,SortList):-insert(Head,SortSublist,S),insertion_sort(Tail,S,SortList).

insert(P,List,Result):-insert(P,[],List,Result).
insert(P,Start,[],Result):-append(Start,[P],Result),!.
insert(P,Start,[Head|Tail],Result):-edge_more(P,Head),append(Start,[Head],NewStart),insert(P,NewStart,Tail,Result),!.
insert(P,Start,Tail,Result):-append(Start,[P|Tail],Result).

edge_more(edge(_,_,X),edge(_,_,Y)):-X > Y.
% edge(e,c,6).
% edge(c,d,2).
% edge(a,e,1).
% edge(b,e,4).
% edge(b,c,5).
% edge(a,b,3).
% edge(e,d,7).

/*Проверяет принадлежность ребра дереву*/
belong(X,[edge(X,_,_)|_]):-!.
belong(X,[edge(_,X,_)|_]):-!.
belong(X,[edge(_,_,_)|OtherEdges]):-belong(X,OtherEdges).

/*Проверяет, создаст ли новое ребро цикл*/
cycle(edge(X,Y,_),[Tree|_]):-belong(X,Tree),belong(Y,Tree),!.
cycle(edge(X,Y,_),[_|OtherTrees]):-cycle(edge(X,Y,_),OtherTrees).

/*Возвращает дерево содержащий узел X и удаляет его из остова*/
tree_return_and_delete(_,[],[],[]):-!.
tree_return_and_delete(X,[Tree|OtherTrees],OtherTrees,Tree):-belong(X,Tree).
tree_return_and_delete(X,[Tree|OtherTrees],[Tree|NewTrees],ReturnTree):-tree_return_and_delete(X,OtherTrees,NewTrees,ReturnTree).

/*Ищет минимальное остовное дерево графа*/
minimum_spanning_tree(Graph,MST):-minimum_spanning_tree(Graph,[],MST).
minimum_spanning_tree([],MST,MST):-!.
minimum_spanning_tree([edge(X,Y,C)|OtherEdges],TempMST,MST):-cycle(edge(X,Y,C),TempMST),minimum_spanning_tree(OtherEdges,TempMST,MST),!.
minimum_spanning_tree([edge(X,Y,C)|OtherEdges],TempMST,MST):-
    tree_return_and_delete(X,TempMST,TempMST1,XTree),
    tree_return_and_delete(Y,TempMST1,TempMST2,YTree),
    append(XTree,YTree,UnionTree),append(TempMST2,[[edge(X,Y,C)|UnionTree]],NewTempMST),minimum_spanning_tree(OtherEdges,NewTempMST,MST).

read_str(A) :- get0(X), r_str(X, A, []).
r_str(10,A,A):-!.
r_str(X,A,B):-append(B,[X],B1),get0(X1),r_str(X1,A,B1).

in_list1([El|_],El):-!.
in_list1([_|T],El):-in_list1(T,El).

in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]):-in_list_exclude(T,El,Tail).

append1([],X,X):-!.
append1([H|T],X,[H |Z]):-append1(T,X,Z).

delete_first([H|T], T).
get_graph_edges(V, E) :- get_V(V), write(V), nl, write("Number of edges"), nl, get_edges(V, E), write(E), nl, nl.

get_V(V) :- write("Number of vertexes"), nl, read(N), write("Vertexes"), nl, N1 is N+1, get_V(V1, N1), delete_first(V1, V).
get_V([], 0) :- !.
get_V([H|T], N) :- read_str(X), name(H, X), N1 is N-1, get_V(T, N1).

get_edges(V, E) :- read(M), get0(X), get_edges(V, E, [], M, 0).
get_edges(V, E, E, M, M) :- !.
get_edges(V, E, Edges, M, Count) :- get_edge(V, Edge), append(Edges, [Edge], E1), Count1 is Count+1, get_edges(V, E, E1, M, Count1).

get_edge(V, [V1, V2]) :- write("Edge"), nl, read_str(X), name(V1, X), check_vertex(V, V1), read_str(Y), name(V2, Y), check_vertex(V, V2).

check_vertex([V1|_], V1) :- !.
check_vertex([_|T], V1) :- check_vertex(T, V1).

path_check([H|T], E) :- append1([H|T], [H], Path), p_c(Path, E).
p_c([_], _) :- !.
p_c([V1, V2|T], E) :- in_list1(E, [V1, V2]), p_c([V2|T], E).
p_c([V1, V2|T], E) :- in_list1(E, [V2, V1]), p_c([V2|T], E).

b_a_r([], Perm1, Perm1) :- !.
b_a_r(A, Perm, Perm1) :- in_list_exclude(A, El, A1), b_a_r(A1, [El|Perm], Perm1).

hamiltonian_cycle :- get_graph_edges(V, E), hamiltonian_cycle(V, E).
hamiltonian_cycle(V, E) :- b_a_r(V, W, Path), path_check(Path, E), write(Path).

node(a).
node(b).
node(s).
node(d).
node(f).
node(g).
node(c).
node(e).
node(r).
node(h).

edge(a, s).
edge(a, b).
edge(a, f).
edge(f, d).
edge(f, g).
edge(f, e).
edge(e, c).
edge(e, r).

linked(A, B):-
    edge(A, B); edge(B, A).

nodes_subset(Subset, Other):-
    findall(Node, node(Node), AllNodes),
    sub(AllNodes, Subset),
    subtract(AllNodes, Subset, Other).

is_not_independent(Set):-
    member(X, Set),
    member(Y, Set),
    linked(X, Y).
is_not_maximal(Set, Other):-
    member(X, Other),
    \+ is_not_independent([X|Set]).

independent_maximal(Subset):-
    nodes_subset(Subset, Other),
    \+ is_not_independent(Subset),
    \+ is_not_maximal(Subset, Other).

:- dynamic db_sub/1.

exist_such_sub(Subset):-
    db_sub(X), is_equal(X, Subset), !.
unique_sub(List, Subset):-
    sub(List, Subset),
    \+ exist_such_sub(Subset),
    assert(db_sub(Subset)).

is_equal(A, B):-
    length(A, Len), length(B, Len), 
    subtract(A, B, []), !.

sub(List, Subset):-
    sub(List, [], Subset).

sub(_List, Subset, Subset).
sub(List, Buf, Subset):-
    select(Element, List, Tail),
    \+ has_edge_with(Element, Buf),
    sub(Tail, [Element|Buf], Subset).
has_edge_with(Node, List):-
    member(X, List),
    linked(Node, X), !.

unique_independent_maximal(Subset):-
    independent_maximal(Subset),
    \+ exist_such_sub(Subset),
    assert(db_sub(Subset)).

/*Поиск наибольшего паросочетания*/
findMaxMatching(V, E, List):- maxMatching(E, Matching), isMaxMatching(V, E, Matching, List).

isMaxMatching(V, E, Matching, List):- findExpendingWay(Matching, E, V, ExpWay), symmetricSubtraction(Matching, ExpWay, NewMatching), isMaxMatching(V, E, NewMatching, List),!.
isMaxMatching(_, _, Matching, Matching).

/*Симметрическая разность расширяющего пути и паросочетания*/
symmetricSubtraction(Matching, ExpWay, ResultMatching):- symmetricSubtraction(Matching, ExpWay, [], ResultMatching).
symmetricSubtraction(Matching, [], CurSub, ResultMatching):- append(Matching, CurSub, ResultMatching), !.
symmetricSubtraction(Matching, [H|T], CurSub, ResultMatching):- not(in_list1(Matching, H)), append(CurSub, [H], NewSub), symmetricSubtraction(Matching, T, NewSub, ResultMatching),!.
symmetricSubtraction(Matching, [H|T], CurSub, ResultMatching):- in_list_exlude(Matching, H, NewMatching), symmetricSubtraction(NewMatching, T, CurSub, ResultMatching).

get_V(V):- write("Amount of vertexes"),read(N),write("Vertexes"),nl,N1 is N+1,get_V(V1,N1),del_1st(V1,V).
get_V([],0):-!.
get_V([H|T],N):-read_str(X),name(H,X),N1 is N-1,get_V(T,N1).

get_edges(V,E):-write("Amount of edges"),read(M),get0(X),get_edges(V,E,[],M,0).
get_edges(V,E,E,M,M):-!.
get_edges(V,E,Edges,M,Count):-get_edge(V,Edge),append(Edges,[Edge],E1), Count1 is Count+1,get_edges(V,E,E1,M,Count1).

del_1st([_|T],T).

read_str(A):-get0(X),r_str(X,A,[]).

r_str(10,A,A):-!.
r_str(X,A,B):-append(B,[X],B1),get0(X1),r_str(X1,A,B1).

get_edge(V,[V1,V2]):-write("Edge"),nl,read_str(X),name(V1,X),check_vertex(V,V1),read_str(Y),name(V2,Y),check_vertex(V,V2).
check_vertex([V1|_],V1):-!.
check_vertex([_|T],V1):-check_vertex(T,V1).

/*Поиск максимального паросочетания*/
maxMatching([],[]):-!.
maxMatching([H|T], ResultMatching):- maxMatching(T, [H], ResultMatching).
maxMatching([], CurMathing, CurMathing):-!.
maxMatching([H|T], CurMatching, ResultMatching):- not(hasAdjacent(H, CurMatching)), append(CurMatching, [H], NewMatching), maxMatching(T, NewMatching, ResultMatching), !.
maxMatching([_|T], CurMatching, ResultMatching):- maxMatching(T, CurMatching, ResultMatching).

hasAdjacent([_,_], []):- !, fail.
hasAdjacent([X,_], [[X,_]|_]):- !.
hasAdjacent([X,_], [[_,X]|_]):- !.
hasAdjacent([_,X], [[X,_]|_]):- !.
hasAdjacent([_,X], [[_,X]|_]):- !.
hasAdjacent(Edge, [_|T]):- hasAdjacent(Edge, T).

/*Нахождение расширяющего пути*/
findExpendingWay(Matching, E, V, ExpWay):- in_list(V, Vertex1), not(isInMatching(Matching, Vertex1)), in_list(V, Vertex2), not(isInMatching(Matching, Vertex2)), Vertex1 \= Vertex2, makeAlternateWay(V, E, Matching, Vertex1, Vertex2, ExpWay).
/**/
isInMatching([],_):- !, fail.
isInMatching([[X,_]|_], X):-!.
isInMatching([[_,X]|_], X):-!.
isInMatching([_|T], X):- isInMatching(T, X).

/*Построение чередующегося пути из вершины I в вершину S*/
makeAlternateWay(V, E, Matching, I,S,Way):- incident(I, NewI, Edge, E), in_list_exlude(V,I,Tail), in_list_exlude(Tail, NewI, Tail1), makeAlternateWay(Tail1,E, Matching, NewI,S,[Edge],Way, m).
makeAlternateWay(_,_,_,S,S,Way,Way,_):-!.
makeAlternateWay(V,E, Matching, I,S,Cur_Way,Way, m):-in_list_exlude(V,X,Tail),(in_list1(E,[I,X]);in_list1(E,[X,I])), (in_list(Matching, [I,X]); in_list(Matching, [X,I])), append1(Cur_Way,[[I,X]],C_W), makeAlternateWay(Tail,E, Matching, X,S,C_W,Way, nm).
makeAlternateWay(V,E, Matching, I,S,Cur_Way,Way, nm):-in_list_exlude(V,X,Tail),(in_list1(E,[I,X]);in_list1(E,[X,I])), not(in_list(Matching, [I,X])), not(in_list(Matching, [X,I])), append1(Cur_Way,[[I,X]],C_W), makeAlternateWay(Tail,E,Matching,X,S,C_W,Way,m).

/*in_list для рёбер*/
in_list1([[X,Y]|_],[X,Y]):-!.
in_list1([[Y,X]|_],[X,Y]):-!.
in_list1([_|T],El):-in_list1(T,El).

append1([],X,X):-!.
append1([H|T],X,[H |Z]):-append1(T,X,Z).

p9_5 :- write("Enter the matrix:"), nl,
    read(L), write([[1,2],[2,3],[1],[2]]).

/*Поиск ребра, инцидентного вершине Vertex*/
incident(Vertex, Vertex2, [Vertex, Vertex2],[[Vertex, Vertex2]|_]).
incident(Vertex, Vertex2, [Vertex2, Vertex], [[Vertex2, Vertex]|_]).
incident(Vertex, Vert, Edge, [_|T]):- incident(Vertex, Vert, Edge, T).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list_exlude([El|T],El,T).
in_list_exlude([H|T],El,[H|Tail]):-in_list_exlude(T,El,Tail).

contains([], _):- !, fail.
contains([H|_], H):- !.
contains([_|T], N):- contains(T, N).
