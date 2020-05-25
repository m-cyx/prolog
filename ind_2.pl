/* Для введенного списка построить два списка L1 и L2, 
где элементы L1 это неповторяющиеся элементы исходного списка, 
а элемент списка L2 с номером i показывает, 
сколько раз элемент списка L1 с таким номером повторяется в исходном.
 */

writeList([]):-!.
writeList([H|T]):-
    write(H),write("  "),
    writeList(T).
%----------------------------------------------------------------------------------------------------------------------------------------------
list_bez_povtorov(ListIn,ListOut):- list_bez_povtorov(ListIn, ListOut, []). % с лабы по спискам - получает лист без повторений 
list_bez_povtorov([], ListOut, ListOut):-!.                                 % list_bez_povtorov([1,1,2,2],ListOut). --> ListOut = [1, 2].
list_bez_povtorov([H|T], ListOut, Cur):-
    check(H, Cur, Cur, R), 
    list_bez_povtorov(T, ListOut, R).
check(El, [El|_], ListIn, ListIn):-!.
check(E1, [], ListIn ,R):-
    append(ListIn, [E1], R),!.
check(El,[_|T],ListIn,R):-
    check(El,T,ListIn,R).
%----------------------------------------------------------------------------------------------------------------------------------------------
count_el_in_list(El,List,Count):-count_el_in_list(El,List,Count,0). % Считает сколько раз El встречается в списке List и выводит ответ в Count
count_el_in_list(_,[],Count,Count):-!.
count_el_in_list(El,[El|T],Count,Cur):-Cur1 is Cur+1, count_el_in_list(El,T,Count,Cur1),!.
count_el_in_list(El,[_|T],Count,Cur):-count_el_in_list(El,T,Count,Cur).
%----------------------------------------------------------------------------------------------------------------------------------------------
list_kol_each_povtorov(L,L1,L2):-kol(L,L1,L2,[]). % получает список кол-ва посторов каждого элемента списка
kol(_,[],L2,L2):-!.                               % list_kol_each_povtorov([1,1,2,2],[1,2],Out). --> Out = [2, 2].
kol(L,[H|T],L2,Tmp):-
    count_el_in_list(H,L,C), 
    append(Tmp,[C],L2stack), 
    kol(L,T,L2,L2stack).
%----------------------------------------------------------------------------------------------------------------------------------------------
run(L):-
    write("ishodniy spisok:"), nl,
    writeList(L), nl,
    list_bez_povtorov(L,L1), 
    write("L1 - nepovtor elementi ishodnongo spiska:"), nl,
    writeList(L1),nl, 
    list_kol_each_povtorov(L,L1,L2), 
    write("L2 - kolvo povtorov kazdogo elementa ishodnongo spiska :"), nl,
    writeList(L2).