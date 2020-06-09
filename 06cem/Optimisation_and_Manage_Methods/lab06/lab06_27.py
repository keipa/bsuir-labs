# -*- coding: utf-8 -*-
from numpy import *
import scipy.optimize as opt


def function_g_x(x, B, c, alpha):  # g(x)
    return 0.5 * x.dot(B.T).dot(B).dot(x) + c.dot(x) + alpha


def function_df_dx(x, B, c):
    return B.T.dot(B).dot(x) + c


def convex(B0, c0, B, c, alpha, x):
    J0 = [index for index in xrange(len(x)) if x[index] == 0.0]
    g = array([function_g_x(x, B_i, c_i, alpha_i) for B_i, c_i, alpha_i in zip(B, c, alpha)])
    print list(x), "- начальный план" if (g <= 0).all() else exit()  # проверим исходный план
    print "Значение целевой функции по начальному плану f(x) =", function_g_x(x, B0, c0, 0.0)
    print "Проверка оптимальности начального плана..."
    I0 = array([index for index in xrange(len(g)) if g[index] == 0.0])
    df = function_df_dx(x, B0, c0)
    dg_I0 = array([function_df_dx(x, B[i], c[i]) for i in I0])
    # границы
    d_m = zeros(len(x))  # dm
    d_m[delete(arange(len(x)), J0)] = -1
    l = opt.linprog(df, A_ub=dg_I0, b_ub=zeros(len(dg_I0)), bounds=zip(d_m, ones(len(x))))
    f = l.fun
    l = l.x  # l0
    print "План не оптимален. Значение dg/dx", f if f < 0 else exit()
    a = 1  # подберём число А для неравенства
    delta_x = zeros(len(x)) - x
    k = df.dot(delta_x)
    a0 = -f / k
    if k < 0 < a0:
        a = a0 / 2
    if k > 0 and a0 > 0:
        a = a0 + 1
    t = 2.0  # подберём число t для неравенства
    while True:
        x_t = x + t * (l + a * delta_x)  # новый план
        if (array([function_g_x(x_t, B_i, c_i, alpha_i) for B_i, c_i, alpha_i in zip(B, c, alpha)]) <= 0.0).all() and (x_t >= 0.0).all():
            break
        t /= 2.0
    print "Новый план  x_t =", list(x_t)
    print "Новое значение целевой функции f(x_t) =", function_g_x(x_t, B0, c0, 0.0)  # less then f(x*)
    print "Улучшение плана: ", round(100 - function_g_x(x_t, B0, c0, 0.0) / function_g_x(x, B0, c0, 0.0) * 100, 2), "%"
