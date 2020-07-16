{-|
Module: Tarefa3_2017li1g5
Description: Módulo correspondente à resolução da tarefa 3 do projeto de LI1
Copyright: Hugo Cardoso <a85006@alunos.uminho.pt>         
           João Cunha <a84775@alunos.uminho.pt>

Um módulo contendo as funções necessárias para implementar a tarefa 3 do projeto de LI1.
-}

module Tarefa3_2017li1g5 where

import LI11718

{- | Para esta tarefa, convenciona-se que uma linha é um par de pontos.-}
type Linha = (Ponto,Ponto)
{- | Para esta tarefa, convenciona-se que uma parede é um par de pares de inteiros.-}
type Parede = ((Int,Int),(Int,Int))

{- | Conjunto de caminhos para testar a funcionalidade desta tarefa. -}
testesT3 :: [(Tabuleiro,Tempo,Carro)]
testesT3 = [t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11]

{- | Primeiro teste. -}
t1 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],3,Carro {posicao = (6.5,3.5), direcao = 45, velocidade = (1,1)})
{- | Segundo teste. -}
t2 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],3,Carro {posicao = (6.5,3.5), direcao = 45, velocidade = (1,-1)})
{- | Terceiro teste. -}
t3 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],15,Carro {posicao = (6.8,3.3), direcao = 45, velocidade = (0.5,1)})
{- | Quarto teste. -}
t4 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],15,Carro {posicao = (6.8,3.3), direcao = 45, velocidade = (0.18,1)})
{- | Quinto teste. -}
t5 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],2,Carro {posicao = (6.5,3.5), direcao = 45, velocidade = (-1,-1)})
{- | Sexto teste. -}
t6 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],30,Carro {posicao = (6.5,3.5), direcao = 45, velocidade = (-1,0)})
{- | Sétimo teste. -}
t7 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca (Curva Norte) (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],5,Carro {posicao = (6.5,3.5), direcao = 45, velocidade = (-1,1)})
{- | Oitavo teste. -}
t8 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 1,Peca (Rampa Oeste) 0,Peca (Rampa Este) 0,Peca (Rampa Oeste) 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Rampa Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],3,Carro {posicao = (3.8,2.5), direcao = 45, velocidade = (-1.4,-1)})
{- | Nono teste. -}
t9 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 1,Peca (Rampa Oeste) 0,Peca (Rampa Este) 0,Peca (Rampa Oeste) 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Rampa Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],3,Carro {posicao = (3.8,2.5), direcao = 45, velocidade = (0,-1)})
{- | Décimo teste. -}
t10 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca (Rampa Oeste) (-1),Peca (Rampa Este) (-1),Peca (Rampa Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca Recta (-1),Peca (Curva Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] ,4,Carro {posicao = (4.8,1.2), direcao = 45, velocidade = (1,0.5)})
{- | Décimo primeiro teste. -}
t11 = ([[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca (Rampa Oeste) (-1),Peca (Rampa Este) (-1),Peca (Rampa Oeste) (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca Recta (-1),Peca (Curva Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]],8,Carro {posicao = (4.8,1.2), direcao = 45, velocidade = (1,0.159)})


{- | A função posSemIntersetar retorna a posição final do carro, assumindo que nunca há colisões.

== Exemplo de utilização:
>>> posSemIntersetar (2.5,1.5) (1,1) 2
(4.5,3.5)
-}

posSemIntersetar :: Ponto -> Velocidade -> Tempo -> Ponto
posSemIntersetar (a,b) (x,y) r = ((a+x*r),(b+y*r))


{- | A função buscarPecaV2 devolve a peça do tabuleiro na posição dada.

== Exemplos de utilização:
>>> buscarPecaV2 (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Peca Recta 0

>>> buscarPecaV2 (-1,-1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Peca Lava (-1) - peça que representa ricochete

>>> buscarPecaV2 (-1,-1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Peca Lava (-2) - peça que representa destruição
-}

buscarPecaV2 :: Ponto -> Tabuleiro -> Velocidade -> Peca
buscarPecaV2 (-50,-50) l (vx,vy) = (Peca Lava (-2))
buscarPecaV2 (-1,-1) l (vx,vy) = (Peca Lava (-1))
buscarPecaV2 (x,y) l (vx,vy) | y == realToFrac (floor y) = if vy < 0 then (l !! (floor (y-1))) !! (floor x) else (l !! (floor y)) !! (floor x) 
                             | x == realToFrac (floor x) = if vx < 0 then (l !! (floor y)) !! (floor (x-1)) else (l !! (floor y)) !! (floor x)
                             | otherwise = (l !! (floor y)) !! (floor x)


{- | A função buscarPecaV2 devolve a peça do tabuleiro na posição dada.

== Exemplo de utilização:
>>> buscarPecaV1 (2,1) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
Peca Recta 0
-}
buscarPecaV1 :: Ponto -> Tabuleiro -> Peca
buscarPecaV1 (-50,-50) l = (Peca Lava (-2))
buscarPecaV1 (-1,-1) l = (Peca Lava (-1))
buscarPecaV1 (x,y) l  = (l !! (floor y)) !! (floor x)


{- | A função vetorCarro devolve uma linha constituída pelo ponto dado e por um ponto que resulta da soma das coordenadas da ponto dado com as da velocidade dada.

== Exemplo de utilização:
>>> vetorCarro (1,1) (2.5,1.5)
((2.5,1.5),(3.5,2.5))
-}

vetorCarro :: Velocidade -> Ponto -> Linha
vetorCarro (vx,vy) (a,b) = ((a,b),(a+vx,b+vy))


{- | A função pontoGeral devolve um par de inteiros que são a posição da peça à qual pertence a posição dada.

== Exemplo de utilização:
>>> pontoGeral (2.7,1.4)
(2,1)
-}

pontoGeral :: Ponto -> Velocidade -> (Int,Int)
pontoGeral (x,y) (vx,vy) | y == realToFrac (floor y) = if vy < 0 then (floor x , floor y-1) else (floor x , floor y)
                         | x == realToFrac (floor x) = if vx < 0 then (floor x-1 , floor y) else (floor x , floor y)
                         | otherwise = (floor x , floor y)
                         
{- | A função pontoGeralFrac devolve um ponto, a posição da peça à qual pertence a posição dada.

== Exemplo de utilização:
>>> pontoGeralFrac (2.7,1.4)
(2.0,1.0)
-}

pontoGeralFrac :: Ponto -> Velocidade -> Ponto
pontoGeralFrac (x,y) (vx,vy) | y == realToFrac (floor y) = if vy < 0 then (realToFrac(floor x) , realToFrac(floor y-1)) else (realToFrac(floor x) ,realToFrac (floor y))
                             | x == realToFrac (floor x) = if vx < 0 then (realToFrac(floor x-1) , realToFrac(floor y)) else (realToFrac(floor x) ,realToFrac (floor y))
                             | otherwise = (realToFrac(floor x) ,realToFrac (floor y))



{- | A função paredes devolve uma lista de paredes, que são os pares dos pontos extremos de cada limite da peça dada. Isto é, representam as paredes da peça.

== Exemplos de utilização:
>>> paredes (Peca Recta 0) (2,1)
[((2,1),(3,1)),((3,1),(3,2)),((3,2),(2,2)),((2,2),(2,1))]

>>> paredes (Peca (Curva Norte) 1) (2,1)
[((3,1),(3,2)),((3,2),(2,2)),((2,2),(3,2))]
-}

paredes :: Peca -> (Int,Int) -> [Parede]    
paredes (Peca (Curva Este) _)  (x,y) = [((x+1,y+1),(x,y+1)),((x,y+1),(x,y)),((x,y),(x+1,y+1))]
paredes (Peca (Curva Sul) _)   (x,y) = [((x,y),(x+1,y)),((x,y+1),(x,y)),((x+1,y),(x,y+1))]
paredes (Peca (Curva Oeste) _) (x,y) = [((x,y),(x+1,y)),((x+1,y),(x+1,y+1)),((x+1,y+1),(x,y))]
paredes (Peca (Curva Norte) _) (x,y) = [((x+1,y),(x+1,y+1)),((x+1,y+1),(x,y+1)),((x,y+1),(x+1,y))]
paredes _ (x,y) = [((x,y),(x+1,y)),((x+1,y),(x+1,y+1)),((x+1,y+1),(x,y+1)),((x,y+1),(x,y))]


{- | A função maybeIntersection devolve o ponto de interseção das retas que são possíveis traçar com as linhas dadas.

== Exemplos de utilização:

>>> maybeIntersection ((1,1),(3,3)) ((3,1),(1,3))
(2.0,2.0)

>>> maybeIntersection ((1,1),(3,3)) ((2,2),(4,4))
(-100.0,-100.0) - Quando não intersetam, devolve este ponto que é impossível e, portanto, é usado como caso de referência.
-}

maybeIntersection :: Linha -> Linha -> Ponto
maybeIntersection ((ax, ay), (bx, by)) ((px, py), (qx, qy)) =
  let (pqDX, abDX) = (px - qx, ax - bx)
      (pqDY, abDY) = (py - qy, ay - by)
      determinant = abDX * pqDY - abDY * pqDX
      f pq ab =
        ((((ax * by) - (ay * bx)) * pq) - 
         (((px * qy) - (py * qx)) * ab)) /
        determinant
  in case determinant of
       0 -> (-100,-100)
       _ -> (f pqDX abDX, f pqDY abDY)


{- | A função intersetarVetorParede devolve a lista dos pontos de interseção da reta que contém os pontos da linha dada com as paredes da peça em questão.

== Exemplo de utilização:
>>> intersetarVetorParede ((2,1),(3,2)) [((2,1),(3,1)),((3,1),(3,2)),((3,2),(2,2)),((2,2),(2,1))]
[(2.0,1.0),(3.0,2.0),(3.0,2.0),(2.0,1.0)]
 -}

intersetarVetorParede :: Linha -> [Parede] -> [Ponto]
intersetarVetorParede l [] = []
intersetarVetorParede l (((x,y),(a,b)):t)  = if maybeIntersection l ((realToFrac x,realToFrac y),(realToFrac a,realToFrac b)) == (-100,-100)
                                             then intersetarVetorParede l t 
                                             else (maybeIntersection l ((realToFrac x,realToFrac y),(realToFrac a,realToFrac b))) : intersetarVetorParede l t


{- | A função verificarPontos verifica que pontos da lista de pontos recebida é que fazem parte da peça cuja posição é dada.

== Exemplos de utilização:
>>> verificarPontos [(2.0,1.0),(3.0,2.0),(3.0,2.0),(2.0,1.0)] (2,1)
[(2.0,1.0),(3.0,2.0),(3.0,2.0),(2.0,1.0)]

>>> verificarPontos [(2.0,1.0),(3.0,1.5),(4.0,2.0),(2.0,1.0)] (2,1)
[(2.0,1.0),(3.0,1.5),(2.0,1.0)]
 -}

verificarPontos :: [Ponto] -> (Int,Int) -> [Ponto]
verificarPontos [] (a,b) = []
verificarPontos ((x,y):t) (a,b) = if x >= (realToFrac a) && x <= (realToFrac (a+1)) && y >= (realToFrac b) && y <= (realToFrac (b+1)) then (x,y):verificarPontos t (a,b) else verificarPontos t (a,b)


{- | A função pontoIntersecao escolhe o ponto da lista de pontos recebida que resulta da interseção do vetor que parte do ponto dado com a parede da peça à qual pertence o ponto dado.

== Exemplo de utilização:
>>> pontoIntersecao [(2.0,1.0),(3.0,2.0),(3.0,2.0),(2.0,1.0)] (2.5,1.5) (1,1)
(3.0,2.0)
-}
  
pontoIntersecao :: [Ponto] -> Ponto -> Velocidade -> Ponto
pontoIntersecao [] p v = (-101,-101)
pontoIntersecao ((x,y):[]) p v = (x,y)
pontoIntersecao ((x,y):t) (a,b) (vx,vy) | vx == 0 && vy == 0 = (a,b)
                                        | vx == 0 && vy > 0 = if (x < (a+0.01) && x > (a-0.01))  && y > b then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx == 0 && vy < 0 = if (x < (a+0.01) && x > (a-0.01))  && y < b then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx < 0 && vy == 0 = if  x < a && (y > (b-0.01) && y < (b+0.01)) then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx > 0 && vy == 0 = if  x > a && (y > (b-0.01) && y < (b+0.01)) then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx > 0 && vy > 0 = if  x > a && y > b then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx < 0 && vy < 0 = if  x < a && y < b then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx < 0 && vy > 0 = if  x < a && y > b then (x,y) else pontoIntersecao t (a,b) (vx,vy)
                                        | vx > 0 && vy < 0 = if  x > a && y < b then (x,y) else pontoIntersecao t (a,b) (vx,vy)


{- | A função qualParede devolve a posição da peça seguinte, para onde o carro vai avançar, e um inteiro que representa a zona da peça em que o carro sai desta.

== Exemplos de utilização:
>>> qualParede (Peca Recta 0) (2,1) (2,1)
((1.0,0.0),4) - o 4 representa um canto da peça.

>>> qualParede (Peca Recta 0) (2,1) (2.5,1)
((2.0,0.0),5) - o 5 representa o topo da peça.

>>> qualParede (Peca Recta 0) (2,1) (3,1.5)
((3.0,1.0),6) - o 6 representa o lado direito da peça.

>>> qualParede (Peca Recta 0) (2,1) (2.5,2)
((2.0,2.0),7) - o 7 representa o fundo da peça.

>>> qualParede (Peca Recta 0) (2,1) (2,1.5)
((1.0,1.0),8) - o 8 representa o lado esquerdo da peça.

>>> qualParede (Peca (Curva Este) 0) (2,1) (2.5,1.5)
((-1.0,-1.0),0) - este resultado simboliza a destruição do carro.

>>> qualParede (Peca (Curva Este) (-1)) (2,1) (2.5,1.5)
((-50.0,-50.0),0) - este resultado simboliza o ricochete do carro.
-}

qualParede :: Peca -> Ponto -> Ponto -> (Ponto,Int)

qualParede (Peca (Curva Este) h)  (a,b) (x,y) | x == a && y == b = ((a-1,b-1),4) 
                                              | x == (a+1) && y == (b+1) = ((a+1,b-1),4) 
                                              | x == a && y == (b+1) = ((a+1,b+1),4) 
                                              | y == (b+1) = ((a,b+1),7)
                                              | x == a = ((a-1,b),8) 
                                              | h > -1 = ((-1,-1),0)
                                              | otherwise = ((-50,-50),0)

qualParede (Peca (Curva Sul) h)   (a,b) (x,y) | x == a && y == b = ((a-1,b-1),4) 
                                              | x == (a+1) && y == b = ((a+1,b-1),4)
                                              | x == a && y == (b+1) = ((a+1,b+1),4) 
                                              | y == b = ((a,b-1),5) 
                                              | x == a = ((a-1,b),8)
                                              | h > -1 = ((-1,-1),0)
                                              | otherwise = ((-50,-50),0)

qualParede (Peca (Curva Oeste) h) (a,b) (x,y) | x == a && y == b = ((a-1,b-1),4) 
                                              | x == (a+1) && y == b = ((a+1,b-1),4) 
                                              | x == (a+1) && y == (b+1) = ((a+1,b-1),4)  
                                              | y == b = ((a,b-1),5) 
                                              | x == (a+1) = ((a+1,b),6) 
                                              | h > -1 = ((-1,-1),0) 
                                              | otherwise = ((-50,-50),0)

qualParede (Peca (Curva Norte) h) (a,b) (x,y) | x == (a+1) && y == b = ((a+1,b-1),4) 
                                              | x == (a+1) && y == (b+1) = ((a+1,b-1),4) 
                                              | x == a && y == (b+1) = ((a+1,b+1),4) 
                                              | x == (a+1) = ((a+1,b),6)
                                              | y == (b+1) = ((a,b+1),7) 
                                              | h > -1 = ((-1,-1),0) 
                                              | otherwise =  ((-50,-50),0)


qualParede _ (a,b) (x,y) | x == a && y == b = ((a-1,b-1),4) 
                         | x == (a+1) && y == b = ((a+1,b-1),4) 
                         | x == (a+1) && y == (b+1) = ((a+1,b+1),4) 
                         | x == a && y == (b+1) = ((a-1,b+1),4) 
                         | y == b = ((a,b-1),5)
                         | x == (a+1) = ((a+1,b),6) 
                         | y == (b+1) = ((a,b+1),7) 
                         | x == a = ((a-1,b),8) 
                         | otherwise = ((a+1,b),6)

{- | A função drs verifica se o carro é destruído, se faz ricochete ou se segue em frente ao passar de uma peça para outra.

== Exemplos de utilização:
>>> drs (Peca Recta 0) (Peca Lava 0) 5
1 - isto significa que o carro é destruído.

>>> drs (Peca (Rampa Este) 1) (Peca Recta 0) 6
2 - isto significa que o carro faz ricochete.

>>> drs (Peca Recta 0) (Peca (Rampa Oeste) (-1)) 4
3 - isto significa que o carro segue em frente
-}

drs :: Peca -> Peca -> Int -> Int
drs (Peca Lava 0) _ _ = 1
drs (Peca (Curva _) _) (Peca Lava (-1)) o = 1 --caso em que a parede é uma diagonal de uma curva e tem lava a seguir e a peça ai tem altura <-1, ou seja é destruido
drs (Peca (Curva _) _) (Peca Lava (-2)) o = 2 --caso em que a parede é uma diagonal de uma curva mas a altura ja permite fazer ricochete 

drs (Peca _ h) (Peca Lava h1) 4 | h <=(-1) = 2 
                                | otherwise = 1

drs (Peca _ h) (Peca (Rampa _ ) h1) 4 | h1-h >= 0 = 2
                                      | h1-h <= (-1) = 3
                                      | otherwise = 1

drs (Peca (Rampa _) h) (Peca _ h1) 4 | h1-h == 1 = 3
                                     | h1-h == 0 = 3
                                     | h1-h < 0 = 1
                                     | otherwise = 2

drs (Peca _ h) (Peca _ h1) 4 | h1-h >= 1 = 2
                             | h1-h <= (-1) = 1
                             | otherwise = 3

drs (Peca (Curva _) h) p o = 3

drs (Peca Recta h) (Peca (Curva p) h1) 5 | p == Sul || p == Oeste = if diffP (Peca Recta h) (Peca (Curva Sul) h1) >= 1 then 2 else 1
                                         | otherwise = 3

drs (Peca Recta h) (Peca (Curva p) h1) 6 | p == Norte || p == Oeste = if diffP (Peca Recta h) (Peca (Curva Sul) h1) >= 1 then 2 else 1
                                         | otherwise = 3

drs (Peca Recta h) (Peca (Curva p) h1) 7 | p == Norte || p == Este = if diffP (Peca Recta h) (Peca (Curva Sul) h1) >= 1 then 2 else 1
                                         | otherwise = 3

drs (Peca Recta h) (Peca (Curva p) h1) 8 | p == Sul || p == Este = if diffP (Peca Recta h) (Peca (Curva Sul) h1) >= 1 then 2 else 1
                                         | otherwise = 3

drs (Peca Recta h) (Peca Recta h1) o | diffP (Peca Recta h) (Peca Recta h1) <= -1 = 1 
                                     | diffP (Peca Recta h) (Peca Recta h1) == 0 = 3
                                     | otherwise = 2

drs (Peca Recta h) (Peca (Rampa _) h1) o | h1-h >= -1 || h1-h == 0 = 3
                                         | otherwise = 1

drs (Peca Recta h) (Peca Lava h1) _ | h <= -1 = 2
                                    | otherwise = 1

drs (Peca (Rampa Este) h) (Peca (Rampa _) h1) 6 | h1 == h+1 = 3 
                                                | otherwise = 1

drs (Peca (Rampa Oeste) h) (Peca (Rampa _) h1) 6 | h1 == h-1 = 3 
                                                 | otherwise = 1

drs (Peca (Rampa Este) h) (Peca (Rampa _) h1) 8 | h1 == h-1 = 3 
                                                | otherwise = 1

drs (Peca (Rampa Oeste) h) (Peca (Rampa _) h1) 8 | h1 == h+1 = 3 
                                                 | otherwise = 1


drs (Peca (Rampa Norte) h) (Peca (Rampa _) h1) 5 | h1 == h+1 = 3 
                                                 | otherwise = 1

drs (Peca (Rampa Norte) h) (Peca (Rampa _) h1) 7 | h1 == h-1 = 3 
                                                 | otherwise = 1

drs (Peca (Rampa Sul) h) (Peca (Rampa _) h1) 5 | h1 == h-1 = 3 
                                               | otherwise = 1

drs (Peca (Rampa Sul) h) (Peca (Rampa _) h1) 7 | h1 == h+1 = 3 
                                               | otherwise = 1


drs (Peca (Rampa _) h) (Peca (Rampa _) h1)  o | h1 == h = 3 
                                              | otherwise = 1


drs (Peca (Rampa _) h) (Peca Recta h1) o | h1 == h || h1 == h + 1 = 3
                                         | h1 > h+1 = 2
                                         | h1 < h = 1 

drs (Peca (Rampa r) h) (Peca (Curva p) h1) 5 | (r == Oeste || r == Este) && (p == Sul || p == Oeste) = if diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) >=(-1) && diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) <= 1 then 3 else 1

drs (Peca (Rampa r) h) (Peca (Curva p) h1) 7 | (r == Oeste || r == Este) && (p == Norte || p == Este) = if diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) >=(-1) && diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) <= 1 then 3 else 1   

drs (Peca (Rampa r) h) (Peca (Curva p) h1) 6 | (r == Norte || r == Sul) && (p == Oeste || p == Norte) = if diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) >=(-1) && diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) <= 1 then 3 else 1

