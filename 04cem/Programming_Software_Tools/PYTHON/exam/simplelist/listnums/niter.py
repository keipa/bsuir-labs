# from  itertools import tee
import collections

def niter(iterate, n):
    if not hasattr(iterate, "__iter__"):
        raise TypeError("send me iter")
    futer = [iterate for _ in range(n)]


    return tuple(futer)


def tee(iterable, n=2):
    it = iter(iterable)
    deques = [collections.deque() for i in range(n)]
    def gen(mydeque):
        while True:
            if not mydeque:             # when the local deque is empty
                newval = next(it)       # fetch a new value and
                for d in deques:        # load it to all the deques
                    d.append(newval)
            yield mydeque.popleft()
    return tuple(gen(d) for d in deques)


def mytee(iterable, n=2):
    it = iter(iterable)
    deques = [collections.deque() for i in range(n)]
    def gen(mydeque):
        while True:
            if not mydeque:             # when the local deque is empty
                newval = next(it)       # fetch a new value and
                for d in deques:        # load it to all the deques
                    d.append(newval)
            yield mydeque.popleft()
    return tuple(gen(d) for d in deques)

if __name__ == '__main__':
    a = iter(range(10))
    # a.step = 5
    print(niter(a, 5))
    # niter(10,5)
    b = tee(range(5), 5)
    print(b)
    print(next(a))
    print(next(a))
    print()