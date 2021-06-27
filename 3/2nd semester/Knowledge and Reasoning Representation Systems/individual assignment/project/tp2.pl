%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag(answer_write_options, [quoted(true),portray(true),spacing(next_argument)]).

:- include('paragens').
:- include('adjacencias').

:- include('percursoMaisCurto').
:- include('percursoMaisProximo').
:- include('caminhosCarreiras').

:- use_module(library(lists)).
:- use_module(library(pairs)).


% Verifica se um elemento pertence a uma lista
pertence(X,L) :- memberchk(X,L).

% Retorna uma lista vazia
cabecaListaVazia([_|T],[[]|T]).

% Calcula a metade do numero dado e arredonda para baixo
metade(N,MetadeInt) :- Metade is N/2, floor(Metade,MetadeInt).

% [1 2 3][] -> [3 2 1]
% [4 5 6][4 3 2 1] -> [6 5 4 3 2 1]
% Adiciona os elementos da primeira lista ao inicio da segunda, tirando a cabeca para nao haver elementos repetidos
concatPartesPercurso([],R,_,R).
concatPartesPercurso([H|T],[],1,R) :- concatPartesPercurso(T,[H],0,R).
concatPartesPercurso([_|T],L,1,R) :- concatPartesPercurso(T,L,0,R).
concatPartesPercurso([H|T],L,0,R) :- concatPartesPercurso(T,[H|L],0,R).

% Verifica se uma lista apenas possui zeros
tudoZeros([]).
tudoZeros([0|T]) :- tudoZeros(T).

% Devolve o gid da paragem na carreira dada com o cid em questao, se existir
existeParagem(Carreira,Gid,Cid) :- paragem(Carreira,Cid,Gid,_,_,_,_,_,_,_,_,_,_).

% Devolve uma lista com pares (carreira,cid) da paragem com o gid dado
% Dependendo do tipo de algoritmo em questao, seleciona so as paragens que cumprem os respetivos requisitos
paragensGid(Gid,selecionarOperadoras,Restricoes,Pares) :-
    findall((Carreira,Cid), (paragem(Carreira,Cid,Gid,_,_,_,_,_,Operadora,_,_,_,_),
                            pertence(Operadora,Restricoes)), Pares).

paragensGid(Gid,excluirOperadoras,Restricoes,Pares) :-
    findall((Carreira,Cid), (paragem(Carreira,Cid,Gid,_,_,_,_,_,Operadora,_,_,_,_),
                            \+ pertence(Operadora,Restricoes)), Pares).

paragensGid(Gid,paragensAbrigadas,_,Pares) :-
    findall((Carreira,Cid), (paragem(Carreira,Cid,Gid,_,_,_,TipoAbrigo,_,_,_,_,_,_),
                            TipoAbrigo \= 'Sem Abrigo'), Pares).

paragensGid(Gid,abrigosComPublicidade,_,Pares) :-
    findall((Carreira,Cid), paragem(Carreira,Cid,Gid,_,_,_,_,'Yes',_,_,_,_,_), Pares).

paragensGid(Gid,normal,_,Pares) :-
    findall((Carreira,Cid), paragem(Carreira,Cid,Gid,_,_,_,_,_,_,_,_,_,_), Pares).

% Identifica o gid de uma paragem, dadas a carreira e o cid
gid(Carreira,Cid,Gid) :- paragem(Carreira,Cid,Gid,_,_,_,_,_,_,_,_,_,_).

% Predicado auxiliar para calcular o minimo de uma lista, em modulo
minAux([],_,Temp,Temp).
minAux([H|T],Atual,_,R) :- H =\= 0, abs(H) < Atual, AbsH is abs(H), minAux(T,AbsH,H,R).
minAux([_|T],Atual,Temp,R) :- minAux(T,Atual,Temp,R).

% Devolve o minimo da lista, em modulo, excluindo os zeros (indicam que o destino nao esta na carreira em questao)
% Se apenas houver zeros na lista, devolve 0 - vai selecionar uma paragem aleatoria a seguir
minModulo([],0).
minModulo([H|T],R) :- H =\= 0, AbsH is abs(H), minAux(T,AbsH,H,R).
minModulo([_|T],R) :- minModulo(T,R).

% Calcula a paragem adjacente no sentido pretendido
adjacente((Carreira,Cid),0,ProxParagem) :-
    (ProxCid is Cid-1, gid(Carreira,ProxCid,ProxParagem));
    (ProxCid is Cid+1, gid(Carreira,ProxCid,ProxParagem)).
