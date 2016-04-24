class Vector:
    # def __init__(self, dimension, fill):
    #     self.dimension = dimension
    #     self.fill = fill
    #     self.x = []
    #     Vector.init(self, self.x, 0)



    # def init(self, pointer, deep):
    #     deep += 1
    #     if deep != self.dimension:
    #         for each in range(self.fill):
    #             pointer.append([])
    #             Vector.init(self, pointer[each], deep)
    #     else:
    #         for i in range(self.fill):
    #             pointer.append(0)
    # def __str__(self):
    #     ret = ""
    #     pointer = self.x
    #     return str(self.x)
    # def __add__(self, other):
    #     if str(type(other)) == "<class 'int'>":
    #         Vector.plusconst(self, other, 0)
    #         return self
    #     else:
    #         Vector.plusvector(self, other, 0, 0)
    #         return self
    # def __getitem__(self, item):
    #     return Vector.getitem(self, item, 0, 1)
    #
    # def getitem(self, item, pointer, deep):
    #     if pointer == 0:
    #         pointer = self.x
    #     if deep == self.dimension:
    #         return pointer[item % self.dimension]
    #     else:
    #         deep += 1
    #         return Vector.getitem(self, item, pointer[(item//self.dimension)-1], deep)



    # def __sub__(self, other):
    #     if str(type(other)) == "<class 'int'>":
    #         Vector.minusconst(self, other, 0)
    #         return self
    #     else:
    #         Vector.minusvector(self, other, 0, 0)
    #         return self

    #     if str(type(other)) == "<class 'int'>":
    # def __mul__(self, other):
    #         Vector.mulconst(self, other, 0)
    #         return self
    #     else:
    #         return Vector.mulvector(self, other, 0, 0)

    def __init__(self, dimension):
        self.x = [0 for _ in range(dimension)]

    def __str__(self):
        ret = ""
        for i in range(len(self.x)-1):
            return str(self.x[i])

    def __add__(self, other):
        if type(self) == type(other):
            if len(self)==len(other):
                for each in range(len(self)-1):
                    self.x[each] += other.x[each]
            else:
                raise ValueError("You can't complete the operation with different dimentions")
                return self
        else:
            for each in range(len(self.x)-1):
                self.x[each] += other

    def __getitem__(self, item):
        if item >= len(self.x):
            raise Exception("Out of range Exception")
        return self.x[item]

    def __sub__(self, other):
        if len(self) == len(other):
            for each in range(len(self)-1):
                self.x[each] -= other.x[each]
        else:
            raise ValueError("You can't complete the operation with different dimentions")
            return self

    def __eq__(self, other):
        if type(self) == type(other):
            if self.x == other.x:
                return True
            else:
                return False
        else:
            return False

    def __mul__(self, other):
        if type(self) == type(other):
            ret = 0
            if len(self) == len(other):
                for each in range(len(self)-1):
                    ret += self.x[each] * other.x[each]
                return ret**0.5
        else:
            for each in range(len(self)-1):
                self.x[each] *= other
    # def __eq__(self, other):
    #     return Vector.equal(self, other, 0, 0, True)
    #
    # def __len__(self):
    #     return Vector.length(self, 0)

    # def length(self, pointer):
    #     count = 0
    #     if pointer == 0:
    #         pointer = self.x
    #     for each in pointer:
    #         if str(type(each)) != "<class 'list'>":
    #             count += 1
    #
    #         else:
    #             count += Vector.length(self, each)
    #     return count
    #
    # def equal(self, p_other, pointer_1, pointer_2, is_eq):
    #     if pointer_1 == 0 and pointer_2 == 0:
    #         pointer_1 = self.x
    #         pointer_2 = p_other.x
    #     for each in range(len(pointer_1)):
    #         if str(type(pointer_1[each])) != "<class 'list'>":
    #             if pointer_1[each] != pointer_2[each]:
    #                 is_eq = False
    #
    #         else:
    #             is_eq = Vector.equal(self, p_other, pointer_1[each], pointer_2[each], is_eq)
    #     return is_eq
    #
    # def change(self, what_changing, pointer):
    #     if pointer == 0:
    #         pointer = self.x
    #     for each in range(len(pointer)):
    #         if str(type(pointer[each])) != "<class 'list'>":
    #             pointer[each] = what_changing
    #         else:
    #             Vector.change(self, what_changing, pointer[each])
    #
    # def plusconst(self, what_changing, pointer):
    #     if pointer == 0:
    #         pointer = self.x
    #     for each in range(len(pointer)):
    #         if str(type(pointer[each])) != "<class 'list'>":
    #             pointer[each] += what_changing
    #         else:
    #             Vector.plusconst(self, what_changing, pointer[each])
    #
    # def plusvector(self, p_other, pointer_1, pointer_2):
    #     if pointer_1 == 0 and pointer_2 == 0:
    #         pointer_1 = self.x
    #         pointer_2 = p_other.x
    #     for each in range(len(pointer_1)):
    #         if str(type(pointer_1[each])) != "<class 'list'>":
    #             pointer_1[each] += pointer_2[each]
    #         else:
    #             Vector.plusvector(self, p_other, pointer_1[each], pointer_2[each])
    #
    # def minusconst(self, what_changing, pointer):
    #     if pointer == 0:
    #         pointer = self.x
    #     for each in range(len(pointer)):
    #         if str(type(pointer[each])) != "<class 'list'>":
    #             pointer[each] -= what_changing
    #         else:
    #             Vector.minusconst(self, what_changing, pointer[each])
    #             break
    #
    # def minusvector(self, p_other, pointer_1, pointer_2):
    #     if pointer_1 == 0 and pointer_2 == 0:
    #         pointer_1 = self.x
    #         pointer_2 = p_other.x
    #     for each in range(len(pointer_1)):
    #         if str(type(pointer_1[each])) != "<class 'list'>":
    #             pointer_1[each] -= pointer_2[each]
    #         else:
    #             Vector.minusvector(self, p_other, pointer_1[each], pointer_2[each])
    #
    # def mulconst(self, what_changing, pointer):
    #     if pointer == 0:
    #         pointer = self.x
    #     for each in range(len(pointer)):
    #         if str(type(pointer[each])) != "<class 'list'>":
    #             pointer[each] *= what_changing
    #         else:
    #             Vector.mulconst(self, what_changing, pointer[each])
    #
    # def mulvector(self, p_other, pointer_1, pointer_2):
    #     ret_mul = 0
    #     if pointer_1 == 0 and pointer_2 == 0:
    #         pointer_1 = self.x
    #         pointer_2 = p_other.x
    #     for each in range(len(pointer_1)):
    #         if str(type(pointer_1[each])) != "<class 'list'>":
    #             ret_mul += pointer_1[each] * pointer_2[each]
    #         else:
    #             ret_mul += Vector.mulvector(self, p_other, pointer_1[each], pointer_2[each])
    #     return ret_mul


def main():
    n = Vector(4)
    b = Vector(2)
    # print(str(n))
    # n.equal(2, 0)

    n += 2
    b += 1
    # n.x[1][1] = 5
    # print(str(n*b))
    # print(len(n))

if __name__ == "__main__":
    main()
