
A = [[3,1,-2,-3],
     [-1,4,5,-1],
     [2,-2,3,4]]

store = {}

def f(y, x):
    if (y, x) in store: return store[(y, x)]
    if y < 0 or x > 3: return -99999
    if (y == 0 and x == 3):
        return A[y][x]
    temp = max(f(y - 1, x), f(y, x + 1)) + A[y][x]
    store[(y, x)] = temp
    return temp

print(f(2, 0))
print(store)