adjacente((Carreira,Cid),Min,ProxParagem) :- 
    Min < 0, ProxCid is Cid-1, gid(Carreira,ProxCid,ProxParagem).
adjacente((Carreira,Cid),_,ProxParagem) :- 
    ProxCid is Cid+1, gid(Carreira,ProxCid,ProxParagem).
adjacente(_,_,_,0).

% Se a carreira passar no destino, devolve o numero de paragens a que se encontra
% Caso contrario, devolve 0
passaDestinoPares([],_,[]).
passaDestinoPares([(Carreira,Cid)|T1],Destino,[Dif|T2]) :-
    existeParagem(Carreira,Destino,CidDestino),
    Dif is CidDestino-Cid,
    passaDestinoPares(T1,Destino,T2).
passaDestinoPares([_|T1],Destino,[0|T2]) :- passaDestinoPares(T1,Destino,T2).

% Retorna o Cid de uma lista de pares (Carreira,Cid) correspondente a Carreira dada
getCidPar(C,[(C,Cid)|_],Cid).
getCidPar(C,[_|T],Cid) :- getCidPar(C,T,Cid).

% Retira a primeira carreira da lista se a tiver alcancado
atualizaCaminhoCarreiras(Cid,Cid,[_],[]).
atualizaCaminhoCarreiras(Cid,Cid,[_,Prox|T],[Prox|T]).
atualizaCaminhoCarreiras(_,_,L,L).

% Determina o cid da lista mais proximo do cid atual
cidMaisProximo(_,[],Cid,_,Cid).
cidMaisProximo(CidAtual,[H|T],Cid,Min,CidMaisProximo) :-
    Dif is CidAtual-H, AbsDif is abs(Dif),
    ((AbsDif < Min, !, cidMaisProximo(CidAtual,T,H,AbsDif,CidMaisProximo));
    cidMaisProximo(CidAtual,T,Cid,Min,CidMaisProximo)).

cidMaisProximo(CidAtual,[H|T],CidMaisProximo) :-
    Dif is CidAtual-H, AbsDif is abs(Dif),
    cidMaisProximo(CidAtual,T,H,AbsDif,CidMaisProximo).

% Recebe uma lista de pares e devolve uma lista com os segundos elementos
listaSnd([],[]).
listaSnd([(_,L)|T],[L|R]) :- listaSnd(T,R).

% Verifica que nao existe nenhuma paragem proibida para a travessia
% entre o cid atual e o cid para o qual se desloca
naoPassaProibido(_,_,[]).
naoPassaProibido(Cid,CidAtual,[CidProibido|T]) :-
    \+ ((Cid =:= CidProibido) ; 
    (Cid < CidProibido, CidAtual > CidProibido) ;
    (Cid > CidProibido, CidAtual < CidProibido)),
    naoPassaProibido(Cid,CidAtual,T).

% Determina os cids para os quais o algoritmo se pode deslocar de seguida
cidsValidos(_,_,_,[],_,CidsValidos,CidsValidos).

cidsValidos(CidAtual,CarrAtual,CarrProx,[(H1,H2)|Pares],CidsProibidos,Temp,CidsValidos) :-
    pertence(CarrAtual,H2), pertence(CarrProx,H2),
    naoPassaProibido(H1,CidAtual,CidsProibidos),
    cidsValidos(CidAtual,CarrAtual,CarrProx,Pares,CidsProibidos,[H1|Temp],CidsValidos).

cidsValidos(CidAtual,CarrAtual,CarrProx,[_|Pares],CidsProibidos,Temp,CidsValidos) :-
    cidsValidos(CidAtual,CarrAtual,CarrProx,Pares,CidsProibidos,Temp,CidsValidos).

% Recebe uma lista de gids proibidos ao percurso atual e a carreira em que se 
% encontra e devolve os respetivos cids
cidsProibidos([],_,[]).
cidsProibidos([Gid|T1],CarrAtual,[Cid|T2]) :-
    paragem(CarrAtual,Cid,Gid,_,_,_,_,_,_,_,_,_,_),
    cidsProibidos(T1,CarrAtual,T2).
cidsProibidos([_|T1],CarrAtual,T2) :- cidsProibidos(T1,CarrAtual,T2).

