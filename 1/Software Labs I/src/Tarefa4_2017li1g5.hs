    
{-|
Module      : Tarefa4_2017li1g5
Description : Módulo da Tarefa 4 para LI1 17/18
Copyright: Hugo Cardoso <a85006@alunos.uminho.pt>         
           João Cunha <a84775@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 de LI1 em 2017/18.
-}

module Tarefa4_2017li1g5 where

import LI11718
import Data.Maybe

{-| Conjunto de testes usados para verificar a funcionalidade desta tarefa.-}
testesT4 :: [(Tempo,Jogo,Acao)]
testesT4 = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19]

{- | Primeiro teste - capacidade de rodagem do carro para a esquerda. -}
t1 = (1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0.5, k_acel = 4, k_peso = 2, k_nitro = 15, k_roda = 180}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.9,0.9)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = True, direita  = False, nitro  = Nothing })
{- | Segundo teste - força de aceleração do nitro, força de atrito e força dos pneus. -}
t2 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2,1.50), direcao = 405, velocidade = (1,0)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Terceiro teste - força do peso (o carro encontra-se numa rampa) e ângulo do atrito. -}    
t3 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (3.5,2.01), direcao = -360, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Quarto teste - força de aceleração do nitro e ângulo do atrito diferente. -}
t4 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 360, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Quinto teste - outro ângulo do atrito (k_pneus) -}
t5 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 180, velocidade = (-1,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Sexto teste - todos os parâmetros da ação ativos. -}
t6 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (3.5,2.51), direcao = -90, velocidade = (0,1)}], nitros  = [5] , historico  = [[(2,1)]] },Acao { acelerar = True, travar  = True , esquerda = True, direita  = True, nitro  = Just 0 })
{- | Sétimo teste - acelerar, travar e rodar para a esquerda. -}
t7 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = -90, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = True , esquerda = True, direita  = False, nitro  = Nothing })
{- | Oitavo teste - acelerar e travar simultaneamente (devem cancelar-se). -}
t8 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = -90, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = True , esquerda = False, direita  = False, nitro  = Nothing })
{- | Nono teste - acelerar apenas (testar k_pneus). -}
t9 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = -90, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Décimo teste - aplicar nitro corretamente com um certo ângulo. -}
t10 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 270, velocidade = (-1,-1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Décimo Primeiro teste - aplicar nitro corretamente com outro ângulo. -}
t11 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 45, velocidade = (-1,-1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Decimo Segundo teste - força de atrito. -}
t12 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = -45, velocidade = (-1,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Décimo Terceiro teste - força de aceleração com direção positiva. -}
t13 = (1,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0, k_pneus = 0, k_acel = 0.2, k_peso = 0, k_nitro = 0, k_roda = 45}, carros = [Carro {posicao = (2.01,1.01), direcao = 45, velocidade = (0.5,0.5)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Décimo Quarto teste - força de aceleração com direção negativa. -}
t14 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = -37, velocidade = (0,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Nothing })
{- | Décimo Quinto teste - direção superior a 180 graus. -}
t15 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 165, velocidade = (-1,-1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = False, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Décimo Sexto teste - direção inferior a 180 graus. -}
t16 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [Carro {posicao = (2.5,1.51), direcao = 20, velocidade = (-1,1)}], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = False, direita  = False, nitro  = Just 0 })
{- | Décimo Sétimo teste - direção igual a 270 graus. -}
t17 = (0.5,Jogo { mapa  = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades { k_atrito  = 0.5, k_pneus = 0.5, k_acel = 0.5, k_peso = 2, k_nitro = 2, k_roda = 180}, carros = [(Carro {posicao = (2.5,1.51), direcao = 270, velocidade = (-1,-1)})], nitros  = [5] , historico  = [[]] },Acao { acelerar = True, travar  = False , esquerda = True, direita  = False, nitro  = Just 0 })
{- | Décimo Oitavo teste - força da gravidade e tempo de nitro inferior ao tempo da ação. -}
t18 = (1.0,Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,2.01), direcao = -90.0, velocidade = (0.0,0.5)}], nitros = [0.5], historico = [[]]},Acao {acelerar = False, travar = False, esquerda = False, direita = False, nitro = Just 0})
{- | Décimo Nono teste - testar o histórico (já tem a posição) e a força do peso -}
t19 = (1.0,Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,3.01), direcao = -90.0, velocidade = (0.0,-0.5)}], nitros = [5.0], historico = [[(3,3)]]},Acao {acelerar = False, travar = False, esquerda = False, direita = False, nitro = Nothing})


