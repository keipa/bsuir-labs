def GetNewPseudoRandom(number):
    number = number ** 2
    number_str = AddZerosFromLeft(number)
    return int(number_str[2:6])  # get from center


def AddZerosFromLeft(number):
    number_str = str(number)
    zerosToAdd = '0' * (8 - len(number_str))
    number_str = zerosToAdd + number_str
    return number_str


def MidSquareMethod(sourceNumber, count):
    A = []
    for i in xrange(count):
        sourceNumber = GetNewPseudoRandom(sourceNumber)
        A.append(sourceNumber)
    return A