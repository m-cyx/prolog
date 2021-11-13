% 1
max2(X,Y,X):-X>Y,!.
max2(_,Y,Y).
% 2
max3(X,Y,Z,X):-X>Y,X>Z,!.
max3(_,Y,Z,Y):-Y>Z,!.
max3(_,_,Z,Z).
maxD(X,Y,Z,U):-max2(Y,Z,K),max2(X,K,U).
% 3
fact(0,1):-!.
fact(N,X):-N1 is N-1,fact(N1,X1), X is X1*N.
% 4
fact1(N,X):-fact2(0,1,N,X).
fact2(N,K,N,K):-!.
fact2(I,K,N,X):-I1 is I+1,K1 is K*I1,fact2(I1,K1,N,X).
% 5
fib(1,1):-!.
fib(2,1):-!.
fib(N,X):-N1 is N-1, fib(N1,X1), N2 is N-2, fib(N2,X2), X is X1+X2.
% 6
fib1(N,X):-fib2(1,1,2,N,X).
fib2(_,K,N,N,K):-!.
fib2(J,K,I,N,X):- I1 is I+1, K1 is J+K, fib2(K,K1,I1,N,X).
% 7
sum_of_digits(N, N) :- N < 10, !.
sum_of_digits(N, X) :- N >= 10, N1 is N // 10, N2 is N mod 10, sum_of_digits(N1, X1), X is X1 + N2.
% 8
sum_of_digits_1(N, N) :- N < 10, !.
sum_of_digits_1(N, X) :- N >= 10, sum_of_digits_2(N, X, 1, 0).
sum_of_digits_2(N, X, I, X) :- N < I, !.
sum_of_digits_2(N, X, I, K) :- I1 is I * 10, I2 is N div I mod 10, K1 is K + I2, sum_of_digits_2(N, X, I1, K1).
% 9
product_of_digits(N, N) :- N < 10, !.
product_of_digits(N, X) :- N >= 10, N1 is N // 10, N2 is N mod 10, product_of_digits(N1, X1), X is X1 * N2.
% 10
product_of_digits_1(N, N) :- N < 10, !.
product_of_digits_1(N, X) :- N >= 10, product_of_digits_2(N, X, 1, 1).
product_of_digits_2(N, X, I, X) :- N < I, !.
product_of_digits_2(N, X, I, K) :- I1 is I * 10, I2 is N div I mod 10, K1 is K * I2, product_of_digits_2(N, X, I1, K1).
% 11
max_digit_not_divisible_by_3(N, N) :- N < 10, !.
max_digit_not_divisible_by_3(N, X) :- 
    N >= 10,
    N1 is N // 10,
    N2 is N mod 10,
    max_digit_not_divisible_by_3(N1, X1),
    (
        (RemainderX1 is X1 mod 3, RemainderX1 \= 0, RemainderN2 is N2 mod 3, RemainderN2 = 0, X is X1);
        (RemainderX1 is X1 mod 3, RemainderX1 = 0, RemainderN2 is N2 mod 3, RemainderN2 \= 0, X is N2);
        (RemainderX1 is X1 mod 3, RemainderX1 \= 0, RemainderN2 is N2 mod 3, RemainderN2 \= 0, X is max(X1,N2));
        (RemainderX1 is X1 mod 3, RemainderX1 = 0, RemainderN2 is N2 mod 3, RemainderN2 = 0, X is -1)
    ).

max_digit_not_divisible_by_3_1(N, N) :- N < 10, !.
max_digit_not_divisible_by_3_1(N, X) :- N >= 10, max_digit_not_divisible_by_3_2(N, X, 1, -1).
max_digit_not_divisible_by_3_2(N, X, I, X) :- N < I, !.
max_digit_not_divisible_by_3_2(N, X, I, Max) :- 
    I1 is I * 10,
    N2 is N div I mod 10,
    (
        (RemainderN2 is N2 mod 3, RemainderN2 \= 0, Max1 is max(Max, N2));
        (RemainderN2 is N2 mod 3, RemainderN2 = 0, Max1 is Max)
    ),
    max_digit_not_divisible_by_3_2(N, X, I1, Max1).
% 12
greatest_common_divisor(A, B, Divisor):-
  B > A, !, greatest_common_divisor(B, A, Divisor).
greatest_common_divisor(A, B, Divisor):-
  A > B, !, Difference is A - B,
  greatest_common_divisor(Difference, B, Divisor).
greatest_common_divisor(Divisor, Divisor, Divisor).

pr(2):-!.
pr(X):-pr1(2,X).
pr1(X,X):-!.
pr1(I,X):- Y is X mod I,not(Y=0),I1 is I+1,pr1(I1,X).

amount_of_divisors(N, A) :- amount_of_divisors_1(N, A, 1, 0).
amount_of_divisors_1(N, A, N, A) :- !.
amount_of_divisors_1(N, A, I, K) :-
    I1 is I + 1,
    I2 is N mod I1,
    (I2 = 0 -> K1 is K + 1; K1 is K),
    amount_of_divisors_1(N, A, I1, K1).
% 13
pred_13(X) :-
    least_divisor(X, LD),
    X1 is X,
    pred_13(X, LD, X1).
pred_13(X, LD, X1) :-
    X2 is X1 - 1,
    pred_13_d(X, LD, X2).
pred_13_d(X, LD, X1) :-
    X2 is X1 - 1,
    co_primes(X, X2),
    pred_13(X, LD, X2), !.
pred_13_d(X, LD, X1) :-
    X2 is X1 - 1,
    Remainder is X2 mod LD,
    Remainder = 0,
    pred_13(X, LD, X1), !.
pred_13_d(X, LD, X1) :-
    X2 is X1 - 1,
    pred_13_1(X2).
pred_13_1(X) :-
    sum_of_digits_less_5_1(X, X1),
    write(X), nl, write(X1), nl,
    Answer is X * X1,
    write(Answer).

sum_of_digits_less_5_1(N, N) :- N < 10, !.
sum_of_digits_less_5_1(N, X) :- N >= 10, sum_of_digits_less_5_2(N, X, 1, 0).
sum_of_digits_less_5_2(N, X, I, X) :- N < I, !.
sum_of_digits_less_5_2(N, X, I, K) :- 
    I1 is I * 10,
    I2 is N div I mod 10,
    (I2 < 5 -> K1 is K + I2; K1 is K),
    sum_of_digits_less_5_2(N, X, I1, K1).

co_primes(A, B):-
    greatest_common_divisor(A, B, 1).

least_divisor(X, LD) :- least_divisor_1(X, LD, 2, 2).
least_divisor_1(X, LD, I, LD) :-
    Remainder is X mod I,
    Remainder = 0, !.
least_divisor_1(X, LD, I, K) :-
    I1 is I + 1,
    K1 is I1,
    least_divisor_1(X, LD, I1, K1).