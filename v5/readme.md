---
script: 
    - path: utils/mathjax-config.js
    - url: https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js
---
# heimaverkefni 5

## 1. runur
### i.
$L(A,B,i,j)$ táknar hlutstrengi A og B, frá og með 
$i$ að
$j$  
við viljum athuga fyrir hvern staf í A hvort hann sé til í B, og halda utan um fjölda stafa sem finnast í röð með einhverskonar töflu

### ii.
$$L(A,B,i,j) = \begin{cases}
    arr[i-1][j-1] + 1 &\text{ef }A[i]=B[j]\\\\ 
    0 &\text{ef } A[i]\neq B[j]
\end{cases}$$

í hverju skrefi athugum við hvort að núverandi stafur sé eins í strengjunum, ef svo er bætum við einum við fjölda eins stafa sem fundust í röð á undann þ.e. arr[i-1][j-1]

### iii.
röð undirverkefna er vaxandi j

### iv. 
grunnskref væri `L(A,B,i,j) = 0`

### v.
upphafleg lausn finnst með `L(A,B,0,0)`

### vi.
lausnin geymir upplýsingar í `[n*m]` tvívíðu fylki þar sem hvert stak segir til um lengd lengstu runu að þeim staf  
þá sleppum við við að bera saman alla mögulega hlutstrengi `A` við alla stafi `B` og veljum þá frekar hæsta gildi í töflunni

### vii
þar sem við rennum n sinnum yfir m stök er tímaflækjan $O(n*m)$


## 2. faldar samhverfur
### i.
undirverkefni þessa verkefnis er að finna lengsta samhverfa hlutstreng `s` á bilinu 
`[i,j]` fyrir öll `i` að `n`

### ii.
við athugum fyrir hvert stak í s, hvort stak n-j sé jafnt, ef svo er þá athugum við hvort stak i+1 sé jafnt og stak n-(j+1) og svo framvegis  
$$decode(i,j) = \begin{cases}
    s[i]+decode(i+1,j-1) & \text{ef}\ s[i]=s[j]\\\\
    decode(i+1,n) & \text{ef}\ s[i] \neq s[j]\\\\
    s[i] & \text{ef}\ i=j
\end{cases}$$

### iii.
röð undirverkefna er hækkandi i á móti lækkandi j

### iv. 
grunntilvik hér er ef `i=j` 

### v.
upphafleg lausn finnst með því að kalla á `decode(0, n)`

### vi.
við geymum strengi sem lenda í grunntilvikinu í tvívíðu fylki af stærð `n*n` 

### vii.
við ýtrum yfir `s[i, j]` þannig tímaflækjan er `O(n^2)`

## 3. kvik bestun á trjám I
### i.
undirskref í þessu verkefni er að ákveða hvort fuglar eigi að vera á grein eða ekki

### ii.
$$birds(V, E) = \begin{cases}
    V + max(birds(V+1, E(V)) - (V+2), birds(V+2, E(V+1) - (V+1))) &\text{ef}\ V <= n\\\\
    0 &\text{ef}\ V > n
\end{cases}$$

### iii.
röð undirverkefna er hækkandi V, þar sem V er hnútur í tré

### iv.
grunntilvik er V > n

### v.
upphafleg lausn er fundin með `birds(0, E(0))`

### vi.
við geymum niðurstöðu fyrir stærsta fjölda fugla fyrir hvern hnút í einföldu fylki þar sem stak `i` telur stærsta fjölda fugla í hnúti `v_i`


## 4. kvik bestun á trjám II
nei takk 😄

