A = [1, 5, 10]


def choose(u, choice, i, j, users):
    if abs(i - j) == 1:
        return A[choice]
    
        
    left = choose(u ^ 1, i, i+1, j,)
    right = choose(u ^ 1, j, i, j-1)
    if u == 0:
        return max(left, right)
    else:
        user[u] += min(left,right)
    return A[choice]


choose(0, 1, 0, len(A) - 1, [0,0])
print(user)
