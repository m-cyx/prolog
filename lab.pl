%=========================================================================
                            % Пзшки и домашки 
%=========================================================================

% Lab_1 tree
%========================================================================
man(alexandr).
man(alexey).
man(sergey).
man(max).
man(miron).

woman(tomara).
woman(anna).
woman(olga).
woman(mira).
woman(arina).
woman(luba).

child(anna, alexandr).
child(olga, alexandr).
child(anna, tomara).
child(olga, tomara).
child(miron, alexey).
child(arina, alexey).
child(luba, alexey).
child(miron, olga).
child(arina, olga).
child(luba, olga).
child(max, anna).
child(mira, anna).
child(max, sergey).
child(mira, sergey).

married(X,Y):-child(Z,Y), !, child(Z,X), not(X=Y).
son(X,Y):- child(X,Y), man(X).
douter(X,Y):-child(X,Y), woman(X).
brother(X,Y):-man(X),not(X=Y),child(X,Z),!,child(Y,Z).
sister(X,Y):-woman(X),not(X=Y),child(X,Z),!,child(Y,Z).
is_br_si(X,Y):-brother(X,Y),!.
is_br_si(X,Y):-sister(X,Y).
uncle(X,Y):-man(X),child(Y,M),is_br_si(Z,M),married(X,Z).
aunt(X,Y):-woman(X),child(Y,M),is_br_si(Z,M),married(X,Z).

% Lab_2 Алгоритмы работы с числами 
%========================================================================

        % 2.1 Максимум из двух чисел.
max(X,Y,X):-X>Y,!.
max(_,Y,Y).
        % 2.2 Максимум из трёх чисел.
max3(X,Y,U,Z):-max(Y,U,K),max(X,K,Z).

        % 2.3 Факториал числа 
        fact(0,1):-!.
fact(N,X):-N1 is N-1,fact(N1,X1),X is X1*N.
fact1(N,X):-fact2(0,1,N,X).
fact2(N,K,N,K):-!.
fact2(I,K,N,X):-I1 is I+1,K1 is K*I1,fact2(I1,K1,N,X).

        % 2.4 Число Фибоначи заданного номера.
fibo(1,1):-!.
fibo(2,1):-!.
fibo(N,X):-N1 is N-1,fibo(N1,X1),N2 is N-2,fibo(N2,X2),X is X1+X2.
    
fibo1(N,X):-fibo2(1,1,2,N,X).
fibo2(_,K,N,N,K):-!.
fibo2(J,K,I,N,X):-I1 is I+1, K1 is J+K, fibo2(K,K1,I1,N,X).

        % 2.5 Является число простым?
pr(2):-!.
pr(X):-pr1(2,X).
pr1(X,X):-!.
pr1(I,X):-Y is X mod I, not(Y=0), I1 is I+1, pr1(I1,X).
    
        % 2.7 Сумма цифр числа
sumcifr(X,X):- X<10, !.
sumcifr(X,S):-L is X mod 10, B is X div 10, sumcifr(B,S1), S is S1+L.

        % 2.8 Найти наибольший простой делитель числа N.
npr_d(N,X):-npd(N,N,X).
npd(I,N,X):-Y is N mod I,Y=0,pr(I).
npd(I,N,X):-I1 is I-1,ndp(I1,N,X).

        % 2.9 НОД Двух чисел
nod(X,Y,Y):-R is X mod Y,(R = 0),!.
nod(X,Y,D):-R is X mod Y,nod(Y,R,D).
% Lab_3 Списки
%========================================================================

            % вводим и выводим список, функции ниже
            pr_1:-read(N), write(N),r_list(A,N),w_list(A).

        % read list
r_list(A,N):-r_list(A,N,0,[]).
r_list(A,N,N,A):-!.
r_list(A,N,I,B):-I1 is I+1, read(X), append(B,[X],B1),r_list(A,N,I1,B1).

        % write list
w_list([]):-!.
w_list([H|T]):-write(H),nl,w_list(T).

        % 3.1 Найти сумму элементов списка 
pr3_1:-
        read(N), 
        r_list(A,N), 
        sum_list(A,Z), 
        write(Z).
sum_list(A,Z):-sum_list(A,Z,0).
sum_list([],Z,Z):-!.
sum_list([H|T],Z,S):- S1 is S+H, sum_list(T,Z,S1).

         % 3.2 предикат, получающий элемент списка с заданным номером
