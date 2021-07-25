import networkx as nx
from itertools import combinations
import matplotlib.patches as mpatches
from matplotlib import pyplot as plot
from random import choice, sample


def randomGraph(n): 
    G = nx.Graph() 
    G.add_nodes_from(range(n), state=-1)
    E = list(combinations(range(n), 2))

    while not nx.is_connected(G): 
        e = choice(E)
        E.remove(e)
        G.add_edge(e[0], e[1])
    
    return G


def preferentialGraph(n):
    G = nx.Graph() #criar o grafo
    G.add_node(0, state=-1) #adicionar o primeiro nodo
    tickets = [0] #inicializar a lista de "bilhetes" com o do primeiro nodo
    E = list(combinations(range(n), 2)) #lista de todas as arestas possíveis

    #inserir os restantes nodos 1 a 1; sempre que insiro um, faço-lhe uma ligação
    for i in range(1,n):
        node = choice(tickets) #escolhe o nodo a que se vai ligar aleatoriamente da lista de bilhetes
        E.remove((i,node) if ((i,node) in E) else (node,i)) #remove a nova aresta de E
        tickets.extend([i,node]) #adiciona um bilhete de cada um dos nodos com nova ligação a tickets
        G.add_edge(i,node) #adiciona a aresta ao grafo
        G.nodes[i]['state'] = -1

    #como adiciona um nodo e aresta de cada vez, o grafo vai ser sempre conectado
    
    #adicionar redundância ao grafo, para o flooding não ser tão linear
    #for i in range(n):
    #    e = sample(tickets,2) #escolhe 2 nodos para estabelecer a nova ligação
    #    while (not ((e[0],e[1]) in E or (e[1],e[0]) in E)): #verifica que a aresta não existe já
    #        e = sample(tickets,2)

    #    E.remove((e[0],e[1]) if ((e[0],e[1]) in E) else (e[1],e[0]))
    #    tickets.extend([e[0],e[1]])
    #    G.add_edge(e[0], e[1])

    return G

# cria um mapa de cores para os nodos do grafo
def nodesColorMap(G):
    color_map = []

    for (p, d) in G.nodes(data=True):
        # a origem fica a verde
        if d['state'] == 0:
            color_map.append('green')
        # os nodos que não foram atingidos a vermelho
        elif d['state'] < 0:
            color_map.append('red')
        # o resto a cinzento
        else:
            color_map.append('grey')

    return color_map


def plotGraph(G, diam):
    color_map = nodesColorMap(G)
    pos = nx.spring_layout(G)
    nx.draw(G, pos, node_color=color_map)

    node_labels = nx.get_node_attributes(G,'state')
    nx.draw_networkx_labels(G, pos, node_labels)

    edge_labels = nx.get_edge_attributes(G,'state')
    nx.draw_networkx_edge_labels(G, pos, edge_labels)

    plot.legend(handles = [mpatches.Patch(label='Diâmetro: ' + str(diam))] )
    plot.show()