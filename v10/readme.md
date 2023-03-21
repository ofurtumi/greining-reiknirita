# línuleg bestun í tveimur víddum
## a)
tökum skorðurnar og skiptum $x_1$ út fyrir $x$ og $x_2$ út fyrir $y$  
setjum svo þessar nýju formúlur inn í [desmos](https://desmos.com) og fáum eftirfarandi mynd:  

![myndin](./imgs/desmos-graph.png)

## b)
þrír skurðpunktar, þar af einn utan gjaldgenga svæðisins

## c)
fimm hornapunkta

## d)
setjum hnitagildin úr hornapunktunum inn í formúluna $2x_1 + 2x_2$ og fáum  
- $0 + 0 = 0$
- $4 + 0 = 4$
- $0 + 15 = 15$
- $2 + 20 = 22$
- $6.8 + 14.5 \approx 20$ 

## e)
eftir að reikna gildi markfallsins útfrá hornapunktunum má sjá að hámarksgilið er 22

# nefndir í háskóla
- $n$ starfsmenn
- $k$ nefndir
- $k_j \geq 3$
- $p_{ij}$ laun starfsmann $i$ í nefnd $j$
- $s_{ij}$ svartur listi ef $1$ má starfsmaður $i$ ekki vera í nefnd $j$

skorðurnar okkar eru:
1. í hverri nefnd þurfa að vera amk. 3 starfsmenn
2. hver starfsmaður má sitja í hámarki 3 nefndum
3. starfsmaður má ekki sitja í nefnd ef sá aðili er á svarta listanum

## 1.
setjum skorðu þannig fyrir hverja nefnd j þurfa að vera í henni amk. 3 starfsfólk, skilgreinum nýja breytu 
$K_{ij}$ sem skilar **0** ef starfsmaður **i** er ekki í nefnd **j** en annars **1**  
$$j\sum_{i=0}^{n}K_{ij} \geq 3$$

## 2.
höldum breytunni $K$ en notum hana núna til þess að athuga fyrir ákveðið starfsfólk **i**, hvort þau séu í fleiri en þremur nefndum
$$i\sum_{j=0}^k K_{ij} \leq 3$$

## 3.
nú þurfum við að athuga, fyrir allt starfsfólk allra nefnda, hvort sá aðili sé á svarta listanum fyrir eftirfarandi nefnd, við höfum nú þegar $K_{ij}$ sem segir til um hvort aðili **i** sé í nefnd **j**  
síðan höfum við líka $s_{ij}$ sem skilar **0** ef aðili **i** er ekki á svarta lista fyrir nefnd **j**  
beitum núna smá tvíundarreikningi og margföldum þessi gildi saman, ef við fáum ekki **0** þá fellur skorðan
$$\sum_{i=0}^n\sum_{j=0}^k K_{ij} * s_{ij} = 0$$


## formúla
ef að skorðurnar fyrir ofan standa viljum við svo að lokum lágmarka fyrir eftirfarandi summu 
$$\sum_{i=1}^k\sum_{j=1}^n p_{ij}*K_{ij}$$

# línuleg aðhvarfsgreining
$\sigma_1(a, b) = \sum^n_{i=1}|y_i-ax_i-b|$

To solve this problem using linear programming, we can express it as a linear program with two variables a and b, and n constraints.

Let's first rewrite the objective function $\epsilon_1 (a, b) = \sum^n_{i=1}|y_i-ax_i-b|$ as a linear expression using slack variables. We can introduce n slack variables s_1, s_2, ..., s_n to convert the absolute values into linear expressions, such that:

$|y_1 - ax_1 - b| = s_1$

$|y_2 - ax_2 - b| = s_2$

...

$|y_n - ax_n - b| = s_n$

Then the objective function becomes:

$minimize \quad \sum^n_{i=1}s_i$

Now we need to formulate the constraints. We want the line y = ax + b to pass through all the given points, so we have n constraints:

$y_1 - ax_1 - b = 0$

$y_2 - ax_2 - b = 0$

...

$y_n - ax_n - b = 0$

We can also add non-negativity constraints for the slack variables:

$s_1 \geq 0$

$s_2 \geq 0$

...

$s_n \geq 0$

Now we have a linear program with n+2 variables and n constraints. We can solve this using any linear programming solver, such as the simplex method or an interior-point method.

Here's the complete formulation:

$minimize \quad \sum^n_{i=1}s_i$

subject to:

$y_1 - ax_1 - b = 0$

$y_2 - ax_2 - b = 0$

...

$y_n - ax_n - b = 0$

$s_1 \geq 0$

$s_2 \geq 0$

...

$s_n \geq 0$

This will give us the values of a and b that minimize the error $\epsilon_1$.
