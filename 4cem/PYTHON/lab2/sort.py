from  tempfile import *


def sort():
    with open("strfiles/genrated.txt", "r") as file:
        print(file.read(10))


if __name__ == '__main__':
    sort()
