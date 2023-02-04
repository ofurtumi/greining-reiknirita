def parse(path):
    with open(path, "r") as file:
        return list(map(lambda x: list(map(int, x.split(","))),
                    file.read().rstrip().split("\n")))


visited = {}
data = parse("h4_example_puzzle.txt")
n = len(data)
def SM(i, j):
    if (i >= n):
        return 0

    if (i, j) not in visited:
        p1 = SM(i + data[i][0], 0)
        p2 = SM(i + data[i][1], 1)
        p3 = SM(i + data[i][2], 2)
        p4 = SM(i + data[i][3], 3)
        visited[(i, j)] = 1 + max(p1, p2, p3, p4)
    return visited[(i, j)]


def SMPath(i, j, n, data):
    if (i >= n):
        return (0, ["end"])

    if (i, j) not in visited:
        p1 = SMPath(i + data[i][0], 0, n, data)
        p2 = SMPath(i + data[i][1], 1, n, data)
        p3 = SMPath(i + data[i][2], 2, n, data)
        p4 = SMPath(i + data[i][3], 3, n, data)

        largest = (0, [])
        if (p1[0] >= largest[0]):
            largest = p1
            ret = 1
        if (p2[0] >= largest[0]):
            largest = p2
            ret = 2
        if (p3[0] >= largest[0]):
            largest = p3
            ret = 3
        if (p4[0] >= largest[0]):
            largest = p4
            ret = 4

        res = [x for x in largest[1]]
        res.insert(0, (i+1, ret))

        visited[(i, j)] = (1 + largest[0], res)
    return visited[(i, j)]


def get_best_game(data_path, path):
    data = parse(data_path)
    if path:
        return SMPath(0, 0, len(data), data)
    return SM(0, 0)


v1 = get_best_game("h4_example_puzzle.txt", True)
print("lengd lengstu leiðar:", v1[0], "lengsta leið:\n", v1[1])

visited = {}
v2 = get_best_game("h4_test_puzzle.txt", True)
print("lengd lengstu leiðar:", v2[0], "lengsta leið:\n", v2[1])
