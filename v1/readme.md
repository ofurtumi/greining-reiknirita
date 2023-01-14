# heimaverkefni 1

## 1. - mengi

við vitum að   
$A = \Big\{ 1+i+ {6 \choose i } \ |\ i \in \mathbb{Z} \land 0 \leq i \leq 6\Big\}$  
$B = \big\{2i\ |\ i\in\{1,2,3,4\}\big\}$  

þá höfum við mengin, 
$A = \{2,8,18,24,20,12,8\}$ og 
$B = \{2,4,6,8\}$

> python forritunarbútur til að fá niðurstöðurnar
```python
from math import factorial
A = [1 + i + (factorial(6) / ((factorial(6 - i) * factorial(i)))) for i in range(0, 7)]
B = [2 * i for i in range(1, 5)]
```

### i)
$A\cap B = \{2,8\}$

### ii)
$|A\cup B| = |\{2,4,6,8,12,18,20,24\}| = 8$

### iii)
$|A - B| = |\{12,18,20,24\}| = 4$

### iv)
$|A \times B| = \left\lvert \begin{Bmatrix*}[r]
    2,2  &2,4  &2,6  &2,8\\
    8,2  &8,4  &8,6  &8,8\\
    18,2 &18,4 &18,6 &18,8\\
    24,2 &24,4 &24,6 &24,8\\
    20,2 &20,4 &20,6 &20,8\\
    12,2 &12,4 &12,6 &12,8
\end{Bmatrix*}\right\rvert = 24$


## 2. - þrepun, endurkvæm skilgreining

### grunnforsenda
fyrir náttúrúlegar tölur 
$n \gt 1$ gildir 
$f_n = f_{n-1} + f_{n-2}$ þar sem 
$f_0  = 0, f_1 = 1$

### þrepunarforsendan 
fyrir sérhverja náttúrulega tölu 
$n \geq 1$ gildir 
$f^2_1 + f^2_2 + ... + f^2_n = f_nf_{n+1}$

### þrepunarskref
látum 
$n = 2 = k$
og byrjum á að finna 
$f_k, f_{k+1}, f_{k+2}$  

$$
\begin{align*}
    f_{k} = f_{k-1} + f_{k-2} &= 1+0 &= 1 \\
    f_{k+1} = f_{k} + f_{k-1} &= 1+1 &= 2 \\ 
    f_{k+2} = f_{k+1} + f_{k} &= 1+2 &= 3 
\end{align*}
$$

leiðum svo út fyrir 
$f_k$ og 
$f_{k+1}$  

$$
\begin{align*}
    f^2_1 + f^2_k &= 1^2+1^2&= 2\\ 
    f_kf_{k+1} &= 1 \cdot2 &= 2\\ \\
    f^2_{1} + f^2_{k} + f^2_{k+1} &= 1^2 + 1^2 + 2^2 &= 6\\
    f_{k+1}f_{k+2} &= 2 \cdot 3 &= 6
\end{align*}
$$


## 3. - endurkvæm reiknirit
**python útfærsla**
```python
def telja(n):
    if n <= 1: return 1
    return 1 + telja(int(n / 2))
```
**sauðakóða útfærsla**
```
int func telja(int n) {
    if n <= 1 { return 1 }
    else return 1 + telja(n >> 1) 
    // notar left shift til að sýna að heiltöludeiling sé til staðar
}
```

## 4. - vaxtarhraði falla
| g(n)                   | f(n) er O(g(n)) | g(n) er O(f(n)) |
| ---------------------- | :-------------: | :-------------: |
| $-3n + 1000n^2 + 5n^3$ |        x        |                 |
| $n^3\log{n}$           |        x        |                 |
| $e^{0.1n}-n^3$         |        x        |                 |
| $n^2$                  |                 |        x        |

## 5. - netafræði og yfirfærsla

netið er stefnt með engar þyngdir á leggjunum þar sem leggir tákna mögulegar leiðir á borðinu og hnútar tákna staðsetningu á borðinu  
leið til að útfæra netið sem `G=(V, E)` væri að lykkja yfir öll `n^2` stökin, athuga fyrir hvert stak hvort hægt sé að fara á reit `x` reiti í burtu upp niður hægri og vinstri við stakið og skila legg fyrir það stak
það þarf að fara yfir öll stök borðsins sem eru $n^2$ mörg og fyrir hvert stak þarf að athuga fjórar stöður, því verður 
$T(n) = 4*n^2 = O(n^2)$