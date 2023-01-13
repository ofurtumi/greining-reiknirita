import networkx as nx
import matplotlib.pyplot as plt


def g(v, e, n):
    e1 = v + e
    e2 = v - e
    e3 = v + n * e
    e4 = v - n * e
    out = []
    if e <= (n - v % n) and e1 <= 25:
        out.append(e1)
    if e <= (v % n - 1) and e2 >= 1:
        out.append(e2)
    if e3 <= 25:
        out.append(e3)
    if e4 >= 1:
        out.append(e4)
    if len(out) > 0:
        return (v, out)


grid = [3, 5, 7, 4, 6,
        5, 3, 1, 5, 3,
        2, 8, 3, 1, 4,
        4, 5, 7, 2, 3,
        3, 1, 3, 2, 0]

graph = [i for (v, e) in enumerate(grid, 1) if (i := g(v, e, 5)) is not None]

G = nx.DiGraph()

color_map = []
for v in graph:
    if v == 1:
        color_map.append("green")
    elif v == 25:
        color_map.append("red")
    else:
        color_map.append("white")
    edges = [(v[0], e) for e in v[1]]
    for e in edges:
        G.add_edge(e[0], e[1])

print(G.edges())

options = {
    "font_size": 36,
    "node_size": 5000,
    "edgecolors": "black",
    "linewidths": 5,
    "width": 5,
    "font_weight": "bold",
}

node_colors = ["yellow" if node == 1 or node == 25 else "white" for node in G]
edge_colors = ["green" if edge in [(1,4),(4,24),(24,22),(22,23),(23,8),(8,7),(7,10),(10, 25)] else "black" for edge in G.edges()]

pos = {
    1:  (-2, 2),
    4:  (-2, 3),
    24: (-1, 4),
    16: (-2, 1),
    2:  (1, 0),
    11: (-1, 2),
    3:  (2, 0),
    5:  (-2, 0),
    6:  (-2, 4),
    7:  (1, 2),
    8:  (1, 1),
    9:  (2, 2),
    10: (2, 1),
    12: (1, 2),
    13: (-1, 1),
    14: (1, 3),
    15: (3, 3),
    17: (1, 4),
    18: (2, 3),
    19: (2, 4),
    20: (-1, 0),
    21: (-1, 3),
    22: (0, 3),
    23: (0, 0),
    25: (4, 1),
}

fig = plt.figure(1, figsize=(20, 15), dpi=100)
nx.draw_networkx(G, pos, node_color=node_colors, edge_color=edge_colors, **options)
plt.show()
