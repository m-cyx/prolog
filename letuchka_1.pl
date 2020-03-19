%предикат для заданного A выдаёт кол-во чисел, равных кол-ву своих простых делителей 
%вар 3, задача 2 , но тут ошибки, см. фото с правильным 
%простота
pr(2):-!.
pr(X):-pr1(2,X).
pr1(X,X):-!.
pr1(I,X):-Y is X mod I,not(Y=0),I1 is I+1,pr1(I1,X).

p3_2(A,N):-p3_2(A,2,0,N).
p3_2(A,A,N,N):-!.
%p3_2(A,I,K,N):-pr(I,PPD), I=PPD, !, K1 is K+1, I1 is I+1, 
%    p3_2(A,I1,K1,N).
p3_2(A,I,K,N):-I1 is I+1, p3_2(A,I1,K,N).
%prprd произведение простых делителей заданного числа
%prprd(I,PPD):-pr(I,2,1,PPD).
prprd(I,I,PPD,PPD):-!.
prprd(I,K,P,PPD):- Y is I mod K, Y=0, pr(K), P1 is P*K, K1 is K+1, 
    prprd(I,K1,P1,PPD), !.
prprd(I,K,P,PPD):- K1 is  K+1, prprd(I,K1,P,PPD).


% функция эйлера для заданного числа (домашка 3 пзшка или 2 )
nod(A,0,A):-!.
nod(_,0,_):-!,fail.
nod(A,B,C):- R is A mod B, nod(B,R,C).
% функция эйлера - euler 
euler(A,N):- euhu(A,2,1,N).
euhu(A,A,N,N):-!.
euhu(A,I,K,N):-nod(A,I,1), !, I1 is I+1, K1 is K+1, euhu(A,I1,K1,N).
euhu(A,I,K,N):-I1 is I+1, euhu(A,I1,K,N).

% Вар2 задача 3
% Для заданного списка выдаёт сумму элементов, меньших 10.
pr2_3(A,N):-pr2_3(A,0,N).
pr2_3([],N,N):-!.
pr2_3([H|T],K,N):-H<10, K1 is K+H, p2_3(T,K1,N),!.
p2_3([_|T],K,N):-p2_3(T,K,N).

% Вар2 задача 1
% Для заданного А выдаёт кол-во простых чисел N, которые меньше А.










