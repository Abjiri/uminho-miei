{-|
Module: Tarefa1_2017li1g5
Description: Módulo correspondente à resolução da tarefa 1 do projeto de LI1
Copyright: Hugo Cardoso <a85006@alunos.uminho.pt>         
           João Cunha <a84775@alunos.uminho.pt>

Um módulo contendo as funções necessárias para implementar a tarefa 1 do projeto de LI1.
-}

module Tarefa1_2017li1g5 where

import LI11718

{- | Conjunto de caminhos para testar a funcionalidade desta tarefa. -}
testesT1 :: [Caminho]
testesT1 = [c1,c2,c3,c4,c5,c6,c7]

{- | Primeiro teste - caminho a começar com um Avanca. -}
c1 = [Avanca,CurvaEsq,CurvaEsq,Avanca,CurvaEsq,CurvaEsq]
{- | Segundo teste - caminho a começar com um Sobe. -}
c2 = [Sobe,CurvaEsq,Sobe,CurvaEsq,Sobe,Desce,CurvaEsq,Desce,CurvaEsq,Desce]
{- | Terceiro teste - caminho a começar com um Desce. -}
c3 = [Desce,CurvaDir,CurvaDir,Sobe,CurvaDir,CurvaDir]
{- | Quarto teste - caminho a começar com uma CurvaDir. -}
c4 = [CurvaDir,Sobe,CurvaDir,CurvaDir,Desce,CurvaDir]
{- | Quinto teste - caminho a começar com uma CurvaEsq. -}
c5 = [CurvaEsq,CurvaEsq,Avanca,CurvaEsq,CurvaEsq,Avanca]
{- | Sexto teste - caminho que faz um oito. -}
c6 = [Sobe,CurvaEsq,Avanca,CurvaDir,Sobe,CurvaDir,CurvaDir,Desce,Avanca,Desce,CurvaEsq,CurvaEsq]
{- | Sétimo teste - caminho que é uma lista vazia. -}
c7 = []


{- | A função tabuleiroLava constrói um tabuleiro formado apenas por peças de lava com as dimensões fornecidas.

== Exemplo de utilização:
>>> tabuleiroLava (2,2)
[[Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0]]
-}

tabuleiroLava :: Dimensao -> Tabuleiro
tabuleiroLava (colunas,linhas) = replicate linhas (replicate colunas (Peca Lava altLava))


{- | A função atualizarTabuleiroLinha atualiza a peça na posicão x de uma linha.

== Exemplo de utilização:
>>> atualizarTabuleiroLinha [Peca Lava 0, Peca Lava 0, Peca Lava 0] (Peca Recta 0) 1
[Peca Lava 0,Peca Recta 0,Peca Lava 0]
-}

atualizarTabuleiroLinha :: [Peca] -- ^ linha de peças original
                        -> Peca -- ^ peça a inserir
                        -> Int -- ^ posição da peça a substituir
                        -> [Peca] -- ^ nova linha de peças
atualizarTabuleiroLinha [] a x = []
atualizarTabuleiroLinha (h:t) a x | x == 0 = a : t
                                  | otherwise = h : atualizarTabuleiroLinha t a (x-1)


{- | A função atualizarTabuleiro atualiza a peça de um tabuleiro na posição dada.

== Exemplo de utilização:
>>> atualizarTabuleiro [[Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0]] (Peca Recta 0) (0,1)
[[Peca Lava 0,Peca Lava 0],[Peca Recta 0,Peca Lava 0]]
-}

atualizarTabuleiro :: Tabuleiro  -- ^ tabuleiro original
                   -> Peca -- ^ peça nova
                   -> Posicao -- ^ posição da peça a substituir
                   -> Tabuleiro -- ^ tabuleiro atualizado
atualizarTabuleiro (h:t) p (x,y) | y == 0 = atualizarTabuleiroLinha h p x : t  
                                 | otherwise = h : atualizarTabuleiro t p (x,y-1)


