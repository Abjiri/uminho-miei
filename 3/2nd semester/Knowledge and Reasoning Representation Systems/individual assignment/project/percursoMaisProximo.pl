
comparaDistancias(Dist,Max) :- Dist < Max, !.
comparaDistancias(_,_) :- !,fail.

percursoMaxDist(_,_,Dist,Max,_,_) :- Dist > Max, !, fail.

percursoMaxDist(X,Y,Dist,Max,DistFinal,[X,Y]) :- adjacencia(Y,X,D), DistFinal is Dist+D, comparaDistancias(DistFinal,Max).
percursoMaxDist(X,Y,Dist,Max,DistFinal,[X,Y]) :- adjacencia(X,Y,D), DistFinal is Dist+D, comparaDistancias(DistFinal,Max).

percursoMaxDist(X,Y,Dist,Max,DistFinal,[X|P]) :- adjacencia(Z,X,D), DistNew is Dist+D, percursoMaxDist(Z,Y,DistNew,Max,DistFinal,P).
percursoMaxDist(X,Y,Dist,Max,DistFinal,[X|P]) :- adjacencia(X,Z,D), DistNew is Dist+D, percursoMaxDist(Z,Y,DistNew,Max,DistFinal,P).


% Converge mais rapido a fazer percursos para tras
escolhePercursoInicial2(O,D,N1,N2,P1,_,(N1,P1,O,D)) :- N1 < N2, !.
escolhePercursoInicial2(O,D,_,N2,_,P2,(N2,P2,D,O)).

calculaDistancia([_],0).
calculaDistancia([H1,H2|T],D) :-
    (adjacencia(H1,H2,DD); adjacencia(H2,H1,DD)),
    calculaDistancia([H2|T],D1), D is D1+DD.


maisProximo(Inicial,Final,Max,_,Percurso) :-
    percursoMaxDist(Inicial,Final,0,Max,Dist,P),
    maisProximo(Inicial,Final,Dist,P,Percurso).
maisProximo(_,_,_,Percurso,Percurso).