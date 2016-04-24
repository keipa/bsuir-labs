import inspect


class Logger(object):
    def __init__(self):
        self.log_array = []

    def __str__(self):
        res_str = ""
        count = 1
        for call in self.log_array:
            res_str += "{0})Name: {1}," \
                       " *args: {2}," \
                       " **kwargs: {3}," \
                       " returned: {4} \n".format(count,
                                                call[0],
                                                call[1],
                                                call[2],
                                                call[3])
            count += 1
        return str(res_str)

    def __getattribute__(self, name, *args, **kwargs):
        if inspect.ismethod(object.__getattribute__(self, name)):
            def tmp(*args, **kwargs):
                res = object.__getattribute__(self, name)(*args, **kwargs)
                self.log_array.append((name, str(args), str(kwargs), res))
                return res
            return tmp
        else:
            return object.__getattribute__(self, name)


class Sample(Logger):
    def sample(self, lol, ke, **kwargs):
        print("sample")
        return lol+ke

def main():
    sam = Sample()

    sam.sample(3, 3)
    sam.sample(3, 1)
    sam.sample(3, 2)
    sam.sample(3, 4)
    sam.sample(3, 5)
    sam.sample(3, 6, jdiw=5)
    print(str(sam))

if __name__ == '__main__':
    main()
