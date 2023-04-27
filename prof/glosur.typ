#set page(margin: (x: 24pt, y: 32pt))
#set text(size: 10pt)

#let bbox(title, input, time, description) = {
  grid(
    columns: (1fr, 1fr),
    [*#title* (#text(size: 8pt, [$#input$]))],
    align(right, [$#time$])
  )
  [#description]
  box(width: 1fr, fill: luma(230), height: 2pt)
}

#show raw.where(block: true): it => block(
  width: 100%,
  fill: luma(210),
  inset: 8pt, // 100% bad
  radius: 4pt,
  breakable: false,
  text(7pt, it)
)

#let example(body) = {
  block(
    width: 100%,
    inset: 4pt,
    stroke: 1pt,
    radius: 4pt,
    text(8pt, [#body])
  )
}


#show: rest => columns(2, rest)


= rakningarvensl

summur af eftirfarandi hafa sömu útkomu, $(n(n+1)/2)$ sem er $O(n^2)$

$sum_(k=0)^n k = 0 + 1 + 2 + ... + n ) = O(n^2)$
$sum_(k=0)^n n-k = n + (n-1) + (n-2) + ... + 0 = O(n^2)$

summur kvótaraða hafa líka sína eigin formúlu,
$ sum_(k=0)^n r^k = cases(r != 1 := (r^(n+1) - 1) / r-1, r = 1 := (n+1)) $

*muna* $a dot.op x^2 +b dot.op x + c = (-b +- sqrt(b^2-4a dot.op c))/(2a)$

= logaritmar
$x^(log_x(y)) = y$
$x^(log_x(y) + 1) = x^(log_x(y) + log_x(x)) = x^(log_x(x times y)) = x times y$

#text(size: 8pt, [ef hægt er að mynda $x$ sem $z$ í veldi $y$ þá gengur eftirfarandi])
$x^(log_z(n)) = (z^y)^(log_z(n)) = z^(y times log_z(n)) = z^(log_z(n^y)) = n^y$ \ 

= master theorem (recursion)

$T(n) = a times T(n/b) + f(n)$

+ Ef $f(n)$ er $O(n^c)$, þar sem $c$ er ehv fasti, og $f(n)$ er minna en $n^(log_b(a))$ þá er $T(n) = O(n^(log_b(a)))$
+ Ef $f(n)$ er $O(n^c)$ og $f(n) == n^(log_b(a))$ þá er $T(n) = O(n^(log_b(a)) times log(n))$
+ Ef $f(n)$ er $O(n^c)$ og $f(n)$ er stærra en $n^(log_b(a))$ og það er til ehv fasti $d$ sem sýnir að $a times f(n/b) <= d times f(n)$ fyrir öll nógu stór $n$, þá er tími reikniritsins $T(n) = O(f(n))$

= DYP (dynamic programming)
#example(
  [
    við höfum runu spilapeninga $t_1,...,t_n$. hver spilapeningur hefur tvo eiginleika, virði og lit. virði er tala á forminu $2,4,8,...,2048$ og litir eru R, G eða B. Við getum myndað vensl á milli peninga ef þeir uppfylla eftirfarandi reglur:
    - þeir hafa virði, eða
    - þeir eru í sama lit, eða 
    - annar þeirra hefur virði 2

    við viljum finna lengstu hlutrunu spilapeninga $t_(i_1) ... t_(i_k)$ þar sem $i_1 < ... < i_k$.

    Tökum sem dæmi rununa $4R, 4B, 16R, 16G, 2R$
  ]  
)

== skref
+ lýsum undirverkefnum
  - undirverkefni hér væri að finna lengstu venslu hlutrunu frá hverju staki
+ lýsum ákvörðun / ágiskun í hverju undirskrefi
  - hér þyrftum við að ákvarða hvaða stak væri best að halda áfram með í rununninni
  - það er frekar augljóst að besta stakið til bæta núverandi runu er það sem hefur lengstu hlutrunu nú þegar
+ lýsum rakningarvenslum
  - tökum skrefin á undan og bætum við grunntilviki
  $ f(i) = cases(i = n: 1, i != n: max("arr" in t_i~t_j and i < j)) $
+ lýsum hvernig koma má í veg fyrir endurtekt með því að geyma niðurstöðurstöður
  - hérna þurfum við að vita hvað besta runa af stökum $A[i+1...]$
  - við geymum þær upplýsingar í einföldu fylki þar sem hvert stak táknar lengstu runu frá því staki
+ rökstyðjum tímaflækju 
  - í hverju skrefi erum við að velja _max(arr)_ og sú aðferð ítrar yfir öll stök fylkisins í $O(n)$ tíma 
  - við endurtökum þessi undirskref fyrir öll stök fylkisins
  - lokatímaflækja er $O(n*n) = O(n^2)$


= leggir og leiðindi
leggir skilgreindir sem $U -> V$ þar sem $U$ er upphafspunktur og $V$ er endapunktur. 

== fram / trjáleggir
V er nýr þegar djúpleit á *U* hefst: $U."pre" < V."pre" < V."post" < U."post"$
+ *trjáleggur* ef U er foreldri V
+ *framleggur* annars

== bakleggur
v er virkur þegar dýptarleit á *U* hefst: $V."pre"< U."pre" < U."post" < V."post"$

== krossleggur
V búinn lokið þegar dýptarleit á *U* hefst: $V."post" < U."pre"$

= netareiknirit

#table(
  columns: (3fr, 4fr, 3fr, 4fr),

  [Net *G=(V,E)*], [Vogtölur], [Reiknirit], [Tímaflækja],
  [ó/stefnt, rásað], [$w in bb(R), w >= 0$], [Dijkstra], [$O(log(V)E)$],
  [ó/stefnt, rásað], [$w in bb(R)$], [Bellman-Ford], [$O(V E)$],
  [stefnt, órásað], [$w in bb(R)$], [SSSPDAG], [$O(V + E)$],
)

