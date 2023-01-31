# Útfærsla á leik sem lýst er í grein 2.2 í bók Ericksson
import random


def init_board(n):
    # The state of the game is stored in a list T
    #  with T[p][i] : position of token i for player p
    #                (column for player 0, row for player 1)
    T = [[], []]
    for player in [0, 1]:
        T[player] = [0 for i in range(n)]
    return T


def draw_board(T):
    n = len(T[0])
    for row in range(0, n + 2):
        if 0 < row < n + 1:
            s = '{:2d} '.format(row - 1)
        else:
            s = '   '
        for col in range(0, n + 2):
            if (row == 0 and (col == 0 or col == n + 1)) or \
               (row == n + 1 and (col == 0 or col == n + 1)):
                s += '🔳'
            else:
                if 0 < row <= n and T[0][row - 1] == col:
                    s += '👉'
                elif 0 < col <= n and T[1][col - 1] == row:
                    s += '👇'
                else:
                    s += '⬜'
        print(s)
    s = '    '
    for col in range(1, n + 1):
        s += '{:2d}'.format(col - 1)
    print(s)


def has_won(player, T):
    n = len(T[0])
    return sum(T[player]) == n * (n + 1)


def move_one_square(player, T, token):
    # Target square must be free for the move to succeed
    # Returns True if the move succeeded, False otherwise
    n = len(T[0])
    other_player = player ^ 1
    target_square = T[player][token] + 1
    if target_square < n + 1:
        if T[other_player][target_square - 1] != token + 1:
            T[player][token] += 1
            return True
    elif target_square == n + 1:
        T[player][token] = n + 1
        return True
    return False


def move_two_squares(player, T, token):
    # Target square must be free and the "middle" square occupied
    # for the move to succeed
    # Returns True if the move succeeded, False otherwise
    n = len(T[0])
    other_player = player ^ 1
    middle_square = T[player][token] + 1
    if middle_square < n + 1:
        if T[other_player][middle_square - 1] == token + 1:
            target_square = T[player][token] + 2
            if target_square < n + 1:
                if T[other_player][target_square - 1] != token + 1:
                    T[player][token] += 2
                    return True
            elif target_square == n + 1:
                T[player][token] = n + 1
                return True
    return False


def is_legal_move(player, T, token):
    temp1 = [x for x in [i.copy() for i in T]]
    if move_one_square(player, temp1, token):
        return True
    temp2 = [x for x in [i.copy() for i in T]]
    return move_two_squares(player, temp2, token)


def FindGoodMove(X, player):
    if has_won(player, X):
        return (True, 0)

    if has_won(player ^ 1, X):
        return (False, 0)

    for i in range(len(X[player])):
        if is_legal_move(player, X, i):
            state = [x for x in [i.copy() for i in X]]
            if not move_one_square(player, state, i):
                move_two_squares(player, state, i)
            if not FindGoodMove(state, player ^ 1)[0]:
                return (True, i)
    return (False, random.randint(0, len(X[player]) - 1))


def comp_comp_turn(turn, player, T):
    print("Turn " + str(turn))
    good_move = FindGoodMove(T, player)
    pos = good_move[1]
    if not move_one_square(player, T, pos):
        if not move_two_squares(player, T, pos):
            print("Move is not possible. Pass on this round!")
    draw_board(T)
    # To get a better grasp of how T is defined, you can write out its contents
    # print(T)
    if has_won(player, T):
        print("Player " + str(player + 1) + " has won!")
        exit()
    player = player ^ 1
    return (turn+1, player)

# Two player version
n = int(input("Stærð borðs: "))  # Board size
T = init_board(n)
draw_board(T)

# Game loop
player = 0
computer = 1  # 0 or 1, depending on whether the computer goes first or not
tokens = ['S', 'X']
turn = 0
max_turns = 2*n*(n+1)
while turn <= max_turns:
    # (turn, player) = comp_comp_turn(turn, player, T)
    turn += 1
    print("Turn " + str(turn))
    if player == computer:
        good_move = FindGoodMove(T, player)
        # print(good_move)
        pos = good_move[1]
        pass
    else:
        pos = int(input("Player " + str(player + 1) +
                        " (" + tokens[player] + ") select token to move: "))
    if pos == -1:
        print("Quit")
        break
    if not move_one_square(player, T, pos):
        if not move_two_squares(player, T, pos):
            print("Move is not possible. Pass on this round!")
    draw_board(T)
    # To get a better grasp of how T is defined, you can write out its contents
    # print(T)
    if has_won(player, T):
        print("Player " + str(player + 1) + " has won!")
        break
    player = player ^ 1
print("Game Over!")
