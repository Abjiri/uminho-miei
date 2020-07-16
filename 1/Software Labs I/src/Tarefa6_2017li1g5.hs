{-|
Module      : Tarefa6_2017li1g5
Description : Módulo da Tarefa 6 para LI1 17/18

Módulo para a realização da Tarefa 6 de LI1 em 2017/18.
-}
module Tarefa6_2017li1g5 where

import LI11718

t = [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]

{- | A função buscarPecaV1 vai ao tabuleiro buscar a peça na posição dada.

== Exemplo de utilização:
>>> buscarPecaV1 (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0, Peca (Curva Norte) 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
(Peca (Curva Norte) 0)
-}

{- | A função myMod devolve o resto da divisao de um double por 360.

== Exemplo de utilização:
>>> myMod 405
45.0
-}
myMod :: Double ->  Double
myMod x = ((x/360)-realToFrac(floor(x/360)))*360 

{- | A função buscarPecaV1 vai ao tabuleiro buscar a peça na posição dada.

== Exemplo de utilização:
>>> buscarPecaV1 (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0, Peca (Curva Norte) 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
(Peca (Curva Norte) 0)
-}
buscarPecaV1 :: Posicao -> Tabuleiro -> Peca
buscarPecaV1 (x,y) l  = (l !! (floor (realToFrac y))) !! (floor (realToFrac x))

{- | A função oriEnt devolve a orientação com que o carro entrou na peça em que está atualmente.

== Exemplo de utilização:
>>> oriEnt (2,1) (3,1)
Este
-}
oriEnt :: Posicao -> Posicao -> Orientacao --pos antiga, pos atual -> orientaçao que entra na peça
oriEnt (a,b) (x,y) | y == b-1 = Norte
                   | x == a+1 = Este
                   | y == b+1 = Sul
                   | x == a-1 = Oeste


{- | A função oriToPos devolve a posição da peça seguinte à peça em que o carro está no momento dado(no caso do historico só ter uma posição é dada a orientação inicial do mapa).

== Exemplo de utilização:
>>> oriToPos (2,1) Este [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
(3.0,1.0)
-}
oriToPos :: Posicao    -- ^ posição atual do carro
         -> Orientacao -- ^ orientação com que entrou na peça atual
         -> Tabuleiro  -- ^ tabuleiro
         -> Posicao
oriToPos (x,y) Este t = estePeca (buscarPecaV1 (x,y) t) (x,y)
oriToPos (x,y) Oeste t = oestePeca (buscarPecaV1 (x,y) t) (x,y)
oriToPos (x,y) Norte t = nortePeca (buscarPecaV1 (x,y) t) (x,y)
oriToPos (x,y) Sul t = sulPeca (buscarPecaV1 (x,y) t) (x,y)



{- | A função estePeca devolve a posição da peça seguinte à peça em que o carro está no momento dado, se a orientação com que entrou na peça é Este.

== Exemplo de utilização:
>>> estePeca (Peca (Curva Este) 0) (3,1)
(3.0,2.0)
-}
estePeca :: Peca -> Posicao -> Posicao 
estePeca (Peca (Curva Este) _) (x,y)  = (x,y+1)
estePeca (Peca (Curva Sul) _) (x,y)   = (x,y-1)
estePeca _  (x,y) = (x+1,y)


{- | A função oestePeca devolve a posição da peça seguinte à peça em que o carro está no momento dado, se a orientação com que entrou na peça é Oeste.

== Exemplo de utilização:
>>> oestePeca (Peca (Curva Oeste) 0) (3,1)
(3.0,0.0)
-}
oestePeca :: Peca -> Posicao -> Posicao
oestePeca (Peca (Curva Norte) _) (x,y)  = (x,y+1)
oestePeca (Peca (Curva Oeste) _) (x,y)  = (x,y-1)
oestePeca _  (x,y) = (x-1,y)

{- | A função nortePeca devolve a posição da peça seguinte à peça em que o carro está no momento dado, se a orientação com que entrou na peça é Norte.

== Exemplo de utilização:
>>> nortePeca (Peca (Curva Norte) 0) (3,1)
(4.0,1.0)
-}
nortePeca :: Peca -> Posicao -> Posicao
nortePeca (Peca (Curva Este) _) (x,y)  = (x-1,y)
nortePeca (Peca (Curva Norte) _) (x,y) = (x+1,y)
nortePeca _  (x,y) = (x,y-1)

{- | A função sulPeca devolve a posição da peça seguinte à peça em que o carro está no momento dado, se a orientação com que entrou na peça é Sul.

== Exemplo de utilização:
>>> sulPeca (Peca (Curva Oeste) 0) (3,1)
(4.0,1.0)
-}
sulPeca :: Peca -> Posicao -> Posicao
sulPeca (Peca (Curva Oeste) _) (x,y)  = (x+1,y)
sulPeca (Peca (Curva Sul) _) (x,y)    = (x-1,y)
sulPeca _  (x,y) = (x,y+1)



{- | A função oriSaida devolve a orientação com que o carro sai da peça em que está atualmente.

== Exemplos de utilização:
>>> oriSaida (3,1) (4,1)
Este
-}
oriSaida :: Posicao -- ^ posição atual do carro
         -> Posicao -- ^ posição da peça seguinte
         -> Orientacao
oriSaida (a,b) (x,y) | y ==(b-1) = Norte
                     | x ==(a+1) = Este
                     | y ==(b+1) = Sul
                     | x ==(a-1) = Oeste


{- | A função radsToGraus converte um angulo de radianos para graus.

== Exemplo de utilização:
>>> radsToGraus (pi/2)
90.0
-}
radsToGraus :: Double -> Double
radsToGraus x = x * (180/pi)

{- | A função direcionar devolve a ação que bot vai tomar.

== Exemplos de utilização:
>>> direcionar 0 (1,0) Sul 180
Acao {acelerar = False, travar = False, esquerda = False, direita = True, nitro = Nothing}
-}
direcionar :: Angulo      -- ^ direção do carro 
           -> Velocidade -- ^ velocidade do carro
           -> Orientacao -- ^ orientação com que o carro sai da peça atual
           -> Double     -- ^ k_roda
           -> Bool
           -> Int     
           -> Acao
direcionar d (vx,vy) Este  kr b i= esteAc d (vx,vy)  kr b i
direcionar d (vx,vy) Oeste kr b i= oesteAc d (vx,vy) kr b i
direcionar d (vx,vy) Sul   kr b i= sulAc d (vx,vy)   kr b i
direcionar d (vx,vy) Norte kr b i= norteAc d (vx,vy) kr b i


{- | A função esteAc devolve a ação que bot vai tomar, caso a orientação de saida da peça seja Este.

== Exemplos de utilização:
>>> esteAc 0 (1,0) 180
Acao {acelerar = True, travar = False, esquerda = False, direita = False, nitro = Nothing}
-}
esteAc :: Angulo     -- ^ direção do carro 
       -> Velocidade -- ^ velocidade do carro
       -> Double     -- ^ k_roda
       -> Bool
       -> Int
       -> Acao
esteAc d (vx,vy) kr b  i | (myMod d) < 6 || (myMod d) > 354 =  if b then Acao { acelerar = True, travar = False , esquerda = False, direita = False, nitro = Just i } 
                                                                    else Acao { acelerar = True, travar = False , esquerda = False, direita = False, nitro = Nothing}
                    
                         | (myMod d) > 0 && (myMod d) < 180 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                              then Acao { acelerar = False, travar  = True , esquerda = False, direita  = True, nitro  = Nothing } 
                                                              else Acao { acelerar = False, travar  = False , esquerda = False, direita  = True, nitro  = Nothing }
                    
                         | (myMod d) > 180 = if (abs vx,abs vy) > (0,0) && kr > 210
                                             then Acao { acelerar = False, travar  = True , esquerda = True, direita  = False, nitro  = Nothing } 
                                             else Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing }


{- | A função oesteAc devolve a ação que bot vai tomar, caso a orientação de saida da peça seja Oeste.

== Exemplos de utilização:
>>> oesteAc 0 (1,0) 180
Acao {acelerar = False, travar = False, esquerda = True, direita = False, nitro = Nothing}
-}
oesteAc :: Angulo     -- ^ direção do carro 
        -> Velocidade -- ^ velocidade do carro
        -> Double     -- ^ k_roda
        -> Bool
        -> Int
        -> Acao
oesteAc d (vx,vy) kr b i | (myMod d) > 174 && (myMod d) < 186 = if b then Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Just i } 
                                                                     else Acao { acelerar = True, travar = False , esquerda = False , direita = False, nitro = Nothing}
                     
                         | (myMod d) >= 0 && (myMod d) < 180 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                               then Acao { acelerar = False, travar  = True , esquerda = True, direita  = False, nitro  = Nothing } 
                                                               else Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing }
                     
                         | (myMod d) > 180 = if (abs vx,abs vy) > (0,0) && kr > 210
                                             then Acao { acelerar = False, travar  = True , esquerda = False, direita  = True, nitro  = Nothing } 
                                             else Acao { acelerar = False, travar  = False , esquerda = False, direita  = True, nitro  = Nothing }



