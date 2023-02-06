
import time
import random
random.seed(42069)
n = int(input("Hversu stórt baby? "))
A = [random.randrange(-10, 10) for i in range(n)]


def old(A):
    largest = 0
    for i in range(len(A)):
        for j in range(i, len(A)):
            temp = sum(A[i:j+1])
            if temp > largest:
                largest = temp
    return largest


def new(A):
    largest = -99999
    large_sub = 0
    for i in range(len(A)):
        large_sub = max(0, large_sub + A[i])
        if large_sub > largest: largest = large_sub

    return largest


t = time.time()
print(f"new: {new(A)} | time: {(time.time() - t):.5f}s")
t = time.time()
print(f"old: {old(A)} | time: {(time.time() - t):.5f}s")
# print("M    ", M(0, len(A)-1))
# print("worse", sum(worse(A)))
