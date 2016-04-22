def cashed(func):
    cash = {}
    def wrapped(*args, **kwargs):
        # create_key = (args,)
        # for each in kwargs:
        b = [(x, kwargs[x]) for x in kwargs.keys() ]
        b.append(args)
        b = tuple(b)
        value = cash.get(b)
        # print("decorating")
        if value is not None:
            print("restoring")
            return value
        else:
            cash[b] = func(*args, **kwargs)
        return cash[b]
    return wrapped


# @cashed
def one(q, **kwargs):
    # print(str(kwargs.get('lol')))
    print("computing")
    return q**100000000

# print(one(2, lol=4))
b = one(2)
c = one(2)
d = one(2)
e = one(2)
f = one(2)