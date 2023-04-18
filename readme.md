# greining reiknirita - Töl403G

## uppsetning á repo

vikuleg verkefni, og vonandi svör við þeim, eru sett í möppur `v<númer viku>`

glósur, aðalega úr reikniritum, áfangans eru að finna í [algos](algos.ipynb) python python bókinni

## render á verkefnum

til þess að búa til `.pdf` skrár úr `.md` verkefnaskilum þarf, í fyrsta skipti, að keyra eftirfarandi skipanir

```bash
npm install
# eða
npm i

# svo
npm run render <dir> <optional: output dir>
```

þessar skipanir gera ráð fyrir því að `node` sé sett upp ásamt `npm`  
strúktúr fyrir verkefni er eins og dæmi:

- rót
  - skil
    - v1.pdf
  - v1
    - readme.md
    - abc.sh
    - test.py
  - v2
    - readme.md
    - spurningar.pdf

til að allt virki eins og á að vera skal skipta verkefnum svona upp og til að breyta `v2/readme.md` yfir í `pdf` skal keyra

```bash
npm run render v2
```

þá verður til `v2.pdf` í `skil` möppunni

# fyrir próf

## tips fyrir kvika bestun

### byrja á að finna undirverkefni

skiptist í þrjár aðferðir,

- pre fix, fara frá byrjun út í enda
- post fix, fara frá enda út að byrjun
- substring, fyrir hvert stak athuga öll önnur stök

halda utan um bæði **fjölda** og **kostnað** undirverkefna
_dæmi:_ lengd lengstu vensluðu hlutrunu sem byrjar á pening $t_i$

> dæmi útfrá dæmi 3 í 2021 prófinu á canvas

### lýsa ákvörðun fyrir hvert skref

### setja upp rakningarvensl

$$L(i) = 1+ max(L(k)): i < k \leq n \land t_i ~ t_k$$

### sýna grunntilvik

$$L(n+1)=0$$

### lausn á upphaflegu verkefni

$$max(L(k)): 1 \leq k \leq n$$

### röð undirverkefna

minnkandi i, samkvæmt rakningarvenslum, hægt að sjá að ef við framkvæmdum reikninga í vaxandi i röð þá hefðum við ekki upplýsingar um $t_i + 1$ þar sem ekki væri búið að reikna það.

### tímaflækja

hvert undirverkefni þarf að velja max úr fylki L þannig það er $O(n)$ og upphaflegt verkefni þarf að finna max úr fylki $L$, tímaflækjan verður því $O(n^2)$

## líkur

líkur á $P_r(A | B) = \frac{P_r(A \cap B)}{P_r(B)}$
