
def hillfinder(array):
    top = len(array)
    bot = 0
    mid = bot + (top - bot) // 2
    while top >= bot:
        t1 = array[mid] > array[mid + 1]
        t2 = array[mid] > array[mid - 1]
        if t1 and t2: return mid
        if t1: top = mid
        elif t2: bot = mid
        mid = bot + (top - bot) // 2

ans1 = hillfinder([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]) # 9
ans2 = hillfinder([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]) # 11

print(ans1, ans2) # 9 11
