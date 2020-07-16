{-|
Module      : Tarefa5_2017li1g5
Description : Módulo da Tarefa 5 para LI1 17/18
Copyright: Hugo Cardoso <a85006@alunos.uminho.pt>         
           João Cunha   <a84775@alunos.uminho.pt>

Módulo para a realização da Tarefa 5 de LI1 em 2017/18.
-}
module Main where


import LI11718
import Tarefa3_2017li1g5
import Tarefa4_2017li1g5
import Tarefa6_2017li1g5
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Data.Bitmap
import GHC.Float
import Data.Maybe
import Data.List


{-| Mundo é um data novo, constituído por um jogo, a ação de cada carro, uma pausa e uma lista de imagens.-}
data Mundo = Mundo 
  { menu :: Bool -- ^ indica se o jogo está no menu ou não
  , modo :: (Bool,Int) -- ^ indica se o jogador está a escolher o modo de jogo ou não
  , tipo :: Bool -- ^ indica se o jogador está a escolher o tipo de estrada ou não
  , pausa :: Bool -- ^ indica se o jogo está em pausa
  , fim :: Bool -- ^ indica se a corrida já acabou ou não
  , jogo :: Jogo -- ^ o jogo em questão
  , acao0 :: Acao -- ^ a ação do primeiro carro
  , acao1 :: Acao -- ^ a ação do segundo carro
  , imagem :: [[Picture]] -- ^ lista de imagens usadas para desenhar o mundo
  } 


{-| A width é a largura da janela em que aparece o jogo, de 1280 pixéis.-}
width :: Int  
width = 1280

{-| A height é a altura da janela em que aparece o jogo, de 720 pixéis.-}
height :: Int 
height = 720


{-| No mundoInicial define-se o estado inicial do jogo, neste caso, o menu.-}
mundoInicial :: [Picture] -> Mundo
mundoInicial l = Mundo {menu = True, modo = (False,0), tipo = False, pausa = False, fim = False, jogo = Jogo {mapa = Mapa ((0,0),Sul) [], pista = Propriedades 0 0 0 0 0 0, carros = [], nitros = [], historico = []}, acao0 = a0, acao1 = a1, imagem = [l,l]}
            where
              a0 = Acao False False False False Nothing
              a1 = Acao False False False False Nothing


{-| O mundoInicial1 possui as características do primeiro mapa, e é usado caso o jogador escolha o mesmo.-}
mundoInicial1 :: Mundo
mundoInicial1 = Mundo {menu = False, modo = (True,0), tipo = False, pausa = False, fim = False
                       , jogo = Jogo { mapa = Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Norte) 1,Peca Recta 1,Peca Recta 1,Peca (Curva Este) 1,Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta 1,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta 1,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
                       , pista = Propriedades 2 3 4 2 15 180, carros = [c0,c1], nitros = [5,5], historico = [[],[]]}, acao0 = a0, acao1 = a1, imagem = [[],[]]}
            where 
              c0 = Carro {posicao = (2.5,1.3), direcao = 0, velocidade = (0,0)}
              c1 = Carro {posicao = (2.5,1.7), direcao = 0, velocidade = (0,0)}
              a0 = Acao False False False False Nothing
              a1 = Acao False False False False Nothing


{-| O mundoInicial2 possui as características do segundo mapa, e é usado caso o jogador escolha o mesmo.-}
mundoInicial2 :: Mundo
mundoInicial2 = Mundo {menu = False, modo = (True,0), tipo = False, pausa = False, fim = False
                       , jogo = Jogo { mapa = Mapa ((4,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Sul) (-1),Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-3),Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Recta (-3),Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Norte) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Oeste) (-3),Peca Recta (-3),Peca (Curva Este) (-3),Peca (Rampa Norte) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
                       , pista = Propriedades 2 3 4 2 15 180, carros = [c0,c1], nitros = [5,5], historico = [[],[]]}, acao0 = a0, acao1 = a1, imagem = [[],[]]}
            where 
              c0 = Carro {posicao = (4.5,1.3), direcao = 0, velocidade = (0,0)}
              c1 = Carro {posicao = (4.5,1.7), direcao = 0, velocidade = (0,0)}
              a0 = Acao False False False False Nothing
              a1 = Acao False False False False Nothing


