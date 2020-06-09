class Defaul_dict( object):
    def __init__(self, default_factory):
        self.d = {}
        self.x = default_factory

    def __setitem__(self, key, value):
        self.d[key] = value

    def __get__(self, instance, owner):
        return self.d

    def __getitem__(self, item):
        return Defaul_dict.getitem(self, item, 0)

    def getitem(self, item, pointer):
        if pointer == 0:
            pointer = self.d
        try:
            a = pointer[item]
        except KeyError:
            pointer[item] = 0

        if pointer[item] == 0:
            pointer[item] = Defaul_dict(self.x)
            return pointer[item]
        else:
            return pointer[item]

    def __str__(self):
        ret = "{"
        length = 0
        for key in self.d:
            ret += str(key) + ":" +str(self.d[key])
            if length < len(self.d)-1 :
                ret +=", "
            length += 1
        return ret + "}"
        return str(self.d)

def retx():
    return 0

def main():
    # k = Defaul_dict(3, 4)
    # k[0][0][0]
    # print(str(k))
    # d = dict()
    # d["kek"] = 2
    # b = {}
    # print(b[2])
    # d[2] = {2: 4}
    #
    # print(d[2][2])

    d = Defaul_dict(retx())
    d["1"] = 2
    d["2"] = 5
    d["3"]["5"]["1"] = 4
    d["3"]["ew2"]["2"] = None

    print(str(d[3][5][2]))

    # print(b[2])
    # d[2] = {2: 4}
    #
    # print(d[2][2])    print(str(d[3]["3"][2]))
    print(str(d))

if __name__ == '__main__':
    main()