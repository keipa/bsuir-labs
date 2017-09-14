#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

import numpy as np
from matplotlib import pyplot
import math


X = [1.0, 5.0, 9.0]
Y = [2.0, 8.0, 15.0]


def createMatrixDistribution():
	matrix_distribution = np. array([[0.15, 0.10, 0.83333],
                                  	 [0.15, 0.10, 0.83333],
                                  	 [0.15, 0.10, 0.83333]])
	m, n = matrix_distribution.shape
	return matrix_distribution, m, n


def multiplicativeCongruentialMethod(count, n=25, k=192837465, a0=5):
	m = 2 ** n
	A = [a0]
	Z = []
	for i in range(1, count + 1):
		A.append((k * A[i-1]) % m)
		Z.append(A[i] / float(m))
	return Z


def getDistributionSeriesForX(matrix_distribution, m, n):
	p_X = [sum(matrix_distribution[i, j] for i in xrange(m)) for j in xrange(n)]
	return p_X


def getDistributionFunctionForX(p_X):
	F_X = [0.0]
	for i in xrange(len(p_X)):
		F_X.append(F_X[i] + p_X[i])
	return F_X


def getDistributionSeriesForY(matrix_distribution, m, n, p_X):
	p_Y = np.array(matrix_distribution)
	for j in xrange(n):
		for i in xrange(m):
			p_Y[i, j] /= p_X[j]
	return p_Y


def getDistributionFunctionForY(p_Y, m, n):
	F_Y = np.zeros((m + 1, n))
	for j in xrange(n):
		for i in xrange(m):
			F_Y[i + 1, j] = F_Y[i, j] + p_Y[i, j]
	return F_Y


def createEmpericalMatrixDistribution(m, n, F_X, F_Y):
	matrix_distribution_practical = np.zeros((m , n))
	z = multiplicativeCongruentialMethod(20000)
	k = 0
	l = 0
	for i in xrange(0, len(z), 2):
		for j in xrange(n + 1):
			if z[i] > F_X[j]:
				pass
			else:
				k = j - 1
				break
		for j in xrange(m + 1):
			if z[i + 1] > F_Y[j, k]:
				pass
			else:
				l = j - 1
				break
		matrix_distribution_practical[l, k] += 1

	for i in xrange(m):
		for j in xrange(n):
			matrix_distribution_practical[i, j] /= 10000
	return matrix_distribution_practical


def constructDiagramForX(m, n, p_X):
	width = 0.1    
	p_X_practical = [sum(matrix_distribution_practical[i, j] for i in xrange(m)) for j in xrange(n)]
	XX = [X[i] + width for i in xrange(n)]
	pyplot.bar(X, p_X, width, color='black')
	pyplot.bar(XX, p_X_practical, width, color='green')
	pyplot.title('probability distribution X components')
	pyplot.show()
	return p_X_practical


def constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical):
	p_Y_practical = np.array(matrix_distribution_practical)  
	for j in xrange(n):
		for i in xrange(m):
			p_Y_practical[i, j] /= p_X_practical[j]

	width = 0.2     
	YY = [Y[i] + width for i in xrange(m)]
	pyplot.figure(figsize = (10, 3))

	for k in xrange(1, n + 1):
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
	print matrix_distribution_practical
	p_X_practical = constructDiagramForX(m, n, p_X)
	constructDiagramForY(m, n, X, Y, matrix_distribution_practical, p_X_practical)
else:
	print "Sum != 1!"