% Devolve o cid da paragem atual, os cids correspondentes aos gids proibidos dados
% e uma lista com todos os pares (cid,carreira) da carreira atual
getInfoCidsCarreira(GidAtual,Carreira,GidsProibidos,(CidAtual,CidsProibidos,Pares)) :-
    paragem(Carreira,CidAtual,GidAtual,_,_,_,_,_,_,_,_,_,_),
    findall((Cid,Carreiras),(paragem(Carreira,Cid,_,_,_,_,_,_,_,Carreiras,_,_,_)), Pares),
    cidsProibidos(GidsProibidos,Carreira,CidsProibidos).

% Dada uma lista de cids e a carreira, devolve os respetivos gids
cidsParaGids([],_,[]).
cidsParaGids([Cid|T1],Carreira,[Gid|T2]) :-
    paragem(Carreira,Cid,Gid,_,_,_,_,_,_,_,_,_,_),
    cidsParaGids(T1,Carreira,T2).

% Devolve os cids correspondentes aos gids validos
cidsComunsAux(_,[],_,[]).
cidsComunsAux(CarrAtual,[H|T],GidsValidosProx,[Cid|CidsValidos]) :-
    pertence(H,GidsValidosProx),
    paragem(CarrAtual,Cid,H,_,_,_,_,_,_,_,_,_,_),
    cidsComunsAux(CarrAtual,T,GidsValidosProx,CidsValidos).
cidsComunsAux(CarrAtual,[_|T],GidsValidosProx,CidsValidos) :-
    cidsComunsAux(CarrAtual,T,GidsValidosProx,CidsValidos).

% Identifica os cids de intersecao validos para onde o algoritmo se pode deslocar
cidsComuns(CarrAtual,CarrProx,CidsValidosAtual,CidsValidosProx,CidsValidos) :-
    cidsParaGids(CidsValidosAtual,CarrAtual,GidsValidosAtual),
    cidsParaGids(CidsValidosProx,CarrProx,GidsValidosProx),
    cidsComunsAux(CarrAtual,GidsValidosAtual,GidsValidosProx,CidsValidos).

% Determina o cid de intersecao entre a carreira atual e a proxima para onde o algoritmo se deve deslocar
cidIntersecao(GidAtual,Destino,CarrAtual,CarrProx,GidsProibidos,CidIntersecao) :-
    getInfoCidsCarreira(GidAtual,CarrAtual,GidsProibidos,(CidAtual,CidsProibidosAtual,ParesAtual)),
    getInfoCidsCarreira(Destino,CarrProx,GidsProibidos,(CidProx,CidsProibidosProx,ParesProx)),
    cidsValidos(CidAtual,CarrAtual,CarrProx,ParesAtual,CidsProibidosAtual,[],CidsValidosAtual),
    cidsValidos(CidProx,CarrAtual,CarrProx,ParesProx,CidsProibidosProx,[],CidsValidosProx),
    cidsComuns(CarrAtual,CarrProx,CidsValidosAtual,CidsValidosProx,CidsValidos),
    cidMaisProximo(CidAtual,CidsValidos,CidIntersecao).

cidIntersecao(GidAtual,_,CarrAtual,CarrProx,GidsProibidos,CidIntersecao) :-
    getInfoCidsCarreira(GidAtual,CarrAtual,GidsProibidos,(CidAtual,CidsProibidos,Pares)),
    cidsValidos(CidAtual,CarrAtual,CarrProx,Pares,CidsProibidos,[],CidsValidos),
    cidMaisProximo(CidAtual,CidsValidos,CidIntersecao).

% Identifica o gid da proxima paragem, tendo em conta o caminho de carreiras que esta a utilizar,
% e atualiza o mesmo
proxParagemCaminhoCarreirasAux(CidAtual,CidIntersecao,[CarrAtual|T],CaminhoAtualizado,ProxParagem) :-
    ((CidIntersecao > CidAtual, ProxCid is CidAtual+1); ProxCid is CidAtual-1),
    gid(CarrAtual,ProxCid,ProxParagem),
    atualizaCaminhoCarreiras(ProxCid,CidIntersecao,[CarrAtual|T],CaminhoAtualizado).

% Nenhuma das carreiras da paragem atual passa no destino
% Verifica qual e o minimo de carreiras que e possivel atravessar ate ao destino
% e escolhe o nodo adjacente no sentido da carreira seguinte
proxParagemCaminhoCarreiras(GidAtual,Destino,_,[[CarrAtual]|Outros],[CaminhoAtualizado|Outros],ProxParagem) :-
    paragem(CarrAtual,CidAtual,GidAtual,_,_,_,_,_,_,_,_,_,_),
    paragem(CarrAtual,CidIntersecao,Destino,_,_,_,_,_,_,_,_,_,_),
    proxParagemCaminhoCarreirasAux(CidAtual,CidIntersecao,[CarrAtual],CaminhoAtualizado,ProxParagem).

