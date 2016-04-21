class vector:
    def __init__(self, dimension, fill):
        self.dimension = dimension
        self.fill = fill
        self.x = []
        vector.init(self, self.x, 0)

    def init(self, pointer, deep):
        deep += 1
        if deep != self.dimension:
            for each in range(self.fill):
                pointer.append([])
                vector.init(self, pointer[each], deep)
        else:
            for i in range(self.fill):
                pointer.append(0)




def main():
    n = vector(2, 3)
    b = vector(2, 3)

    # n.equal(2, 0)
    n.x[0][0] = 777
    print(str(n.x))

if __name__ == "__main__":
    main()