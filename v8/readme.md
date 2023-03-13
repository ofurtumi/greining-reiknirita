---
script: 
    - path: utils/mathjax-config.js
    - url: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js
---
# heimaverkefni 8


## 1. 
ef við ímyndum okkur að við höfum hnúta 
$s_0$ og 
$t_0$ þar sem rými úr 
$s_0$ og rými inn í 
$t_0$ eru bæði 
$\infty$

tengjum núna þessa nýju hnúta við þá sem voru upphaflega í flæðisnetinu það mun þá líta svona út:  

![](imgs/multiple.png)

nú erum við búin að leysa kjarna vandans, að vera með marga $s$ og $t$ hnúta

þessi aðferð virkar líka fyrir net sem hafa hnúta sem eru bæði upphafs og endahnútar á sama tíma, við þurfum samt að bæta við einu skrefi til að það virki  
> fyrir alla hnúta V sem eru bæði upphafs- og endahnútar skiptum við þeim upp í tvennt, fyrir hnút $V_i$ yrði skiptingin $SV_i$ og $TV_i$ þar sem flæðið á milli leggjana ákvarðaðist af $w_i$

## 2. sundurliðun tvíhlutanets...
við höfum G sem er tvíhluta net með hnúta 
$L \cup R$ og leggi E. 
tökum núna afrit af þessu neti og breytum því þannig að hver leggur sé hnútur með nafn 
$(L_i, R_j)$ og tengjum þessa hnúta þannig að þeir uppfylli
$i < i' \land j <j'$, köllum þetta net F

skoðum sýnidæmi fyrir þessa aðferð á nýju neti G:  

![](imgs/decomp.excalidraw.png)

**sauðakóði?? áhersla á sauða**
```rust
let F = G.edges().map(|e.u, e.v| Node(e.u, e.v)) // búum til nýtt net F úr leggjum G
for current in F.nodes() { // ítrum yfir alla leggi í nýja netinu
    for adj in F.nodes().filter(not current) { // og athugum fyrir alla aðra hnúta en núverandi
        if current.u < adj.u && current.v < adj.v { // hvort hægt sé að tengja samkvæmt reglu
            F.connect(current, adj) // og tengjum ef svo er
        }
    }
}

let decomp = F.dpc() // keyrum "black box" reikniritið disjoint path coverage
for road in decomp.roads { // ítrum yfir alla aðskilda vegi F 
    G.show(List(road)) // og sýnum tilheyrandi vegi úr G
}
```
> þakning fyrir aðskilda vegi