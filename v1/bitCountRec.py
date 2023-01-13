def telja(n):
    if n <= 1: return 1
    return 1 + telja(int(n/2))

print(telja(2))
print(telja(4))
print(telja(16))