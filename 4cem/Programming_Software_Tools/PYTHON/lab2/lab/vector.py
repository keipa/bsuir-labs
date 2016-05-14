class Vector:
    def __init__(self, dimension):
        self.x = [0 for _ in range(dimension)]

    def __str__(self):
        ret = ""
        # for i in range(len(self.x)-1):
        #     return str(self.x[i])
        #
        return str(self.x)

    def __add__(self, other):
        if type(self) == type(other):
            if len(self)==len(other):
                for each in range(len(self)-1):
                    self.x[each] += other.x[each]
            else:
                raise ValueError("You can't complete the operation with different dimentions")
                return self
        else:
            for each in range(len(self.x)):
                self.x[each] += other

            return self

    def __getitem__(self, item):
        if item >= len(self.x):
            raise Exception("Out of range Exception")
        return self.x[item]
    def __len__(self):
        return len(self.x)

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
        if isinstance(other, Vector):
            ret = 0
            if len(self.x) == len(other.x):
                for each in range(len(self.x)):
                    ret += self.x[each] *other.x[each]
                return ret ** 0.5
            else:
                raise TypeError("Different dimensions")
        else:
            for each in range(len(self.x)):
                self.x[each] *= other
            return self



def main():
    n = Vector(4)
    b = Vector(4)
    # print(str(n))
    # n.equal(2, 0)

    n += 3
    b += 1
    print(n.x)
    # n.x[1][1] = 5
    print(str(n*b))
    # print(len(n))

if __name__ == "__main__":
    main()
