

percursoMaxIter(_,_,_,Max,Max,_) :- !,fail.

percursoMaxIter(X,Y,_,_,_,[X,Y]) :- adjacencia(Y,X,_).
percursoMaxIter(X,Y,2,_,_,[X,Y]) :- adjacencia(X,Y,_).

percursoMaxIter(X,Y,N,Iter,Max,[X|P]) :- adjacencia(Z,X,_), IterInc is Iter+1, percursoMaxIter(Z,Y,N,IterInc,Max,P).
percursoMaxIter(X,Y,2,Iter,Max,[X|P]) :- adjacencia(X,Z,_), IterInc is Iter+1, percursoMaxIter(Z,Y,2,IterInc,Max,P).


maisCurto(Inicial,Final,NSentidos,Inf,_,_,Percurso) :-
    percursoMaxIter(Inicial,Final,NSentidos,1,Inf,P),
    metade(Inf,Metade),
    maisCurto(Inicial,Final,NSentidos,Metade,Inf,P,Percurso).

maisCurto(_,_,_,Inf,Sup,Percurso,Percurso) :-
    SupDec is Sup-1, Inf =:= SupDec, !.

maisCurto(Inicial,Final,NSentidos,Inf,Sup,PercursoTemp,Percurso) :-
    Dist is Sup-Inf,
    metade(Dist,Metade), InfMaisMetade is Inf+Metade,
    maisCurto(Inicial,Final,NSentidos,InfMaisMetade,Sup,PercursoTemp,Percurso).



mudancasSentido([_],_,[]).

mudancasSentido([H1,H2|T],frente,R) :- adjacencia(H1,H2,_), mudancasSentido([H2|T],frente,R).
mudancasSentido([H1,H2|T],frente,[H1|R]) :- mudancasSentido([H2|T],tras,R).

mudancasSentido([H1,H2|T],tras,R) :- adjacencia(H2,H1,_), mudancasSentido([H2|T],tras,R).
mudancasSentido([H1,H2|T],tras,[H1|R]) :- mudancasSentido([H2|T],frente,R).

mudancasSentido([H1,H2|T],R) :- adjacencia(H1,H2,_), mudancasSentido([H2|T],frente,R).
mudancasSentido([_,H2|T],R) :- mudancasSentido([H2|T],tras,R).


sentidoTras([Origem,H|_],[Destino|T2],([Destino|T2],Destino,Origem)) :- adjacencia(Origem,H,_).
sentidoTras([Origem|T1],[Destino|_],([Origem|T1],Origem,Destino)).

% Converge mais rapido a fazer percursos para tras
% Converge mais rapido com um percurso inicial maior
escolhePercursoInicial1(O,D,N1,N2,_,P,(N2,PInv,O,D)) :- N1 < N2, !, reverse(P,PInv).
escolhePercursoInicial1(O,D,N1,N2,P,_,(N1,PInv,D,O)) :- N1 > N2, !, reverse(P,PInv).
escolhePercursoInicial1(_,_,N,_,P1,P2,(N,P,Inicial,Final)) :- sentidoTras(P1,P2,(P,Inicial,Final)).

ordenaPercurso(Origem,[Origem|Percurso],[Origem|Percurso]).
ordenaPercurso(_,PercursoInv,Percurso) :- reverse(PercursoInv,Percurso).


uniOuBidirecional(Inicial,Final,Inf,Sup,Temp,[],Percurso) :-
    maisCurto(Inicial,Final,1,Inf,Sup,Temp,Percurso).
uniOuBidirecional(Inicial,Final,Inf,Sup,Temp,_,Percurso) :-
    maisCurto(Inicial,Final,2,Inf,Sup,Temp,Percurso).