
solve(1,A,_,C,[A-C]) :- !.
solve(N,A,B,C,Result) :-
    M is N - 1,
    solve(M,A,C,B,Left),
    solve(M,B,A,C,Right),
    append(Left,[A-C|Right],Result).

show_solution(N,S) :-
    print(N),nl,
    show_solution(S).
show_solution([A-B|Rest]) :-
    format('~p -> ~p~n',[A,B]),
    show_solution(Rest).
show_solution([]).

main :-
    current_prolog_flag(argv,Argv),
    ( append(_,[--, M | _],Argv) ->
        atom_number(M,N) ;
        N = 7
    ),
    solve(N,'A','B','C',R),
    show_solution(N,R).

% vim: set filetype=prolog
