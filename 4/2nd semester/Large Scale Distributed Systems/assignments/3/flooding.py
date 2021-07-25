import networkx as nx
from random import choice
import numpy as np
from matplotlib import pyplot as plot
from algorithms import randomGraph, preferentialGraph, plotGraph


# versão em que um nodo propaga a mensagem para todos os vizinhos
def basicFlood(algorithm, n):
    # cria o grafo e calcula o seu diâmetro
    G = randomGraph(n) if (algorithm == "random") else preferentialGraph(n)
    diam = nx.algorithms.distance_measures.diameter(G)
    #print("Diâmetro: " + str(diam))
    round = 0

    # escolhe o nodo origem aleatoriamente, é "visitado" na ronda 0
    origin = choice(range(n))
    G.nodes[origin]['state'] = round

    visited = [origin] # lista de nodos visitados
    in_q = [] # lista de nodos para os quais são enviadas mensagens durante a ronda
    out_q = [origin] # lista de nodos que enviam mensagens durante a ronda

    # em flooding, vai sempre chegar a todos os nodos
    while len(visited) < n:
        round += 1
        
        for node in out_q:
            for neighbor in G.neighbors(node):
                # atualiza o estado de um nodo para a primeira ronda em que lhe chegou uma mensagem
                if (G.nodes[neighbor]['state'] < 0):
                    G.nodes[neighbor]['state'] = round
                
                # adiciona à lista de visitados se for a primeira vez
                if (neighbor not in visited):
                    visited.append(neighbor)

                # adiciona à in_queue, sem repetir o mesmo nodo (p.e. se X e Y mandaram para Z, Z só aparece 1x na queue)
                if (neighbor not in in_q):
                    in_q.append(neighbor)
                
        #print(f'Ronda {round}: {in_q}') # nodos novos contactados nesta ronda
        out_q = in_q.copy() # os que receberam mensagem nesta são os que enviam na próxima
        in_q = []
    
    #plotGraph(G,diam)
    return round
    

# versão em que um nodo só propaga a mensagem para os vizinhos por visitar
def optimizedFlood(algorithm, n):
    # cria o grafo e calcula o seu diâmetro
    G = randomGraph(n) if (algorithm == "random") else preferentialGraph(n)
    diam = nx.algorithms.distance_measures.diameter(G)
    #print("Diâmetro: " + str(diam))
    round = 0

    # escolhe o nodo origem aleatoriamente, é "visitado" na ronda 0
    origin = choice(range(n))
    G.nodes[origin]['state'] = round

    visited = [origin] # lista de nodos visitados
    in_q = [] # lista de nodos para os quais são enviadas mensagens durante a ronda
    out_q = [origin] # lista de nodos que enviam mensagens durante a ronda

    # em flooding, vai sempre chegar a todos os nodos
    while len(visited) < n:
        round += 1
        
        for node in out_q:
            # ignora os vizinhos que já tenham sido visitados e só envia mensagem para novos
            for neighbor in np.setdiff1d( list(G.neighbors(node)), visited ):
                G.nodes[neighbor]['state'] = round
                visited.append(neighbor)
                in_q.append(neighbor)
                
        #print(f'Ronda {round}: {in_q}') # nodos novos contactados nesta ronda
        out_q = in_q.copy() # os que receberam mensagem nesta são os que enviam na próxima
        in_q = []
    
    #plotGraph(G,diam)
    return round


def simulate(minNodes, maxNodes, algorithm):
    nodes = []
    rounds = []

    for i in range(minNodes, maxNodes):
        result = []

        for j in range(30):
            #result.append(basicFlood(algorithm, i))
            result.append(optimizedFlood(algorithm, i))

        nodes.append(i)
        rounds.append(np.mean(result))
        print(f'{nodes[-1]} - {rounds[-1]}')

    plot.plot(nodes,rounds)
    plot.title('Flooding otimizado - Barabási-Albert sem redundância')
    plot.xlabel('# nodos')
    plot.ylabel('# rondas para atingir todos os nodos')
    #plot.axis('scaled')
    plot.savefig('optimizedFlood.pdf')


#simulate(10, 200, "random")
simulate(10, 200, "preferential")