import numpy as np
import scipy.optimize as opt
import sys


def function_g_x(x, B, c, alpha): #g(x)
    return 0.5*x.dot(B.T).dot(B).dot(x) + c.dot(x) + alpha

def d_function(x, B, c):
    return B.T.dot(B).dot(x) + c

def create_estimate(x, J0):
    d_m = np.zeros(len(x)) 
    d_m[np.delete(np.arange(len(x)), J0)] = -1
    d_u = np.ones(len(x))
    return d_m, d_u

def selection_a(x, f, df):
    _x = np.zeros(len(x))
    delta_x = _x - x
    k = df.dot(delta_x)
    a0 = -f/k
    if k < 0:
        if a0 <= 0:
            a = 1.0
        else:
            a = a0 / 2.0
    elif k > 0:
        if a0 <= 0:
            a = 1.0
        else:
            a = a0 + 1.0
    else:
        a = 1.0
    return a, delta_x

def selection_t(x, l, a, delta_x, B_i, c_i, alpha_i):
    t = 2.0 
    while True:
        x_t = x + t*(l + a*delta_x)
        _g = np.array([function_g_x(x_t, B_i, c_i, alpha_i) for B_i, c_i, alpha_i in zip(B, c, alpha)])
        if (_g <= 0.0).all() and (x_t >= 0.0).all():
            break
        t /= 2.0
    return t

def check_for_optimality(df, dg_I0, d_m, d_u):
    l = opt.linprog(df, A_ub=dg_I0, b_ub=np.zeros(len(dg_I0)), bounds=zip(d_m, d_u))
    f = l.fun
    l = l.x #l0
    if f < 0:
        return 'x is not optimal', l, f
    else:
        return 'x is optimal', l, f
        

def analyse(B0, c0, B, c, alpha, x):
    J0 = [index for index in xrange(len(x)) if x[index] == 0.0]
    g = np.array([function_g_x(x, B_i, c_i, alpha_i) for B_i, c_i, alpha_i in zip(B, c, alpha)])
    if (g <= 0).all():
        print "x = ", x, " is a plan"

    I0 = np.array([index for index in xrange(len(g)) if g[index] == 0.0])
    df = d_function(x, B0, c0)

    dg_I0 = np.array([d_function(x, B[i], c[i]) for i in I0])
    d_m, d_u = create_estimate(x, J0)

    check_optimal, l, f = check_for_optimality(df, dg_I0, d_m, d_u)
    print check_optimal
    if check_optimal == "x is optimal":
        return

    a, delta_x = selection_a(x, f, df)

    t = selection_t(x, l, a, delta_x, B_i, c_i, alpha_i)

    x_t = x + t*(l + a*delta_x)
    print "new x = x_t =", x_t

    new_func = function_g_x(x_t, B0, c0, 0.0)
    func = function_g_x(x, B0, c0, 0.0)
    print "f(x) =", func
    print "f(x_t) =", new_func 
    print "f(x_t) < f(x)"


if __name__ == '__main__':
    m = 3
    n = 8
    B0 = np.array([[2, 1, 0, 4, 0, 3, 0, 0], 
                   [0, 4, 0, 3, 1, 1, 3, 2], 
                   [1, 3, 0, 5, 0, 4, 0, 4]])
    B = np.array([[[0, 0, 0.5, 2.5, 1.0, 0, -2.5, -2.0],
                   [0.5, 0.5, -0.5, 0, 0.5, -0.5, -0.5, -0.5], 
                   [0.5, 0.5, 0.5, 0, 0.5, 1.0, 2.5, 4.0]], 
                  [[1, 2, -1.5, 3, -2.5, 0, -1, -0.5], 
                   [-1.5, -0.5, -1, -2.5, 3.5, -3, -1.5, -0.5], 
                   [1.5, 2.5, -1, 1, 2.5, 1.5, 3, 0]], 
                  [[0.75, 0.5, -1, 0.25, 0.25, 0, 0.25, 0.75], 
                   [-1.0000, 1.0000, 4.0000, 0.7500, 0.7500, 0.5000, 7.0, -0.75], 
                   [0.5000, -0.2500, 0.5000, 0.75, 0.5000, 1.2500, -0.7500, -0.25]], 
                  [[1.5000, -1.5000, -1.5000, 2.0000, 1.5000, 0, 0.5000, -1.5000], 
                   [-0.5000, -2.5000, -0.5000, -5.0000, -2.5000, 3.5000, 1.0000, 2.0000], 
                   [-2.5000, 1.0000, -2.0000, -1.500, -2.5000, 0.5000, 8.5000, -2.5000]], 
                  [[1.0000, 0.2500, -0.5000, 1.2500, 1.2500, -0.5000, 0.2500, -0.7500], 
                   [-1.0000, -0.7500, -0.7500, 0.5000, -0.2500, 1.2500, 0.2500, -0.5000], 
                   [0, 0.7500, 0.5000, -0.5000, -1.0000, 1.0000, -1.0000, 1.0000]]])
    c0 = np.array([-1, -1, -1, -1, -2, 0, -2, -3])
    c = np.array([[0, 60, 80, 0, 0, 0, 40, 0],
                   [2, 0, 3, 0, 2, 0, 3, 0],
                   [0, 0, 80, 0, 0, 0, 0, 0],
                   [0, -2, 1, 2, 0, 0, -2, 1],
                   [-4, -2, 6, 0, 4, -2, 60, 2]])
    alpha = np.array([-687.125, -666.625, -349.5938, -254.625, -45.1563])
    x = np.array([0, 8, 2, 1, 0, 4, 0, 0])

    analyse(B0, c0, B, c, alpha, x)