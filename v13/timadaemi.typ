#set text(size: 14pt)
#set page(paper: "us-letter", margin: 1cm)
#set heading(numbering: "1. a")

=
$ p(n) = cases(
    "if" n > 1 : "p(n/3)" "p(n/3)" "Hello world" times n^2, 
  "else": "return") $

=
==
Finnum lægstu mögulegu summu fyrir núverandi röð endurkvæmt. Athugum svo þegar við komum að þekktri leið hvort summa núverandi leiðar og þekktu leiðarinnar sé minni en stysta geymda leið. Ef svo er þá uppfærum við stystu leiðina.

- Undirverkefni: Finna lægstu mögulegu summu fyrir núverandi hnút endurkvæmt.
- Geymum stystu summu fyrir hvern og einn hnút í tvívíðu fylki.
- Ef við byrjum í hliðunum þurfum við fyrir hvern hnút í versta falli að athuga $(n*m)$ leiðir upp að topp tími undirverkfnis er fasti þar sem það eru $3*O(1)$ og við höfum $n*m$ undirverkefni þannig tímaflækja er $O(n*m)$

== 
Sjá "reiknirit" fyrir ofan

==
Breytum kubbum í hnúta með enga þyngd þar sem leggur í næsta kubb/hnút er summa núverandi kubbs og næstu fyrir ofan. Beita djúpleit eða breiddarleit á þetta og guddy.

= 