{- | A função atualizarTabuleiroTodo atualiza as peças do tabuleiro das posições dadas.

== Exemplo de utilização:
>>> atualizarTabuleiroTodo [[Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0]] [Peca Recta 0,Peca (Curva Norte) 0,Peca (Rampa Norte) 0] [(0,1),(1,0),(1,1)]
[[Peca Lava 0,Peca (Curva Norte) 0],[Peca Recta 0,Peca (Rampa Norte) 0]]
-}

atualizarTabuleiroTodo :: Tabuleiro -- ^ tabuleiro original
                       -> [Peca] -- ^ lista de peças novas
                       -> [Posicao] -- ^ posições das peças a substituir
                       -> Tabuleiro -- ^ tabuleiro atualizado
atualizarTabuleiroTodo a [] [] = a
atualizarTabuleiroTodo [] b c = []
atualizarTabuleiroTodo a (h1:t1) (h2:t2)  = atualizarTabuleiroTodo (atualizarTabuleiro a h1 h2) t1 t2


{- | A função passoParaPeca devolve a lista das peças correspondentes ao caminho.

== Exemplo de utilização:
>>> passoParaPeca [Avanca,Sobe,CurvaDir,Desce,Avanca] Este 0
[Peca Recta 0,Peca (Rampa Este) 0,Peca (Curva Este) 1,Peca (Rampa Norte) 0,Peca Recta 0]
-}

passoParaPeca :: Caminho -- ^ lista de passos
              -> Orientacao -- ^ orientação inicial
              -> Altura -- ^ altura inicial
              -> [Peca] -- ^ lista de peças
passoParaPeca [] o a = []
passoParaPeca (h:t) o a | h == Avanca = Peca Recta a : passoParaPeca t o a
                        | h == CurvaEsq = fst (esqAux o a) : passoParaPeca t (snd (esqAux o a)) a
                        | h == CurvaDir = fst (dirAux o a) : passoParaPeca t (snd (dirAux o a)) a
                        | h == Sobe = sobeAux o a : passoParaPeca t o (a+1)
                        | h == Desce = desceAux o a : passoParaPeca t o (a-1)


{- | A função esqAux devolve a peça correspondente ao passo CurvaEsq, no contexto do caminho, e a orientação nova.

== Exemplo de utilização:
>>> esqAux Este 0
(Peca (Curva Sul) 0,Norte)
-}

esqAux :: Orientacao  -- ^ orientação atual
       -> Altura -- ^ altura atual
       -> (Peca,Orientacao) -- ^ peça e orientação seguinte
esqAux Norte a = (Peca (Curva Este) a, Oeste)
esqAux Este a  = (Peca (Curva Sul) a, Norte)
esqAux Sul a   = (Peca (Curva Oeste) a, Este)
esqAux Oeste a = (Peca (Curva Norte) a, Sul)


{- | A função dirAux devolve a peça correspondente ao passo CurvaDir, no contexto do caminho, e a orientação nova. 

== Exemplo de utilização:
>>> dirAux Norte 1
(Peca (Curva Norte) 1,Este)
-}
dirAux :: Orientacao -> Altura -> (Peca,Orientacao)
dirAux Norte a = (Peca (Curva Norte) a, Este)
dirAux Este a  = (Peca (Curva Este) a, Sul)
dirAux Sul a   = (Peca (Curva Sul) a, Oeste)
dirAux Oeste a = (Peca (Curva Oeste) a, Norte)


{- | A função sobeAux devolve a peça correspondente ao passo Sobe, no contexto do caminho, e a orientação nova. 

== Exemplo de utilização:
>>> sobeAux Sul 0
Peca (Rampa Sul) 0
-}
sobeAux :: Orientacao -> Altura -> Peca
sobeAux Norte a = Peca (Rampa Norte) a
sobeAux Este a  = Peca (Rampa Este) a
sobeAux Sul a   = Peca (Rampa Sul) a
sobeAux Oeste a = Peca (Rampa Oeste) a


