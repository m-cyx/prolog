read_str_file(A,Flag):-get0(X),r_str(X,A,[],Flag).
r_str(10,A,A,10):-!.
r_str(-1,A,A,-1):-!.
r_str(X,A,B,Flag):-append(B,[X],B1),get0(X1),r_str(X1,A,B1,Flag).

read_str_str(A):-read_str_file(B,Flag),read_str_str(A,[B],Flag).
read_str_str(A,A,-1):-!.
read_str_str(A,Temp_list,10):-read_str_file(B,Flag),append(Temp_list,[B],T_L),read_str_str(A,T_L,Flag).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

write_list_str([]):-!.
write_list_str([H|T]):-write_str(H),nl,write_list_str(T).

length_str([],K,K):-!.
length_str([_|T],I,K):-I1 is I+1,length_str(T,I1,K),!.

% 1-1
pr6:-see('p7.txt'),read_str_str_max(A,Max),write_list_str(A),write(Max),seen.
read_str_str_max(A,Max):-read_str_file(B,Flag),length_str(B,0,Current_max),read_str_str_max(A,[B],Flag,Current_max,Max).
read_str_str_max(A,A,-1,Max,Max):-!.
read_str_str_max(A,C,10,Current_max,Max):-read_str_file(B,Flag),length_str(B,0,L),(L>Current_max->New_current_max is L;New_current_max is Current_max),append(C,[B],NL),read_str_str_max(A,NL,Flag,New_current_max,Max).
% 1-2
pr7:-see('p7.txt'),read_str_str_space(A,Count),write_list_str(A),write(Count),seen.
find_elem([H|_],H):-!.
find_elem([_|T],El):-find_elem(T,El).
read_str_str_space(A,Count):-read_str_file(B,Flag),(find_elem(B,32)->K is 0;K is 1),read_str_str_space(A,[B],Flag,K,Count).
read_str_str_space(A,A,-1,Count,Count):-!.
read_str_str_space(A,C,10,K,Count):-read_str_file(B,Flag),append(C,[B],NL),(find_elem(B,32)->K1 is K; K1 is K+1),read_str_str_space(A,NL,Flag,K1,Count).
% 1-3
pr8:-return_count_str(Count_str),return_count_A(Count_A),Sr is Count_A div Count_str,return_str(Sr).

return_count_str(Count_str):-see('p7.txt'),read_str_str_count(Count_str),seen.

return_count_A(Count_A):-see('p7.txt'),read_str_str_countA(Count_A),seen.

return_str(Sr):-see('p7.txt'),read_str_str_A(A,Sr),write_list_str(A),seen.

read_str_str_count(Count_str):-read_str_file(_,Flag),read_str_str_count(Flag,1,Count_str).
read_str_str_count(-1,Count_str,Count_str):-!.
read_str_str_count(10,K,Count_str):-read_str_file(_,Flag),K1 is K+1,read_str_str_count(Flag,K1,Count_str).

count_elem([],_,K,K):-!.
count_elem([H|T],H,K,K1):-K2 is K1+1,count_elem(T,H,K,K2),!.
count_elem([_|T],EL,K,K1):-count_elem(T,EL,K,K1).

read_str_str_countA(Count_A):-read_str_file(B,Flag),count_elem(B,65,K,0),read_str_str_countA(Flag,K,Count_A).
read_str_str_countA(-1,Count_A,Count_A):-!.
read_str_str_countA(10,K,Count_A):-read_str_file(B,Flag),count_elem(B,65,K1,0),K2 is K+K1,read_str_str_count(Flag,K2,Count_A).

read_str_str_A(A,Sr):-read_str_file(B,Flag),count_elem(B,65,K,0),(K>Sr->read_str_str_A(A,[B],Flag,Sr);read_str_str_A(A,[],Flag,Sr)).
read_str_str_A(A,A,-1,_):-!.
read_str_str_A(A,C,10,Sr):-read_str_file(B,Flag),count_elem(B,65,K,0),
    (K>Sr->append(C,[B],NL),read_str_str_A(A,NL,Flag,Sr);read_str_str_A(A,C,Flag,Sr)).
% 1-4
pr9:-see('p7.txt'),read_str_str(A),read_str_str_1(A,Word,Max),
    write("The most often word: "),write_str(Word),write("\nAmount: "),write(Max),seen.

read_str_str_1([H|T],Word,Max):-common_word([H|T],H,Word,[],[],0,Max,H).