{-| O mundoInicial3 possui as características do terceiro mapa, e é usado caso o jogador escolha o mesmo.-}
mundoInicial3 :: Mundo
mundoInicial3 = Mundo {menu = False, modo = (True,0), tipo = False, pausa = False, fim = False
                       , jogo = Jogo { mapa = Mapa ((6,5),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca Recta 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca (Curva Norte) 0,Peca (Curva Este) 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca (Rampa Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca (Rampa Norte) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Rampa Este) 0,Peca Recta 1,Peca (Rampa Este) 1,Peca Recta 2,Peca (Rampa Este) 2,Peca Recta 3,Peca (Rampa Este) 3,Peca Recta 4,Peca (Rampa Este) 4,Peca Recta 5,Peca (Rampa Este) 5,Peca Recta 6,Peca (Rampa Este) 6,Peca (Curva Este) 7,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca Recta (-1),Peca Recta (-1),Peca (Rampa Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca (Rampa Este) 0,Peca (Rampa Este) 1,Peca (Rampa Este) 2,Peca (Rampa Este) 3,Peca (Rampa Este) 4,Peca (Rampa Este) 5,Peca (Rampa Este) 6,Peca (Curva Sul) 7,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Sul) (-1),Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-2),Peca (Curva Este) (-2),Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca (Rampa Oeste) (-2),Peca (Rampa Oeste) (-3),Peca (Rampa Oeste) (-4),Peca (Curva Este) (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca (Curva Norte) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-4),Peca (Curva Este) (-4),Peca Recta (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Rampa Oeste) (-3),Peca Recta (-3),Peca Recta (-3),Peca (Curva Este) (-3),Peca Lava 0,Peca (Curva Oeste) (-4),Peca Recta (-4),Peca (Curva Sul) (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca Recta (-2),Peca (Curva Sul) (-2),Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-3),Peca Recta (-3),Peca (Rampa Oeste) (-4),Peca Recta (-4),Peca (Curva Sul) (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
                       , pista = Propriedades 2 3 4 2 15 180, carros = [c0,c1], nitros = [5,5], historico = [[],[]]}, acao0 = a0, acao1 = a1, imagem = [[],[]]}
            where 
              c0 = Carro {posicao = (6.5,5.3), direcao = 0, velocidade = (0,0)}
              c1 = Carro {posicao = (6.5,5.7), direcao = 0, velocidade = (0,0)}
              a0 = Acao False False False False Nothing
              a1 = Acao False False False False Nothing


{-| O mundoInicial4 possui as características do quarto mapa, e é usado caso o jogador escolha o mesmo.-}
mundoInicial4 :: Mundo
mundoInicial4 = Mundo {menu = False, modo = (True,0), tipo = False, pausa = False, fim = False
                       , jogo = Jogo { mapa = Mapa ((6,4),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-2),Peca (Rampa Oeste) (-3),Peca (Rampa Oeste) (-4),Peca Recta (-4),Peca Recta (-4),Peca Recta (-4),Peca (Rampa Este) (-4),Peca Recta (-3),Peca (Curva Este) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-3),Peca Recta (-3),Peca Recta (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Norte) (-2),Peca Recta (-2),Peca Recta (-2),Peca Recta (-2),Peca Recta (-2),Peca Recta (-2),Peca Recta (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca (Curva Oeste) (-3),Peca Recta (-3),Peca (Rampa Este) (-3),Peca Recta (-2),Peca Recta (-2),Peca (Rampa Este) (-2),Peca (Rampa Oeste) (-2),Peca Recta (-2),Peca (Curva Este) (-2),Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) (-1),Peca (Curva Norte) 0,Peca Recta 0,Peca (Curva Este) 0,Peca Lava 0,Peca (Curva Oeste) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Norte) (-2),Peca (Curva Sul) (-2),Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Recta 0,Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) 0,Peca Recta 0,Peca Recta 0,Peca (Curva Sul) 0,Peca Lava 0,Peca Lava 0,Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-3),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca (Curva Oeste) (-2),Peca Recta (-2),Peca (Rampa Este) (-2),Peca Recta (-1),Peca (Rampa Este) (-1),Peca (Curva Sul) 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-4),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Sul) (-1),Peca (Curva Norte) (-2),Peca (Curva Este) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-4),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Recta (-2),Peca Recta (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-4),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta 0,Peca Recta (-2),Peca (Rampa Norte) (-3),Peca Lava 0,Peca (Curva Norte) (-4),Peca Recta (-4),Peca (Curva Sul) (-4),Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca (Rampa Sul) (-2),Peca (Rampa Norte) (-4),Peca Lava 0,Peca Recta (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-1),Peca Recta (-1),Peca Recta (-4),Peca Lava 0,Peca Recta (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-1),Peca (Curva Sul) (-1),Peca (Curva Oeste) (-4),Peca Recta (-4),Peca (Curva Sul) (-4),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]
                       ,[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
                       , pista = Propriedades 2 3 4 2 15 180, carros = [c0,c1], nitros = [5,5], historico = [[],[]]}, acao0 = a0, acao1 = a1, imagem = [[],[]]}
            where 
              c0 = Carro {posicao = (6.5,4.3), direcao = 0, velocidade = (0,0)}
              c1 = Carro {posicao = (6.5,4.7), direcao = 0, velocidade = (0,0)}
              a0 = Acao False False False False Nothing
              a1 = Acao False False False False Nothing


