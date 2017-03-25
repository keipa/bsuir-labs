import numpy as np
from sympy import *
from scipy.integrate import odeint
import cvxopt as cvx
import pylab
from matplotlib import mlab

def func(omega,tt,A,c):
	return np.dot(A,omega)

def func1(y,tt1,A,b):
	return np.dot(A,y) + b

def func2(U,D_new,c_new):
	return 0.5 * np.dot(np.dot(U.transpose(),D_new),U) + np.dot(c_new.transpose(),U)

def alg(D,A,b,c,x_zv,H,g,t0,t_zv):
	N = 30.
	y = np.zeros(len(A))
	h = (t_zv - t0) / N
	tj = []

	for i in xrange(1,int(N) + 1):
		tj.append(t0 + i * h)

	tt = [t0,t_zv]
	B0 = odeint(func,x_zv,tt,args = (A,b))[1]
	tt1 = [t0,tj[0]]
	y1  = odeint(func1,y,tt1,args = (A,b))[1]
	temp = odeint(func1,y1,tj,args = (A,b))
	B = np.random.random((len(A),int(N)))

	for i in xrange(int(N)):
		B[:,i] = temp[int(N) - i - 1]

	D_new = cvx.matrix(np.dot(np.dot(B.transpose(),D),B))
	A_new = cvx.matrix(np.dot(H,B))
	c_new = cvx.matrix(np.dot(B.transpose(),c + np.dot(D,B0)))
	b_new = cvx.matrix(g - np.dot(H,B0))
	G = np.zeros((2 * int(N), int(N)))

	for i in xrange(int(N)):
		G[i][i] = 1
	for i in xrange(int(N)):
		G[int(N) + i][i] = -1

	G = cvx.matrix(G)
	h = [1.0 for i in xrange(2 * int(N))]
	h = cvx.matrix(h)


	u = cvx.solvers.qp(D_new,c_new,G,h,A_new,b_new)['x']
	#u = cvx.solvers.qp(D_new,c_new,G,h,A_new.T,b_new)['x']

	for i in xrange(0,int(N)):
		tj[i] -= (t_zv - t0) / N

	pylab.plot(tj,u)
	pylab.show()

'''	

D = np.array([[1,0,0],
	       	[0,1,0],
		   [0,0,1]])

A = np.array([[-1,1,0],
			  [0,0,1],
			  [0,-1,0]]) 

b = np.array([0,0,1])
c = np.array([0,1,0])
x_zv = np.array([1,-1,3])
H = np.array([[1,0,1],
			  [1,-1,0]])
g = np.array([0.3916,-0.3916])
t0 = 0.
t_zv = 5.
'''
'''
D = np.array([[5,0,9],
	       [0,0,0],
		   [9,0,17]])

A = np.array([[-1,1,0],
			  [0,0,1],
			  [0,-1,0]]) 

b = np.array([0,0,1])
c = np.array([-3,1,-2])
x_zv = np.array([-5,-4,-3])
H = np.array([1,1,1])
g = np.array([-6.5139])
t0 = 0.
t_zv = 6.
''' '''
D = np.array([[5,0,9],
	       [0,1,0],
		   [9,0,17]])

A = np.array([[-1,1,0],
			  [0,0,1],
			  [0,-1,0]]) 

b = np.array([0,0,1])
c = np.array([-1.5,0.5,-1])
x_zv = np.array([-5,-4,-3])
H = np.array([1,1,1])
g = np.array([-6.5139])
t0 = 0.
t_zv = 6.'''

D = np.array([[5,0,9],
	       [0,1,0],
		   [9,0,17]])

A = np.array([[0,1,0],
			  [0,0,1],
			  [0,0,0]]) 

b = np.array([0,0,1])
c = np.array([1,0.5,-1])
x_zv = np.array([-5,-4,-3])
H = np.array([[1,0,1],
			  [1,0,-1]])
g = np.array([-198.0,-192.0])
t0 = 0.
t_zv = 10.
alg(D,A,b,c,x_zv,H,g,t0,t_zv)