drs (Peca (Rampa r) h) (Peca (Curva p) h1) 8 | (r == Norte || r == Sul) && (p == Sul || p == Este) = if diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) >=(-1) && diffP (Peca (Rampa Oeste) h) (Peca (Curva p) h1) <= 1 then 3 else 1

drs (Peca (Rampa _) h) (Peca (Curva _) h1) o = 3

drs (Peca (Rampa _) h) (Peca Lava h1) o | h < 0 = 2
                                        | otherwise = 1


{- | A função diffP calcula a diferença entre a altura de duas peças.

== Exemplo de utilização:
>>> diffP (Peca Recta 0) (Peca (Curva Norte) 1)
1
-}

diffP :: Peca -> Peca -> Int
diffP (Peca _ h) (Peca Lava h1) = h1-h
diffP (Peca Recta h) (Peca (Rampa _) h1) = h1-h
diffP (Peca _ h) (Peca _ h1) = h1-h


{- | A função vetorColisao calcula o novo vetor de velocidade do carro, quando este faz ricochete.

== Exemplos de utilização:
>>> vetorColisao (Peca Recta 0) (2,1) (2.5,1) (1,-1)
(1.0,1.0)

>>> vetorColisao (Peca Recta 0) (2,1) (2,1.5) (1,-1)
(-1.0,-1.0)

>>> vetorColisao (Peca (Curva Norte) 0) (1,1) (1.5,1.5) (0.1,-1)
(1.0,-0.1)

>>> vetorColisao (Peca (Curva Este) 0) (1,1) (1.5,1.5) (1,0.2)
(0.2,1.0)
-}

