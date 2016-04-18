class vector:
    def __init__(self, n):
        self.x = []
        pointer = self.x
        self.g =8
        for i in range(n - 1):
            a = []
            pointer.append(a)
            pointer = a

    def __str__(self):
        return str(self.g)


def main():
    n = vector(6)
    print(str(n))

if __name__ == "__main__":
    main()