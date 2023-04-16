#set text(size: 14pt)
#set page(paper: "us-letter", margin: 1cm)

#let question(content, fill: gray) = {
  set text(style: "italic", size:10pt)
  rect(
    inset: 8pt, 
    radius: 4pt, 
    width: 100%, 
    [#text(weight:"bold", style: "normal")[Spurning: ]\ #content])
}

#let comment(body, size: 9pt) = {
  text(style: "italic", size: size, body)
}

// Display block code in a larger block
// with more padding.
#show raw.where(block: true): it => block(
  width: 100%,
  fill: luma(230),
  inset: 16pt, // 100% bad
  radius: 4pt,
  breakable: false,
  text(10pt, it)
)

#show raw.where(lang: "bash"): block.with(
  width: 100%,
  height: 100%,
  fill: luma(230),
  radius: 4pt,
) 


= Kóði:
```python
import requests
import numpy as np
import scipy.stats as st

menu = int(input("spila (1) / skoða (2)\n"))
if menu == 2:
    game = input("leikur nr: ")
    print(requests.get(f'http://64.225.108.43:5000/highscore/{game}').content.decode("utf-8"))
    exit()


# Hver og einn leikur skilgreindur sem fjöldi kassa í games[i]
games = [2,3,3,4,6,6,2,2,3,2]
game_id = int(input("Leikur nr: "))
num_slots = games[game_id]

def fetch(i):
    PARAMS = {'gameid': game_id, 'slotid': i, 'playerid': 'fe38'}
    r = requests.get('http://64.225.108.43:5000/play', params=PARAMS)
    return r.json()["winnings"]

# Fjöldi keyrslna fyrir hvern kassa, frumstillt sem 0
slot_tries = [0] * num_slots 
# Fjöldi sigra fyrir hvern kassa, frumstillt sem 0
slot_wins  = [0] * num_slots

max = 1000
for result in range(1, max+1):
    # Skilgreina "prior" gildi fyrir núverandi tilraun
    # Notar beta dreifni úr stats pakkanum því ég er ekki nógu góður í líkindafræði :)
    # https://en.wikipedia.org/wiki/Beta_distribution - sjá um beta dreifni 
    slot_prob_prior = [st.beta(a=1+w, b=1+t-w) for t, w in zip(slot_tries, slot_wins)]
    
    # Töfrafunction úr scipy, normalísar random gildin í SPP
    theta_samples = [d.rvs(1) for d in slot_prob_prior]
    
    # slot valið útfrá stærsta theta
    current_slot = np.argmax(theta_samples)
    # sækja gögn á server notandi valið slot og utanumhalds fylki uppfærð í samræmi
    x = fetch(current_slot)
    slot_tries[current_slot] += 1
    slot_wins[current_slot] += x

print(f"Stig: {sum(slot_wins)}\n")
for result in range(num_slots):
    print(f"Kassi: {result}: {slot_wins[result] / slot_tries[result]}")
```


#comment[Ath, kóðinn fyrir ofan er sá sem keyrði verkefnið, hann er alltof flókinn, ég reyndi að útfæra ehv tölfræði sem ég skildi ekki, seinni kóðabúturinn er eins og ég myndi gera þetta núna, eftir að hafa spáð aðeins meira í vandamálið og skoðað það betur]

= Einfaldari kóði 
== skiljanlegri og ábyggilega betri:
```python
import requests

url = "http://64.225.108.43:5000/play" 
game_id = 0
n_slots = 2
tests = 5
outputs = [0] * n_slots

for i in range(n_slots):
    for j in range(tests):
        PARAMS = {"gameid": game_id, "slotid": i, "playerid": 'fe38'} 
        outputs[i] += int(requests.get(url, params = PARAMS).json()["winnings"]) 

counter = sum(outputs)
max_machine = outputs.index(max(outputs)) 
for i in range(1000-5*n_slots):
    PARAMS = {"gameid": game_id, "slotid": max_machine, "playerid": 'fe38'}
    requests.get(url, params = PARAMS) 
```


#pagebreak()
#set text(size: 14pt)
*Sjá keyrslur á næstu síðu*
#grid(
  columns: (1fr, 1fr),
  gutter: 6pt,
  rows: (3fr, 3fr, 4fr, 3fr, 3fr),
  ```bash
Leikur nr: 0
Stig: 502

Kassi: 0: 0.5092213114754098
Kassi: 1: 0.20833333333333334
```,
```bash
Leikur nr: 1
Stig: 673

Kassi: 0: 0.41025641025641024
Kassi: 1: 0.0
Kassi: 2: 0.6886792452830188
```,
```bash
Leikur nr: 2
Stig: 205

Kassi: 0: 0.10256410256410256
Kassi: 1: 0.0
Kassi: 2: 0.21428571428571427
```,
```bash
Leikur nr: 3
# keyrsla klikkaði :(
```,
```bash
Leikur nr: 4
Stig: 669

Kassi: 0: 0.6986951364175563
Kassi: 1: 0.4
Kassi: 2: 0.55
Kassi: 3: 0.5531914893617021
Kassi: 4: 0.4838709677419355
Kassi: 5: 0.47368421052631576
```,
```bash
Leikur nr: 5
Stig: 893

Kassi: 0: 0.9074074074074074
Kassi: 1: 0.0
Kassi: 2: 0.6666666666666666
Kassi: 3: 0.25
Kassi: 4: 0.0
Kassi: 5: 0.0
```,
```bash
Leikur nr: 6
Stig: 570

Kassi: 0: 0.5793991416309013
Kassi: 1: 0.4411764705882353
```,
```bash
Leikur nr: 7
Stig: 457

Kassi: 0: 0.46311475409836067
Kassi: 1: 0.20833333333333334
```,
```bash
Leikur nr: 8
Stig: 479

Kassi: 0: 0.0
Kassi: 1: 0.16666666666666666
Kassi: 2: 0.4892086330935252
```,
```bash
Leikur nr: 9
Stig: 990

Kassi: 0: 0.9919839679358717
Kassi: 1: 0.0

```
)