proxParagemCaminhoCarreiras(GidAtual,Destino,GidsProibidos,[[CarrAtual,CarrProx|Resto]|Outros],[CaminhoAtualizado|Outros],ProxParagem) :-
    cidIntersecao(GidAtual,Destino,CarrAtual,CarrProx,GidsProibidos,CidIntersecao),
    paragem(CarrAtual,CidAtual,GidAtual,_,_,_,_,_,_,_,_,_,_),
    proxParagemCaminhoCarreirasAux(CidAtual,CidIntersecao,[CarrAtual,CarrProx|Resto],CaminhoAtualizado,ProxParagem).

% Dada uma lista de pares, devolve uma lista com os primeiros elementos
listaFstPares([],[]).
listaFstPares([(C,_)|T],[C|R]) :- listaFstPares(T,R).

% Pelo menos uma das carreiras da paragem atual passa no destino
% Escolhe a paragem adjacente que se encontre a menos paragens do destino
proxParagemCarreiraDestino(Carreiras,Difs,ProxParagem) :-
    minModulo(Difs,Min),
    nth0(Indice,Difs,Min),
    nth0(Indice,Carreiras,Prox),
    adjacente(Prox,Min,ProxParagem). % calcula a proxima paragem

% Tendo em conta o caminho de carreiras que esta a seguir e todos os outros parametros dados
% escolhe o gid da proxima paragem e atualiza os caminhos de carreiras conforme o resultado
escolheProxParagem(Gid,Destino,GidsProibidos,CaminhosCarreiras,TipoTravessia,Restricoes,(ProxParagem,CaminhosAtualizados)) :-
    paragensGid(Gid,TipoTravessia,Restricoes,Pares), % verifica em que carreiras se encontra a paragem atual (e o respetivo cid)
    ((length(Pares,0), !, ProxParagem is -Gid, cabecaListaVazia(CaminhosCarreiras,CaminhosAtualizados)); % nao ha paragens adjacentes admissiveis
    proxParagemCaminhoCarreiras(Gid,Destino,GidsProibidos,CaminhosCarreiras,CaminhosAtualizados,ProxParagem)). % nenhuma das carreiras atuais passa no destino

% Calcula a proxima paragem, caso haja algum caminho possivel
escolheProxParagem(Gid,Destino,GidsProibidos,TipoTravessia,Restricoes,(ProxParagem,CaminhosAtualizados)) :-
    paragensGid(Gid,TipoTravessia,Restricoes,Pares), % verifica em que carreiras se encontra a paragem atual (e o respetivo cid)
    passaDestinoPares(Pares,Destino,Difs),!, % verifica para cada carreira se passa no destino e da uma lista com o numero de estacoes ate la, se passar
    ((length(Difs,0), !, ProxParagem is -Gid, cabecaListaVazia([[]],CaminhosAtualizados)); % nao ha paragens adjacentes admissiveis
    (tudoZeros(Difs), !,
        listaFstPares(Pares,Carreiras),
        calculaCaminhosCarreiras(Carreiras,Destino,CaminhosCarreiras),!,
        proxParagemCaminhoCarreiras(Gid,Destino,GidsProibidos,CaminhosCarreiras,CaminhosAtualizados,ProxParagem)); % nenhuma das carreiras atuais passa no destino
    (proxParagemCarreiraDestino(Pares,Difs,ProxParagem), cabecaListaVazia([[]],CaminhosAtualizados))). % pelo menos uma das carreiras atuais passa no destino

% Processa a proxima paragem e a lista de carreiras devolvidas pela proxParagem
% Esta numa carreira com ligacao direta ao destino, pode continuar a calcular o caminho normalmente
processaProxParagem((ProxParagem,[[]]),(Origem,Destino),GidsProibidos,PercursoAtual,TipoTravessia,Restricoes,Percurso) :-
    ProxParagem > 0, !,
    percursoInformado(ProxParagem,(Origem,Destino),GidsProibidos,[ProxParagem|PercursoAtual],TipoTravessia,Restricoes,Percurso).

