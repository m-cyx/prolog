in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

sprava_next(A,B,[C]):-fail.
sprava_next(A,B,[A|[B|Tail]]).
sprava_next(A,B,[_|List]):-sprava_next(A,B,List).

sleva_next(A,B,[C]):-fail.
sleva_next(A,B,[B|[A|Tail]]).
sleva_next(A,B,[_|List]):-sleva_next(A,B,List).

next_to(A,B,List):-sprava_next(A,B,List).
next_to(A,B,List):-sleva_next(A,B,List).

el_no(List,Num,El):-el_no(List,Num,1,El).
el_no([H|_],Num,Num,H):-!.
el_no([_|Tail],Num,Ind,El):-Ind1 is Ind+1,el_no(Tail,Num,Ind1,El).

pred5_1 :-
    List=[_,_,_,_,_],
	in_list(List,[red,englishman,_,_,_]),
	in_list(List,[_,spanish,_,dog,_]),
	in_list(List,[green,_,coffee,_,_]),
	in_list(List,[_,ukrainian,tea,_,_]),
	sprava_next([green,_,_,_,_],[white,_,_,_,_],List),
	in_list(List,[_,_,_,slow,old_gold]),
	in_list(List,[yellow,_,_,_,kool]),
	el_no(List,3,[_,_,milk,_,_]),
	el_no(List,1,[_,norwegian,_,_,_]),
	next_to([_,_,_,_,chester],[_,_,_,fox,_],List),
	next_to([_,_,_,_,kool],[_,_,_,horse,_],List),
	in_list(List,[_,_,orange,_,lucky]),
	in_list(List,[_,japan,_,_,parlament]),
	next_to([_,norwegian,_,_,_],[blue,_,_,_,_],List),
	in_list(List,[_,WHO1,water,_,_]),
	in_list(List,[_,WHO2,_,zebra,_]),
	write(List), nl, write(WHO1), nl, write(WHO2).

pred5_2 :-
    List=[_,_,_],
	in_list(List,[_,black]),
    in_list(List,[_,white]),
    in_list(List,[_,red]),
    in_list(List,[belokurov,A]), A \= white,
    in_list(List,[ryzhov,B]), B \= red,
    in_list(List,[chernov,C]), C \= black,
	write(List).

pred5_3 :-
    List=[_,_,_],
    in_list(List,[_,white,_]),
    in_list(List,[_,green,_]),
    in_list(List,[_,blue,_]),
    in_list(List,[_,_,white]),
    in_list(List,[_,_,green]),
    in_list(List,[_,_,blue]),
	in_list(List,[anya,A,A]),
    in_list(List,[valya,B,C]), B \= white, C \= white,
    in_list(List,[natasha,_,green]),
	write(List).

pred5_4 :-
    List = [_,_,_],
	in_list(List,[_,_,has_sister,_]),
	in_list(List,[_,_,has_no_sister,_]),
	in_list(List,[_,_,_,middleage]),
	in_list(List,[_,turner,_,_]),
	in_list(List,[_,welder,_,_]),
	in_list(List,[_,locksmith,has_no_sister,joungest]),
	in_list(List,[borisov,_,has_sister,_]),
	in_list(List,[ivanov,_,_,_]),
	in_list(List,[semyonov,A,_,oldest]), A \= turner,
	write(List).
	
pred5_5 :-
    List = [_,_,_,_],
	in_list(List,[bottle,_]),
	in_list(List,[glass,_]),
	in_list(List,[jug,_]),
	in_list(List,[jar,_]),
	in_list(List,[_,lemonade]),
	in_list(List,[_,kvass]),
	in_list(List,[A,milk]), A \= bottle, 
	in_list(List,[C,water]), C \= bottle,
	in_list(List,[jar,B]), B \= lemonade, B \= water,
	next_to([_,lemonade],[jug,_], List),
	next_to([_,lemonade],[_,kvass], List),
	next_to([glass,_],[jar,_], List),
	next_to([glass,_],[_,milk], List),
	in_list(List,[jug, K]), K \= kvass,
	write(List).

pred5_6 :-
    List = [_,_,_,_],
	in_list(List, [voronov,_]),
	in_list(List, [pavlov,_]),
	in_list(List, [lyevitskiy,_]),
	in_list(List, [saharov,_]),
	in_list(List, [_,dancer]),
	in_list(List, [B,artist]), B \= pavlov,
	in_list(List, [_,singer]),
	in_list(List, [D,writer]), D \= saharov, D \= voronov,
	in_list(List, [A,singer]), A \= voronov, A \= lyevitskiy,
	(in_list(List, [voronov,artist]) -> (in_list(List, [L,writer]), L \= lyevitskiy)),
	write(List).

pred5_7 :-
    List = [_,_,_],
	in_list(List, [michael,_,_,_]),
	in_list(List, [simon,_,_,_]),
	in_list(List, [richard,_,_,_]),
	in_list(List, [_,american,_,_]),
	in_list(List, [_,israeli,_,_]),
	in_list(List, [_,australian,_,_]),
	in_list(List, [_,_,basketball,_]),
	in_list(List, [_,_,tennis,_]),
	in_list(List, [_,_,cricket,_]),
	in_list(List, [_,_,_,first]),
	in_list(List, [_,_,_,second]),
	in_list(List, [_,_,_,third]),
	in_list(List, [michael,A,basketball,C]), A \= american, C \= third,
	in_list(List, [simon,israeli,B,D]), B \= tennis, D \= third,
	in_list(List, [_,_,cricket,first]),
	write(List).

pred5_8_4 :-
    List=[_],
    (
        (
            (in_list(List,[vitya]); in_list(List,[kolya])),
            (in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])),
            (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[vitya]); in_list(List,[jura])));

        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])))),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])));
        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[vitya]); in_list(List,[jura])))));

    (
        (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),

        (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[vitya]); in_list(List,[jura])));

        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])))),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])));
        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[vitya]); in_list(List,[jura])))));


    (
        (   in_list(List,[vitya]); in_list(List,[kolya])),

        (   in_list(List,[vitya]); in_list(List,[jura])),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[vitya]); in_list(List,[jura])));

        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])))),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])));
        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[vitya]); in_list(List,[jura])))));

    (
        (   in_list(List,[vitya]); in_list(List,[kolya])),

        (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[vitya]); in_list(List,[jura])));

        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])))));

    (
        (   in_list(List,[vitya]); in_list(List,[kolya])),

        (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])),

        (
        (  (   in_list(List,[vitya]); in_list(List,[kolya])),
            (   in_list(List,[kolya]); in_list(List,[andrew]);in_list(List,[dima])));
        (  (   in_list(List,[andrew]); in_list(List,[dima]);in_list(List,[jura])),
            (   in_list(List,[vitya]); in_list(List,[jura])))))),

    write(List).