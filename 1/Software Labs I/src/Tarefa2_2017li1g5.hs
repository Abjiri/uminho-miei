{-|
Module: Tarefa2_2017li1g5
Description: Módulo correspondente à resolução da tarefa 2 do projeto de LI1
Copyright: Hugo Cardoso <a85006@alunos.uminho.pt>         
           João Cunha <a84775@alunos.uminho.pt>

Um módulo contendo as funções necessárias para implementar a tarefa 2 do projeto de LI1.
-}

module Tarefa2_2017li1g5 where

import LI11718

{- | Conjunto de caminhos para testar a funcionalidade desta tarefa. -}
testesT2 :: [Tabuleiro]
testesT2 = [t1,t2,t3,t4,t5,t6,t7]


{- | Primeiro teste - falha porque o tabuleiro é uma lista vazia. -}
t1 = []
{- | Segundo teste - falha porque o tabuleiro não está rodeado por lava. -}
t2 = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0]]
{- | Terceiro teste - falha porque o tabuleiro não é retangular. -}
t3 = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
{- | Quarto teste - falha porque nem todas as peças do tipo lava estão à altura 0. -}
t4 = [[Peca Lava 0,Peca Lava 0,Peca Lava 1,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
{- | Quinto teste - falha porque nem todas as peças do percurso estão ligadas apenas a peças do percurso com alturas compatíveis. -}
t5 = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 1,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
{- | Sexto teste - falha porque o percurso não corresponde a uma trajetória. -}
t6 = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
{- | Sétimo teste - falha porque nem todas as peças fora do percurso são do tipo lava. -}
t7 = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0]]


{- | A função rodeadoLava verifica se o mapa é rodeado por lava.

== Exemplos de utilização:
>>> rodeadoLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
True

>>> rodeadoLava [[Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
False
-}

rodeadoLava :: Tabuleiro -> Bool
rodeadoLava t =  linhasLava (head t)(last t) && colunasLava t 
                where
                    linhasLava [][] = True
                    linhasLava (h:t)(h1:t1) = (h == Peca Lava altLava && h1 == Peca Lava altLava) && linhasLava t t1 
                    colunasLava [] = True
                    colunasLava ((h:t):t1) = (h == Peca Lava altLava && last t == Peca Lava altLava) && colunasLava t1


{- | A função valLava verifica se todas as peças do tipo lava estão à altura 0.

== Exemplos de utilização:
>>> valLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
True

>>> valLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 1,Peca Lava 0]]
False
-}

valLava :: Tabuleiro -> Bool
valLava [] = True
valLava ([]:t1) = valLava t1
valLava ((Peca Lava a:t):t1) | a == 0 = valLava (t:t1)
                             | otherwise = False
valLava ((_:t):t1) = valLava (t:t1)


