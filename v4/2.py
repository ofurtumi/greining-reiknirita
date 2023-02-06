A = [5, 4, 2, 3]
def BaP(i):
    even = odd = 0
    for (i, a) in enumerate(A):
        if i % 2 == 0:
            even += a
        else:
            odd += a
    return max(even, odd)


print(BaP(0))
