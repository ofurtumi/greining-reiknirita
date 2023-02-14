A = "ABCDEFGHIJK"
B = "ABBBCDE"


def LCS(A, B, i, j):
    longest = 0
    arr = [[0 for i in range(len(B)+1)] for j in range(len(A)+1)]
    for i in range(len(A)+1):
        for j in range(len(B)+1):
            if i == 0 or j == 0:
                pass
            elif A[i-1] == B[j-1]:
                arr[i][j] = arr[i-1][j-1] + 1
                longest = max(arr[i][j], longest)
    return longest

print(LCS(A,B,0,0))
