from math import factorial
def binomial(n, k): 
    return (factorial(k)/((factorial(k-n)*factorial(n))))

A = [1 + i + binomial(i,6) for i in range(0, 7)]
B = [2 * i for i in range(1, 5)]

print(A)
print(B)
