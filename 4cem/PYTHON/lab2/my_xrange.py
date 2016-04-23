class xrange(object):
        def __init__(self):
            pass
        def __next__(self):
            pass
        def __getitem__(self, item):
            pass
        def __get__(self, instance, owner):
            pass

        def gene(*args):
            a = 0
            step = 1
            if len(args) == 1:
                while a < args[0]:
                    yield a
                    a += step
            if len(args) == 2:
                a = args[0]
                b = args[1]
                if a < b:
                    while a < b:
                        yield a
                        a += step
            if len(args) == 3:
                a = args[0]
                b = args[1]
                step = args[2]
                if step == 0:
                    raise ValueError("xrange() arg 3 must not be zero")
                if a < b and step > 0:
                    while a < b:
                        yield a
                        a += step
                elif a > b and step < 0:
                    while a > b:
                        yield a
                        a += step




print(str(range(100500)[63]))
print(str(next(reversed(range(100500)))))
# for i in range(10, 1, 0):
#     print(i)

# for i in xrange(2, 10, 0):
#     print(i)