```python
def dijkstra(G, start):
  dist, parent = {}, {}
  for v in G.v: dist[v]
  Q = new minPQ(start)  

  while Q:
    v = Q.pop()
    for u in G[v]:
      if dist[u] > dist[v] + G[v][u]:
        dist[u] = dist[v] + G[v][u]
        parent[u] = v
        Q.push(u))
```

#bbox(
  "MaxFlow",
  "G = (V,E)",
  "O(VE)",
  "Tekur inn flæðisnet og skilar því með hámarksflæði, passa að leggir þurfa þyngd",
)
#bbox(
  "FlowToPaths",
  "MaxFlow",
  "O(E)",
  "Tekur inn flæðisnet, búið að finna maxflow og skilar vegum sem fylgja því með tilliti til hnúta",
)
#bbox(
  "FlowToMatching",
  "MaxFlow",
  "O(E)",
  "Tekur inn maxflow og varpar yfir í spyrðingu"
)
#bbox(
  "MaximumMatching",
  "G(V,E)",
  "",
  "Tekur inn net með hnúta af týpu inn-út, og skilar hámarksspyrðingu, líka hægt að fá með MaxFlow",
)
#bbox(
  "MatchingToCover",
  "Matching",
  "",
  "Tekur inn spyrðingu úr falli eins og MM og skilar þakningu yfir netið",
)

= línuleg bestun
Formúla linu er $y=a dot.op x+b$ þar sem $a$ er hallatala línu og $b$ er skurðpunktur við $y$ ás. Til að finna skurðpunkt lína setja upp jöfnuhneppi og leysa fyrir x.

= P/NP
verkefni sem #underline[hægt] er að leysa í margliðutíma eru í flokknum P, verkefni sem #underline[ekki hægt] er að leysa í margliðutíma eru í flokknum NP. 
- *Ákvörðunarverkefni:* verkefni sem hafa lausn já/nei
  - *P:* hægt að leysa í margliðutíma
  - *NP:* hægt að staðfesta já á margliðutíma
  - *co-NP:* hægt að staðfesta nei á margliðutíma
#example([Reynum að finna minnsta _sterka_ mengi hnúta í neti $G$. Setjum verkefnið fram sem ákvörðunarverkefni, þ.e. svörum fyrir gefna tölu $k$ hvort til sé sterkt mengi af stærð $k$ í netinu. Við getum ekki svarað því í margliðutíma en við getum, ef við fáum gefið mengi þá getum við svarað í margliðutíma hvort það sé af stærð $k$ eða ekki. Þetta er NP-verkefni #text(size: 6pt, [_(co-NP)_]).])


