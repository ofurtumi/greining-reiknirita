#set text(size: 13pt)
#set page(paper: "us-letter", margin: 1cm)
#set heading(numbering: "1. ")

#show figure: it => align(center)[
  #it.body
  #text(size: 10pt)[#it.caption]
]

=
Framleiðum nammiöskjur þar sem markmið okkar er að fylla sem flestar öskjur af a.m.k. $L$ þyngd af nammi per öskju. Hvert nammi $t_i$ er $0 < t_i < L$. 

+ Röðum öllu namminu í vaxandi röð þannig að $w_i <= w_(i+1)$ 
+ Byrjum að troða öllu því nammi sem kemst ofan í öskju þangað til við förum yfir $L$ 
+ Um leið og við förum yfir $L$ færum við okkur í nýja öskju og endurtökum skref 2 og 3 þangað til allt nammi er búið

Í versta falli höfum við fullt af litlu nammi sem saman nær ekki upp í heila öskju þannig við þurfum að bæta við stóru nammi til að ná upp fyrir $L$. 

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  align(horizon)[Látum okkur hafa nammi þar sem við höfum 4 stór nammi, $0.9$ og 4 lítil nammi $0.2$ með $L = 1.0$. Í fljótu bragði getum við séð að besta lausn væri að para stórt nammi við lítið nammi og enda þannig með 4 öskjur af þyngd $1.1$.],
  image("imgs/best-1.png"),
)

Ef við beitum ofangreindri aðferð byrjum við að setja öll 4 litlu nömmin í sömu öskju, við sjáum að $4 times 0.2 = 0.8 < 1.0$, það uppfyllir ekki skilyrðin $"askja" >= L$ þannig nú þurfum við að bæta einu þungu nammi í þessa öskju til að uppfylla skilyrðin. 

Þá eigum við bara þrjú þung "nömm" eftir, við pörum tvö þeirra saman og fáum $1.8 > L$ en þar sem við getum engu bætt við síðasta nammið verðum við að bæta því í öskju sem er nú þegar til. 

Bætum í léttari öskjuna og endum með tvær öskjur af þyngd $1.8$ og $2.6$, ekki frábær lausn en uppfyllir skilyrðin að vera a.m.k. $"besta" / 2$, sjá mynd: 

#align(center)[#image("imgs/okkar-1.png", width: 75%)]

#pagebreak()
=
#grid(
  gutter: 12pt,
  columns: (1fr, 1fr),
  rows: (auto),
  [#image("imgs/G.excalidraw.png")],
  align(horizon)[
  Gefum okkur netið $G$ sem inniheldur fjóra hnúta $[A, B, C, D]$ og eftirfarandi leggi: 
  - $D->[A, B, C]$
  - $C->[A, B]$ 
  - $B->[A, C]$ 
  - $A->[D]$ 

  sem sýna hvernig hnútar eru tengdir. Þá er $G$ eins og á myndinni hér til hliðar.],
)


#grid(
  gutter: 12pt,
  columns: (1fr, 2fr),
[Ef við skoðum bestu lausn þá sést að það væri að raða hnútunum í röð $D -> C -> B -> A$ eða $D -> B -> C -> A$ þar sem leggir örvar benda til hægri eru *6*, sjá mynd:],


align(center)[#image("imgs/legs.excalidraw.png")]

)
Skoðum nú leiðir til þess að nálgast þessa niðurstöðu. Byrjum á að prófa að fara í gegnum netið og búa til röð af hnútum, þar sem aðgengilegir hnútar fara í röð, við notum þessa röð svo sem röðina okkar. Byrjum í `a` og sjáum hvernig röðin verður.

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  figure(
    image("imgs/bfs.excalidraw.png", width: 90%),
    caption: [Fyrsta tilraun]
  ),
  [Með þessari fyrstu tilraun að aðferð fáum við *4* örvar sem benda til hægri sem er innan okkar skekkjumarka.
En við getum ekki endilega notað þessa aðferð fyrir hvaða net sem er, hvað ef við hefðum ekki legg $A->D$ hvert færum við þá? Endurhugsum þetta aðeins. 

+ Byrjum á að finna hnút sem hefur enga #text(red)[aðliggjandi leggi]
  - Í netinu okkar eru engir þannig veljum þann hnút með fæstu aðliggjandi leggi, það væri $D$. 
+ Setjum þá $D$ í röðina okkar og fjarlægjum alla hnúta sem snerta $D$.
+ Endurtökum skref 1 og 2 þar til að enginn hnútur er eftir. Þá er röðin til, sjá mynd:
])
#figure(
  caption: [Önnur tilraun],
  image("imgs/topsort.excalidraw.png")
)

Með þessari nýju "næstum grannröðun" fáum við *6* örvar til hægri sem er það sama og í bestu lausn, við getum náttúrulega ekki gert ráð fyrir því að þessi aðferð finni alltaf bestu lausn en þar sem við lágmörkum örvar til vinstri með því að velja hnúta í hækkandi innleggja röð, getum við gert ráð fyrir því að þessi aðferð skilji allavega alltaf frekar góðri lausn. 

Hér má svo sjá niðurstöðu aðferðarinnar: 
#figure(
  caption: [Niðurstaða aðferðarinnar],
  image("imgs/final-top-sort.png", width: 75%)
)

Versta staða sem við lendum í er þegar allir hnútar hafa jafnmarga aðliggjandi og fráliggjandi leggi, þá skilar aðferðin að minnsta kosti leggjum til hægri sem er jafnt og helming af bestu lausn.

Í stuttu máli, við röðum hnútum í vaxandi röð eftir innstigi.
