def fib(num):
    a = 0
    b = 1
    while a < num:
        yield a
        a, b = b, a + b
