/* Для введенного списка построить два списка L1 и L2, 
где элементы L1 это неповторяющиеся элементы исходного списка, 
а элемент списка L2 с номером i показывает, 
сколько раз элемент списка L1 с таким номером повторяется в исходном.
 */
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
