from numpy import round_
from numpy.core.multiarray import array
from numpy.core.umath import absolute


def isInteger(eps, val):
    return abs(round(val) - val) < eps


def isIntegers(eps, x):
    roundX = array([round(el) for el in x])
    return (abs(roundX - x) < eps).all()


def getIndexOfFirstFloat(eps, x):
    roundX = array([round(el) for el in x])
    return list(abs(roundX - x) < eps).index(False)