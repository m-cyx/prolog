:-dynamic human/2.
:-dynamic good/2.
:-dynamic madefromcandy/2.
:-dynamic magic/2.
:-dynamic male/2.
:-dynamic adult/2.
:-dynamic /2.


read_str(A):-
	get0(X),
	r_str(X,A,[]).
r_str(10,A,A):-!.
r_str(X,A,B):-
	append(B,[X],B1),
	get0(X1),
	r_str(X1,A,B1).
%---------------------------------ШТУКИ ДЛЯ ОБУЧЕНИЯ (только для факта ЧЕЛОВЕК)----дописать для каждго нового факта?????
human_r(X,Y):-	repeat, (human(X,Y) -> (nl,write("human"),write(" "),write(X),write(" "),write(Y),write("."),
				retract(human(X,Y))) ;X=nil,Y=nil).

good_r(X,Y):-	repeat, (good(X,Y) -> (nl,write("good"),write(" "),write(X),write(" "),write(Y),write("."),
				retract(good(X,Y))) ;X=nil,Y=nil).
% ТУТ ДЛЯ КАЖДОГО ФАКТА 
%---------------------------------
pr2:- %для добавления? 
	tell('.\\111.txt'),
	human_r(X,_),good_r(X,_),
	X=nil,
	told.
pr3:- %для чтения?
	see('.\\111.txt'),
	get0(Sym),
	read_human(Sym),
	seen.
read_human(-1):-!.
read_human(_):-	
	read_str(Lang),
	name(X,Lang),
	read(Y),
	asserta(human(X,Y)),
	get0(Sym),
	read_human(Sym).

%--------------------------------------База фактов 


human(finn,1).
human(jake,0).
human(bmo,0).
human(bubblegum,0).
human(iceking,1).
human(glob,0).
human(lemongrab,0).
human(pupirka,0).


good(finn,1).
good(jake,1).
good(bmo,1).
good(bubblegum,1).
good(iceking,1).
good(glob,0).
good(lemongrab,0).
good(pupirka,1).

madefromcandy(finn,0).
madefromcandy(bmo,0).
madefromcandy(iceking,0).
madefromcandy(glob,0).
madefromcandy(jake,0).
madefromcandy(bubblegum,1).
madefromcandy(lemongrab,1).
madefromcandy(pupirka,0).

magic(finn,0).
magic(jake,1).
magic(bmo,0).
magic(bubblegum,1).
magic(iceking,1).
magic(glob,1).
magic(lemongrab,0).
magic(pupirka,0).

male(finn,1).
male(bmo,0).
male(bubblegum,0).
male(glob,1).
male(lemongrab,1).
male(pupirka,0).
male(jake,1).
male(iceking,1).

adult(jake,1).
adult(finn,0).
adult(bmo,0).
adult(bubblegum,1).
adult(iceking,1).
adult(glob,1).
adult(lemongrab,1).
adult(pupirka,0).

can_fly(jake,1).
can_fly(finn,0).
can_fly(bmo,0).
can_fly(bubblegum,1).
can_fly(iceking,1).
can_fly(glob,1).
can_fly(lemongrab,0).
can_fly(pupirka,1).

question1(X1):-	write("		Is human?"),nl,
				write("1. Yes"),nl,
				write("0. No"),nl,
				read(X1).

question2(X2):-	write("		Good?"),nl,
				write("1. Yes"),nl,
				write("0. No"),nl,
				read(X2).

question3(X3):-	write("		Made of candy?"),nl,
				write("1. Yes"),nl,
				write("0. No"),nl,
				read(X3).

question4(X4):-	write("		Have magic?"),nl,
				write("1. yes"),nl,
				write("0. No"),nl,
				read(X4).

question5(X5):-	write("		Male?"),nl,
				write("1. Yes"),nl,
				write("0. No"),nl,
				read(X5).

question6(X6):-	write("		Adult?"),nl,
				write("1. yes"),nl,
				write("0. No"),nl,
				read(X6).

question7(X7):-	write("		Can fly?"),nl,
				write("1. Yes"),nl,
				write("0. No"),nl,
				read(X7).				



pr:-	question1(X1),question2(X2),question3(X3),question4(X4),question5(X5),question6(X6),question7(X7),
		human(X,X1),
		good(X,X2),
		madefromcandy(X,X3),
		magic(X,X4),
		male(X,X5),
		adult(X,X6),
		can_fly(X,X7),
		write("Answer is: "),write(X).