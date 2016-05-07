class Seq(object):
    class Iterable(object):
        def __init__(self, seq):
            self.seq = seq
            self.current = 0

        def __next__(self):
            try:
                return self.seq[self.current]
            except:
                raise IndexError
                # self.current = 0
            finally:
                self.current += 1

        def filter(self, filtration_func):
            # for each in range(len(self.seq)-1):
            #     if not filtration_func(self.seq[each]):
            #         self.seq.remove(self.seq[each])
            # return self.seq
            #generator fail
            for each in self.seq:
                if not filtration_func(each):
                    self.seq.remove(each)
            return self.seq


    def __init__(self, some_object):
        if hasattr(some_object, "__iter__"):
            self.seq = some_object
            print(type(some_object))
        else:
            raise TypeError

    def __iter__(self):
        return Seq.Iterable(self.seq)

    def custom_filter(self, filtration_func):
        return Seq.Iterable(self.seq).filter(filtration_func)




def custom_5(x):
    if x>5:
        return False
    else:
        return True

def custom_2(x):
    if x<2:
        return False
    else:
        return True

def fib(num):
    a = 0
    b = 1
    while a < num:
        yield a
        a, b = b, a + b



b = Seq(fib(8))
# b = Seq([1, 2, 4, 5, 6])
c = Seq(b.custom_filter(custom_5))
# b = b.custom_filter(custom)
for each in c.custom_filter(custom_2):
    print(each)
for each in c.custom_filter(custom_2):
    print(each)
# print(b)


