import networkx as nx
from random import choice, sample
import numpy as np
from matplotlib import pyplot as plot
from algorithms import randomGraph, preferentialGraph, plotGraph


# seleciona um subconjunto de elementos da lista equivalente à percentagem dada
def listSubset(neighbors, percentage):
    k = int(round(len(neighbors) * percentage / 100))
    indexes = sample(range(len(neighbors)), k)
    return [neighbors[i] for i in indexes]

# versão que não revisita nodos
def subsetFlood(algorithm, n, percentage):
    # cria o grafo e calcula o seu diâmetro
    G = randomGraph(n) if (algorithm == "random") else preferentialGraph(n)
    diam = nx.algorithms.distance_measures.diameter(G)
    #print("Diâmetro: " + str(diam))
    iter = 0

    # escolhe o nodo origem aleatoriamente, é "visitado" na ronda 0
    origin = choice(range(n))
    G.nodes[origin]['state'] = iter

    visited = [origin] # lista de nodos visitados
    in_q = [] # lista de nodos para os quais são enviadas mensagens durante a ronda
    out_q = [origin] # lista de nodos que enviam mensagens durante a ronda

    # condição de paragem #1: visita todos os nodos
    while len(visited) < n:
        iter += 1
        new_neighbors = 0 # conta quantos nodos novos encontra em cada ronda
        
        for node in out_q:
            # calcula um subconjunto aleatório dos vizinhos do nodo
            sendTo = listSubset(list(G.neighbors(node)), percentage)

            # só envia mensagem aos vizinhos que ainda não tenham sido visitados
            for neighbor in np.setdiff1d( sendTo, visited ):
                G.nodes[neighbor]['state'] = iter # atualiza o estado do nodo para a ronda em que é contactado
                visited.append(neighbor)
                in_q.append(neighbor)
                new_neighbors += 1 # incrementa a contagem de novos nodos nesta ronda
                
        #print(f'Ronda {iter}: {in_q}') # nodos novos contactados nesta ronda

        # se não tiver encontrado nenhum nodo novo nesta ronda, a mensagem perde-se e não chega a todos
        if (new_neighbors == 0):
            break

        out_q = in_q.copy() # os que receberam mensagem nesta são os que enviam na próxima
        in_q = []
    
    #plotGraph(G,diam)
    return int(round(len(visited) / n * 100)) # percentagem de nodos visitados


# de uma lista de nodos, seleciona aqueles com vizinhos ainda por visitar
def withUnvisitedNeighbors(G, nodes, visited):
    final = []
    for n in nodes:
        # se for um nodo por visitar, envia-lhe mensagem
        if (n not in visited):
            final.append(n)
        # se já tiver sido visitado mas ainda tiver vizinhos por explorar, envia também
        elif (len(np.setdiff1d( list(G.neighbors(n)), visited )) > 0):
            final.append(n)
    return final

# versão que revisita nodos se ainda tiverem vizinhos por visitar
def subsetFlood2(algorithm, n, percentage):
    # cria o grafo e calcula o seu diâmetro
    G = randomGraph(n) if (algorithm == "random") else preferentialGraph(n)
    diam = nx.algorithms.distance_measures.diameter(G)
    #print("Diâmetro: " + str(diam))
    iter = 0

    # escolhe o nodo origem aleatoriamente, é "visitado" na ronda 0
    origin = choice(range(n))
    G.nodes[origin]['state'] = iter

    visited = [origin] # lista de nodos visitados
    in_q = [] # lista de nodos para os quais são enviadas mensagens durante a ronda
    out_q = [origin] # lista de nodos que enviam mensagens durante a ronda

    # condição de paragem #1: visita todos os nodos
    while len(visited) < n:
        iter += 1
        new_neighbors = 0 # conta quantos nodos novos encontra em cada ronda
        
        for node in out_q:
            # calcula um subconjunto aleatório dos vizinhos do nodo
            subset = listSubset(list(G.neighbors(node)), percentage)

            # só envia mensagem aos vizinhos que ainda não tenham sido visitados
            for neighbor in withUnvisitedNeighbors(G, subset, visited):
                if (neighbor not in in_q):
                    in_q.append(neighbor)
                    new_neighbors += 1 # incrementa a contagem de novos nodos nesta ronda

                if (neighbor not in visited):
                    G.nodes[neighbor]['state'] = iter # atualiza o estado do nodo para a ronda em que é contactado
                    visited.append(neighbor)
                
        #print(f'Ronda {iter}: {in_q}') # nodos novos contactados nesta ronda

        # se não tiver encontrado nenhum nodo novo nesta ronda, a mensagem perde-se e não chega a todos
        if (new_neighbors == 0):
            break
        
        out_q = in_q.copy() # os que receberam mensagem nesta são os que enviam na próxima
        in_q = []
    
    #plotGraph(G,diam)
    return int(round(len(visited) / n * 100)) # percentagem de nodos visitados


def simulate(minNodes, maxNodes, step, algorithm):
    for n in range(minNodes, maxNodes+1, step):
        probs = []
        nodesPercent = []

        for prob in range(5, 100, 5):
            result = []

            for j in range(30):
                #result.append(subsetFlood(algorithm, n, prob))
                result.append(subsetFlood2(algorithm, n, prob))

            probs.append(prob)
            nodesPercent.append(np.mean(result))
            print(f'{probs[-1]} - {nodesPercent[-1]}')

        plot.plot(probs,nodesPercent, label = f'{n} nodos')

    plot.title('Subset flooding (com revisita de nodos) - Barabási-Albert sem redundância')
    plot.xlabel('% vizinhos de cada nodo selecionados por ronda')
    plot.ylabel('% nodos visitados')
    plot.legend()
    plot.savefig('subsetFlooding2-noRedundancy.pdf')

#simulate(100, 300, 100, "random")
simulate(100, 300, 100, "preferential")

#subsetFlood("preferential", 30, 50)