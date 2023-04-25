counter = 0
def p(n):
    if n >= 1:
        p(n-1)
        print("hello world")
        p(n-1)

p(4)
