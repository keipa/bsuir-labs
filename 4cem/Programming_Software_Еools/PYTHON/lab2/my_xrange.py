class xrange(object):
        def __init__(self, *args):
            self.arguments = args
            self.range = []
            for i in self.gene(*args):
                self.range.append(i)
            self.current = 0

        def __next__(self):
            self.current += 1
            return self.range[self.current]

        def __reversed__(self):
            self.range = reversed(self.range)
            return self.range

        def __getitem__(self, item):
            return self.range[item]

        def __get__(self, instance, owner):
            # self.current += 1
            # return self.range[self.current - 1]
            pass

        def gene(self, *args):
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



def main():



    # print(str(range(100500)[63]))
    # print(str(xrange(100500)[63]))
    #
    # print(str(next(reversed(range(100500)))))
    # print(str(next(reversed(xrange(100500)))))


    for i in range(10, 1, -1):
        print(i)

    # a = xrange(2, 10, 0)

    for i in xrange(2, 10, 1):
        print(i)

if __name__ == '__main__':
    main()