{-| A função getTab devolve o tabuleiro de um determinado mundo.

== Exemplo de utilização:
>>> getTab mundoInicial1
[[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 1,Peca Recta 1,Peca Recta 1,Peca (Curva Este) 1,Peca Lava 0],[Peca Lava 0,Peca Recta 1,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca Recta 1,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 1,Peca Recta 1,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
-}
getTab :: Mundo -> Tabuleiro
getTab (Mundo {jogo = Jogo { mapa = Mapa _ t}}) = t


{-| A função getTab2 devolve o tabuleiro de um determinado jogo.

== Exemplo de utilização:
>>> getTab2 (jogo(mundoInicial2))
[[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Rampa Oeste) (-1),Peca Recta (-1),Peca (Curva Este) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Recta (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca (Curva Norte) (-1),Peca Recta (-1),Peca (Curva Sul) (-1),Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca (Rampa Norte) (-3),Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Recta (-3),Peca Lava 0,Peca Recta (-1),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca (Rampa Norte) (-2),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) (-3),Peca Recta (-3),Peca (Curva Este) (-3),Peca (Rampa Norte) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca (Curva Oeste) (-3),Peca (Curva Sul) (-3),Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
-}
getTab2 :: Jogo -> Tabuleiro
getTab2 (Jogo { mapa = Mapa _ t}) = t


{-| A função dimensaoTab, dado um tabuleiro, devolve a dimensão do mesmo.

== Exemplo de utilização:
>>> dimensaoTab [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Rampa Este) 0,Peca (Curva Este) 1,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Rampa Este) 0,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]]
(6,5)
-}
dimensaoTab :: Tabuleiro -> Dimensao
dimensaoTab (h:t) = (length h, length (h:t))


{-| A função dimPeca devolve o comprimento de cada peça, dependendo das dimensões do tabuleiro e das imagens importadas para as peças (as peças são quadradas).

== Exemplos de utilização:
>>> dimPeca (10,5)
128.0

>>> dimPeca (5,5)
144.0

>>> dimPeca (3,8)
90.0
-}
dimPeca :: Dimensao -> Double
dimPeca (x,y) | fromIntegral(width)/fromIntegral(x) >= fromIntegral(height)/fromIntegral(y) = fromIntegral(height)/fromIntegral(y)
              | otherwise = fromIntegral(width)/fromIntegral(x)


{-| A função escalaPeca redimensiona as imagens importadas. É aplicada às imagens das peças.-}
escalaPeca :: Tabuleiro -> Picture -> Picture
escalaPeca t p = Scale a a p
  where
    a = double2Float(dimPeca(dimensaoTab t))/250


{-| A função desenhaPecas desenha todas as peças do tabuleiro no centro da janela, pela ordem do tabuleiro, já com as dimensões certas.

== Exemplo de utilização:
>>> desenhaPecas [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Rampa Este) 0,Peca (Curva Este) 1,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Rampa Este) 0,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]] [lava,recta,curvaNorte,curvaOeste,curvaEste,curvaSul,rampaNorte,rampaOeste,rampaEste,rampaSul]
[[lava,lava,lava,lava,lava,lava],[lava,curvaNorte,recta,rampaEste,curvaEste,lava],[lava,recta,lava,lava,recta,lava],[lava,curvaOeste,rampaEste,recta,curvaSul,lava],[lava,lava,lava,lava,lava,lava]]
-}
desenhaPecas :: Tabuleiro -> [Picture] -> Tabuleiro -> [[Picture]]
desenhaPecas [] l p = []
desenhaPecas (h:t) l p = aux h l p : desenhaPecas t l p
  where
    aux :: [Peca] -> [Picture] -> Tabuleiro -> [Picture]
    aux [] l _ = []
    aux (Peca Lava 0:t)          l tab = escalaPeca tab (l!!0) : aux t l tab       
    aux (Peca Recta _:t)         l tab = escalaPeca tab (l!!1) : aux t l tab
    aux (Peca (Curva Norte) _:t) l tab = escalaPeca tab (l!!2) : aux t l tab
    aux (Peca (Curva Oeste) _:t) l tab = escalaPeca tab (l!!3) : aux t l tab
    aux (Peca (Curva Este) _:t)  l tab = escalaPeca tab (l!!4) : aux t l tab
    aux (Peca (Curva Sul) _:t)   l tab = escalaPeca tab (l!!5) : aux t l tab
    aux (Peca (Rampa Norte) _:t) l tab = escalaPeca tab (l!!6) : aux t l tab
    aux (Peca (Rampa Oeste) _:t) l tab = escalaPeca tab (l!!7) : aux t l tab
    aux (Peca (Rampa Este) _:t)  l tab = escalaPeca tab (l!!8) : aux t l tab
    aux (Peca (Rampa Sul) _:t)   l tab = escalaPeca tab (l!!9) : aux t l tab


