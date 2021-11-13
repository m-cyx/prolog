% 1
read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).
write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).
pr1 :- read_str(A,N), write_str(A), write(', '), write_str(A), write(', '), write_str(A), write(', '), write(N).
% 2
pr2:-read_str(A,_),count_word(A,0,K,0),write(K).
count_word([],K1,K,1):-K is K1+1,!.
count_word([],K1,K,0):-K is K1,!.
count_word([32|T],K1,K,0):-count_word(T,K1,K,0),!.
count_word([32|T],K1,K,1):-K2 is K1+1,count_word(T,K2,K,0),!.
count_word([_|T],K1,K,_):-count_word(T,K1,K,1).
% 3
pr3:-read_str(A,_),common_word(A,B,[],[],0,Max,A),write_str(B),nl,write(Max).
repeat_word([],[],_,K1,K,1):-K is K1+1,!.
repeat_word([],_,_,K,K,_):-!.
repeat_word([H|T],[],Sub,I,K,1):-H>=32,H=<64,I1 is I+1,repeat_word(T,Sub,Sub,I1,K,1),!.
repeat_word([H|T],_,Sub,I,K,_):-H>=32,H=<64,repeat_word(T,Sub,Sub,I,K,1),!.
repeat_word([H|T],[H1|T1],Sub,I,K,_):-H\=H1,repeat_word(T,[H1|T1],Sub,I,K,0),!.
repeat_word([H|T],[H1|T1],Sub,I,K,1):-H=H1,repeat_word(T,T1,Sub,I,K,1),!.
repeat_word([_|T],B,Sub,I,K,_):-repeat_word(T,B,Sub,I,K,0).

common_word([],B,B,_,Max,Max,_):-!.
common_word([H|T],B,ML,[],Max,LM,A):-H>=32,H=<64,common_word(T,B,ML,[],Max,LM,A),!.
common_word([H|T],B,ML,C,Max,LM,A):-H>=32,H=<64,repeat_word(A,C,C,0,K,1),(K>Max->common_word(T,B,C,[],K,LM,[H|T]);common_word(T,B,ML,[],Max,LM,[H|T])),!.
common_word([H|T],B,ML,C,Max,LM,A):-append(C,[H],C1),common_word(T,B,ML,C1,Max,LM,A).
% 4
pr4:-read_str(A,N),(N>5->N1 is N-3,write_first(A,C,[],0,N1),write_str(C);write_length(A,[],B,0,N),write_str(B)).
write_first([],B,B,_,_):-!.
write_first([H|T],C,B,K,N1):-K<3,K1 is K+1,append(B,[H],B1),write_first(T,C,B1,K1,N1),!.
write_first([H|T],C,B,K,N1):-K>=N1,K1 is K+1,append(B,[H],B1),write_first(T,C,B1,K1,N1),!.
write_first([_|T],C,B,K,N1):-K1 is K+1,write_first(T,C,B,K1,N1).
write_length([_],B,B,N,N):-!.
write_length([H|_],C,B,K,N):-K<N,K1 is K+1,append(C,[H],C1),write_length([H],C1,B,K1,N).
% 5
pr5:-read_str(A,_),find_last(A,El),numbers(A,[],B,0,El),write(B).
find_last([H],H):-!.
find_last([_|T],El):-find_last(T,El).
numbers([_],B,B,_,_):-!.
numbers([H|T],C,B,K,El):-K1 is K+1,H=El,append(C,[K1],C1),numbers(T,C1,B,K1,El),!.
numbers([_|T],C,B,K,El):-K1 is K+1,numbers(T,C,B,K1,El).
% 6
pr6:-read_str(A,_),show(A,[],B,1),write_str(B).
show([],B,B,_):-!.
show([H|T],C,B,K):-R is K mod 3,R=0,append(C,[H],C1),K1 is K+1,show(T,C1,B,K1),!.
show([_|T],C,B,K):-K1 is K+1,show(T,C,B,K1).
% 7
pr7:-read_str(A,_),count_sign(A,0,K,0),write(K).
count_sign([],K,K,_):-!.
count_sign([H|T],I,K,_):-H=43,I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([H|T],I,K,_):-H=45,I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([48|T],I,K,0):-count_sign(T,I,K,1),!.
count_sign([48|T],I,K,1):-I1 is I+1,count_sign(T,I1,K,1),!.
count_sign([_|T],I,K,_):-count_sign(T,I,K,1).
% 8
pr8:-read_str(A,_),check(A,0,0).
check([],0,0):-write("There are no x and w characters in the string."),!.
check([],0,1):-write("There is no x character in the string."),!.
check([],1,0):-write("There is no w character in the string."),!.
check([],1,1):-!.
check([H|T],0,0):-H=120,write("x have found before w."),check(T,1,0),!.
check([H|T],0,0):-H=119,write("w have found before x."),check(T,0,1),!.
check([H|T],1,0):-H=119,check(T,1,1),!.
check([H|T],0,1):-H=120,check(T,1,1),!.
check([_|T],F1,F2):-check(T,F1,F2).
% 9
pr9:-read_str(A,N1),read_str(B,N2),(N1>N2->N3 is N1-N2-1,out(A,0,N3);N3 is N2-N1-1,out(B,0,N3)).
out(_,N3,N3):-!.
out(A,K,N3):-K1 is K+1,write_str(A),nl,out(A,K1,N3).
% 10
pr10:-read_str(A,_),(first_symb(A,[97,98,99])->replace_str(A,[119,119,119],[],B);append(A,[122,122,122],B)),write_str(B).
first_symb(_,[]):-!.
first_symb([H|T],[H1|T1]):-H=H1,first_symb(T,T1),!.
first_symb(_,_):-!,fail.

