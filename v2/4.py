search_string = [x for x in input()]


def binary_count(string):
    min = 0
    max = len(string)
    mid = int((min + max) / 2)

    if string[-1] == "O": return 0
    if string[0] == "X": return max

    while max - 1 != min:
        if string[mid] == "O": min = mid
        elif string[mid] == "X": max = mid
        mid = int((min + max) / 2)
    return len(string) - mid - 1


print(binary_count(search_string))