{-| A função desenhaTab desloca todas as peças para a sua respetiva posição, devolvendo um tabuleiro propriamente desenhado.-}
desenhaTab :: Tabuleiro -> [[Picture]] -> [Picture]
desenhaTab tab l = aux tab l (-fromIntegral(fst(dimensaoTab tab))/2) (fromIntegral(snd(dimensaoTab tab))/2) 0
  where
    aux :: Tabuleiro -> [[Picture]] -> Double -> Double -> Double -> [Picture]
    aux tab [] x y z = []
    aux tab ([]:t) x y z = aux tab t (x-z) (y-1) 0
    aux tab ((h:t):ts) x y z = Translate ((double2Float(dimPeca(dimensaoTab tab)))*((double2Float x) + 1/2)) ((double2Float(dimPeca(dimensaoTab tab)))*((double2Float y) - 1/2)) h : aux tab (t:ts) (x+1) y (z+1)


{-| A função getPosDir, dado um jogo, devolve as posições e as direções dos carros.

== Exemplo de utilização:
>>> getPosDir (Jogo {mapa= Mapa ((2,1),Este) [[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0],[Peca Lava 0,Peca (Curva Norte) 0,Peca Recta 0,Peca (Rampa Este) 0,Peca (Curva Este) 1,Peca Lava 0],[Peca Lava 0,Peca Recta 0,Peca Lava 0,Peca Lava 0,Peca Recta 1,Peca Lava 0],[Peca Lava 0,Peca (Curva Oeste) 0,Peca (Rampa Este) 0,Peca Recta 1,Peca (Curva Sul) 1,Peca Lava 0],[Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0,Peca Lava 0]], pista = Propriedades 2 3 4 2 15 180, carros = [Carro {posicao=(2.5,1.3),direcao=0,velocidade=(0,0)},Carro {posicao=(2.5,1.7),direcao=90,velocidade=(0,0)}], nitros = [5,5], historico = [[],[]] })
([(2.5,1.3),(2.5,1.7)],[0.0,90.0])
-}
getPosDir :: Jogo -> ([Ponto],[Angulo])
getPosDir j = aux j ([],[])
  where
    aux (Jogo {carros=[]}) a = a
    aux (Jogo {mapa=m,pista=p,carros=(Carro{posicao=pos,direcao=dir,velocidade=_}:t),nitros=n,historico=h}) (a,b) = aux (Jogo {mapa=m,pista=p,carros=t,nitros=n,historico=h}) (a++[pos],b++[dir])


{-| A função escalaCarro redimensiona as imagens dos carros.-}
escalaCarro :: Tabuleiro -> Picture -> Picture 
escalaCarro tab p = Scale a a p
  where
    a = double2Float((dimPeca(dimensaoTab tab))/2.5)/1333


{-| A função desenhaCarro desenha a imagem do carro fornecida, na posição e com a direção também fornecidas.-}
desenhaCarro :: Tabuleiro -> Dimensao -> Ponto -> Angulo -> Picture -> Picture
desenhaCarro tab (dx,dy) (x,y) a p = t (Rotate (-double2Float a) (escalaCarro tab p))
  where
    t = Translate (double2Float(dimPeca(dimensaoTab tab))*((-fromIntegral dx/2)+double2Float x)) (double2Float(dimPeca(dimensaoTab tab))*((fromIntegral dy/2)-double2Float y))


{-| A função escalaTecla redimensiona as imagens das teclas.-}
escalaTecla :: Picture -> Picture 
escalaTecla p = Scale 0.2 0.2 p


{-| A função escalaCarro2 redimensiona os carros que vão fazer parte da interface.-}
escalaCarro2 :: Picture -> Picture
escalaCarro2 p = Scale (25/1333) (25/1333) p