% Esta numa carreira com ligacao direta ao destino mas encontrou uma paragem que nao pode usar devido as
% restricoes estabelecidas, calcula os conjuntos de carreiras a partir dos quais e possivel chegar ao destino
% e comeca a seguir o mais curto a partir da origem, caso exista algum, senao falha
processaProxParagem((GidProibidoNeg,[[]]),(Origem,Destino),GidsProibidos,_,TipoTravessia,Restricoes,Percurso) :-
    GidProibido is abs(GidProibidoNeg),
    getCarreiras(Origem,CarreirasOrigem),
    calculaCaminhosCarreiras(CarreirasOrigem,Destino,CaminhosCarreiras),
    length(CaminhosCarreiras,N), !, N > 0,
    percursoInformado(Origem,(Origem,Destino),[GidProibido|GidsProibidos],CaminhosCarreiras,[Origem],TipoTravessia,Restricoes,Percurso).

% Esta a seguir um caminho de carreiras e nao teve problemas a passar para a proxima paragem
processaProxParagem((ProxParagem,CaminhosCarreiras),(Origem,Destino),GidsProibidos,PercursoAtual,TipoTravessia,Restricoes,Percurso) :-
    ProxParagem > 0, !,
    percursoInformado(ProxParagem,(Origem,Destino),GidsProibidos,CaminhosCarreiras,[ProxParagem|PercursoAtual],TipoTravessia,Restricoes,Percurso).

% Esta a seguir um camihno de carreiras mas encontrou uma paragem que nao pode usar devido as restricoes
% estabelecidas, volta a origem e tenta seguir o caminho de carreiras seguinte
processaProxParagem((GidProibidoNeg,[_|CaminhosCarreiras]),(Origem,Destino),GidsProibidos,_,TipoTravessia,Restricoes,Percurso) :-
    GidProibido is abs(GidProibidoNeg),
    percursoInformado(Origem,(Origem,Destino),[GidProibido|GidsProibidos],CaminhosCarreiras,[Origem],TipoTravessia,Restricoes,Percurso).


% Calcula o percurso da Origem ao Destino, se for possivel chegar ao Destino partindo da Origem
% Caso contrario devolve "no"
% Se uma das carreiras da Origem passar no Destino, calcula o percurso mais curto em paragens ate ao Destino
% Se nenhuma das carreiras da Origem passar no Destino, calcula os conjuntos de carreiras a partir dos quais
% e possivel chegar ao destino e faz o percurso pelo menor
percursoInformado(Destino,(_,Destino),_,PercursoInverso,_,_,Percurso) :- reverse(PercursoInverso,Percurso).

percursoInformado(Gid,(Origem,Destino),GidsProibidos,PercursoAtual,TipoTravessia,Restricoes,Percurso):-
    escolheProxParagem(Gid,Destino,GidsProibidos,TipoTravessia,Restricoes,ProxParagem),!,
    processaProxParagem(ProxParagem,(Origem,Destino),GidsProibidos,PercursoAtual,TipoTravessia,Restricoes,Percurso).

percursoInformado(Destino,(_,Destino),_,_,PercursoInverso,_,_,Percurso) :- reverse(PercursoInverso,Percurso).

percursoInformado(Gid,(Origem,Destino),GidsProibidos,CaminhosCarreiras,PercursoAtual,TipoTravessia,Restricoes,Percurso):-
    escolheProxParagem(Gid,Destino,GidsProibidos,CaminhosCarreiras,TipoTravessia,Restricoes,ProxParagem),!,
    processaProxParagem(ProxParagem,(Origem,Destino),GidsProibidos,PercursoAtual,TipoTravessia,Restricoes,Percurso).

% Verifica se o elemento dado e adjacente a algum dos elementos da lista dada
% apagando todos os elementos entre eles, se for o caso
atalhosAux(_,[],[]).
atalhosAux(H,[X|T],[X|T]) :- adjacencia(H,X,_); adjacencia(X,H,_).
atalhosAux(H,[_|T],L) :- atalhosAux(H,T,L).

% Recursividade da funcao atalhos
proxAtalhos([_,H2|T],Temp,[],L) :- atalhos([H2|T],Temp,L).
proxAtalhos(_,_,Lista,L) :- atalhos(Lista,Lista,L).

% Realiza todos os atalhos possiveis no percurso dado
atalhos([H1,H2],_,[H1,H2]).
atalhos([H1,H2|T],Temp,[H1|L]) :- atalhosAux(H1,T,Lista), proxAtalhos([H1,H2|T],Temp,Lista,L).


