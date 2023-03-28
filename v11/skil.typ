#set text(font: "Berkeley Mono", size: 14pt)
#set page(paper: "us-letter", margin: 1cm)
#set heading(numbering: "1. a)")

#let question(content, fill: gray) = {
  set text(style: "italic", size:10pt)
  rect(
    inset: 8pt, 
    radius: 4pt, 
    width: 100%, 
    [#text(weight:"bold", style: "normal")[Spurning: ]\ #content])
}

// Display block code in a larger block
// with more padding.
#show raw.where(block: true): block.with(
  width: 100%,
  fill: luma(230),
  inset: 16pt, // 100% bad
  radius: 4pt,
  breakable: false,
)

= Allt eða ekkert
==
#question[Sýndu hvernig hægt er að leysa AONS verkefnið í margliðutíma]

Fyrir allar breytur í inntaki athugum við hvort að breyta komi fyrir í bæði jákvæðu og 
neikvæðu formi innan einhverrar klausu, sé það staðan er ekki hægt að finna lausn á verkefninu.
Þetta þýðir að í versta falli erum við að athuga $3*n$ stöður sem er tímaflækja $O(n)$.

== 
#question[Útskýrðu hvernig þetta getur staðist þegar 3SAT verkefnið er NP-erfitt]

Þetta stenst vegna þess að aukareglurnar sem settar eru fyrir *AONS* verkefnið 
láta mann vita hvort verkefnið sé hægt eða ekki um leið og fyrsta þversögn kemur fyrir.
Í *3SAT* hinsvegar þarf að athuga öll möguleg mismunandi inntök.


#pagebreak()
= Black box reiknirit
==
#question[Gerðu ráð fyrir að þú hafir aðgang að fallinu `HamiltonDist(G)` sem tekur við
vegnu neti $G = (V, E, W)$ og skilar lengdinni á stystu Hamilton rás í vegnu netinu í
margliðutíma, $(W : E -> NN)$ er fall sem lýsir þyngd sérhvers leggjar). Finndu reiknirit
sem notar þetta fall og finnur stystu Hamilton rásina á margliðutíma.]

Ef við ýtrum yfir alla leggi í netinu og fyrir hvern legg, fjarlægjum hann úr netinu og athugum með `HamiltonDist(G)` hvort lengdin sé önnur en upphaflegt gildi. Við beitum eftirfarani á alla hnúta í röð: 

```rust
fn get_hamilton_road(G: Graph) -> Graph()::Edges {
  const shortest_path = HamiltonDist(G);
  for e in G.edges().clone() {
    G.remove(e);
    if HamiltonDist(G) != shortest_path {
      G.add(e);
    }
  }
  
  return G.edges();
}
```
Við ýtrum yfir alla leggi $G$ og keyrum `HamiltonDist` í hverri ýtrun, tímaflækjan verður því $O(n*"HamiltonDist")$

==
#question[Gerðu ráð fyrir að þú hafir aðgang að fallinu `MaxClique(G)` sem tekur við óstefndu
neti $G = (V, E)$ og segir til um stærð stærstu klíku sem finna má í G á margliðutíma.
Finndu reiknirit sem notar þetta fall og finnur stærstu klíkuna á margliðutíma.]

Við getum nýtt svipaða tækni til að finna stærstu klíkuna. 

Geymum stærð stærstu klíku og ýtrum yfir alla hnúta $G$. Athugum síðan hvort `MaxClique(G)` skilar minna gildi án núverandi hnúts, ef svo er þá setjum hnútinn aftur í netið annars höldum við áfram. 

Þar sem að `MaxClique` keyrir í margliðutíma og við köllum á fallið $V$ sinnum getum við sagst finna stærstu klíku á margliðutíma.

#pagebreak()
= Önnur útgáfa af SAT
#question[Skoðum nú aðra útgáfu af *SAT*, svipað og í *3SAT* krefjumst við þess að formúlurnar séu á *CNF* formi en við leyfum nú að fjöldi breyta í hverri klausu séu ein, tvær eða þrjár. Að auki krefjumst við þess að sérhver breyta komi fyrir í mesta lagi þremur klausum. Sýndu að þessi útgáfa af verkefninu sé NP-erfið með yfirfærslu frá *3SAT*]

Til að yfirfæra *3SAT* verkefni yfir á *123SAT* byrjum við á því að skipta öllum breytum *3SAT* útfyrir breytur með sama nafn plús staðsetningu þeirra í verkefninu sjá: 

$ (A or B or accent(C, ~)) and (accent(A, ~) or B or accent(D, ~)) => (A_1 or B_1 or accent(C_1, ~)) and (accent(A_2, ~) or B_2 or accent(D_1, ~)) $

hérna erum við að leysa, allavega hálf, skorðuna um að breyta megi mest koma fram þrisvar sinnum
síðan, til þess að athuga hvort að nýju breyturnar séu jafnar upprunalegu breytunum t.d. 

$ A = A_1 = A_2 $ 

bætum við klausum þar sem við berum saman hverja nýja breytu við næstu í röðinni þangað við komum að síðustu nýju breytunni og berum hana saman við þá fyrstu til að tryggja þetta sjá:

$ ... and (A_1 or accent(A_2, ~)) and (A_2 or accent(A_3, ~)) and ... and (A_n or accent(A_1, ~)) and ... $
#align(right)[#text(size: 10pt)[(sjá sanntöflu á næstu síðu)]]

nú erum við komin með yfirfærslu sem uppfyllir öll þau skilyrði sem sett voru í verkefnalýsingunni og vegna þess að *3SAT* er NP-erfitt þá getum við sagt að þessi nýja útgáfa af *SAT* sé líka NP-erfið ef færð frá *3SAT*

#pagebreak()
#set align(center)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 6fr, 6fr, 4fr),
  inset: 12pt,
  [A],[B],[C],[D],
  [$(A or accent(B, ~)) and (B or accent(C, ~))$], 
  [$(C or accent(D, ~)) and (D or accent(A, ~))$],
  [$f_"AB" and f_"CD"$],
  [1],[1],[1],[1],[1],[1],[1],
  [1],[1],[1],[0],[1],[0],[0],
  [1],[1],[0],[1],[1],[0],[0],
  [1],[1],[0],[0],[1],[0],[0],
  [1],[0],[1],[1],[0],[1],[0],
  [1],[0],[1],[0],[0],[1],[0],
  [1],[0],[0],[1],[0],[0],[0],
  [1],[0],[0],[0],[0],[0],[0],
  [0],[1],[1],[1],[0],[1],[0],
  [0],[1],[1],[0],[0],[1],[0],
  [0],[1],[0],[1],[0],[0],[0],
  [0],[1],[0],[0],[0],[1],[0],
  [0],[0],[1],[1],[0],[1],[0],
  [0],[0],[1],[0],[0],[1],[0],
  [0],[0],[0],[1],[1],[0],[0],
  [0],[0],[0],[0],[1],[1],[1],
)