{-| A função desenhaTeclas recebe as imagens das teclas, que fazem parte da interface, e desloca-as para as suas respetivas posições.-}
desenhaTeclas :: [Picture] -> [Picture]
desenhaTeclas [] = []
desenhaTeclas l = aux l 7 7
  where
    aux [] _ _ = []
    aux (h:t) x y | x == 7 = Translate (-600) (-260) (escalaTecla h)                              : aux t (x-1) y
                  | x == 6 = Translate (-550) (-210) (escalaTecla h)                              : aux t (x-1) y
                  | x == 5 = Translate (-550) (-310) (escalaTecla h)                              : aux t (x-1) y
                  | x == 4 = Translate (-500) (-260) (escalaTecla h)                              : aux t (x-1) y
                  | x == 3 = Translate (-550) (-260) (Rotate (-90) (escalaCarro2 h))              : aux t (x-1) y
                  | x == 2 = Translate (-480) (-310) (Scale 0.3 0.3 h)                            : aux t (x-1) y
                  | x == 1 = Translate (-430) (-310) (Scale 0.3 0.3 h)                            : aux t (x-1) y
                  | y == 7 = Translate   500  (-260) (escalaTecla h)                              : aux t x (y-1)
                  | y == 6 = Translate   550  (-210) (escalaTecla h)                              : aux t x (y-1)
                  | y == 5 = Translate   550  (-310) (escalaTecla h)                              : aux t x (y-1)
                  | y == 4 = Translate   600  (-260) (escalaTecla h)                              : aux t x (y-1)
                  | y == 3 = Translate   550  (-260) (Rotate (-90) (escalaCarro2 h))              : aux t x (y-1)
                  | y == 2 = Translate   480  (-310) (Scale 0.3 0.3 h)                            : aux t x (y-1)
                  | y == 1 = Translate   430  (-310) (Scale 0.3 0.3 h)                            : aux t x (y-1)
                  | otherwise = Translate  0  (-310) h                                            : aux t x y


{-| A função desenhaMundo, tal como o nome indica, desenha o mundo, ou seja, o jogo. Isto é, converte o mundo numa imagem.-}
desenhaMundo :: Mundo -> Picture
desenhaMundo (Mundo {imagem=[[tab1,tab2,tab3,tab4,c00,c01,p,teclas,vA,vV,m,m2,t,f],l]}) = m
desenhaMundo (Mundo {menu=m,modo=(m2,_),tipo=t,pausa=p,fim=f,jogo=j,imagem=[[tab,c0,c1,pau,teclas,vA,vV,men,mod,tip,fun],l]}) | m = men
                                                                                                                              | m2 = mod
                                                                                                                              | t = tip
                                                                                                                              | p = Pictures [fun, tab, teclas, desenhaCarro (getTab2 j) dimTab p0 dir0 c0, desenhaCarro (getTab2 j) dimTab p1 dir1 c1, pau] 
                                                                                                                              | f && head(head(historico j)) == last(head(historico j)) && length(head(historico j)) >= difLava (getTab2 j) = Pictures [fun, tab, teclas,desenhaCarro (getTab2 j) dimTab p0 dir0 c0, desenhaCarro (getTab2 j) dimTab p1 dir1 c1, vA]
                                                                                                                              | f && head(last(historico j)) == last(last(historico j)) && length(last(historico j)) >= difLava (getTab2 j) = Pictures [fun, tab, teclas,desenhaCarro (getTab2 j) dimTab p0 dir0 c0, desenhaCarro (getTab2 j) dimTab p1 dir1 c1, vV]
                                                                                                                              | otherwise = Pictures [fun, tab, teclas, desenhaCarro (getTab2 j) dimTab p0 dir0 c0, desenhaCarro (getTab2 j) dimTab p1 dir1 c1] 
   where
    dimTab = dimensaoTab (getTab2 j)
    p0 = head(fst(getPosDir j))
    dir0 = head(snd(getPosDir j))
    p1 = last(fst(getPosDir j))
    dir1 = last(snd(getPosDir j)) 


{-| A função reageEvento altera o mundo conforme o input dos jogadores, isto é, segundo as teclas que os jogadores pressionam.

Exemplos de utilização:
>>> reageEvento (EventKey (SpecialKey KeyUp) Down _ _) m
m {acao0 = ((acao0 m) { acelerar = True })}

>>> reageEvento (EventKey (Char 'c') Down _ _) m
m {acao0 = ((acao0 m) { nitro = Just 0 })}

>>> reageEvento (EventKey (SpecialKey KeySpace) Down _ _) m
m {pausa = not (pausa m)}
-}
reageEvento :: Event -> Mundo -> Mundo
reageEvento (EventKey (Char '1') Down _ _)            m | menu m = mundoInicial1 {imagem = [(last(imagem m))\\[((last(imagem m))!!1),((last(imagem m))!!2),((last(imagem m))!!3)], last(imagem m)]}
                                                        | fst(modo m) = m {modo = (False,1), tipo = True}
                                                        | otherwise = m