repeat_word([],[],[],_,K1,K,1):-K is K1+1,!.
repeat_word([],[],_,_,K,K,_):-!.
repeat_word([_|T],[],[],Sub,K1,K,1):-K2 is K1+1,first_elem(T,EL),repeat_word(T,EL,Sub,Sub,K2,K,1),!.
repeat_word([_|T],[],_,Sub,K1,K,_):-first_elem(T,EL),repeat_word(T,EL,Sub,Sub,K1,K,1),!.
repeat_word(Q,[H|T],[],Sub,I,K,1):-H>=32,H=<64,I1 is I+1,repeat_word(Q,T,Sub,Sub,I1,K,1),!.
repeat_word(Q,[H|T],_,Sub,I,K,_):-H>=32,H=<64,repeat_word(Q,T,Sub,Sub,I,K,1),!.
repeat_word(Q,[H|T],[H1|T1],Sub,I,K,_):-H\=H1,repeat_word(Q,T,[H1|T1],Sub,I,K,0),!.
repeat_word(Q,[H|T],[H1|T1],Sub,I,K,1):-H=H1,repeat_word(Q,T,T1,Sub,I,K,1),!.
repeat_word(Q,[_|T],B,Sub,I,K,_):-repeat_word(Q,T,B,Sub,I,K,0).

first_elem([H|_],H):-!.
first_elem([],[]).

common_word([],[],B,B,[],MAX,MAX,_):-!.
common_word([_|T],[],B,ML,[],Max,LM,_):-first_elem(T,EL),common_word(T,EL,B,ML,[],Max,LM,EL),!.
common_word(Q,[],B,ML,C,Max,LM,A):-repeat_word(Q,A,C,C,0,K,1),(K>Max->common_word(Q,[],B,C,[],K,LM,A);common_word(Q,[],B,ML,[],Max,LM,A)),!.
common_word(Q,[H|T],B,ML,[],Max,LM,A):-H>=32,H=<64,common_word(Q,T,B,ML,[],Max,LM,A),!.
common_word(Q,[H|T],B,ML,C,Max,LM,A):-H>=32,H=<64,repeat_word(Q,A,C,C,0,K,1),(K>Max->common_word(Q,T,B,C,[],K,LM,A);common_word(Q,T,B,ML,[],Max,LM,A)),!.
common_word(Q,[H|T],B,ML,C,Max,LM,A):-append(C,[H],C1),common_word(Q,T,B,ML,C1,Max,LM,A).
% 1-5
pr10:-see('p7.txt'),tell('p7_1.txt'),read_str_str(A),unique_str(A),told,seen.
unique_str([H|T]):-unique_str([H|T],[H|T],H,[],H,0,H).
unique_str(_,[],[],[],_,_,_):-!.
unique_str(Text,[_|T],[],[],A,0,Current_str):-write_str(Current_str),nl,first_elem(T,EL),unique_str(Text,T,EL,[],A,0,EL),!.
unique_str(Text,[_|T],[],[],A,1,_):-first_elem(T,EL),unique_str(Text,T,EL,[],A,0,EL),!.
unique_str(Text,B,[],C,A,_,CS):-repeat_word(Text,A,C,C,0,K,1),(K>1->unique_str(Text,B,[],[],A,1,CS);unique_str(Text,B,[],[],A,0,CS)),!.
unique_str(Text,Current_text,[H|T],[],A,_,CS):-H>=32,H=<64,unique_str(Text,Current_text,T,[],A,_,CS),!.
unique_str(Text,Current_text,[H|T],C,A,_,CS):-H>=32,H=<64,repeat_word(Text,A,C,C,0,K,1),(K>1->unique_str(Text,Current_text,[],[],A,1,CS);unique_str(Text,Current_text,T,[],A,0,CS)),!.
unique_str(Text,Current_text,[H|T],C,A,_,CS):-append(C,[H],C1),unique_str(Text,Current_text,T,C1,A,_,CS).
% 2-4
concatenate([],List,List).
concatenate([X|List1],List2,[X|List3]) :-
    concatenate(List1,List2,List3).

reverse([],[]).
reverse([X|Tail],List) :-
    reverse(Tail,Tail1),
    concatenate(Tail1,[X],List).

palindrome(List) :- reverse(List,List).

read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).

pr2_4 :- read_str(A, _), palindrome(A).
% 2-11
% 2-15
% 3
% 4-4
% 4-11
% 4-15
% 5
% 6
% 8-1
% 8-5
% 8-7
% 8-11