#!/usr/bin/python2.7
from numpy import *
import scipy.optimize as sc


def matrix_play(A):
	A_ub = copy(A)
	A_ub = A_ub.transpose()
	A_ub = -1*A_ub
	m, n = A_ub.shape
	A_ub = insert(A_ub, n, 1, axis=1)
	n += 1
	A_eq = [[] for i in xrange(m)]
	A_eq[0] = [1.0 for i in xrange(n - 1)]
	A_eq[0].append(0.0)
	for i in xrange(1, m):
		A_eq[i] = [0.0 for j in xrange(n)]

	A_eq = array(A_eq)
	b_ub = array([0.0 for i in xrange(m)])
	b_eq = [0.0 for i in xrange(m)]
	b_eq[0] = 1.0
	b_eq = array(b_eq)
	c = [0.0 for i in xrange(n - 1)]
	c.append(-1.0)
	c = array(c)
	result1 = sc.linprog(c, A_ub=A_ub, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq)
	print result1.x
	A_ub2 = copy(A)
	m, n = A_ub2.shape
	A_ub2 = insert(A_ub2, n, -1, axis=1)
	n += 1
	A_eq = [[] for i in xrange(m)]
	A_eq[0] = [1.0 for i in xrange(n - 1)]
	A_eq[0].append(0.0)
	for i in xrange(1, m):
		A_eq[i] = [0.0 for j in xrange(n)]

	A_eq = array(A_eq)
	b_ub = array([0.0 for i in xrange(m)])
	b_eq = [0.0 for i in xrange(m)]
	b_eq[0] = 1.0
	b_eq = array(b_eq)
	c = [0.0 for i in xrange(n - 1)]
	c.append(1.0)
	c = array(c)
	result2 = sc.linprog(c, A_ub=A_ub2, b_ub=b_ub, A_eq=A_eq, b_eq=b_eq)
	print result2.x
	return result1.x[-1]

	


if __name__ == "__main__":
	with open('laba12.txt') as file:
		m, n = [int(elem) for elem in file.readline().split() if elem != ""]
		A = zeros((m, n))
		for i in xrange(m):
			A[i] = [float(elem) for elem in file.readline().split() if elem != ""]

	res = matrix_play(A)
	print res
