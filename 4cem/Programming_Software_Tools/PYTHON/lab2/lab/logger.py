import inspect


class Logger(object):
    def __init__(self):
        self.log_array = []
        self.logformat = ""
        Logger.set_logger_format(self)

    def __str__(self):
        res_str = ""
        count = 1
        for call in self.log_array:
            res_str += self.logformat.format(count,
                                            call[0],
                                            call[1],
                                            call[2],
                                            call[3])
            count += 1
        return str(res_str)

    def set_logger_format(self, **kwargs):
        s = "{0})"
        if len(kwargs) == 0:
            self.logformat = "{0})Name: {1}," \
                   " *args: {2}," \
                   " **kwargs: {3}," \
                   " returned: {4} \n"
        if "name" in kwargs:
            s += " Name: {1} "
        if "args" in kwargs:
            s += " *args: {2} "
        if "kwargs" in kwargs:
            s += " **kwargs: {3} "
        if "ret" in kwargs:
            s += " returned: {4} "
        s += "\n"
        self.logformat = s


    def __getattribute__(self, name, *args, **kwargs):
        if inspect.ismethod(object.__getattribute__(self, name)) and name != "set_logger_format":
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
    sam.set_logger_format(name=True, ret=True)
    sam.sample(3, 3)
    sam.sample(3, 1)
    sam.sample(3, 2)
    sam.sample(3, 4)
    sam.sample(3, 5)
    sam.sample(3, 6, jdiw=5)
    print(str(sam))

if __name__ == '__main__':
    main()
