from math import sqrt, log


def process(n):
    cnt = 0
    i = 0
    j = 0
    while i <= n:
        i += j
        j += sqrt(n)
        cnt += 1

    return cnt

values = [(i, process(i)) for i in range(1, 1000)]

print(values[0])
for i in range(1, len(values)):
    n = values[i][0]
    if values[i][1] > values[i-1][1]:
        print(values[i], log(n**sqrt(log(n)))/2)