{- | A função buscarPecaV3 vai ao tabuleiro buscar a peça na posição dada.

== Exemplos de utilização:
>>> buscarPecaV3 (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0, Peca (Curva Norte) 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0]]
(Peca (Curva Norte) 0)

-}
buscarPecaV3 :: Ponto -> Tabuleiro ->  Peca
buscarPecaV3 (a,b) l = (l !! (floor (realToFrac b))) !! (floor (realToFrac a))
                   
{- | Para esta tarefa define-se o data Point de forma a usar coordenadas Polar (distância à origem e ângulo do respectivo vector com o eixo horizontal).-}
data Point = Polar Double Double
            deriving (Show,Eq)



{- | A função posx calcula a distância de um ponto ao eixo vertical. Nesta tarefa vai ser usada para devolver a componente horizontal de um vetor.

== Exemplo de utilização:
>>> posx (Polar 1 0)
1
-}
posx :: Point -> Double
posx (Polar n a) = n*cos(a)


{- | A função posy calcula a distância de um ponto ao eixo horizontal. Nesta tarefa vai ser usada para devolver a componente vertical de um vetor.

== Exemplo de utilização:
>>> posy (Polar 1 0)
0
-}
posy :: Point -> Double
posy (Polar x y) = x*sin(y)

{- | A função norma calcula a norma do vetor velocidade.

== Exemplo de utilização:
>>> norma (2,2.5)
3.2015621187164243
-}
norma :: Velocidade -> Double
norma (x1,y1) = sqrt(x1^2 + y1^2)


{- | A função grausToRads converte um ângulo de graus para radianos.

== Exemplo de utilização:
>>> grausToRads 90
1.5707963267948966
-}
grausToRads :: Double -> Double
grausToRads x = x * (pi/180)

{- | A função radsToGraus converte um ângulo de radianos para graus.

== Exemplo de utilização:
>>> radsToGraus (pi/2)
90.0
-}
radsToGraus :: Double -> Double
radsToGraus x = x * (180/pi)

{- | A função myMod devolve o resto da divisao de um double por 360.

== Exemplo de utilização:
>>> myMod 405
45.0
-}
myMod :: Double ->  Double
myMod x = ((x/360)-realToFrac(floor(x/360)))*360    


{- | A função angVelocidade devolve o angulo do vetor velocidade em radianos no contexto deste projeto. Quando a velocidade é (0,0) nao faz sentido ter angulo daí o caso do (-91), que neste contexto vai ser um valor absurdo e vai ser usado posteriormente para caso de paragem.

== Exemplo de utilização:
>>> angVelocidade (1,1)
5.497787143782138
-}
angVelocidade :: Velocidade -> Double
angVelocidade (x,y) | x > 0 && y > 0 = 2*pi+(atan (-y/x))
                    | x > 0 && y < 0 = atan (-y/x)
                    | x < 0 && y > 0 = pi + atan(-y/x)
                    | x < 0 && y < 0 = pi + atan(-y/x)
                    | x < 0 && y == 0 = pi
                    | x > 0 && y == 0 = 0
                    | x == 0 && y < 0 = pi/2
                    | x == 0 && y > 0 = (3*pi)/2
                    | x == 0 && y == 0 = (-91)

