#!/usr/bin/python2.7
from numpy import *
from simplex_method import SimplexMethodSolver
from math import floor

class IntegerLinearProgrammingSolver(object):
    def __init__(self, A, b, c):
        self.A = A
        self.b = b
        self.c = c
        self.m, self.n = A.shape
        self.eps = 0.000001

    def isInteger(self, val):
        return abs(round(val) - val) < self.eps

    def isIntegers(self, x):
        roundX = array([round(el) for el in x])
        return all(abs(roundX - x) < self.eps)

    def getIndexOfFirstFloat(self, x):
        roundX = array([round(el) for el in x])
        return list(abs(roundX - x) < self.eps).index(False)

    def calculateY(self):
        i0 = self.getIndexOfFirstFloat(self.x)
        ji0 = self.basicIndexes.index(i0)
        return dot(eye(self.m)[:, ji0], self.B)

    def calculateAlpha(self, y):
        alpha = dot(y, self.A)
        alpha = array([round(el) if self.isInteger(el) else el for el in alpha])
        alpha = array([el - floor(el) for el in alpha])
        return alpha

    def calculateBetta(self, y):
        betta = dot(y, self.b)
        betta = betta - floor(betta)
        return betta

    def expansionForA(self, y):
        alpha = self.calculateAlpha(y)
        self.A = vstack([self.A, alpha])
        column = -eye(self.m + 1)[:, self.m]
        self.A = hstack([self.A, column.reshape(self.m + 1, 1)])

    def expansionForB(self, y):
        betta = self.calculateBetta(y)
        self.b = append(self.b, [betta])      

    def expansionForC(self):
        self.c = append(self.c, [0])

    def theGomoriMethod(self):
        while True:
            res = SimplexMethodSolver(self.A, self.b, self.c).solve()

            self.A, self.B, self.b, self.c, self.basicIndexes = res.A, res.B, res.b, res.c, res.basicIndexes  
            self.nonBasicIndexes, self.n, self.m, self.x = res.nonBasicIndexes, res.n, res.m, res.x

            if(self.isIntegers(self.x)):
                return self
            y = self.calculateY()
            self.expansionForA(y)
            self.expansionForB(y)
            self.expansionForC()
            self.m += 1
            self.n += 1


with open('03.txt') as file:
    m, n = [int(elem) for elem in file.readline().split() if elem != ""]
    A = zeros((m, n))
    for i in xrange(m):
        A[i] = [float(elem) for elem in file.readline().split() if elem != ""]
    b = array([float(elem) for elem in file.readline().split() if elem != ""])
    c = array([float(elem) for elem in file.readline().split() if elem != ""])


x0 = IntegerLinearProgrammingSolver(A, b, c).theGomoriMethod()
print x0.x
print dot(x0.c, x0.x)