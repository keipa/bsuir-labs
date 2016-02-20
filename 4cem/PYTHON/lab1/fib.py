def fib():
    x = input("How many fib-numbers?\n")
    x = int(x)-1
    a = 0
    b = 1
    print(0)
    for i in range(x):
        c = a + b
        b = a
        a = c
        print(c)

