% Индивидуалка 4.
            /* В одной школе уроки по истории, математике, биологии, географии, английскому, французскому языку 
            вели три учителя – Морозов, Васильев,Токарев. 
            Каждый из них преподавал ДВА предмета. 
            Географ и учитель французского языка – соседи по дому. 
            Учитель биологии старше учителя математики. 
            Морозов – самый молодой. 
            В понедельник первый урок по расписанию у Токарева, у биолога и у учителя французского языка. 
            В воскресенье Морозов, математик и учитель английского языка были на рыбалке. 
            Какие предметы преподает каждый учитель? */


:-dynamic mem/2.        % Указывает интерпретатору на то, что определение двуместного предиката может изменяться в процессе выполнения
:-dynamic teacher/2.

predmet(history).
predmet(matematika).
predmet(biologia).
predmet(geographia).
predmet(english).
predmet(franch).

provPredmeta(X,Y):- % Проверяет, не является ли два предмета одним и тем же.
    predmet(X), 
    predmet(Y), 
    not(X=Y). 

provUnic(X1,X2,X3,X4,X5,X6):- % Проверяет, являются ли уникальным каждый из предметов в 6 переменных.
    not(X1=X2), not(X1=X3), not(X1=X4), not(X1=X5), not(X1=X6),
    not(X2=X3), not(X2=X4), not(X2=X5), not(X2=X6), not(X3=X4), 
    not(X3=X5), not(X3=X6), not(X4=X5), not(X4=X6), not(X5=X6).

paraPredmetov(Predmet1, Predmet2):-teacher(Teach,Predmet1),teacher(Teach,Predmet2). % Проверяет, ведёт ли эту пару предметов один учитель.


gen:-                       % обучаю, добавляю факты в базу знаний 
    assert(teacher(0,0)), 
    provPredmeta(PredmetMorozova1,PredmetMorozova2), 
    provPredmeta(PredmetVasileva1,PredmetVasileva2),
    provPredmeta(PredmetTokareva1,PredmetTokareva2), 
    provUnic(PredmetMorozova1,PredmetMorozova2,PredmetTokareva1,PredmetTokareva2,PredmetVasileva1,PredmetVasileva2), 
    retractall(teacher(_,_)),
    assert(teacher(morozov,PredmetMorozova1)), assert(teacher(morozov,PredmetMorozova2)),
    assert(teacher(vasilev,PredmetVasileva1)), assert(teacher(vasilev,PredmetVasileva2)),
    assert(teacher(tokarev,PredmetTokareva1)), assert(teacher(tokarev,PredmetTokareva2)).
    
gen:-!,retractall(teacher(_,_)),fail.

run:-assert(mem(0,0)), main, fail. 
run:-retractall(mem(_,_)).

main:-
    gen, 
    teacher(P1,P2),
    not(mem(P1,P2)), 
    not(paraPredmetov(geographia,franch)),   % Географ и учитель французского языка – соседи по дому. 
    not(paraPredmetov(biologia,matematika)), % Учитель биологии старше учителя математики. 
    not(teacher(morozov,biologia)),          % Морозов – самый молодой.
    not(teacher(tokarev,biologia)),          % В понедельник первый урок по расписанию у Токарева, у биолога и у учителя французского языка.
    not(teacher(tokarev,franch)),            % Значит Токарев не француз 
    not(paraPredmetov(biologia,franch)),     % Значит биология и француский не пара предметов 
    not(teacher(morozov,matematika)),        % В воскресенье Морозов, математик и учитель английского языка были на рыбалке.  
    not(teacher(morozov,english)),           % значит Морозов не учитель Английского 
    not(paraPredmetov(english,matematika)),  % и Английский с Математикой не пара предметов 
    teacher(X,Y),
    assert(mem(X,Y)),
    write(X),
    write(" ----> "),
    write(Y), nl.