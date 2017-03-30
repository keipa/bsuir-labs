from sympy import Symbol, exp, solve, symbols
from sympy.matrices import Matrix
from numpy import *





def d_column_vector(x, I0, g, plan_):
    matrix = zeros((len(x), len(I0)))
    for i, index in enumerate(I0):
        matrix[:, i] = [g[index].diff(xi).subs(plan_) for xi in x]
    return matrix


def check_usual_plan(I0, matrix):
    if len(I0) == 0:
        print("x is not usual plan.")
        a0 = Symbol("a0", nonnegative=True)
    elif linalg.matrix_rank(matrix) == len(I0):
        a0 = 1.0
        print("x is usual plan.")
    else:
        print("x is not usual plan.")
        a0 = Symbol("a0", nonnegative=True)
    return a0


def calculate_differentials(plan_, df, dg, a0, a, g_plan):
    df_ = [elem.subs(plan_) for elem in df]
    dg_ = []
    for dgi in dg:
        dg_.append([elem.subs(plan_) for elem in dgi])
    eqs = []
    for i in range(len(df_)):
        eq = a0 * df_[i]
        for ai, dgi in zip(a, dg_):
            eq += ai * dgi[i]
        eqs.append(eq)
    eq = 0
    for ai, gi in zip(a, g_plan):
        eq += ai * gi
    eqs.append(eq)
    a_res = solve(eqs)
    return a_res, dg_


def search_k(I0_plus, l, dg_, I0_0):
    eqs = []
    for i in I0_plus:
        eq = 0
        for li, dgi in zip(l, dg_[i]):
            eq += li * dgi
        eqs.append(eq)
    eqs_ = []
    for i in I0_0:
        eq = 0
        for li, dgi in zip(l, dg_[i]):
            eq += li * dgi
        eqs_.append(eq <= 0)

    K = solve(eqs)
    K_ = solve(eqs_)
    return K, K_


def verification_of_sufficient_second_order_conditions(K, df, x, l):
    if not K:
        print("The sufficient optimality condition of second kind is made.")
    else:
        ddf = []
        for xi in x:
            ddf.append([ddfi.diff(xi) for ddfi in df])
        ddf = Matrix(ddf)
        ll = Matrix(l)
        if Matrix(ddf.dot(ll.T)).dot(ll).subs(K) > 0:
            print("The sufficient optimality condition of second kind is made.")
        else:
            print("The sufficient optimality condition of second kind is not made.")
            return


def check_of_condition(x, plan, a, f, g, l):
    plan_ = []
    for obj in zip(x, plan):
        plan_.append(obj)

    # проверка допустимости
    g_plan = array([elem.subs(plan_) for elem in g])
    if (g_plan <= 0.0).all():
        print("x is plan.", plan)
    else:
        return

    df = [f.diff(xi) for xi in x]  # дифференцируем по каждому X
    dg = []
    for gi in g:
        dg.append([gi.diff(xi) for xi in x])

    I0 = [i for i, gi in enumerate(g_plan) if gi == 0.0]   # проверка на линейную независимость?
    matrix = d_column_vector(x, I0, g, plan_)
    a0 = check_usual_plan(I0, matrix)
    a_res, dg_ = calculate_differentials(plan_, df, dg, a0, a, g_plan)
    if a_res:
        if type(a_res) == list:
            a_res = a_res[0]
        if (array(a_res.values()) == 0.0).all():
            print("The necessary optimality condition of the first kind is not made.")
            return
        print("The necessary optimality condition of the first kind is made.")
    else:
        print("The necessary optimality condition of the first kind is not made.")
        return
    I0_plus = [ind for ind in I0 if a_res[a[ind]] > 0.0]
    I0_0 = [ind for ind in I0 if a_res[a[ind]] == 0.0]
    K, K_ = search_k(I0_plus, l, dg_, I0_0)
    verification_of_sufficient_second_order_conditions(K, df, x, l)
