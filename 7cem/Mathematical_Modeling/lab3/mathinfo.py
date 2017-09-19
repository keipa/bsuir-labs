from functools import reduce

import numpy as np


def GetMathWait(distr, X, Y):
    print("M[x]", distr.sum(axis=0).dot(X))
    print("M[x]", distr.sum(axis=1).dot(Y))


def GetDispersion(distr, X, Y):
    print("D[x]", np.multiply(distr.sum(axis=0), (distr.sum(axis=0))).dot(X))
    print("D[y]", np.multiply(distr.sum(axis=1), (distr.sum(axis=1))).dot(Y))


def M(arr):
    return reduce(lambda x, y: x + y, arr) / len(arr)


def D(arr):
    arr2 = [i for i in map(lambda x: x * x, arr)]
    return M(arr2) - pow(M(arr), 2)


def GetCorrelationCoeff(x, y):
    Mxy = M([i * j for i, j in zip(x, y)])
    MxMy = M(x) * M(y)
    DxDy = D(x) * D(y)
    print("R[X,Y]", (Mxy - MxMy) / (pow(DxDy, 0.5)))