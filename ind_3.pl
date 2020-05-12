% Индивидуалка 3.
/*
В файле записаны арифметические выражения на отдельных строках
(операции a+b , a–b , a*b и a/b и их суперпозиции). 
В отдельный файл вывести результат вычисления каждого выражения.
*/

main:-
    see('.\\in.txt'),    % открывает файл и он становится текущим ВХОДНЫМ  потоком.
    tell('.\\out.txt'),  % открывает файл и он становится текущим ВЫХОДНЫМ потоком.
    in, 
    seen, 
    told.

in:-
    read(X),
    not(X=end_of_file),
    calculate(X),
    in,
    fail.
in:-!.

calculate(X):-
    Out is X, 
    write(Out),
    nl.

/* read читает очередной терм из текущего входного потока данных и сопоставляет его с X. 
Предикат read выполняется только один раз. Вводимый терм должен заканчиваться точкой '.' которая не становится частью этого терма. 
После точки должна следовать по крайней мере одна управляющая литера. Точка удаляется из текущего входного потока данных. */