import cvxopt as cvx
import numpy as np
import pylab
from scipy.integrate import odeint


def func(omega, tt, A, c):
    return np.dot(A, omega)


def func1(y, tt1, A, b):
    return np.dot(A, y) + b


def func2(U, D_new, c_new):
    return 0.5 * np.dot(np.dot(U.transpose(), D_new), U) + np.dot(c_new.transpose(), U)


def alg(D, A, b, c, x_zv, H, g, t0, t_zv):
    N = 30
    y = np.zeros(len(A))
    h = (t_zv - t0) / N
    tj = []

    for i in xrange(1, int(N) + 1):
        tj.append(t0 + i * h)

    tt = [t0, t_zv]
    B0 = odeint(func, x_zv, tt, args=(A, b))[1]
    tt1 = [t0, tj[0]]
    y1 = odeint(func1, y, tt1, args=(A, b))[1]
    temp = odeint(func1, y1, tj, args=(A, b))
    B = np.random.random((len(A), int(N)))

    for i in xrange(int(N)):
        B[:, i] = temp[int(N) - i - 1]

    D_new = cvx.matrix(np.dot(np.dot(B.transpose(), D), B))
    A_new = cvx.matrix(np.dot(H, B))
    c_new = cvx.matrix(np.dot(B.transpose(), c + np.dot(D, B0)))
    b_new = cvx.matrix(g - np.dot(H, B0))
    G = np.zeros((2 * int(N), int(N)))

    for i in xrange(int(N)):
        G[i][i] = 1
    for i in xrange(int(N)):
        G[int(N) + i][i] = -1

    G = cvx.matrix(G)
    h = [1.0 for i in xrange(2 * int(N))]
    h = cvx.matrix(h)

    u = cvx.solvers.qp(D_new, c_new, G, h, A_new.T, b_new)['x']

    for i in xrange(0, int(N)):
        tj[i] -= (t_zv - t0) / N

    pylab.plot(tj, u)
    pylab.show()
