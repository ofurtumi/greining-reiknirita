---
script: 
    - path: utils/mathjax-config.js
    - url: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js
---

# heimaverkefni 6

## 1. litunartala
Ef við skoðum skilgreiningu á tvíhlutanetum þá má sjá að "tvíhlutanet er net sem inniheldur enga hringi af oddatölulengd", 
þá getum við séð að ef netið okkar inniheldur enga hringi af oddatölulengd er netið tvískipt og þá með litatölu 2

þá höfum við í raun þrjár stöður
1. ef netið okkar inniheldur enga hringi af oddatölulengd, þar með talið enga hringi, hefur netið litatölu **2**
2. ef netið inniheldur hringi af oddatölulengd má nota setningu Brooks og segja að litatalan sé **3**
3. ef allir hnútar netsins hafa enga aðlæga hnúta er litatala **1**

```python
def color2deg(V,E):
    if E.length == 0: return 1
    for v in V:
        if v.prev.marked:
            v.marked = v.prev.marked ^ 1
            if v.marked == v.post.marked:
                return 3
    return 2
```


## 2. djúpleit
### a)
við getum sagt til um hvort leggur `(u,v)` sé bak- eða krossleggur út frá pre og post gildum leggjanna, ákvörðun fylgir eftirfarandi reglum

leggur er **bakleggur** ef 
- `v` er virkur þegar dýptarleit hefst á `u`
- $v.pre < u.pre < u.post < v.post$

leggur er **krossleggur** ef
- `v` er lokið þegar dýptarleit hefst á `u`
- $v.post < u.pre$

### b)
trjáleggir eru leggir sem koma í ljós eftir að búið er að framkvæma DFS á net  
framleggir eru leggir `(u,v)` þar sem `v` er afkomandi `u` án þess þó að leggurinn sé partur af djúpleitartréinu  

með þessum skilgreiningum er hægt að sjá að það þarf fleiri upplýsingar um leggi og djúpleitartréð en bara **pre** og **post**, helst dýpt trésins, til þess að gera greinarmun á trjá og framleggjum, 

## 3. yfirfærsla
táknum borðið sem tvívítt fylki 
$[n\times n]$ þar sem hvert stak táknar gildi á borðinu  

byggjum upp netið með því að hugsa um stöður $S_r$ og $S_b$ sem hnút, þ.e. fyrsti hnúturinn væri $((0,0), (3,3))$, 
markmið okkar er þá að finna stystu leið í stöðuna $((3,3),(0,0))$, hnútarnir innihalda líka upplýsingar um fjarlægð sína frá rót

við byggjum netið með því að bæta, fyrir núverandi stöðu, öllum löglegum stöðum í biðröð og ganga svo í gegn um biðröðina og bæta við hnút og legg frá foreldrisstöðu í löglegar stöður, einskonar BFS,

ef við lendum einhverntímann á hnút sem hefur lokastöðuna okkar $((3,3),(0,0))$ þá stoppum við leitina og skilum fjölda leggja, leikja, sem tók að komast þangað

## 4. networkx

```python
# Create a new empty directed graph
Gr = nx.DiGraph()  # nx.Graph() for undirected graph


board_path = "h6_example_puzzle.txt"
# board_path = "h6_test_puzzle2.txt"
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
```

### útkomur
| dæmi    | fæstu leikir |
| ------- | ------------ |
| example | 5            |
| p0      | 12           |
| p1      | 10           |
| p2      | 14           |