{- | A função sulAc devolve a ação que bot vai tomar, caso a orientação de saida da peça seja Sul.

== Exemplos de utilização:
>>> sulAc 0 (1,0) 180
Acao {acelerar = False, travar = False, esquerda = False, direita = True, nitro = Nothing}
-}                  
sulAc :: Angulo     -- ^ direção do carro 
      -> Velocidade -- ^ velocidade do carro
      -> Double     -- ^ k_roda
      -> Bool
      -> Int
      -> Acao
sulAc d (vx,vy) kr b   i| (myMod d) > 264 && (myMod d) < 276 = if b then Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Just i } 
                                                                    else Acao { acelerar = True, travar = False , esquerda = False , direita = False, nitro = Nothing}
                    
                    | (myMod d) > 90  && (myMod d) < 270 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                           then Acao { acelerar = False, travar  = True , esquerda = True, direita  = False, nitro  = Nothing } 
                                                           else Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing }
                    
                    | (myMod d) > 270 || (myMod d) < 90 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                          then Acao { acelerar = False, travar  = True , esquerda = False, direita  = True, nitro  = Nothing } 
                                                          else Acao { acelerar = False, travar  = False , esquerda = False, direita  = True, nitro  = Nothing }

{- | A função norteAc devolve a ação que bot vai tomar, caso a orientação de saida da peça seja Norte.

== Exemplos de utilização:
>>> norteAc 0 (1,0) 180
Acao {acelerar = False, travar = False, esquerda = True, direita = False, nitro = Nothing}
-}   
norteAc :: Angulo     -- ^ direção do carro 
        -> Velocidade -- ^ direção do carro 
        -> Double     -- ^ k_roda
        -> Bool
        -> Int
        -> Acao
