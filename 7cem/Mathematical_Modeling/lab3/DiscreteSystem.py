from Plot import ShowDiagramX, ShowDiagramY
from config import XYProbMatrix, X, Y
from mathinfo import GetMathWait, GetDispersion, GetCorrelationCoeff
from matixproc import GetXIntervals, GetSumByColumns, GetYIntervals, createMatrix


def Processing():
    global rows, columns, sumByRows, sumByColumns, practMatrix
    rows, columns = XYProbMatrix.shape
    if sum(sum(XYProbMatrix)) != 1.0: exit("Exception")
    sumByRows = [sum(XYProbMatrix[i, j] for i in range(rows)) for j in range(columns)]
    intervals_X = GetXIntervals(sumByRows)
    sumByColumns = GetSumByColumns(XYProbMatrix, rows, columns, sumByRows)
    intervals_Y = GetYIntervals(sumByColumns, rows, columns)
    practMatrix = createMatrix(rows, columns, intervals_X, intervals_Y)


def Output():
    ShowDiagramX(rows, columns, sumByRows, practMatrix)
    ShowDiagramY(rows, columns, X, Y, practMatrix, sumByColumns)
    print(practMatrix)
    GetMathWait(XYProbMatrix, X, Y)
    GetDispersion(XYProbMatrix, X, Y)
    GetCorrelationCoeff(X, Y)