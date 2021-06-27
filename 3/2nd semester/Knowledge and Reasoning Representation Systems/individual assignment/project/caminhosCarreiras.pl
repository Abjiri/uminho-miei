% Devolve as carreiras que se cruzam com a carreira atual
carreirasLigacaoDireta(Carreira,Adjacentes) :-
    findall(X, paragem(Carreira,_,_,_,_,_,_,_,_,X,_,_,_), Carreiras),
    flatten(Carreiras,ListaCarreiras),
    sort(ListaCarreiras,Adjacentes).

% Remove os elementos do segundo argumento da primeira lista
removerIntersecao(PorVisitar,[],PorVisitar).
removerIntersecao(Adjacentes,[H|T],PorVisitar) :-
    delete(Adjacentes,H,NovosAdjacentes),
    removerIntersecao(NovosAdjacentes,T,PorVisitar).

% Seleciona o elemento da lista dada cuja cabeca e a carreira atual
getCaminhoAteAtual(Atual,[[Atual|T]|_],[Atual|T]).
getCaminhoAteAtual(Atual,[_|T],Caminho) :- getCaminhoAteAtual(Atual,T,Caminho).

% Cria novos caminhos a partir do caminho ate ao momento e as novas carreiras
atualizaCaminhos([],_,[]).
atualizaCaminhos([H|T],CaminhoAteAtual,[[H|CaminhoAteAtual]|R]) :-
    atualizaCaminhos(T,CaminhoAteAtual,R).

% Devolve uma lista com as cabecas dos elementos da lista original
listaCabecas([],[]).
listaCabecas([[X|_]|T],[X|R]) :- listaCabecas(T,R).

% Determina as carreiras que se cruzam com a atual e ainda nao foram visitadas
carreirasAdjacentesPorVisitar(Atual,Vis,PorVisitar) :-
    carreirasLigacaoDireta(Atual,Adjacentes),
    intersection(Adjacentes,Vis,Repetidas),
    removerIntersecao(Adjacentes,Repetidas,PorVisitar).

% Atualiza as listas de carreiras visitadas, caminhos acabados e caminhos em curso
atualizaListas([],_,_,NaoOld,SimOld,VisOld,(NaoOld,SimOld,VisOld)).

atualizaListas([[H|T]|NovosCaminhos],[H|Sim],Nao,NaoOld,SimOld,VisOld,(NaoNew,[C|SimNew],[H|VisNew])):-
    reverse([H|T],C), atualizaListas(NovosCaminhos,Sim,Nao,NaoOld,SimOld,VisOld,(NaoNew,SimNew,VisNew)).

atualizaListas([[H|T]|NovosCaminhos],Sim,[H|Nao],NaoOld,SimOld,VisOld,([[H|T]|NaoNew],SimNew,[H|VisNew])):-
    atualizaListas(NovosCaminhos,Sim,Nao,NaoOld,SimOld,VisOld,(NaoNew,SimNew,VisNew)).
    
% Atualiza os caminhos em construcao que conseguem chegar ao destino,
% adicionando-lhes as respetivas carreiras adjacentes
caminhosAteAdjacentes(Atual,CDestino,Caminhos,PorVisitar,Vis,TempNovosCaminhos,
                        TempFinais,(TempNCAtualizado,FinaisAtualizados,VisNew)) :-
    getCaminhoAteAtual(Atual,Caminhos,CaminhoAteAtual),
    atualizaCaminhos(PorVisitar,CaminhoAteAtual,NovosCaminhos),
    passamDestino(PorVisitar,CDestino,Sim,Nao),
    atualizaListas(NovosCaminhos,Sim,Nao,TempNovosCaminhos,TempFinais,Vis,
                    (TempNCAtualizado,FinaisAtualizados,VisNew)).

% Concatena duas listas
concat([], List, List).
concat([Head|Tail], List, [Head|Rest]) :-
    concat(Tail, List, Rest).

% Separa as carreiras que passam no destino e as que nao passam em duas listas diferentes
passamDestino([],_,[],[]).
passamDestino([Carreira|T],CDestino,[Carreira|Sim],Nao) :- 
    pertence(Carreira,CDestino), passamDestino(T,CDestino,Sim,Nao).
passamDestino([Carreira|T],CDestino,Sim,[Carreira|Nao]) :- passamDestino(T,CDestino,Sim,Nao).

% Algoritmo breadth-first usado para calcular caminhos entre as carreiras dadas
% e as carreiras do destino
caminhosCarreirasAux([],_,_,_,[],R,R).

caminhosCarreirasAux([],CDestino,_,Vis,NovosCaminhos,Finais,R) :-
    listaCabecas(NovosCaminhos,Proximas),
    caminhosCarreirasAux(Proximas,CDestino,NovosCaminhos,Vis,[],Finais,R).

caminhosCarreirasAux([Atual|T],CDestino,Caminhos,Vis,TempNovosCaminhos,Finais,R) :-
    carreirasAdjacentesPorVisitar(Atual,Vis,PorVisitar),
    caminhosAteAdjacentes(Atual,CDestino,Caminhos,PorVisitar,Vis,TempNovosCaminhos,
                            Finais,(TempAtualizado,FinaisAtualizados,NovasVis)),
    caminhosCarreirasAux(T,CDestino,Caminhos,NovasVis,TempAtualizado,FinaisAtualizados,R).

% Coloca cada elemento da lista original numa lista própria e devolve uma lista de listas
criaCaminhosIndividuais([],[]).
criaCaminhosIndividuais([H|T1],[[H]|T2]):- criaCaminhosIndividuais(T1,T2).

% Devolve as carreiras que passam num dado gid
getCarreiras(Destino,Carreiras) :- paragem(_,_,Destino,_,_,_,_,_,_,Carreiras,_,_,_).

% Cria uma lista de pares comprimento-lista a partir da lista de listas original
paresListaComprimento([],[]).
paresListaComprimento([H|T1],[N-H|T2]) :- length(H,N), paresListaComprimento(T1,T2).

% Devolve uma lista com o segundo elemento de cada par da lista original
listaFstPares2([],[]).
listaFstPares2([_-H|T1],[H|T2]) :- listaFstPares2(T1,T2).

% Ordena as listas numa lista pelo seu comprimento
sortPorComprimento(Listas,ListasOrd) :-
    paresListaComprimento(Listas,Pares),
    keysort(Pares,ParesOrd),
    listaFstPares2(ParesOrd,ListasOrd).

% Calcula os conjuntos de caminhos a partir dos quais e possivel atingir o destino
% partindo de cada elemento da lista de carreiras iniciais dada
calculaCaminhosCarreiras([],_,Temp,CaminhosOrd) :- sortPorComprimento(Temp,CaminhosOrd).
calculaCaminhosCarreiras([H|T],CDestino,Temp,CaminhosOrd) :-
    caminhosCarreirasAux([H],CDestino,[[H]],[H],[],[],Caminhos),
    concat(Caminhos,Temp,NovoTemp),
    calculaCaminhosCarreiras(T,CDestino,NovoTemp,CaminhosOrd).

% Calcula os conjuntos de carreiras a partir dos quais e possivel atingir o destino
calculaCaminhosCarreiras(Carreiras,Destino,Caminhos) :-
    getCarreiras(Destino,CarreirasDestino),
    calculaCaminhosCarreiras(Carreiras,CarreirasDestino,[],Caminhos).