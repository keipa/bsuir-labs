import numpy as np
from matplotlib import pyplot
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod
import math

X = [1.0, 5.0, 9.0]
Y = [2.0, 8.0, 15.0]


def createMatrixDistribution():
    # matrix_distribution = np.array([[0.15, 0.10, 0.83333],
    #                                 [0.15, 0.10, 0.83333],
    #                                 [0.15, 0.10, 0.83333]])
    matrix_distribution = np.array([[0.1, 0.10, 0.1],
                                    [0.1, 0.10, 0.1],
                                    [0.1, 0.10, 0.2]])
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
    pyplot.bar(X, p_X, width, color='black')
    pyplot.bar(XX, p_X_practical, width, color='green')
    pyplot.title('probability distribution X components')
    pyplot.show()
    return p_X_practical


def constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical):
    p_Y_practical = np.array(matrix_distribution_practical)
    for j in range(n):
        for i in range(m):
            p_Y_practical[i, j] /= p_X_practical[j]

    width = 0.2
    YY = [Y[i] + width for i in range(m)]
    pyplot.figure(figsize=(10, 3))

    for k in range(1, n + 1):
        pyplot.subplot(1, n, k)
        pyplot.bar(Y, p_Y[:, k - 1], width, color='black')
        pyplot.bar(YY, p_Y_practical[:, k - 1], width, color='green')
        pyplot.title('Y for X = {0}'.format(X[k - 1]))
    pyplot.show()


matrix_distribution, m, n = createMatrixDistribution()
if sum(sum(matrix_distribution)) == 1.0:
    p_X = getDistributionSeriesForX(matrix_distribution, m, n)
    F_X = getDistributionFunctionForX(p_X)
    p_Y = getDistributionSeriesForY(matrix_distribution, m, n, p_X)
    F_Y = getDistributionFunctionForY(p_Y, m, n)
    matrix_distribution_practical = createEmpericalMatrixDistribution(m, n, F_X, F_Y)
    print(matrix_distribution_practical)
    p_X_practical = constructDiagramForX(m, n, p_X)
    constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical)
else:
    print("Sum != 1!")
