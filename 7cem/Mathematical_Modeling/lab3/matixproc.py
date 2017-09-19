import numpy as np
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod
from config import RandomCount


def GetXIntervals(p_X):
    F_X = [0.0]
    for i in range(len(p_X)):
        F_X.append(F_X[i] + p_X[i])
    return F_X


def GetSumByColumns(ProbMatrix, m, n, sumByRows):
    ColumnsSum = np.array(ProbMatrix)
    for j in range(n):
        for i in range(m):
            ColumnsSum[i, j] /= sumByRows[j]
    return ColumnsSum


def GetYIntervals(ColumnsSum, rows, columns):
    intervals_Y = np.zeros((rows + 1, columns))
    for j in range(columns):
        for i in range(rows):
            intervals_Y[i + 1, j] = intervals_Y[i, j] + ColumnsSum[i, j]
    return intervals_Y


def createMatrix(rows, columns, intervals_X, intervals_Y):
    autoFill = np.zeros((rows, columns))
    randomList = MultiplicativeCongruentialMethod(RandomCount*2)
    BitFilling(intervals_X, intervals_Y, autoFill, columns, rows, randomList)
    for i in range(rows):
        for j in range(columns):
            autoFill[i, j] /= RandomCount
    return autoFill


def BitFilling(intervals_X, intervals_Y, autoFill, columns, rows, randomList):
    k = 0
    l = 0
    for i in range(0, len(randomList), 2):
        for j in range(columns + 1):
            if randomList[i] <= intervals_X[j]:
                k = j - 1
                break

        for j in range(rows + 1):
            if randomList[i + 1] <= intervals_Y[j, k]:
                l = j - 1
                break
        autoFill[l, k] += 1