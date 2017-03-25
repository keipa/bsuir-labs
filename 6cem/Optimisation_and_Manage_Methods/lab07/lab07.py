from sympy import Symbol, exp, solve, var, symbols
from sympy.matrices import Matrix
import numpy as np


def admissibility_check(plan_, g, plan):
    g_plan = np.array([elem.subs(plan_) for elem in g])
    if (g_plan <= 0.0).all():
        tmp = "is plan."
    else:
        tmp = "is not plan."
    print("x =", plan, tmp)
    return g_plan, tmp


def d_column_vector(x, I0, g, plan_):
    matrix = np.zeros((len(x), len(I0)))
    for i, index in enumerate(I0):
        matrix[:, i] = [g[index].diff(xi).subs(plan_) for xi in x]
    return matrix


def check_usual_plan(I0, matrix):
    if len(I0) == 0:
        print("x is not usual plan.")
        a0 = Symbol("a0", nonnegative=True)
    elif np.linalg.matrix_rank(matrix) == len(I0):
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

    eqs =[]
    for i in range(len(df_)):
        eq = a0*df_[i]
        for ai, dgi in zip(a, dg_):
            eq += ai*dgi[i]
        eqs.append(eq)
    eq = 0
    for ai, gi in zip(a, g_plan):
        eq += ai*gi
    eqs.append(eq)
    a_res = solve(eqs)
    return a_res, dg_


def search_k(I0_plus, l, dg_, I0_0):
    eqs = []
    for i in I0_plus:
        eq = 0
        for li, dgi in zip(l, dg_[i]):
            eq += li*dgi
        eqs.append(eq)
    eqs_ = []
    for i in I0_0:
        eq = 0
        for li, dgi in zip(l, dg_[i]):
            eq += li*dgi
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
    plan_ = zip(x, plan)#[(x1, plan[0]), (x2, plan[1])]

    df = [f.diff(xi) for xi in x]
    dg = []
    for gi in g:
        dg.append([gi.diff(xi) for xi in x])

    g_plan, is_not_plan = admissibility_check(plan_, g, plan)
    if is_not_plan == "is not plan.":
        return

    I0 = [i for i, gi in enumerate(g_plan) if gi == 0.0]

    matrix = d_column_vector(x, I0, g, plan_)

    a0 = check_usual_plan(I0, matrix)

    a_res, dg_ = calculate_differentials(plan_, df, dg, a0, a, g_plan)

    if a_res:
        if type(a_res) == list:
            a_res = a_res[0]
        if (np.array(a_res.values()) == 0.0).all():
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


def call_check_of_condition(x, plan, a, f, g, l, task):
    print("Task {}\n".format(task))
    print("--------------------")
    check_of_condition(x, plan, a, f, g, l)
    print("")


def task_1():
    x1, x2 = Symbol("x1"), Symbol("x2")
    a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
    a = [a1, a2, a3]
    plan = [0.0, 1.0]
    x = [x1, x2]
    f = exp(x1 - x2) - x1 - x2
    g = [x1 + x2 -1, -x1, -x2]
    l = symbols("l1 l2", nonzero=True)
    call_check_of_condition(x, plan, a, f, g, l, '1.1')
    plan = [1.0, 1.0]
    call_check_of_condition(x, plan, a, f, g, l, '1.2')

def task_2():
    x1, x2 = Symbol("x1"), Symbol("x2")
    x = [x1, x2]
    a1 = Symbol("a1", nonnegative=True)
    a = [a1]
    plan = [3.0, 9.0]
    f = x1**2 + x2**2 - 8*x1
    g = [x1**2 + (x2 - 9)**2 - 9]
    l = symbols("l1 l2", nonzero=True)
    call_check_of_condition(x, plan, a, f, g, l, '2')

def task_3():
    x1, x2 = Symbol("x1"), Symbol("x2")
    x = [x1, x2]
    a1, a2 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True)
    a = [a1, a2]
    plan = [6*10**0.5/5.0, 2*10**0.5/5.0]
    f = 3*x1 + x2
    g = [-x1*x2 + 2, x1**2 + x2**2 - 16]
    l = symbols("l1 l2", nonzero=True)
    call_check_of_condition(x, plan, a, f, g, l, '3')

def task_4():
    x1, x2, x3 = Symbol("x1"), Symbol("x2"), Symbol("x3")
    x = [x1, x2, x3]
    a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
    a = [a1, a2, a3]
    plan = [0.0, 1.0, 0.0]
    f = 3*x2**2 - 11*x1 -3*x2 - x3
    g = [x1-7*x2+3*x3+7, 5*x1+2*x2-x3-2, -x3]
    l = symbols("l1 l2 l3", nonzero=True)
    call_check_of_condition(x, plan, a, f, g, l, '4')

def task_5():
    x1, x2 = Symbol("x1"), Symbol("x2")
    x = [x1, x2]
    a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
    a = [a1, a2, a3]
    plan = [3.0, 4.0]
    f = 9*(x1-5)**2+4*(x2-5)**2
    g = [x1**2-3*x2+1, x2-x1-1, x1-x2]
    l = symbols("l1 l2", nonzero=True)
    call_check_of_condition(x, plan, a, f, g, l, '5')


#task_1()
#task_2()
#task_3()
task_4()
#task_5()