% Calcula o percurso com uma estrategia de pesquisa informada e verifica atalhos
percursoInformadoFinal(Origem,Destino,Tipo,Restricoes,PercursoFinal) :-
    percursoInformado(Origem,(Origem,Destino),[],[Origem],Tipo,Restricoes,Percurso),
    atalhos(Percurso,Percurso,PercursoFinal).


%---------------------------------------------------------------------------------------------------------
% Requisito 1: Calcular um trajeto entre dois pontos
percurso(Origem,Destino,Percurso):- 
    percursoInformadoFinal(Origem,Destino,normal,_,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 2: Selecionar apenas algumas das operadoras de transporte para um determinado percurso
selecionarOperadoras(Origem,Destino,Operadoras,Percurso) :- 
    percursoInformadoFinal(Origem,Destino,selecionarOperadoras,Operadoras,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 3: Excluir uma ou mais operadoras de transporte para o percurso
excluirOperadoras(Origem,Destino,Operadoras,Percurso) :- 
    percursoInformadoFinal(Origem,Destino,excluirOperadoras,Operadoras,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 4: Identificar quais as paragens com o maior 
% número de carreiras num determinado percurso
paragensMaisCarreiras(Percurso,Pares) :-
    contaCarreiras(Percurso,ParesInv),
    keysort(ParesInv,ParesInvDecresc),
    reverse(ParesInvDecresc,ParesInvCresc),
    invertePares(ParesInvCresc,Pares).

% Conta o numero de carreiras que passam pela paragem do gid
contaCarreiras([],[]).
contaCarreiras([Gid|T],[N-Gid|L]) :-
    paragem(_,_,Gid,_,_,_,_,_,_,Carreiras,_,_,_),
    length(Carreiras,N),
    contaCarreiras(T,L).

invertePares([],[]).
invertePares([N-Gid|T],[Gid-N|L]) :- invertePares(T,L).

%---------------------------------------------------------------------------------------------------------
% Requisito 5: Escolher o menor percurso (usando critério menor número de paragens)
percursoMaisCurto(Origem,Destino,Percurso) :-
    percursoInformado(Origem,(Origem,Destino),[],[Origem],normal,_,P1), length(P1,N1),
    percursoInformado(Destino,(Destino,Origem),[],[Destino],normal,_,P2), length(P2,N2),
    escolhePercursoInicial1(Origem,Destino,N1,N2,P1,P2,(N,P,Inicial,Final)),
    mudancasSentido(P,ParagensMudanca),
    metade(N,Metade),
    uniOuBidirecional(Inicial,Final,Metade,N,P,ParagensMudanca,PercursoDesord),
    ordenaPercurso(Origem,PercursoDesord,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 6: Escolher o percurso mais rápido (usando critério da distância)
percursoMaisProximo(Origem,Destino,Percurso) :-
    percurso(Origem,Destino,P1), calculaDistancia(P1,N1),
    percurso(Destino,Origem,P2), calculaDistancia(P2,N2),
    escolhePercursoInicial2(Origem,Destino,N1,N2,P1,P2,(N,P,Inicial,Final)),
    maisProximo(Inicial,Final,N,P,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 7: Escolher o percurso que passe apenas por abrigos com publicidade
abrigosComPublicidade(Origem,Destino,Percurso) :-
    percursoInformadoFinal(Origem,Destino,abrigosComPublicidade,_,Percurso).

%---------------------------------------------------------------------------------------------------------
% Requisito 8: Escolher o percurso que passe apenas por paragens abrigadas
paragensAbrigadas(Origem,Destino,Percurso) :-
    percursoInformadoFinal(Origem,Destino,paragensAbrigadas,_,Percurso).

%---------------------------------------------------------------------------------------------------------

% Requisito 9: Escolher um ou mais pontos intermédios por onde o percurso deverá passar
paragensIntermedias(Origem,Destino,Intermedias,Percurso) :-
    reverse([Origem|Intermedias],L1), reverse([Destino|L1],L2),
    paragensIntermediasAux(L2,[],Percurso).

% Calcula um percurso que passa por todas as paragens da primeira lista
% Se nao for possivel, devolve "no"
paragensIntermediasAux([_],PercursoInvertido,Percurso) :- reverse(PercursoInvertido,Percurso).
paragensIntermediasAux([H1,H2|T],PercursoAtual,Percurso) :-
    percurso(H1,H2,PartePercurso),!,
    length(PartePercurso,N), N > 0,
    concatPartesPercurso(PartePercurso,PercursoAtual,1,P),
    paragensIntermediasAux([H2|T],P,Percurso).