pr3_2:-
        read(N), 
        r_list(A,N), 
        read(I), 
        el_no(A,I,Z), 
        write(Z).
el_no(A,I,Z):-el_no(A,I,1,Z).
el_no([H|_],I,I,H):-!.
el_no([_|T],I,K,Z):- K1 is K+1, el_no(T,I,K1,Z).

        % 3.3 Найти минимальный элемент в списке 
pr3_3:-
        read(N), 
        r_list(A,N), 
        min(A,M), 
        write(M).
min([H|T],M):-min(T,M,H).
min([],M,M):-!.
min([H|T],M,Mi):-H<Mi, !, min(T,M,H).
min([_|T],M,Mi):-min(T,M,Mi).

 
                

        % 3.4 Предикат, который возвращает true, если элемент есть в списке
pr3_4:- 
        write('size of list: '), 
        read(N), 
        r_list(A,N), 
        write('Wich el to search?'), 
        read(El), 
        search(A,El).
search([X|_],X):-!.
search([_|Y],El):- search(Y,El).

        % Предикат, который получает номер элемента в списке 
pr3_5:-
        write("Enter kol-vo el: "),
        read(N),
        write("Enter list: "), nl,
        r_list(A,N),
        write("Enter el wich u wanna know the number: "),
        read(P),
        number(A,P,Num),
        write("Number is: "),
        write(Num).
number([H|_],H,1):-!.
number([_|T],P,N):-number(T,P,N1),N is N1+1.

        % Произведение листа А
pr_list(A,Pr):-pr_list(A,Pr,1).
pr_list([],Pr,Pr):-!.
pr_list([Head|Tail],Pr,P):- P1 is P*Head, pr_list(Tail,Pr,P1).

% Lab_5 Чтение и тд.
%========================================================================
        % Word \=[]  -> слово не пустое 
        % прочитать строку 
read_str(A,N):-get0(X), r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-
        K1 is K+1, 
        append(B,[X],B1), 
        get0(X1), 
        r_str(X1,A,B1,N,K1).


write_str([]):-!.
write_str([H|T]):-put(H),nl,write_str(T).


% 5.1 Вывести строку три раза через запятую и количество символов в ней.
pr5_1:-
    read_str(A,N), 
    write_str(A), 
    write('' ), 
    write_str(A), 
    write('' ),
    write_str(A), 
    write('' ), 
    write(N).


% 5.2 Дана строка. Найти количество слов. 
%(вводим через пробел и нажимаем энтер )
pr5_2:-read_str(A,N),count_words(A,K),write(K).

count_words(A,K):-count_words(A,0,K).
count_words([],K,K):-!.
count_words(A,I,K):-skip_space(A,A1),get_word(A1,Word,A2),
                        Word \=[],I1 is I+1,count_words(A2,I1,K),!.
count_words(_,K,K).

skip_space([32|T],A1):-skip_space(T,A1),!.
skip_space(A1,A1).

get_word([],[],[]):-!.
get_word(A,Word,A2):-get_word(A,[],Word,A2).
get_word([],Word,Word,[]):-!.
get_word([32|T],Word,Word,T):-!.
get_word([H|T],W,Word,A2):-append(W,[H],W1),get_word(T,W1,Word,A2).

/*Вывести первые три символа и последниt три символа,
если длина строки больше 5. Иначе вывести первый символ столько
раз, какова длина строки.*/

%дз 4,5, 11-27. 

       % номер максимального эл в списке 
       max_numb:-
        read(N), 
        r_list(A,N), 
        max(A,M), 
        write(M).
max([H|T],M):-max(T,M,H).
max([],M,M):-!.
max([H|T],M,Ma):-H>Ma, !, max(T,M,H).
max([_|T],M,Ma):-max(T,M,Ma).
number(A,P,),
write("Number is: "),
write(Num).
number([H|_],H,1):-!.
number([_|T],P,N):-number(T,P,N1),N is N1+1.

% 5.3 определить самое частое слово
       pr5_3:-read_str(A,N), get_words(A,Wkrds,K).



unique(A, Result) :- 
	unique(A, Result, []), !.
unique([],[],_):-!.
unique([H|T], [H|T], Found) :-
	not(member(H, Found)),
	unique(T, T, [H|Found]),!.
unique([_|T], Result, Found) :-
	unique(T, Result, Found). 