{- | A função posTabuleiro verifica se a posição inicial pertence ao tabuleiro.

== Exemplos de utilização:
>>> posTabuleiro (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
True

>>> posTabuleiro (-2,-2) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
False

>>> posTabuleiro (200,100) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
False
-}

posTabuleiro :: Posicao -> Tabuleiro -> Bool
posTabuleiro a [] = False
posTabuleiro (x,y) (h:t) | x < 0 || y < 0 || x > length (h:t) || y > (1 + length t) = False
                         | otherwise = True


{- | A função buscarPeca vai ao tabuleiro buscar a peça na posição dada, caso essa posição exista no tabuleiro.

== Exemplos de utilização:
>>> buscarPeca (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0, Peca (Curva Norte) 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Just (Peca (Curva Norte) 0)

>>> buscarPeca (10,10) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0, Peca (Curva Norte) 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Nothing
-}

buscarPeca :: Posicao -> Tabuleiro -> Maybe Peca
buscarPeca (a,b) l | posTabuleiro (a,b) l = Just ((l !! b) !! a)
                   | otherwise = Nothing 


{- | A função compPos compara duas posições e verifica se são iguais.

== Exemplos de utilização:
>>> compPos (2,2) (2,2)
True

>>> compPos (1,2) (2,2)
False
-}

compPos :: Posicao -> Posicao -> Bool
compPos (x,y)(x1,y1) = x == x1 && y == y1


{- | A função primeiro retorna o primeiro elemento de um triplo.

== Exemplo de utilização:
>>> primeiro ((2,1),Este,0)
(2,1)
-}

primeiro :: (Posicao,Orientacao,Altura) -- ^ triplo
         -> Posicao -- ^ primeiro elemento (neste caso, uma posição)
primeiro (a,b,c) = a


{- | A função segundo retorna o segundo elemento de um triplo.

== Exemplo de utilização:
>>> segundo ((2,1),Este,0)
Este
-}

segundo :: (Posicao,Orientacao,Altura) -- ^ triplo
        -> Orientacao -- ^ segundo elemento (neste caso, uma orientação)
segundo (a,b,c) = b


{- | A função terceiro retorna o terceiro elemento de um triplo.

== Exemplo de utilização:
>>> terceiro ((2,1),Este,0)
0
-}

terceiro :: (Posicao,Orientacao,Altura) -- ^ triplo
         -> Altura -- ^ terceiro elemento (neste caso, uma altura)
terceiro (a,b,c) = c


{- | A função partidaDesce devolve um Bool dependendo de se a peça inicial e respetiva orientação são alguma das especificadas.

== Exemplos de utilização:

>>> partidaDesce (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca (Rampa Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Rampa Oeste) (-1),Peca (Curva Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] Este
True

>>> partidaDesce (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca (Rampa Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Rampa Oeste) (-1),Peca (Curva Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] Oeste
False
-}

partidaDesce :: Posicao -> Tabuleiro -> Altura -> Orientacao -> Bool
partidaDesce x [] a o = False
partidaDesce x t a o | buscarPeca x t == Just (Peca (Rampa Oeste) a) && o == Este  = True
                     | buscarPeca x t == Just (Peca (Rampa Este) a)  && o == Oeste = True
                     | buscarPeca x t == Just (Peca (Rampa Sul) a)   && o == Norte = True
                     | buscarPeca x t == Just (Peca (Rampa Norte) a) && o == Sul   = True
                     | otherwise = False


{- | A função oriEste devolve a posição da seguinte peça do caminho, a orientação que o caminho toma ao entrar nesta e a altura atualizada, quando a orientação do caminho ao entrar na peça do /input/ é Este. 

== Exemplo de utilização:
>>> oriEste (Peca (Rampa Oeste) 1) (2,1) 2
((3,1),Este,1)

== Caso de paragem:
>>> oriEste (Peca (Rampa Oeste) 1) (2,1) 3
((0,0),Sul,3) - a peça dada não é compatível com a altura, logo retorna parâmetros impossíveis de assumir para uma peça do caminho
-}

oriEste :: Maybe Peca -- ^ peça atual do caminho
        -> Posicao -- ^ posição da peça atual do caminho
        -> Altura -- ^ altura da peça anterior do caminho
        -> (Posicao,Orientacao,Altura) -- ^ triplo com os elementos descritos
oriEste (Just (Peca (Curva Este) a)) (c,l) h  = if h == a     then ((c,l+1),Sul,h)    else ((0,0),Sul,h)
oriEste (Just (Peca (Curva Sul) a)) (c,l) h   = if h == a     then ((c,l-1),Norte,h)  else ((0,0),Sul,h)
oriEste (Just (Peca (Rampa Este) a)) (c,l) h  = if h == a     then ((c+1,l),Este,h+1) else ((0,0),Sul,h)
oriEste (Just (Peca (Rampa Oeste) a)) (c,l) h = if (h-1) == a then ((c+1,l),Este,h-1) else ((0,0),Sul,h)
oriEste (Just (Peca Recta a)) (c,l) h         = if h == a     then ((c+1,l),Este,h)   else ((0,0),Sul,h)
oriEste _ (c,l) h                             = ((0,0),Sul,h)


{- | A função oriOeste é análoga à função oriEste, mas aplica-se quando a orientação do caminho ao entrar na peça do /input/ é Oeste. 

== Exemplo de utilização:
>>> oriOeste (Peca (Curva Norte) 0) (1,1) 0
((1,2),Sul,0)

== Caso de paragem:
>>> oriOeste (Peca (Curva Norte) 0) (1,1) 1
((0,0),Sul,1) - a peça dada não é compatível com a altura, logo retorna parâmetros impossíveis de assumir para uma peça do caminho
-}

oriOeste :: Maybe Peca -> Posicao -> Altura -> (Posicao,Orientacao,Altura)
oriOeste (Just (Peca (Curva Norte) a)) (c,l) h = if h == a     then ((c,l+1),Sul,h)     else ((0,0),Sul,h)
oriOeste (Just (Peca (Curva Oeste) a)) (c,l) h = if h == a     then ((c,l-1),Norte,h)   else ((0,0),Sul,h)
oriOeste (Just (Peca (Rampa Este) a)) (c,l) h  = if (h-1) == a then ((c-1,l),Oeste,h-1) else ((0,0),Sul,h)
oriOeste (Just (Peca (Rampa Oeste) a)) (c,l) h = if h == a     then ((c-1,l),Oeste,h+1) else ((0,0),Sul,h)
oriOeste (Just (Peca Recta a)) (c,l) h         = if h == a     then ((c-1,l),Oeste,h)   else ((0,0),Sul,h)
oriOeste _ (c,l) h                             = ((0,0),Sul,h)


{- | A função oriNorte é análoga à função oriEste, mas aplica-se quando a orientação do caminho ao entrar na peça do /input/ é Norte. 

== Exemplo de utilização:
>>> oriNorte (Peca Recta 2) (3,2) 2
((3,1),Norte,2)

== Caso de paragem:
>>> oriNorte (Peca Recta 2) (3,2) 1
((0,0),Sul,1) - a peça dada não é compatível com a altura, logo retorna parâmetros impossíveis de assumir para uma peça do caminho
-}

oriNorte :: Maybe Peca -> Posicao -> Altura -> (Posicao,Orientacao,Altura)
oriNorte (Just (Peca (Curva Norte) a)) (c,l) h = if h == a     then ((c+1,l),Este,h)    else ((0,0),Sul,h)
oriNorte (Just (Peca (Curva Este) a)) (c,l) h  = if h == a     then ((c-1,l),Oeste,h)   else ((0,0),Sul,h)
oriNorte (Just (Peca (Rampa Norte) a)) (c,l) h = if h == a     then ((c,l-1),Norte,h+1) else ((0,0),Sul,h)
oriNorte (Just (Peca (Rampa Sul) a)) (c,l) h   = if (h-1) == a then ((c,l-1),Norte,h-1) else ((0,0),Sul,h)
oriNorte (Just (Peca Recta a)) (c,l) h         = if h == a     then ((c,l-1),Norte,h)   else ((0,0),Sul,h)
oriNorte _ (c,l) h                             = ((0,0),Sul,h)


{- | A função oriSul é análoga à função oriEste, mas aplica-se quando a orientação do caminho ao entrar na peça do /input/ é Sul. 

== Exemplo de utilização:
>>> oriSul (Peca (Curva Oeste) 1) (2,1) 1
((3,1),Este,1)

== Caso de paragem:
>>> oriSul (Peca (Curva Oeste) 1) (2,1) 0
((0,0),Sul,0) - a peça dada não é compatível com a altura, logo retorna parâmetros impossíveis de assumir para uma peça do caminho
-}

oriSul :: Maybe Peca -> Posicao -> Altura -> (Posicao,Orientacao,Altura)
oriSul (Just (Peca (Curva Sul) a)) (c,l) h   = if h == a     then ((c-1,l),Oeste,h) else ((0,0),Sul,h)
oriSul (Just (Peca (Curva Oeste) a)) (c,l) h = if h == a     then ((c+1,l),Este,h)   else ((0,0),Sul,h)
oriSul (Just (Peca (Rampa Norte) a)) (c,l) h = if (h-1) == a then ((c,l+1),Sul,h-1) else ((0,0),Sul,h)
oriSul (Just (Peca (Rampa Sul) a)) (c,l) h   = if h == a     then ((c,l+1),Sul,h+1) else ((0,0),Sul,h)
oriSul (Just (Peca Recta a)) (c,l) h         = if h == a     then ((c,l+1),Sul,h)   else ((0,0),Sul,h)
oriSul _ (c,l) h                             = ((0,0),Sul,h)


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
atualizarTabuleiroTodo a (h1:t1) (h2:t2) = atualizarTabuleiroTodo (atualizarTabuleiro a h1 h2) t1 t2


{- | A função verificarTabuleiro retorna a lista das posições das peças do caminho e um Bool.

== Exemplos de utilização:
>>> verificarTabuleiro (2,2) Este [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 0 (2,2) [] 0
([(2,2),(3,2),(3,1),(2,1),(1,1),(1,2)],True)

>>> verificarTabuleiro (2,2) Este [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 0 (2,2) [] 0
([],False)
-}

verificarTabuleiro :: Posicao -- ^ posição de uma peça do caminho
                   -> Orientacao -- ^ orientação atual do percurso
                   -> Tabuleiro -- ^ tabuleiro a testar
                   -> Int -- ^ acumulador
                   -> Posicao -- ^ posição da peça de partida
                   -> [Posicao] -- ^ acumulador (lista) que armazena as posições das peças do caminho
                   -> Altura -- ^ altura inicial
                   -> ([Posicao],Bool) -- ^ duplo constituído pela lista das posições das peças do caminho e por um Bool
verificarTabuleiro (0,0) o l y c a h = ([],False)
verificarTabuleiro p o l y c a h | compPos p c && y /= 0 = (a,True)
                                 | o == Este  =  verificarTabuleiro (primeiro i) (segundo i) l (y+1) c (a++[p]) (terceiro i)
                                 | o == Oeste =  verificarTabuleiro (primeiro j) (segundo j) l (y+1) c (a++[p]) (terceiro j)
                                 | o == Norte =  verificarTabuleiro (primeiro m) (segundo m) l (y+1) c (a++[p]) (terceiro m)
                                 | o == Sul   =  verificarTabuleiro (primeiro n) (segundo n) l (y+1) c (a++[p]) (terceiro n)
                            where
                              i = oriEste  (buscarPeca p l) p h
                              j = oriOeste (buscarPeca p l) p h
                              m = oriNorte (buscarPeca p l) p h
                              n = oriSul   (buscarPeca p l) p h


{- | A função valTudoLava verifica se todas as peças do tabuleiro dado são do tipo lava.

== Exemplos de utilização:
>>> valTudoLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
True

>>> valTudoLava [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
False
-}

valTudoLava :: Tabuleiro -> Bool
valTudoLava [] = True
valTudoLava ([]:t1) = valTudoLava t1
valTudoLava ((Peca Lava _:t):t1) = valTudoLava (t:t1)
valTudoLava ((_:t):t1) = False


{- | A função tabuleiroLavaLinha cria uma linha constituída pelo número dado de peças do tipo lava.

== Exemplo de utilização:
>>> tabuleiroLavaLinha 3
[Peca Lava 0,Peca Lava 0,Peca Lava 0]
-}

tabuleiroLavaLinha :: Int -> [Peca]
tabuleiroLavaLinha n = replicate n (Peca Lava altLava)


{- | A função subtracaoTab retira ao tabuleiro original as peças pertencentes ao caminho e verifica se as restantes peças do tabuleiro são do tipo lava.

== Exemplos de utilização:
>>> subtracaoTab (2,2) Este [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 0 (2,2) [] 0
True

>>> subtracaoTab (2,2) Este [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0]] 0 (2,2) [] 0
False
-}

subtracaoTab :: Posicao -- ^ posição de uma peça do caminho
             -> Orientacao -- ^ orientação atual do percurso
             -> Tabuleiro -- ^ tabuleiro a testar
             -> Int -- ^ acumulador
             -> Posicao -- ^ posição da peça de partida
             -> [Posicao] -- ^ acumulador (lista) que armazena as posições das peças do caminho
             -> Altura -- ^ altura inicial
             -> Bool
subtracaoTab p o l y c a h = let 
                                pos = fst (verificarTabuleiro p o l y c a h)
                              in
                                valTudoLava (atualizarTabuleiroTodo l (tabuleiroLavaLinha (length pos)) pos)


{- | A função hdeP retorna a altura da peça dada.

== Exemplo de utilização:
>>> hdeP (Peca Recta 1)
1
-}

hdeP :: Maybe Peca -> Altura
hdeP (Just (Peca _ h)) = h


{- | A função hdePartida retorna a altura da peça de partida.

== Exemplo de utilização:
>>> hdePartida (1,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
1
-}

hdePartida :: Posicao -- ^ posição da peça de partida
           -> Tabuleiro -- ^ tabuleiro
           -> Altura -- ^ altura da peça de partida
hdePartida c l = hdeP(buscarPeca c l)


{- | A função tabRetangular verificar se o tabuleiro é retangular.

== Exemplos de utilização:
>>> tabRetangular [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
True

>>> tabRetangular [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
False
-}

tabRetangular :: Tabuleiro -> Bool
tabRetangular [] = True
tabRetangular [h] = True
tabRetangular (h:h1:t) | length h == length h1 = tabRetangular (h1:t)
                       | otherwise = False 


{- | A função valida verifica se um mapa é válido ou não.

== Exemplos de utilização:
>>> valida (Mapa ((3,3),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 2,Peca (Rampa Este) 2,Peca (Rampa Oeste) 2,Peca (Curva Este) 2,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) 1,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Oeste) 0,Peca (Rampa Este) 0,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]])
True

>>> valida (Mapa ((2,3),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 2,Peca (Rampa Este) 2,Peca (Rampa Oeste) 2,Peca (Curva Este) 2,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) 1,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca (Rampa Oeste) 0,Peca (Rampa Este) 0,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]])
False
-}

valida :: Mapa -> Bool
valida (Mapa(p,o) []) = False
valida (Mapa(p,o) t) | partidaDesce p t (hdePartida p t) o = tabRetangular t && posTabuleiro p t && snd(verificarTabuleiro p o t 0 p [] (1+hdePartida p t)) && rodeadoLava t && valLava t && subtracaoTab p o t 0 p [] (1+hdePartida p t)
                     | otherwise = tabRetangular t && posTabuleiro p t && snd(verificarTabuleiro p o t 0 p [] (hdePartida p t)) && rodeadoLava t && valLava t && subtracaoTab p o t 0 p [] (hdePartida p t)
