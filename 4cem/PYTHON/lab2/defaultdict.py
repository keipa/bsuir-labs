class Defaul_dict( object):
    def __init__(self, default_factory):
        self.d = {}
        self.x = default_factory

    # def __set__(self, instance, value):
    #     self.d[instance] = value
    #
    def __setitem__(self, key, value):
        self.d[key] = value

    # def __get__(self, item):
    #     pass
    def __get__(self, instance, owner):
        return self.d
    # def __init__(self, dimension, fill):
    #     self.dimension = dimension
    #     self.fill = fill
    #     self.x = {}
    #     Defaul_dict.init(self, self.x, 0)
    #
    # # def init(self, pointer, deep):
    # #     deep += 1
    # #     if deep != self.dimension:
    # #         for each in range(self.fill):
    # #             pointer[])
    # #             Defaul_dict.init(self, pointer[each], deep)
    # #     else:
    # #         for i in range(self.fill):
    # #             pointer.append(0)
    #
    # def __str__(self):
    #     return str(self.x)


    def __getitem__(self, item):
        return Defaul_dict.getitem(self, item, 0)
    #
    # def __get__(self, instance, owner):
    #     return self.x
    #

    def getitem(self, item, pointer):
        if pointer == 0:
            pointer = self.d
            # print(str(pointer))
        try:
            a = pointer[item]
        except KeyError:
            pointer[item] = Defaul_dict(self.x)
            return pointer[item]

        if pointer[item] != 0:
            return pointer[item]
            # return Defaul_dict.getitem(self,item, pointer[item])
        # if deep == self.dimension:
        #     return pointer[item % self.dimension]
        # else:
        #     deep += 1
        #     return Defaul_dict.getitem(self, item, pointer[(item//self.dimension)-1], deep)
    #
    # def __setitem__(self, key, value):
    #     pass

    def __str__(self):
        return str(self.x)

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
    d[1][2] = 2
    d[2] = 5
    d[3][5][1] = 4


    print(str(d[3][5][3]))

if __name__ == '__main__':
    main()