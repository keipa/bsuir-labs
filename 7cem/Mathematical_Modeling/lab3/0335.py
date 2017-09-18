import numpy as np
from matplotlib import pyplot
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod
import math
from functools import reduce

X = [1.0, 5.0, 9.0]
Y = [2.0, 8.0, 15.0]

XYProb = np.array([[0.1, 0.10, 0.1],
                   [0.1, 0.05, 0.1],
                   [0.1, 0.15, 0.2]])


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


def createMatrixDistribution():
    matrix_distribution = XYProb
    m, n = matrix_distribution.shape
    return matrix_distribution, m, n


def getDistributionSeriesForX(matrix_distribution, m, n):
    p_X = [sum(matrix_distribution[i, j] for i in range(m)) for j in range(n)]
    return p_X


def getDistributionFunctionForX(p_X):
    F_X = [0.0]
    for i in range(len(p_X)):
        F_X.append(F_X[i] + p_X[i])
    return F_X


def getDistributionSeriesForY(matrix_distribution, m, n, p_X):
    p_Y = np.array(matrix_distribution)
    for j in range(n):
        for i in range(m):
            p_Y[i, j] /= p_X[j]
    return p_Y


def getDistributionFunctionForY(p_Y, m, n):
    F_Y = np.zeros((m + 1, n))
    for j in range(n):
        for i in range(m):
            F_Y[i + 1, j] = F_Y[i, j] + p_Y[i, j]
    return F_Y


def createEmpericalMatrixDistribution(m, n, F_X, F_Y):
    matrix_distribution_practical = np.zeros((m, n))
    z = MultiplicativeCongruentialMethod(20000)
    k = 0
    l = 0
    for i in range(0, len(z), 2):
        for j in range(n + 1):
            if z[i] > F_X[j]:
                pass
            else:
                k = j - 1
                break
        for j in range(m + 1):
            if z[i + 1] > F_Y[j, k]:
                pass
            else:
                l = j - 1
                break
        matrix_distribution_practical[l, k] += 1

    for i in range(m):
        for j in range(n):
            matrix_distribution_practical[i, j] /= 10000
    return matrix_distribution_practical


def constructDiagramForX(m, n, p_X):
    width = 0.1
    p_X_practical = [sum(matrix_distribution_practical[i, j] for i in range(m)) for j in range(n)]
    XX = [X[i] + width for i in range(n)]
    pyplot.bar(X, p_X, width, color='red')
    pyplot.bar(XX, p_X_practical, width, color='orange')
    # pyplot.title('probability distribution X components')
    pyplot.show()
    return p_X_practical


def constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical):
    p_Y_practical = np.array(matrix_distribution_practical)
    for j in range(n):
        for i in range(m):git
            p_Y_practical[i, j] /= p_X_practical[j]

    width = 0.2
    YY = [Y[i] + width for i in range(m)]
    #pyplot.figure(figsize=(6, 6))

    for k in range(1, n + 1):
        pyplot.subplot(1, 1, 1)
        pyplot.bar(Y, p_Y[:, k - 1], width, color='red')
        pyplot.bar(YY, p_Y_practical[:, k - 1], width, color='orange')
        pyplot.title('для  X = {0}'.format(X[k - 1]))
        pyplot.show()


matrix_distribution, m, n = createMatrixDistribution()
if sum(sum(matrix_distribution)) != 1.0: exit("Sum != 1!")

p_X = getDistributionSeriesForX(matrix_distribution, m, n)
F_X = getDistributionFunctionForX(p_X)
p_Y = getDistributionSeriesForY(matrix_distribution, m, n, p_X)
F_Y = getDistributionFunctionForY(p_Y, m, n)
matrix_distribution_practical = createEmpericalMatrixDistribution(m, n, F_X, F_Y)
print(matrix_distribution_practical)
p_X_practical = constructDiagramForX(m, n, p_X)
constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical)
GetMathWait(matrix_distribution, X, Y)
GetDispersion(matrix_distribution, X, Y)
GetCorrelationCoeff(X, Y)
