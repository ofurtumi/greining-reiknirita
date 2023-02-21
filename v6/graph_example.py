import networkx as nx
import matplotlib.pyplot as plt
import numpy as np
import random


def hierarchy_pos(G, root=None, width=1., vert_gap=0.2, vert_loc=0, xcenter=0.5):
    '''
    From Joel's answer at https://stackoverflow.com/a/29597209/2966723.  
    Licensed under Creative Commons Attribution-Share Alike 

    If the graph is a tree this will return the positions to plot this in a 
    hierarchical layout.

    G: the graph (must be a tree)

    root: the root node of current branch 
    - if the tree is directed and this is not given, 
      the root will be found and used
    - if the tree is directed and this is given, then 
      the positions will be just for the descendants of this node.
    - if the tree is undirected and not given, 
      then a random choice will be used.

    width: horizontal space allocated for this branch - avoids overlap with other branches

    vert_gap: gap between levels of hierarchy

    vert_loc: vertical location of root

    xcenter: horizontal location of root
    '''
    if not nx.is_tree(G):
        raise TypeError(
            'cannot use hierarchy_pos on a graph that is not a tree')

    if root is None:
        if isinstance(G, nx.DiGraph):
            # allows back compatibility with nx version 1.11
            root = next(iter(nx.topological_sort(G)))
        else:
            root = random.choice(list(G.nodes))

    def _hierarchy_pos(G, root, width=4., vert_gap=0.1, vert_loc=0, xcenter=0.5, pos=None, parent=None):
        '''
        see hierarchy_pos docstring for most arguments

        pos: a dict saying where all nodes go if they have been assigned
        parent: parent of this branch. - only affects it if non-directed

        '''

        if pos is None:
            pos = {root: (xcenter, vert_loc)}
        else:
            pos[root] = (xcenter, vert_loc)
        children = list(G.neighbors(root))
        if not isinstance(G, nx.DiGraph) and parent is not None:
            children.remove(parent)
        if len(children) != 0:
            dx = width/len(children)
            nextx = xcenter - width/2 - dx/2
            for child in children:
                nextx += dx
                pos = _hierarchy_pos(G, child, width=dx, vert_gap=vert_gap,
                                     vert_loc=vert_loc-vert_gap, xcenter=nextx,
                                     pos=pos, parent=root)
        return pos

    return _hierarchy_pos(G, root, width, vert_gap, vert_loc, xcenter)


# Create a new empty directed graph
Gr = nx.DiGraph()  # nx.Graph() for undirected graph


# board_path = "h6_example_puzzle.txt"
board_path = "h6_test_puzzle2.txt"
game = np.loadtxt(board_path, delimiter=',', dtype=int)


# global variables
start_pos = ((0, 0), (3, 3))
end_pos = ((3, 3), (0, 0))
n = len(game)


def mark_node(parent, new):
    p_data = Gr.nodes(data=True)[parent]["road_len"]
    Gr.add_node(new, road_len=p_data+1)


Q = []
Q.append(start_pos)
Gr.add_node(Q[0], road_len=0)
while len(Q) > 0:
    u = Q.pop(0)
    if (u == end_pos):
        print(f"fæstu leikir að {end_pos}: {Gr.nodes()[end_pos]['road_len']}")
        break

    r = u[0]
    b = u[1]
    Sr = game[r[1]][r[0]]
    Sb = game[b[1]][b[0]]

    if r[0] + Sb < n:
        new = ((r[0] + Sb, r[1]), b)
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)
            Gr.add_edge(u, new, color="black", weight=1)

    if r[1] + Sb < n:
        new = ((r[0], r[1] + Sb), b)
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)
            Gr.add_edge(u, new, color="black", weight=1)

    if b[0] - Sr >= 0:
        new = (r, (b[0] - Sr, b[1]))
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

    if b[1] - Sr >= 0:
        new = (r, (b[0], b[1] - Sr))
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

    if r[0] - Sb >= 0:
        new = ((r[0] - Sb, r[1]), b)
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

    if r[1] - Sb >= 0:
        new = ((r[0], r[1] - Sb), b)
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

    if b[0] + Sr < n:
        new = (r, (b[0] + Sr, b[1]))
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

    if b[1] + Sr < n:
        new = (r, (b[0], b[1] + Sr))
        if not Gr.has_node(new):
            Q.append(new)
            mark_node(u, new)

            Gr.add_edge(u, new, color="black", weight=1)

# # hægt að nota þetta til að setja áherslu á stystu hnúta í netinu
# p = (nx.shortest_path(Gr, ((0, 0), (3, 3)), ((3, 3), (0, 0))))
# plt.figure(figsize=(20, 6), dpi=100)
# for e in range(1, len(p)):
#     Gr.add_edge(p[e-1], p[e], color="g", weight=3)

# # nota þetta til að teikna netið
# colors = [Gr[u][v]['color'] for u, v in Gr.edges()]
# weights = [Gr[u][v]['weight'] for u, v in Gr.edges()]
# pos = hierarchy_pos(Gr, start_pos)
# nx.draw(Gr, pos, edge_color=colors, width=weights)
# plt.show()