vetorColisao :: Peca -> Ponto -> Ponto -> Velocidade -> Velocidade
vetorColisao (Peca (Curva c) _)  (a,b) (x,y) (vx,vy) | c== Este || c == Oeste = (vy,vx)
                                                     | c == Sul || c == Norte = (-vy,-vx)
vetorColisao _ (a,b) (x,y) (vx,vy) | x == a || x == (a+1) = (-vx,vy)
                                   | y == b || y == (b+1) = (vx,-vy)
vetorColisao _ _ _ (vx,vy) = (vx,vy)


{- | A função valorVelo calcula a norma do vetor velocidade.

== Exemplo de utilização:
>>> valorVelo (2,2.5)
3.2015621187164243
-}

valorVelo :: Velocidade -> Double
valorVelo (vx,vy) = sqrt((vx)^2 + (vy)^2)
    

{- | A função valorVetor calcula a norma do vetor que vai do primeiro ponto dado ao segundo.

== Exemplo de utilização:
>>> valorVetor (1,1) (2.5,3.5)
2.9154759474226504
-}

valorVetor :: Ponto -> Ponto -> Double
valorVetor (x,y) (x1,y1) = sqrt((x1-x)^2 + (y1-y)^2)


{- | A função movAux devolve o carro, caso este nunca saia do percurso, ou um Nothing, caso seja destruído.

== Exemplos de utilização:
>>> movAux [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 1 (sqrt (0.3^2+0.3^2)) (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (0.3,0.3)})
Just (Carro {posicao = (2.8,1.8), direcao = 50.0, velocidade = (0.3,0.3)})

>>> movimenta [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 3 (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (1,0)})
Just (Carro {posicao = (3.5,3.5), direcao = 50.0, velocidade = (0.0,1.0)})

>>> movAux [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 5 5 (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (1,0)})
Nothing
-}

    
movAux :: Tabuleiro -> Tempo -> Double -> Carro -> Maybe Carro
movAux [] t d c = Nothing
movAux l t d (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})  | dis == 0 = Just (Carro {posicao = nint,direcao = o,velocidade = (vx,vy)})
                                                                         | dis <  0 = Just (Carro {posicao = nint,direcao = o,velocidade = (vx,vy)})
                                                                         | drs (buscarPecaV2 (x,y) l (vx,vy)) (buscarPecaV1 fsp l) snp == 1 = Nothing
                                                                         | drs (buscarPecaV2 (x,y) l (vx,vy)) (buscarPecaV1 fsp l) snp == 3 = movAux l (t-tim) dis (Carro {posicao = inter,direcao = o,velocidade = (vx,vy)})
                                                                         | drs (buscarPecaV2 (x,y) l (vx,vy)) (buscarPecaV1 fsp l) snp == 2 = movAux l (t-tim) dis (Carro {posicao = inter,direcao = o,velocidade = novoV})
                                                                    where 
                                                                      nint  = posSemIntersetar (x,y) (vx,vy) t
                                                                      inter = (pontoIntersecao (verificarPontos (intersetarVetorParede (vetorCarro (vx,vy) (x,y)) (paredes (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeral (x,y) (vx,vy)))) (pontoGeral (x,y) (vx,vy))) (x,y) (vx,vy))
                                                                      tim   = ((valorVetor (x,y) inter) / (valorVelo (vx,vy)))
                                                                      dis   = d-(valorVetor (x,y) inter)
                                                                      fsp   = fst (qualParede (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeralFrac (x,y) (vx,vy)  ) (pontoIntersecao (verificarPontos (intersetarVetorParede (vetorCarro (vx,vy) (x,y)) (paredes (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeral (x,y) (vx,vy)))) (pontoGeral (x,y) (vx,vy)) ) (x,y) (vx,vy)))
                                                                      snp   = snd (qualParede (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeralFrac (x,y) (vx,vy) ) (pontoIntersecao (verificarPontos (intersetarVetorParede (vetorCarro (vx,vy) (x,y)) (paredes (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeral (x,y) (vx,vy)))) (pontoGeral (x,y) (vx,vy)) ) (x,y) (vx,vy)))
                                                                      novoV = vetorColisao (buscarPecaV2 (x,y) l (vx,vy)) (pontoGeralFrac (x,y) (vx,vy) ) inter (vx,vy)

{- | A função movAux devolve o carro, caso este nunca saia do percurso, ou um Nothing, caso seja destruído.

== Exemplos de utilização:
>>> movAux [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca (Rampa Sul) 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 1 (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (0.3,0.3)})
Just (Carro {posicao = (2.8,1.8), direcao = 50.0, velocidade = (0.3,0.3)})

>>> movimenta [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 3 (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (1,0)})
Just (Carro {posicao = (3.5,3.5), direcao = 50.0, velocidade = (0.0,1.0)})

>>> movimenta [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0,Peca (Rampa Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] 5 (Carro {posicao = (2.5,1.5), direcao = 50, velocidade = (1,0)})
Nothing

-}

movimenta :: Tabuleiro -> Tempo -> Carro -> Maybe Carro

movimenta l t (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) | vx == 0 && vy == 0 = Just (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})
movimenta [] t c  = Nothing 
movimenta l t (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)}) = movAux l t ((valorVelo (vx,vy))*t) (Carro {posicao = (x,y),direcao = o,velocidade = (vx,vy)})

