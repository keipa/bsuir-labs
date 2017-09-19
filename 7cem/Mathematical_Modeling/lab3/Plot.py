import numpy as np
from matplotlib import pyplot, patches as mpatches
from config import X, width


def ShowDiagramX(m, n, practX, practicalMatrix):
    width = 0.1
    practX = [sum(practicalMatrix[i, j] for i in range(m)) for j in range(n)]
    interval = [X[i] + width for i in range(n)]
    AddBarsX(interval, practX, practX)
    AddLegend()
    pyplot.show()


def AddBarsX(interval, subByRows, practX):
    pyplot.bar(X, subByRows, width, color='red')
    pyplot.bar(interval, practX, width, color='orange')


def AddBarsY(Y, interval, k, practY, sumByColumns):
    pyplot.bar(Y, sumByColumns[:, k - 1], width, color='red')
    pyplot.bar(interval, practY[:, k - 1], width, color='orange')


def ShowDiagramY(m, n, X, Y, practicalMatrix, sumByColumns):
    practX = [sum(practicalMatrix[i, j] for i in range(m)) for j in range(n)]
    practY = np.array(practicalMatrix)
    for j in range(n):
        for i in range(m):
            practY[i, j] /= practX[j]
    interval = [Y[i] + width for i in range(m)]
    ShowDiagramForEachColumn(X, Y, interval, n, practY, sumByColumns)


def ShowDiagramForEachColumn(X, Y, interval, n, practY, sumByColumns):
    for k in range(1, n + 1):
        pyplot.subplot(1, 1, 1)
        AddBarsY(Y, interval, k, practY, sumByColumns)
        AddLegend()
        pyplot.title('для  X = {0}'.format(X[k - 1]))
        pyplot.show()


def AddLegend():
    red_patch = mpatches.Patch(color='red', label='теоретическая гистограмма')
    orange_patch = mpatches.Patch(color='orange', label='практическая гистограмма')
    pyplot.legend(handles=[red_patch, orange_patch])
