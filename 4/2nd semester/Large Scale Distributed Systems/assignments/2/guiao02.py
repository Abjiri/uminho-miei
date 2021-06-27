import networkx as nx
import numpy as np
import collections
from matplotlib import pyplot as plot
from itertools import combinations
from random import choice, sample

def plot_histogram(G):
    degree_sequence = sorted([d for n, d in G.degree()], reverse=True)  # degree sequence
    degreeCount = collections.Counter(degree_sequence)
    deg, cnt = zip(*degreeCount.items())

    fig, ax = plot.subplots()
    plot.bar(deg, cnt, width=0.80, color="b")

    plot.title("Degree Histogram")
    plot.ylabel("Count")
    plot.xlabel("Degree")
    ax.set_xticks([d + 0.4 for d in deg])
    ax.set_xticklabels(deg)

    # draw graph in inset
    plot.axes([0.4, 0.4, 0.5, 0.5])
    Gcc = G.subgraph(sorted(nx.connected_components(G), key=len, reverse=True)[0])
    pos = nx.spring_layout(G)
    plot.axis("off")
    nx.draw_networkx_nodes(G, pos, node_size=20)
    nx.draw_networkx_edges(G, pos, alpha=0.4)
    #plot.show()
    plot.savefig(f'{G.number_of_nodes()}nodos.pdf')

def simulate(n): 
    G = nx.Graph() #criar o grafo
    G.add_node(0) #adicionar o primeiro nodo
    tickets = [0] #inicializar a lista de "bilhetes" com o do primeiro nodo
    E = list(combinations(range(n), 2)) #lista de todas as arestas possíveis

    #inserir os restantes nodo 1 a 1; sempre que insiro um, faço-lhe uma ligação
    for i in range(1,n):
        node = choice(tickets) #escolhe o nodo a que se vai ligar aleatoriamente da lista de bilhetes
        E.remove((i,node) if ((i,node) in E) else (node,i)) #remove a nova aresta de E
        tickets.extend([i,node]) #adiciona um bilhete de cada um dos nodos com nova ligação a tickets
        G.add_edge(i,node) #adiciona a aresta ao grafo

    #enquanto o grafo não for conectado, continua a gerar arestas
    while not nx.is_connected(G):
        e = sample(tickets,2) #escolhe 2 nodos para estabelecer a nova ligação
        while ((e[0],e[1]) in E or (e[1],e[0]) in E): #verifica que a aresta não existe já
            e = sample(tickets,2)

        E.remove((e[0],e[1]) if ((e[0],e[1]) in E) else (e[1],e[0]))
        tickets.extend([e[0],e[1]])
        G.add_edge(e[0], e[1]) 
    plot_histogram(G)
    return G.size()

def runSimulations(min,max,step):
    nodes = []
    edges = []
    for i in range(min,max,step):
        result = []
        for j in range(30):
            result.append(simulate(i))
        nodes.append(i)
        edges.append(np.mean(result))
        print(f'{nodes[-1]} - {edges[-1]}')
    plot.plot(nodes,edges)
    plot.xlabel('Nodos')
    plot.ylabel('Arestas')
    plot.axis('scaled')
    plot.savefig('output.pdf')

#runSimulations(10,500,10)
simulate(100)