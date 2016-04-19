class vector:
    def __init__(self, dimension, fill):
        if dimension == 1:
            self.x = [0 for _ in range(fill)]
        else:
            self.x = []
        self.dimension = dimension
        self.fill = fill
        pointer = self.x
        for i in range(dimension-1):
            if i == dimension-2:
                a = [0 for _ in range(self.fill)]
            else:
                a = []
            for _ in range(self.fill):
                pointer.append(a)
            pointer = a

    def __str__(self):
        ret = ""
        pointer = self.x
        return str(self.x)

    def __add__(self, other):
        if str(type(other)) == "<class 'int'>":
            vector.plusconst(self, other, 0)
            return self
        else:
            vector.plusvector(self, other, 0, 0)
            return self

    def __sub__(self, other):
        if str(type(other)) == "<class 'int'>":
            vector.minusconst(self, other, 0)
            return self
        else:
            vector.minusvector(self, other, 0, 0)
            return self

    def __mul__(self, other):
        if str(type(other)) == "<class 'int'>":
            vector.mulconst(self, other, 0)
            return self
        else:
            vector.mulvector(self, other, 0, 0)
            return self

    def __eq__(self, other):
        pass

    def __len__(self):
        return vector.length(self, 0)

    def length(self, pointer):
        count = 0
        if pointer == 0:
            pointer = self.x
        for each in pointer:
            if str(type(each)) != "<class 'list'>":
                count += 1
                continue
            else:
                count += vector.length(self, each)
            return count

    def equal(self, what_changing, pointer):
        if pointer == 0:
            pointer = self.x
        for each in range(len(pointer)):
            if str(type(pointer[each])) != "<class 'list'>":
                pointer[each] += what_changing
            else:
                vector.equal(self, what_changing, pointer[each])


    def change(self, what_changing, pointer):
        if pointer == 0:
            pointer = self.x
        for each in range(len(pointer)):
            if str(type(pointer[each])) != "<class 'list'>":
                pointer[each] = what_changing
            else:
                vector.change(self, what_changing, pointer[each])


    def plusconst(self, what_changing, pointer):
        if pointer == 0:
            pointer = self.x
        for each in range(len(pointer)):
            if str(type(pointer[each])) != "<class 'list'>":
                pointer[each] += what_changing
            else:
                vector.plusconst(self, what_changing, pointer[each])
                break

    def plusvector(self, p_other, pointer_1, pointer_2):
        if pointer_1 == 0 and pointer_2 == 0:
            pointer_1 = self.x
            pointer_2 = p_other.x
        for each in range(len(pointer_1)):
            if str(type(pointer_1[each])) != "<class 'list'>":
                pointer_1[each] += pointer_2[each]
            else:
                vector.plusvector(self, p_other, pointer_1[each], pointer_2[each])
                break

    def minusconst(self, what_changing, pointer):
        if pointer == 0:
            pointer = self.x
        for each in range(len(pointer)):
            if str(type(pointer[each])) != "<class 'list'>":
                pointer[each] -= what_changing
            else:
                vector.minusconst(self, what_changing, pointer[each])
                break

    def minusvector(self, p_other, pointer_1, pointer_2):
        if pointer_1 == 0 and pointer_2 == 0:
            pointer_1 = self.x
            pointer_2 = p_other.x
        for each in range(len(pointer_1)):
            if str(type(pointer_1[each])) != "<class 'list'>":
                pointer_1[each] -= pointer_2[each]
            else:
                vector.minusvector(self, p_other, pointer_1[each], pointer_2[each])
                break


    def mulconst(self, what_changing, pointer):
        if pointer == 0:
            pointer = self.x
        for each in range(len(pointer)):
            if str(type(pointer[each])) != "<class 'list'>":
                pointer[each] *= what_changing
            else:
                vector.mulconst(self, what_changing, pointer[each])
                break


    def mulvector(self, p_other, pointer_1, pointer_2):
        if pointer_1 == 0 and pointer_2 == 0:
            pointer_1 = self.x
            pointer_2 = p_other.x
        for each in range(len(pointer_1)):
            if str(type(pointer_1[each])) != "<class 'list'>":
                pointer_1[each] *= pointer_2[each]
            else:
                vector.mulvector(self, p_other, pointer_1[each], pointer_2[each])
                break


def main():
    n = vector(2, 3)
    b = vector(2, 3)

    # n.equal(2, 0)
    n.x[0][0] = 777
    print(str(n))

if __name__ == "__main__":
    main()