reageEvento (EventKey (Char '2') Down _ _)            m | menu m = mundoInicial2 {imagem = [(last(imagem m))\\[((last(imagem m))!!0),((last(imagem m))!!2),((last(imagem m))!!3)], last(imagem m)]}
                                                        | fst(modo m) = m {modo = (False,2), tipo = True}
                                                        | otherwise = m
reageEvento (EventKey (Char '3') Down _ _)            m | menu m = mundoInicial3 {imagem = [(last(imagem m))\\[((last(imagem m))!!0),((last(imagem m))!!1),((last(imagem m))!!3)], last(imagem m)]}
                                                        | otherwise = m 
reageEvento (EventKey (Char '4') Down _ _)            m | menu m = mundoInicial4 {imagem = [(last(imagem m))\\[((last(imagem m))!!0),((last(imagem m))!!1),((last(imagem m))!!2)], last(imagem m)]}
                                                        | otherwise = m     
reageEvento (EventKey (Char 'g') Down _ _)            m | tipo m = m {tipo = False}
                                                        | otherwise = m
reageEvento (EventKey (Char 'i') Down _ _)            m | tipo m = m {tipo = False, jogo = ((jogo m) {pista = Propriedades 0.3 0.4 2 1.5 15 270})}
                                                        | otherwise = m  
reageEvento (EventKey (Char 'a') Down _ _)            m | tipo m = m {tipo = False, jogo = ((jogo m) {pista = Propriedades 4 5 8 4 10 120})}
                                                        | snd(modo m) == 1 = m {acao1 = ((acao1 m) { esquerda = True })} 
                                                        | otherwise = m
reageEvento (EventKey (SpecialKey KeySpace) Down _ _) m | menu m || fst(modo m) || tipo m || fim m = m
                                                        | otherwise = m {pausa = not (pausa m)} 
reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) m | fim m || pausa m = m {menu = True, modo = (True,0)}
                                                        | otherwise = m                                                                                                                                                                                                                   
reageEvento (EventKey (SpecialKey KeyUp) Down _ _)    m = m {acao0 = ((acao0 m) { acelerar = True })}
reageEvento (EventKey (SpecialKey KeyDown) Down _ _)  m = m {acao0 = ((acao0 m) { travar   = True })}
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _)  m = m {acao0 = ((acao0 m) { esquerda = True })}
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) m = m {acao0 = ((acao0 m) { direita  = True })}
reageEvento (EventKey (Char '9') Down _ _)            m = m {acao0 = ((acao0 m) { nitro    = Just 0 })}
reageEvento (EventKey (Char '0') Down _ _)            m = m {acao1 = ((acao1 m) { nitro    = Just 1 })}
reageEvento (EventKey (SpecialKey KeyUp) Up _ _)      m = m {acao0 = ((acao0 m) { acelerar = False })}
reageEvento (EventKey (SpecialKey KeyDown) Up _ _)    m = m {acao0 = ((acao0 m) { travar   = False })}
reageEvento (EventKey (SpecialKey KeyLeft) Up _ _)    m = m {acao0 = ((acao0 m) { esquerda = False })}
reageEvento (EventKey (SpecialKey KeyRight) Up _ _)   m = m {acao0 = ((acao0 m) { direita  = False })}
reageEvento (EventKey (Char '9') Up _ _)              m = m {acao0 = ((acao0 m) { nitro    = Nothing })}
reageEvento (EventKey (Char '0') Up _ _)              m = m {acao1 = ((acao1 m) { nitro    = Nothing })}
reageEvento (EventKey (Char 'w') Down _ _)            m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { acelerar = True })}
                                                        | otherwise = m
reageEvento (EventKey (Char 's') Down _ _)            m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { travar   = True })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'd') Down _ _)            m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { direita  = True })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'c') Down _ _)            m | snd(modo m) == 1 = m {acao0 = ((acao0 m) { nitro    = Just 0 })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'v') Down _ _)            m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { nitro    = Just 1 })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'w') Up _ _)              m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { acelerar = False })}
                                                        | otherwise = m
reageEvento (EventKey (Char 's') Up _ _)              m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { travar   = False })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'a') Up _ _)              m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { esquerda = False })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'd') Up _ _)              m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { direita  = False })}
                                                        | otherwise = m
reageEvento (EventKey (Char 'c') Up _ _)              m | snd(modo m) == 1 = m {acao0 = ((acao0 m) { nitro    = Nothing })}
                                                        | snd(modo m) == 2 = m {acao1 = (bot (1/(fromIntegral fr)) (jogo m) 1)}
                                                        | otherwise = m
