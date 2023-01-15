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