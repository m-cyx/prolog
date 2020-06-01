

pow(A,B,X):-                % степень 
    pw(A,B,X,A,1).
pw(_,0,1,_,_):-!.
pw(_,B,R,R,B):-!.
pw(A,B,X,R,I):-
    I<B, 
    RN is R*A, 
    IN is I+1, 
    pw(A,B,X,RN,IN).
%----------------------------------------------------------------------------------------------------------------------------------------------
otDo(Ot,Do,X):-             % от до включительно (перебор)
    DoN is Do+1, 
    otD(Ot,DoN,X).
otD(Ot,Do,X):-
    OtN is Ot+1, 
    OtN<Do, 
    otD(OtN,Do,X).
otD(X,_,X).