norteAc d (vx,vy) kr b i | (myMod d) > 84 && (myMod d) < 96 = if b then Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Just i } 
                                                                   else Acao { acelerar = True, travar = False , esquerda = False , direita = False, nitro = Nothing}
                     
                     | (myMod d) > 90  && (myMod d) < 270 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                            then Acao { acelerar = False, travar  = True , esquerda = False, direita  = True, nitro  = Nothing } 
                                                            else Acao { acelerar = False, travar  = False , esquerda = False, direita  = True, nitro  = Nothing }
                    
                     | (myMod d) > 270 || (myMod d) < 90 = if (abs vx,abs vy) > (0,0) && kr > 210
                                                           then Acao { acelerar = False, travar  = True , esquerda = True, direita  = False, nitro  = Nothing } 
                                                           else Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing }


{-|
Esta função serve para verificar se as duas peças seguintes são reta ou rampas, de forma a saber se se aplica nitro ou não.

== Exemplos de utilização:
≳>> dalheGas (Peca Recta 0) (Peca (Rampa Sul) 0)
True
-}
dalheGas :: Peca -> Peca -> Bool
dalheGas (Peca (Curva _) _) _ = False
dalheGas _ (Peca (Curva _) _) = False
dalheGas _ _ = True


{-|
Esta função serve de auxilio à função bot, que vai buscar os parametros necessários para a função direcionar.

== Exemplos de utilização:
≳>> botAux [(2,1)] Este (Carro {posicao = (2.5,1.5),direcao = 0,velocidade = (1,0)}) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 180 
Acao {acelerar = True, travar = False, esquerda = False, direita = False, nitro = Nothing}
-}
botAux :: [Posicao]  -- ^ histórico do carro 
       -> Orientacao -- ^ orientação inicial do mapa
       -> Carro     
       -> Tabuleiro  
       -> Double     -- ^ k_roda
       -> Int
       ->  Acao
botAux [] o (Carro {posicao = (x,y),direcao = d,velocidade = (vx,vy)}) t kr i = Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Nothing }
botAux [(a,b)] o (Carro {posicao = (x,y),direcao = d,velocidade   = (vx,vy)}) t kr i = direcionar d (vx,vy) (oriSaida (a,b) po) kr  nit  i
                                                                                        where
                                                                                          po  = (oriToPos (a,b) o t )
                                                                                          nit = (dalheGas (buscarPecaV1 po t) (buscarPecaV1 (oriToPos po (oriSaida (a,b) po) t ) t)) 
botAux (h:h1:t1) o (Carro {posicao = (x,y),direcao = d,velocidade = (vx,vy)}) t kr i = direcionar d (vx,vy) (oriSaida h pa) kr net i
                                                                                        where
                                                                                          pa = (oriToPos h (oriEnt h1 h) t)
                                                                                          net = (dalheGas (buscarPecaV1 pa t) (buscarPecaV1 (oriToPos pa (oriSaida h pa) t ) t))
{-|
Função usada para simular um /bot/ no jogo /Micro Machines/.
Em cada instante, dado o tempo decorrido, o estado do jogo
e o identificador do jogador, toma uma ação.
1.0 Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,3.01), direcao = -90.0, velocidade = (0.0,-0.5)}], nitros = [5.0], historico = [[]]} 0

== Exemplos de utilização:
≳>> bot 1.0 Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,3.01), direcao = -90.0, velocidade = (0.0,-0.5)}], nitros = [5.0], historico = [[]]} 0
Acao {acelerar = True, travar = False, esquerda = False, direita = False, nitro = Nothing}
-}
bot :: Tempo  -- ^ tempo decorrido desde a última decisão
    -> Jogo   -- ^ estado atual do jogo
    -> Int    -- ^ identificador do jogador dentro do estado
    -> Acao   -- ^ a decisão tomada pelo /bot/
bot t (Jogo {mapa = (Mapa (p,o) m) ,pista = (Propriedades {k_atrito = ka,k_pneus = kp,k_acel = kl,k_peso = kg,k_nitro = kn ,k_roda = kr}),carros = c,nitros = l ,historico = h}) i = botAux ((!!) h i) o ((!!) c i) m kr i