replace_str([],_,B,B):-!.
replace_str([_|T],[H1|T1],C,B):-append(C,[H1],C1),replace_str(T,T1,C1,B),!.
replace_str([H|T],[],C,B):-append(C,[H],C1),replace_str(T,[],C1,B).
% 11
pr11:-read_str(A,N),(N>10->first_six(A,[],B,0);full_str(A,[],B,0)),write_str(B).
first_six(_,B,B,6):-!.
first_six([H|T],C,B,K):-K1 is K+1,append(C,[H],C1),first_six(T,C1,B,K1).

full_str([],B,B,12):-!.
full_str([],C,B,N):-N1 is N+1,append(C,[111],C1),full_str([],C1,B,N1),!.
full_str([H|T],C,B,N):-N1 is N+1,append(C,[H],C1),full_str(T,C1,B,N1).
% 12
pr12:-randset(1,120,S),write_str(S).
% 13
pr13:-read_str(A,_),replace(A,B,[],0),write_str(B).
replace([],B,B,_):-!.
replace([H|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,H=97,append(C,[99],C1),replace(T,B,C1,K1),!.
replace([H|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,H=98,append(C,[99],C1),replace(T,B,C1,K1),!.
replace([_|T],B,C,K):-K1 is K+1,R is K1 mod 2,R=0,append(C,[97],C1),replace(T,B,C1,K1),!.
replace([H|T],B,C,K):-K1 is K+1,append(C,[H],C1),replace(T,B,C1,K1).
% 14
pr14:-read_str(A,_),count(A,0,K),write(K).
count([],K,K):-!.
count([H|T],I,K):-H>=48,H=<57,I1 is I+1,count(T,I1,K),!.
count([_|T],I,K):-count(T,I,K).
% 15
pr15:-read_str(A,_),check_symb(A,0,0,0).
check_symb([],F1,F2,F3):-F1=F2,F1=F3,F1=1,!.
check_symb([H|T],_,F2,F3):-H=97,check_symb(T,1,F2,F3),!.
check_symb([H|T],F1,_,F3):-H=98,check_symb(T,F1,1,F3),!.
check_symb([H|T],F1 ,F2,_):-H=99,check_symb(T,F1,F2,1),!.
check_symb(_,_,_,_):-!,fail.
% 16
pr16:-read_str(A,_),replace(A,[],B),write_str(B).
delete_first([],B,B,_,_):-!.
delete_first([_|T],B,C,I,K):-I1 is I+1,I1=<K,delete_first(T,B,C,I1,K),!.
delete_first([H|T],B,C,I,K):-append(C,[H],C1),delete_first(T,B,C1,I,K).

append_word(A,[],A):-!.
append_word(A,[H|T],C):-append(A,[H],A1),append_word(A1,T,C),!.

replace([],B,B):-!.
replace([H|T],C,B):-first_symb([H|T],[119,111,114,100]),delete_first([H|T],D,[],0,4),append_word(C,[108,101,116,116,101,114],NL),replace(D,NL,B),!.
replace([H|T],C,B):-append(C,[H],C1),replace(T,C1,B).
% 17
pr17:-read_str(A,_),delete_x(A,[],B),write_str(B).
delete_x([],B,B):-!.
delete_x([120|T],C,B):-first_symb(T,[97,98,99]),delete_x(T,C,B),!.
delete_x([H|T],C,B):-append(C,[H],C1),delete_x(T,C1,B).
% 18
pr18:-read_str(A,_),delete_abc(A,[],B),write_str(B).
first_digit([H|_]):-H>=48,H=<57.

delete_abc([],B,B):-!.
delete_abc([H|T],C,B):-first_symb([H|T],[97,98,99]),delete_first([H|T],D,[],0,3),first_digit(D),delete_abc(D,C,B),!.
delete_abc([H|T],C,B):-append(C,[H],C1),delete_abc(T,C1,B).
% 19
pr19:-read_str(A,_),count_aba(A,0,K),write(K).
count_aba([],K,K):-!.
count_aba([H|T],I,K):-first_symb([H|T],[97,98,97]),delete_first([H|T],B,[],0,2),I1 is I+1,count_aba(B,I1,K),!.
count_aba([_|T],I,K):-count_aba(T,I,K).
% 20
pr20:-read_str(A,_),delete_space(A,[],C,1),delete_space(C,[],B,0),length_str(B,0,K),write_str(B),nl,write("Length: "),write(K).
length_str([],K,K):-!.
length_str([_|T],I,K):-I1 is I+1,length_str(T,I1,K),!.

delete_space([],B,B,_):-!.
delete_space([32],C,B,_):-delete_space([],C,B,_),!.
delete_space([32|T],C,B,0):-append(C,[32],C1),delete_space(T,C1,B,1),!.
delete_space([32|T],C,B,1):-delete_space(T,C,B,1),!.
delete_space([H|T],C,B,_):-append(C,[H],C1),delete_space(T,C1,B,0),!.
% 21
pr21:-read_str(A,_),read_str(B,_),print_word(A,B,[],[],E),delete_space(E,[],C,1),write_str(C),count_word(C,0,K,0),nl,write("Amount of words: "),write(K).
compare_sign(_,[]):-!,fail.
compare_sign(H,[H|_]):-!.
compare_sign(El,[_|T]):-compare_sign(El,T).

print_word([],_,[],E,E):-!.
print_word([],_,D,C,E):-append_word(C,D,C1),print_word([],_,[],C1,E),!.
print_word([H|T],B,D,C,E):-compare_sign(H,B),(D\=[]->append_word(C,D,C1),append(C1,[32],C2),print_word(T,B,[],C2,E);append_word(C,D,C1),print_word(T,B,[],C1,E)),!.
print_word([H|T],B,D,C,E):-append(D,[H],D1),print_word(T,B,D1,C,E).
% 22
pr22:-read_str(A,N),R is N mod 2,(R=0->Sr is N/2+1-1;Sr is (N+1)/2-1),print_symb(A,B,[],0,Sr),write_str(B).
print_symb([],B,B,_,_):-!.
print_symb([H],C,B,_,_):-append(B,[H],B1),print_symb([],C,B1,_,_),!.
print_symb([H|T],C,B,0,Sr):-append(B,[H],B1),print_symb(T,C,B1,1,Sr),!.
print_symb([H|T],C,B,Sr,Sr):-append(B,[H],B1),K1 is Sr+1,print_symb(T,C,B1,K1,Sr),!.
print_symb([_|T],C,B,K,Sr):-K1 is K+1,print_symb(T,C,B,K1,Sr).