{- | A função desceAux devolve a peça correspondente ao passo Desce, no contexto do caminho, e a orientação nova. 

== Exemplo de utilização:
>>> desceAux Oeste 1
Peca (Rampa Este) 1
-}
desceAux :: Orientacao -> Altura -> Peca
desceAux Norte a = Peca (Rampa Sul) (a-1)
desceAux Este a  = Peca (Rampa Oeste) (a-1)
desceAux Sul a   = Peca (Rampa Norte) (a-1)
desceAux Oeste a = Peca (Rampa Este) (a-1)


{- | A função posicaoPeca devolve a lista das posições das peças correspondentes a todo o caminho, exceto a posição de partida.

== Exemplo de utilização:
>>> posicaoPeca [Avanca,CurvaDir,Desce,CurvaDir] (2,1) Este 0
[(3,1),(3,2),(3,3)]
-}

posicaoPeca :: Caminho -- ^ lista de passos
            -> Posicao -- ^ posição de partida
            -> Orientacao -- ^ orientação inicial
            -> [Posicao] -- ^ lista de posições
posicaoPeca [] p o = []
posicaoPeca (h:t) p o | h ==  Avanca || h == Desce || h == Sobe = auxPosicaoPeca (h:t) p o
                        | h == CurvaDir = auxPosicaoPeca (h:t) p (snd(dirAux o altInit))
                        | otherwise = auxPosicaoPeca (h:t) p (snd(esqAux o altInit))
                            where
                               auxPosicaoPeca [h] (x,y) o = []
                               auxPosicaoPeca (h:hs:t) (x,y) o | hs == Avanca || hs == Desce || hs == Sobe =
                                                                          if o == Norte then (x,y-1) : auxPosicaoPeca (hs:t) (x,y-1) o
                                                                     else if o == Sul   then (x,y+1) : auxPosicaoPeca (hs:t) (x,y+1) o 
                                                                     else if o == Este  then (x+1,y) : auxPosicaoPeca (hs:t) (x+1,y) o 
                                                                                        else (x-1,y) : auxPosicaoPeca (hs:t) (x-1,y) o 

                                                                 | hs == CurvaDir =
                                                                          if o == Norte then (x,y-1) : auxPosicaoPeca (hs:t) (x,y-1) (snd(dirAux o altInit))
                                                                     else if o == Sul   then (x,y+1) : auxPosicaoPeca (hs:t) (x,y+1) (snd(dirAux o altInit))
                                                                     else if o == Este  then (x+1,y) : auxPosicaoPeca (hs:t) (x+1,y) (snd(dirAux o altInit))
                                                                                        else (x-1,y) : auxPosicaoPeca (hs:t) (x-1,y) (snd(dirAux o altInit)) 

                                                                 | o == Norte = (x,y-1) : auxPosicaoPeca (hs:t) (x,y-1) (snd(esqAux o altInit))
                                                                 | o == Sul   = (x,y+1) : auxPosicaoPeca (hs:t) (x,y+1) (snd(esqAux o altInit)) 
                                                                 | o == Este  = (x+1,y) : auxPosicaoPeca (hs:t) (x+1,y) (snd(esqAux o altInit)) 
                                                                 | otherwise  = (x-1,y) : auxPosicaoPeca (hs:t) (x-1,y) (snd(esqAux o altInit))


{- | A função constroi cria um mapa.

== Exemplo de utilização:
>>> constroi [Avanca,CurvaDir,Sobe,CurvaDir,Avanca,CurvaDir,Desce,CurvaDir]
Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],
                   [Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],
                   [Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],
                   [Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],
                   [Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
-}

constroi :: Caminho -- ^ lista de passos
         -> Mapa -- ^ posição e orientação iniciais e tabuleiro
constroi [] = Mapa (partida [],dirInit) (tabuleiroLava (dimensao []))
constroi c = let
                 x = passoParaPeca c dirInit altInit
                 y = tabuleiroLava (dimensao c)
                 z = partida c : posicaoPeca c (partida c) dirInit
             in 
             Mapa (partida c,dirInit) (atualizarTabuleiroTodo y x z)