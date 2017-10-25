from math import floor

from numpy import *

from GomorianExtensions import isInteger, isIntegers, getIndexOfFirstFloat
from simplex_method import SimplexMethodSolver as sms


class Gomorian(object):
    def __init__(self, A, b, c):
        self.A = A
        self.b = b
        self.c = c
        self.m, self.n = A.shape
        self.eps = 0.000001
        self.iteration = 0

    def RefreshParams(self, res):
        self.m, self.n = self.A.shape
        self.A, self.B, self.b, self.c, self.basicIndexes = res.A, res.B, res.b, res.c, res.basicIndexes
        self.nonBasicIndexes, self.n, self.m, self.x = res.nonBasicIndexes, res.n, res.m, res.x
        self.iteration += 1



    def resizeA(self, y):
        alpha = dot(y, self.A)
        alpha = array([round(i) if isInteger(self.eps, i) else i for i in alpha])
        alpha = array([i - floor(i) for i in alpha])
        self.A = vstack([self.A, alpha])
        column = -eye(self.m + 1)[:, self.m]
        self.A = hstack([self.A, column.reshape(self.m + 1, 1)])

    def resizeB(self, y):
        beta = dot(y, self.b)
        beta = beta - floor(beta)
        self.b = append(self.b, [beta])

    def resizeC(self):
        self.c = append(self.c, [0])

    def run(self):
        iter = 0
        while True:

            res = sms(self.A, self.b, self.c).solve()
            self.RefreshParams(res)
            if isIntegers(self.eps, self.x):
                return self
            eab = dot(eye(self.m)[:, self.basicIndexes.index(getIndexOfFirstFloat(self.eps, self.x))], self.B)
            self.resizeA(eab)
            self.resizeB(eab)
            self.resizeC()
            print(str(self.iteration)+": "+str(list(self.x)))

    def GetBestPlan(self):
        return str([round(i) for i in self.x])

    def GetBestResult(self):
        return dot(sol.c, sol.x)




def manualInput(objtype, f):
    return [objtype(number) for number in f.readline().split()]


def inputValues(path="input"):
    m, n, A, b, c, dmin, dmax, J = 0, 0, [], [], [], [], [], []
    with open(path) as f:
        m, n = manualInput(int, f)
        for _ in range(m):
            A.append(manualInput(float, f))
        A = array(A)
        b = array(manualInput(float, f))
        c = array(manualInput(float, f))
    return A, b, c


A, b, c = inputValues("01.txt")
sol = Gomorian(A, b, c).run()
print(sol.GetBestPlan())
print(sol.GetBestResult())