reageEvento (EventKey (Char 'v') Up _ _)              m | snd(modo m) == 1 = m {acao1 = ((acao1 m) { nitro    = Nothing })}
                                                        | snd(modo m) == 2 = m {acao1 = (bot (1/(fromIntegral fr)) (jogo m) 1)}
                                                        | otherwise = m
reageEvento _ m = m 


{-| A função reageTempo movimenta o mundo no tempo dado. Neste caso, movimenta os carros.-}
reageTempo :: Float -> Mundo -> Mundo
reageTempo n m | menu m || fst(modo m) || tipo m || pausa m = m
               | snd(modo m) == 1 = reageTempo2 (float2Double n) (m {jogo = atualiza (float2Double n) (atualiza (float2Double n) (jogo m) 0 (acao0 m)) 1 (acao1 m)})
               | otherwise = reageTempo2 (float2Double n) (m {jogo = atualiza (float2Double n) (atualiza (float2Double n) (jogo m) 0 (acao0 m)) 1 (bot (float2Double n) (jogo m) 1)})
               where
                reageTempo2 :: Double -> Mundo -> Mundo 
                reageTempo2 n m | contaVoltas (historico (jogo m)) (getTab m) = m {fim = True}
                                | mov0 == Nothing && mov1 /= Nothing = m {jogo = ((jogo m) {carros = [Carro {posicao = p0, direcao = dir0, velocidade = (0,0)}, fromJust mov1]})}
                                | mov0 /= Nothing && mov1 == Nothing = m {jogo = ((jogo m) {carros = [fromJust mov0, Carro {posicao = p1, direcao = dir1, velocidade = (0,0)}]})}
                                | mov0 == Nothing && mov1 == Nothing = m {jogo = ((jogo m) {carros = [Carro {posicao = p0, direcao = dir0, velocidade = (0,0)}, Carro {posicao = p1, direcao = dir1, velocidade = (0,0)}]})}
                                | otherwise = m {jogo = ((jogo m) {carros = [fromJust mov0,fromJust mov1]})}
                              where
                               mov0 = movimenta (getTab m) n (head(carros(jogo m)))
                               mov1 = movimenta (getTab m) n (last(carros(jogo m)))
                               p0 = (fromIntegral(fst(head(head(historico(jogo m)))))+0.5, fromIntegral(snd(head(head(historico(jogo m)))))+0.5)
                               p1 = (fromIntegral(fst(head(last(historico(jogo m)))))+0.5, fromIntegral(snd(head(last(historico(jogo m)))))+0.5)
                               dir0 = direcao(head(carros(jogo m)))
                               dir1 = direcao(last(carros(jogo m)))



{-| A função contaVoltas verifica se algum dos carros já deu uma volta completa à pista, isto é, se a corrida já acabou.

== Exemplos de utilização:
>>> contaVoltas [[(7,5),(6,5)],[(8,5),(7,5),(6,5)]] (getTab(mundoInicial3)) 
False

>>> contaVoltas [[(6,5),(5,5),(5,4),(5,3),(5,2),(5,1),(4,1),(3,1),(2,1),(1,1),(1,2),(1,3),(2,3),(3,3),(4,3),(4,2),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(2,7),(2,6),(3,6),(4,6),(5,6),(6,6),(7,6),(8,6),(8,7),(8,8),(7,8),(6,8),(6,7),(7,7),(7,8),(7,9),(7,10),(8,10),(9,10),(10,10),(10,9),(10,8),(9,8),(9,9),(10,9),(11,9),(12,9),(13,9),(14,9),(14,10),(14,11),(13,11),(13,10),(14,10),(15,10),(16,10),(17,10),(17,9),(17,8),(16,8),(16,9),(17,9),(18,9),(18,8),(18,7),(17,7),(16,7),(15,7),(14,7),(13,7),(12,7),(12,6),(13,6),(14,6),(15,6),(16,6),(17,6),(18,6),(19,6),(20,6),(20,5),(19,5),(18,5),(17,5),(16,5),(15,5),(14,5),(13,5),(12,5),(11,5),(10,5),(9,5),(8,5),(7,5),(6,5)],[(7,5),(6,5)]] (getTab(mundoInicial3))
True
-}
contaVoltas :: [[Posicao]] -> Tabuleiro -> Bool
contaVoltas [h,t] tab | length h < 2 && length t < 2 = False
                      | length h < 2 && length t >= 2 = (head t == last t && t!!1 == (fst(last t)-1,snd(last t))) && length t >= difLava tab
                      | length h >= 2 && length t < 2 = (head h == last h && h!!1 == (fst(last h)-1,snd(last h))) && length h >= difLava tab
                      | otherwise = ((head h == last h && h!!1 == (fst(last h)-1,snd(last h))) || (head t == last t && t!!1 == (fst(last t)-1,snd(last t)))) && (length h >= difLava tab || length t >= difLava tab)


