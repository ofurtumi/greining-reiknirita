#set page(margin: (x: 24pt, y: 32pt))
#set text(size: 10pt)

#let bbox(title, input, time, description) = {
  block(
    breakable: false,
    [#grid(
      columns: (1fr, 1fr),
      [*#title* (#text(size: 8pt, [$#input$]))],
      align(right, [$#time$])
    )
    #description,
    #box(width: 1fr, fill: luma(230), height: 2pt)
    ]
  )
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


= RAKNINGARVENSL

summur af eftirfarandi hafa sömu útkomu, $(n(n+1)/2)$ sem er $O(n^2)$

$sum_(k=0)^n k = 0 + 1 + 2 + ... + n ) = O(n^2)$
$sum_(k=0)^n n-k = n + (n-1) + (n-2) + ... + 0 = O(n^2)$

summur kvótaraða hafa líka sína eigin formúlu,
$ sum_(k=0)^n r^k = cases(r != 1 := (r^(n+1) - 1) / r-1, r = 1 := (n+1)) $

líka hægt að nota þetta stundum, þegar $0 <|r|<1$
$ sum_(k=0)^(infinity) r^k = 1/(1-r) approx 1 $

= LOGARITMAR
$x^(log_x(y)) = y$
$x^(log_x(y) + 1) = x^(log_x(y) + log_x(x)) = x^(log_x(x times y)) = x times y$

#text(size: 8pt, [ef hægt er að mynda $x$ sem $z$ í veldi $y$ þá gengur eftirfarandi])
$x^(log_z(n)) = (z^y)^(log_z(n)) = z^(y times log_z(n)) = z^(log_z(n^y)) = n^y$ \ 

= MASTER THEOREMS 
== *$T(n) = a dot.op T(n/b) + f(n^c)$*

+ Ef $c < log_b(a)$ þá er $T(n) = O(n^(log_b(a)))$
+ Ef $c = log_b(a)$ þá er $T(n) = O(n^(log_b(a)) dot.op log(n))$
+ Ef $c > log_b(a)$ þá er tími reikniritsins $T(n) = O(f(n))$

== *$T(n) = a dot.op T(n-b) + f(n)$*
+ Ef $a<1$ þá er $T(n) = O(f(n))$
+ Ef $a=1$ þá er $T(n) = O(n dot.op f(n))$
+ Ef $a>1$ þá er $T(n) = O(f(n) dot.op n^(a/b))$

= LEGGIR OG LEIÐINDI
leggir skilgreindir sem $U -> V$ þar sem $U$ er upphafspunktur og $V$ er endapunktur. 

== fram / trjáleggir
V er nýr þegar djúpleit á *U* hefst: $U."pre" < V."pre" < V."post" < U."post"$
+ *trjáleggur* ef U er foreldri V
+ *framleggur* annars

== bakleggur
v er virkur þegar dýptarleit á *U* hefst: $V."pre"< U."pre" < U."post" < V."post"$

== krossleggur
V búinn lokið þegar dýptarleit á *U* hefst: $V."post" < U."pre"$

= DYNAMIC PROGRAMMING
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



= NETAREIKNIRIT

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

= LÍNULEG BESTUN
Formúla linu er $y=a dot.op x+b$ þar sem $a$ er hallatala línu og $b$ er skurðpunktur við $y$ ás. Til að finna skurðpunkt lína setja upp jöfnuhneppi og leysa fyrir x.

Fjöldi skurpðpunkta útfrá skorðum er $binom("n", 2) -> "nCr"$ þar sem n er fjöldi skorða, á meðan hornapunktar gjaldgenga svæðisins tákna bara innliggjandi horn, sést mjög auðveldlega á mynd.

= P/NP
verkefni sem #underline[hægt] er að leysa í margliðutíma eru í flokknum P, verkefni sem #underline[ekki hægt] er að leysa í margliðutíma eru í flokknum NP. 
- *Ákvörðunarverkefni:* verkefni sem hafa lausn já/nei
  - *P:* hægt að leysa í margliðutíma
  - *NP:* hægt að staðfesta já á margliðutíma
    - líka ef hægt er að leysa þekkt NP-verkefni með lausn á þessu verkefni
  - *co-NP:* hægt að staðfesta nei á margliðutíma
#example([Reynum að finna minnsta _sterka_ mengi hnúta í neti $G$. Setjum verkefnið fram sem ákvörðunarverkefni, þ.e. svörum fyrir gefna tölu $k$ hvort til sé sterkt mengi af stærð $k$ í netinu. Við getum ekki svarað því í margliðutíma en við getum, ef við fáum gefið mengi þá getum við svarað í margliðutíma hvort það sé af stærð $k$ eða ekki. Þetta er NP-verkefni #text(size: 6pt, [_(co-NP)_]).])

= SLEMBIREIKNIRIT
Líkur á atburði $A$ eru táknaðar með $Pr[A]$ og fengnar með $sum_(w in A) Pr[cal(w)]$ þ.e. fyrir tening með fjórar hliðar er mengi sléttra talna $Omega = {2,4}$ og líkurnar á að fá aðra þeirra eru $1/4 + 1/4 = 2/4$

Fyrir tvo fjögurra hliða teninga eru heildafjöldi útkoma hjá okkur $4^2$ þannig mengi þar sem báðir teningar hafi slétta tölu er $Omega = {(2,2), (4,2), (2,4), (4,4)}$ og líkurnar þá $4*1/16= 4/16 = 1/4$. 

Þetta virkar þar sem fyrir sérhverja tvo atburði $A$ og $B$ með $Pr[B] > 0$ skilgreinum við skilyrtar líkur á $A$ gefið $B$, þ.e.$A$ og $B$, sem $Pr[A | B] = (Pr[A and B]) / Pr[B]$

Líkur á að fá í mesta lagi einn $3$ þegar við köstum tveimur tengingum og vitum að fyrri teningurinn skilar alltaf $3$ eru $3/4$, sjáum að ef við notum formúluna fyrir ofan er $A$ að fá ekki þrist á öðrum teningnum, $B$ er að fyrri teningur skilar alltaf $3$. $Pr[A] = 3/4$ og $Pr[B] = 1/4$. Þessu er síðan hægt að plugga inn í formúluna uppi.

Væntigildi $max(X_1, X_2)$, þar sem $X_1$ og $X_2$ eru fjögurra hliða teningar, höfum við útkomumengi $Omega = {(1,1), (1,2), (1,3),...,(4,3), (4,4)}$ 

Væntigildið er þá summa líkna þess að fá gildi, margfaldað við gildi þ.e. $1*1/16+2*3/16+3*5/16+4*7/16$

Þetta er svo mikið rugl??

= TIPS N TRICKS
- Kvik bestunardæmi sem hægt er að leysa með þríhyrnings geymslu, _tvívítt fylki sem geymir "bestu" lausn fyrir þann reit_, eru yfirleitt $M dot.op N$
- Línuleg bestun er auðveld, bara plugga skorðum inn í simplex
- Hafa gaman :)
- Drekka jafnt magn vatns og áfengis á djamminu
- Alltaf hafa hreinar nærbuxur aðgengilegar

= Vaxtarhraði
$1<log(n)<(log(n))^c<sqrt(n)<n<n log(n)<n^c<c^n<n^n<n!$
Þar sem c er einhver fasti