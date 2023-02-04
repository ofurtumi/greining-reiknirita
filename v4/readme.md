---
script: 
    - path: utils/mathjax-config.js
    - url: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js
---

# Heimaverkefni 4 - Þorvaldur Tumi Baldursson

# 1. Atvinnuviðtalið
## a)
einföld útfærsla á lausn án kvikrar bestunar, í python:
```python
largest = 0
for i in range(len(A)):
    for j in range(i, len(A)):
        temp = sum(A[i:j+1])
        if temp > largest:
            largest = temp

```
þessi útfærsla keyrir lykkju fyrir öll 
$n$ stök fylkisins hver lykkja framkvæmir síðan 
$n-i$ aðgerðir sem samsvarar summuformúlunni
$$\sum_{i=0}^n n-i$$
þessa summu er hægt að færa yfir á fast form og finna tímann út frá því 
$$\frac{1}{2}(n-1)n = O(n^2)$$

## b)
### i.
undirverkefnin `M(i, j)` í þessu verkefni eru að finna stærstu summu samliggjandi talna `A[i:j]` 

### ii.
við þurfum að finna fyrir hvern stað 
$$M(i, j) = \begin{cases}A[i] & \text{ef}\ i = j\\ Max(Sum(M(i+1, j)), Max(M(i, j-1))) & \text{annars}\end{cases}$$

### iii.
hægt væri að geyma summu fyrir `A[i:j]` eftir að vera reiknuð í fyrsta skipti og vísað í það í seinni endurkvæmni

### iv.
röð undirverkefna er 
$i > n > j $

### v. 
grunntilvik er 
$i = j$ og þá er skilað `A[i]`

### vi.
lausn á upphaflegu verkefni væri `M(0,n)`

# 2. Bestun á prófi

# 3. Soby Melene
## a)
tökum fyrir dæmið sem er gefið í skilaheftinu, nú þegar í borðinu er leið til að ná **6** færslum, veljum nú alltaf minnsta peð í hverjum reit þetta væri
$$1\rArr2\rArr3\rArr6\rArr1\rArr\text{út}$$
þetta eru aðeins **5** mögulegar færslur sem er minna en **6** og sýnir þannig að minnsta tala í hverjum reit er ekki *the way to go*

## b)
### i.
Undirverkefni: `SM(i,j)` finna lengstu leið frá peði `j` í reit `i` út að enda

### ii.
við skiptum leiðunum niður í tré, þar sem hver grein er möguleg leið frá núverandi reit, við vinnum okkur til baka þegar við reiturinn sem við erum á telur hefur
$i\geq n$, ef við uppfyllum ekki þessi skilirði köllum við endurkvæmt á fallið með öllum mögulegum útkomum frá $i$, þ.e. fyrir peð 1 köllum við á `SM(i+ data[i][0], 0)` gerum þetta fyrir peð `1-4` og fáum eitthvað svona út:
$$SM(i, j) = \begin{cases}0 & \text{ef}\ i \geq n\\ 1+max(SM(i+1, A[0]), SM(i+1, A[1]), SM(i+1, A[2]),SM(i+1,A[3])) & \text{ef}\ i\neq n\end{cases}$$
> ekki fallegt en virkar 

### iii.
fyrir hverja óheimsótta stöðu `(i,j)` geymum við lengsta veg þaðan í minni
```python
if (i, j) not in visited:
        visited[(i, j)] = 1 + max(p1, p2, p3, p4)
```
þar sem
$p_k = SM(i + A[i][k], k)$ 

### iv.
röð undirirverkefna
er minnkandi $i$

### v.
grunntilvik er 
$SM(i, j) >= n$

### vi
upphafleg lausn á verkefni væri `SM(0, 0)`

### vii.
fjöldi undirverkefna er 
$4\cdot O(n)$ og tími per undirverkefni er fasti 
$O(1)$ þannig heildartími er 
$O(n)$

## b)
```python
visited = {}
data = parse("h4_test_puzzle.txt")
n = len(data)
def SM(i, j):
    if (i >= n):
        return 0

    if (i, j) not in visited:
        p1 = SM(i + data[i][0], 0)
        p2 = SM(i + data[i][1], 1)
        p3 = SM(i + data[i][2], 2)
        p4 = SM(i + data[i][3], 3)
        visited[(i, j)] = 1 + max(p1, p2, p3, p4)
    return visited[(i, j)]
```
skilar 7 fyrir `example` og 86 fyrir `test`

## d)
```python
# hér tekur fallið inn n og data sem parametra 
# einfaldlega til að minnka global variable notkun
def SMPath(i, j, n, data):
    if (i >= n):
        return (0, ["end"])

    if (i, j) not in visited:
        p1 = SMPath(i + data[i][0], 0, n, data)
        p2 = SMPath(i + data[i][1], 1, n, data)
        p3 = SMPath(i + data[i][2], 2, n, data)
        p4 = SMPath(i + data[i][3], 3, n, data)

        largest = (0, [])
        if (p1[0] >= largest[0]):
            largest = p1
            ret = 1
        if (p2[0] >= largest[0]):
            largest = p2
            ret = 2
        if (p3[0] >= largest[0]):
            largest = p3
            ret = 3
        if (p4[0] >= largest[0]):
            largest = p4
            ret = 4

        res = [x for x in largest[1]]
        res.insert(0, (i+1, ret))

        visited[(i, j)] = (1 + largest[0], res)
    return visited[(i, j)]
```
útkoma úr fallinu fyrir bæði `example` og `test` borðin fengin með 
```python
def get_best_game(data_path, path):
    data = parse(data_path)
    if path:
        return SMPath(0, 0, len(data), data)
    return SM(0, 0)


v1 = get_best_game("h4_example_puzzle.txt", True)
print("lengd lengstu leiðar:", v1[0], "lengsta leið:\n", v1[1])

visited = {}
v2 = get_best_game("h4_test_puzzle.txt", True)
print("lengd lengstu leiðar:", v2[0], "lengsta leið:\n", v2[1])
```
lengd lengstu leiðar: 7 lengsta leið:
[(1, 4), (3, 1), (5, 3), (6, 3), (10, 1), (11, 4), (13, 4), 'end']  

lengd lengstu leiðar: 86 lengsta leið:
[(1, 1), (6, 2), (10, 4), (12, 1), (14, 2), (17, 2), (18, 4), (20, 4), (22, 2), (23, 4), (24, 4), (26, 2), (27, 4), (34, 4), (36, 4), (40, 2), (42, 3), (43, 3), (49, 2), (51, 4), (54, 4), (61, 4), (62, 1), (64, 1), (65, 4), (70, 1), (71, 2), (72, 3), (75, 3), (78, 3), (79, 3), (80, 3), (81, 3), (83, 2), (86, 2), (88, 2), (89, 1), (91, 1), (93, 4), (98, 2), (99, 3), (101, 2), (102, 2), (106, 3), (112, 2), (113, 2), (114, 3), (117, 4), (120, 3), (126, 2), (127, 4), (130, 1), (131, 3), (134, 4), (135, 4), (136, 4), (139, 3), (143, 1), (145, 2), (148, 2), (149, 2), (150, 2), (151, 4), (154, 3), (155, 3), (156, 3), (157, 2), (158, 4), (160, 4), (164, 2), (166, 3), (168, 4), (173, 1), (174, 1), (178, 2), (179, 3), (180, 4), (182, 4), (184, 3), (186, 3), (189, 1), (190, 1), (191, 4), (193, 2), (195, 4), (199, 4), 'end']