{- | A função vAtrito aplica a força de atrito à velocidade do carro dado.

== Exemplo de utilização:
>>> vAtrito (Carro {posicao = (2.5,1.5),direcao = 0,velocidade = (1,0)}) 0.5 1 (2,0)
Carro {posicao = (2.5,1.5), direcao = 0.0, velocidade = (0.0,0.0)}
-}
vAtrito :: Carro -- ^ Carro dado
        -> Double -- ^ k_atrito
        -> Tempo -- ^ tempo da atualização
        -> Velocidade -- ^ velocidade inicial
        -> Carro 
vAtrito (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) a t (vx1,vy1) = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx -(a*vx1)*t),(vy-(a*vy1)*t))})



{- | A função atlPneus aplica a força dos pneus à velocidade do carro dado.

== Exemplo de utilização:
>>> atlPneus (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) 0.5 1 
Carro {posicao = (2.5,1.5), direcao = 90.0, velocidade = (0.5,-6.123233995736766e-17)}
-}
atlPneus :: Carro -- ^ carro dado
         -> Double -- ^ k_pneus
         -> Tempo -- ^ tempo da atualização
         -> Carro
atlPneus (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) kp t | angVelocidade (vx,vy) == (-91) = (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) 
                                                                         | (myMod o) <= 180 && radsToGraus (angVelocidade (vx,vy)) >= (myMod o) && radsToGraus (angVelocidade (vx,vy)) <= (180+(myMod o))  = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar asa menos))*t),(vy-((posy (Polar asa menos))*t))))})
                                                                         | (myMod o) <= 180 && (radsToGraus (angVelocidade (vx,vy)) <  (myMod o) || radsToGraus (angVelocidade (vx,vy)) > (180+(myMod o))) = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar asa mais))*t), (vy-((posy (Polar asa mais ))*t))))})
                                                                         | (myMod o) > 180 && (radsToGraus (angVelocidade (vx,vy)) >= (myMod o) || radsToGraus (angVelocidade (vx,vy))<= ((myMod o)-180))  = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar asa menos))*t),(vy-((posy (Polar asa menos))*t))))})
                                                                         | (myMod o) > 180 && radsToGraus (angVelocidade (vx,vy)) < (myMod o) && radsToGraus (angVelocidade (vx,vy)) >=  ((myMod o)-180)   = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar asa mais))*t), (vy-((posy (Polar asa mais ))*t))))})
                                                                        where
                                                                          asa = (abs(sin(abs((grausToRads o)-angVelocidade (vx,vy))))*kp*(norma (vx,vy)))
                                                                          menos = ((grausToRads o)-pi/2)
                                                                          mais = ((grausToRads o)+pi/2)


{- | A função atlAceleracoes aplica a força de aceleração (e/ou travagem) à velocidade do carro dado.

== Exemplo de utilização:
>>> atlAceleracoes (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) [True,False] [0.5,0.5] 0 0 1
Carro {posicao = (2.5,1.5), direcao = 90.0, velocidade = (1.0,-0.5)}
-}
atlAceleracoes :: Carro -- ^ carro dado
               -> [Bool] -- ^ lista formada por dois bool o da ação acelerar e travar
               -> [Double] -- ^ lista com o k_acel duas vezes na lista ou seja [k_acel,k_acel]
               -> Double -- ^ neste parametro o valor inicial dado é 0 e no final da execução desta função vai ser a soma(ou subtração) dos k_acel que depois vai ser usado para atualizar a velocidade 
               -> Int -- ^  valor para indicar caso especifico do bool travar
               -> Tempo -- ^ tempo da atualização
               -> Carro
atlAceleracoes (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) [] [] a b w = (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar a (grausToRads o)))*w)),(vy-((posy (Polar a (grausToRads o)))*w)))})
atlAceleracoes (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) (h:t) (h1:t1) a b w | b == 1 && h == True = atlAceleracoes (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) t t1 (a-h1) (b+1) w
                                                                                              | h == True = atlAceleracoes (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) t t1 (a+h1) (b+1) w
                                                                                              | otherwise = atlAceleracoes (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) t t1 a (b+1) w
                                                                                              
