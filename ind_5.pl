/* 
Составить предикат средствами SWI-Prolog, который составляет и выводит
в файл все слова алфавита {a,b,c,d,e,f} длины n, 
в которых ровно четыре буквы повторяются по 2 раза, 
остальные буквы встречаются ровно 1 раз 
или не встречаются вообще. 
*/

char(a).
char(b).
char(c).
char(d).
char(e).
char(f).
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
list_kol_unic(In,Out):-                           % то же что и выше, только минуя второй аргумент 
    list_bez_povtorov(In,L1), 
    list_kol_each_povtorov(In,L1,Out).
%----------------------------------------------------------------------------------------------------------------------------------------------
prov(In,K1,K2):-                                  %генерация : проверка, что буква встречается два раза
list_kol_unic(In,Out),
count_el_in_list(1,Out,CountedFirst),                   % Считает сколько раз первый элемент встречается в списке List и выводит ответ в Count
K1=CountedFirst,
count_el_in_list(2,Out,CountedSecond),
K2=CountedSecond.
%----------------------------------------------------------------------------------------------------------------------------------------------
run(8):-tell('.\\out.txt'), %открываю входной поток
char(X1),   char(X2),   char(X3),   char(X4),   char(X5),   char(X6),   char(X7),   char(X8),
prov([X1,X2,X3,X4,X5,X6,X7,X8],0,4), %ровно K2(4 буквы по 2 раза) и K1(0 раз) остальные
write(X1),  write(X2),  write(X3),  write(X4),  write(X5),  write(X6),  write(X7),  write(X8),
nl,
fail.
run(8):-!,told.
