import numpy as np
import random
A = [random.randrange(-10, 10) for i in range(25)]
# A = [1, 2, 3, 4, 5]


print(A, sum(A))


def bad(A):
    largest = 0
    for i in range(len(A)):
        for j in range(i, len(A)):
            temp = sum(A[i:j+1])
            if temp > largest:
                largest = temp
    return largest


def worse(A):
    if (len(A) == 1):
        return A
    sumA = sum(A)
    B = worse(A[1:])
    C = worse(A[:-1])

    sumB = sum(B)
    sumC = sum(C)

    if (sumA > max(sumB, sumC)):
        return A
    if (sumB > sumC):
        return B
    return C

    # return max(sum(good(A[1:])), sum(good(A[1:])))


m = {}


def M(i, j):
    if (i == j):
        return A[i:j+1]
    if ((i, j) in m):
        return m[(i, j)]
    r = M(i+1, j)
    l = M(i, j-1)
    bigger = np.maximum(r, l)
    m[(i, j)] = bigger
    return bigger


print("bad ", bad(A))
print("M    ", M(0, len(A)-1))
print("worse", sum(worse(A)))