{- | A função atlGravidade aplica a força de gravidade à velocidade do carro dado, dependendo se o carro está numa rampa ou não.

== Exemplo de utilização:
>>> atlGravidade (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) 0.5 (Peca (Rampa Sul) 0) 1
Carro {posicao = (2.5,1.5), direcao = 90.0, velocidade = (1.0,-0.5)}
-}
atlGravidade :: Carro -- ^ carro dado
             -> Double -- ^ k_peso
             -> Peca -- ^ peça onde o carro está
             -> Tempo -- ^ tempo da atualizaçao
             -> Carro 
atlGravidade (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) k_peso (Peca (Rampa Sul) _) t = Carro {posicao = (x,y),direcao = o,velocidade = (vx,(vy-k_peso*t))}
atlGravidade (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) k_peso (Peca (Rampa Norte) _) t = Carro {posicao = (x,y),direcao = o,velocidade = (vx,(vy+k_peso*t))}
atlGravidade (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) k_peso (Peca (Rampa Oeste) _) t = Carro {posicao = (x,y),direcao = o,velocidade = ((vx+k_peso*t),vy)}
atlGravidade (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) k_peso (Peca (Rampa Este) _) t = Carro {posicao = (x,y),direcao = o,velocidade = ((vx-k_peso*t),vy)}
atlGravidade (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) k_peso _ t = Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}

{- | A função atldirecao atualiza a direção do carro dado.

== Exemplo de utilização:
>>> atldirecao 1 (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) True False 180
Carro {posicao = (2.5,1.5), direcao = 270.0, velocidade = (1.0,0.0)}
-}
atldirecao :: Tempo -- ^ tempo da atualizaçao
           -> Carro -- ^ carro dado
           -> Bool -- ^ bool da ação Esquerda
           -> Bool -- ^ bool da ação Direita
           -> Double -- ^ k_roda
           -> Carro
atldirecao t (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})  e d k | e == True && d == True = (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})
                                                                               | e == True = (Carro {posicao = (x,y),direcao = (o+k*t),velocidade = (vx,vy)}) 
                                                                               | d == True = (Carro {posicao = (x,y),direcao = (o-k*t),     velocidade = (vx,vy)}) 
                                                                               | otherwise = (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) 

{- | A função atlhistorico atualiza o histórico das posições percorridas pelo carro dado.

== Exemplo de utilização:
>>> atlhistorico (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) []
[(2,1)]
-}
atlhistorico :: Carro -> [Posicao] -> [Posicao]
atlhistorico (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) [] = [(floor x,floor y)]
atlhistorico (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) ((h,h1):t) = if  (floor x, floor y) == (h,h1)  then (h,h1):t else (fromIntegral (floor x),fromIntegral (floor y)):(h,h1):t

{- | A função atlacelNitro aplica o nitro, caso seja suposto, à velocidade do carro dado.

== Exemplo de utilização:
>>> atlacelNitro (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)}) 5 5 10 True
Carro {posicao = (2.5,1.5), direcao = 90.0, velocidade = (1.000000000000003,-50.0)}
-}
atlacelNitro :: Carro -- ^ carro dado
             -> Tempo -- ^ tempo da atualização
             -> Tempo -- ^ tempo de nitro disponível
             -> Double -- ^ k_nitro
             -> Bool -- ^ bool da ação nitro
             -> Carro
atlacelNitro (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) t n kn False = (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})
atlacelNitro (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) t n kn True  = if n < t 
                                                                                       then (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar kn (grausToRads o)))*n)),(vy-((posy (Polar kn (grausToRads o)))*n)))})
                                                                                       else (Carro {posicao = (x,y),direcao = o,velocidade = ((vx+((posx (Polar kn (grausToRads o)))*t)),(vy-((posy (Polar kn (grausToRads o)))*t)))})


