import networkx as nx
import numpy as np
from matplotlib import pyplot as plot
from itertools import combinations
from random import choice

#10-500-5 -> nodos x arestas; 10 nodos até 500, step 5; gráfico escalado
#10-1000-10 -> nodos x arestas; 10 nodos até 1000, step 10; gráfico escalado

def simulate(n): 
    G = nx.Graph() 
    G.add_nodes_from(range(n))
    E = list(combinations(range(n), 2))

    while True: 
        e = choice(E)
        E.remove(e)
        G.add_edge(e[0], e[1]) 
        if nx.is_connected(G):
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
    plot.show()

#runSimulations(10,100,5)