{-| A função difLava indica o número de peças diferentes de lava existentes num tabuleiro.

== Exemplo de utilização:
>>> difLava (getTab(mundoInicial1))
13
-}
difLava :: Tabuleiro -> Int
difLava [] = 1
difLava ([]:ts) = difLava ts
difLava ((h:t):ts) | h /= Peca Lava 0 = 1 + difLava (t:ts)
                   | otherwise = difLava (t:ts)


{-| fr é o frame rate a que é corrido o Jogo.-}
fr :: Int
fr = 50


{-| Na função dm define-se as características da janela em que se mostra o jogo.-}
dm :: Display
dm = InWindow "Micro Machines" -- ^ título da janela
              (width,height) -- ^ tamanho da janela
              (0,0)          -- ^ posição da janela



{-| Função principal usada para animar um jogo completo. Compilar com o GHC. -}
main :: IO ()  
main = do carroAzul     <- loadBMP "bmp/CarroAzul.bmp"
          carroVermelho <- loadBMP "bmp/CarroVermelho.bmp"
          lava          <- loadBMP "bmp/Lava.bmp"
          recta         <- loadBMP "bmp/Recta.bmp"
          curvaEste     <- loadBMP "bmp/CurvaEste.bmp"
          curvaOeste    <- loadBMP "bmp/CurvaOeste.bmp"
          curvaSul      <- loadBMP "bmp/CurvaSul.bmp"
          curvaNorte    <- loadBMP "bmp/CurvaNorte.bmp"
          rampaEste     <- loadBMP "bmp/RampaEste.bmp"
          rampaOeste    <- loadBMP "bmp/RampaOeste.bmp"
          rampaSul      <- loadBMP "bmp/RampaSul.bmp"
          rampaNorte    <- loadBMP "bmp/RampaNorte.bmp"
          pausa         <- loadBMP "bmp/Pausa.bmp"
          espaco        <- loadBMP "bmp/Space.bmp"
          movA          <- loadBMP "bmp/A.bmp"
          movW          <- loadBMP "bmp/W.bmp"
          movS          <- loadBMP "bmp/S.bmp"
          movD          <- loadBMP "bmp/D.bmp"
          movEsq        <- loadBMP "bmp/SetaEsquerda.bmp"
          movCima       <- loadBMP "bmp/SetaCima.bmp"
          movBaixo      <- loadBMP "bmp/SetaBaixo.bmp"
          movDir        <- loadBMP "bmp/SetaDireita.bmp"
          nitro00       <- loadBMP "bmp/Nitro00.bmp"
          nitro01       <- loadBMP "bmp/Nitro01.bmp"
          nitro10       <- loadBMP "bmp/Nitro10.bmp"
          nitro11       <- loadBMP "bmp/Nitro11.bmp"
          vAzul         <- loadBMP "bmp/VitoriaAzul.bmp"
          vVermelho     <- loadBMP "bmp/VitoriaVermelho.bmp"
          menu          <- loadBMP "bmp/Menu.bmp"
          modo          <- loadBMP "bmp/Modo.bmp"
          tipo          <- loadBMP "bmp/Tipo.bmp"
          fundo         <- loadBMP "bmp/Fundo.bmp"
          let
           imagens = [lava,recta,curvaNorte,curvaOeste,curvaEste,curvaSul,rampaNorte,rampaOeste,rampaEste,rampaSul]
           teclas = [movA,movW,movS,movD,carroVermelho,nitro10,nitro11,movEsq,movCima,movBaixo,movDir,carroAzul,nitro00,nitro01,espaco]
           tab1 = getTab mundoInicial1
           tab2 = getTab mundoInicial2
           tab3 = getTab mundoInicial3
           tab4 = getTab mundoInicial4
           mapa1 = Pictures (desenhaTab tab1 (desenhaPecas tab1 imagens tab1))
           mapa2 = Pictures (desenhaTab tab2 (desenhaPecas tab2 imagens tab2))
           mapa3 = Pictures (desenhaTab tab3 (desenhaPecas tab3 imagens tab3))
           mapa4 = Pictures (desenhaTab tab4 (desenhaPecas tab4 imagens tab4))
          play dm               
               (greyN 0.5)      
               fr               
               (mundoInicial [mapa1,mapa2,mapa3,mapa4,carroAzul,carroVermelho,pausa,(Pictures(desenhaTeclas teclas)),vAzul,vVermelho,menu,modo,tipo,fundo])
               desenhaMundo     
               reageEvento      
               reageTempo       
