from math import factorial
A = [1 + i + (factorial(6)/((factorial(6-i)*factorial(i)))) for i in range(0, 7)]
B = [2 * i for i in range(1, 5)]

print(A)
print(B)