{- | A função atualizarTNitro atualiza o tempo de nitro do carro dado.

== Exemplo de utilização:
>>> atualizarTNitro 5 (Just 0) 4
0.0
-}
atualizarTNitro :: Tempo -- ^ tempo da atualização
                -> Maybe Int -- ^ Maybe Int da ação nitro
                -> Tempo -- ^ tempo de nitro disponível do carro
                -> Tempo
atualizarTNitro t (Just _) a = if t > a then 0 else (a-t)
atualizarTNitro t Nothing a = a

{- | A função insere , substitui um elemento de uma lista pelo elemento dado na posição dada.

== Exemplo de utilização:
>>> insere 5 [1,3] 2
[1,3,5]
-}
insere :: a -> [a] -> Int -> [a]        
insere x [] _ = [x]
insere x (h:t) 0 = x:t
insere x (h:t) i = h:insere x t (i-1)


{- | A função pecaAtual vai ao tabuleiro buscar a peça em que o carro dado está.

== Exemplo de utilização:
>>> pecaAtual [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)})
Peca Recta 0
-}
pecaAtual :: Tabuleiro -> Carro -> Peca
pecaAtual t (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) = buscarPecaV3 (x,y) t


{- | A função velCarro devolve a velocidade do carro dado.

== Exemplo de utilização:
>>> velCarro (Carro {posicao = (2.5,1.5),direcao = 90,velocidade = (1,0)})
(1.0,0.0)
-}
velCarro :: Carro -> Velocidade
velCarro Carro {posicao = (x,y), direcao = o, velocidade = (vx,vy)} = (vx,vy)

{- | A função atualiza ,​ atualiza​ ​o ​estado​ do​ jogo, dado um período de tempo, o estado atual do jogo, o identificador de um jogador, e a ação efetuada por esse​ ​jogador.

== Exemplo de utilização:
>>> atualiza 1.0 Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,3.01), direcao = -90.0, velocidade = (0.0,-0.5)}], nitros = [5.0], historico = [[]]} 0 Acao {acelerar = False, travar = False, esquerda = False, direita = False, nitro = Nothing}
Jogo {mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades {k_atrito = 0.0, k_pneus = 0.0, k_acel = 0.0, k_peso = 0.2, k_nitro = 0.0, k_roda = 0.0}, carros = [Carro {posicao = (3.5,3.01), direcao = -90.0, velocidade = (0.0,-0.5)}], nitros = [5.0], historico = [[(3,3)]]}
-}    
atualiza :: Tempo -> Jogo -> Int -> Acao -> Jogo
atualiza t (Jogo {mapa = (Mapa (p,o) m) ,pista = (Propriedades {k_atrito = ka,k_pneus = kp,k_acel = kl,k_peso = kg,k_nitro = kn ,k_roda = kr}),carros = c,nitros = l ,historico = h}) i (Acao {acelerar = a ,travar = b ,esquerda = e,direita = d,nitro = n}) = (Jogo {mapa = (Mapa(p,o) m)  ,pista = (Propriedades {k_atrito = ka,k_pneus = kp,k_acel = kl,k_peso = kg,k_nitro = kn ,k_roda = kr}),carros = z,nitros = (insere (atualizarTNitro t n ((!!) l i)) l i),historico = (insere (atlhistorico ((!!) c i) ((!!) h i)) h i)})
                                                where
                                                    z = insere (atldirecao t (atlacelNitro  (atlAceleracoes (atlGravidade (vAtrito (atlPneus ((!!) c i) kp t ) ka t (velCarro ((!!) c i)))  kg (pecaAtual m ((!!) c i)) t ) [a,b] [kl,kl] 0 0 t) t ((!!) l i) kn (isJust n)) e d kr ) c i


