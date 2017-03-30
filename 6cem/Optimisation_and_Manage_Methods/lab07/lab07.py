from sympy import Symbol,  solve
from sympy.matrices import Matrix
from numpy import *

necessaryNotPassedLabel = "Необходимое условие оптимальности первого рода НЕ выполнено"

necessaryPassedLabel = "Необходимое условие оптимальности первого рода выполнено"

usualPlanLabel = "план x0 является обыкновенным."

notUsualPlanLabel = "план x0 НЕ является обыкновенным."

sufficientPassedLabel = "Достаточне условие оптимальности второго рода выполнено"

sufficientNotPassedLabel = "Достаточне условие оптимальности второго рода НЕ выполнено"

accessedPlanLabel = "Текущий план {} является допустимым"

errorMessage = "Что-то пошло не так ¯\_(ツ)_/¯"


def d_column_vector(x, I0, g, plan_):
    matrix = zeros((len(x), len(I0)))
    for i, index in enumerate(I0):
        matrix[:, i] = [g[index].diff(xi).subs(plan_) for xi in x]
    return matrix


def check_usual_plan(I0, matrix):
    if len(I0) == 0 or linalg.matrix_rank(matrix) != len(I0):
        a0 = Symbol("a0", nonnegative=True)
        print(notUsualPlanLabel)
    else:
        a0 = 1.0
        print(usualPlanLabel)
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

    return K, K_





def СheckСonditions(x, plan, a, f, g, l):
    plan_ = []
    for obj in zip(x, plan):
        plan_.append(obj)

    # проверка допустимости
    g_plan = array([elem.subs(plan_) for elem in g])
    if (g_plan <= 0.0).all():
        print(accessedPlanLabel.format(plan))
    else:
        raise Exception(errorMessage)
        return

    # дифференцируем по каждому X исходную функцию
    df = [f.diff(xi) for xi in x]
    dg = []
    for gi in g:
        dg.append([gi.diff(xi) for xi in x])

    I0 = [i for i, gi in enumerate(g_plan) if gi == 0.0]

    # подготовим таблицу с частными производными по каждой переменной
    matrix = zeros((len(x), len(I0)))
    for i, index in enumerate(I0):
        matrix[:, i] = [g[index].diff(xi).subs(plan_) for xi in x]

    # проверка плана на обыкновенность
    if len(I0) == 0 or linalg.matrix_rank(matrix) != len(I0):
        a0 = Symbol("a0", nonnegative=True)
        print(notUsualPlanLabel)
    else:
        a0 = 1.0
        print(usualPlanLabel)

    # ищем решение уравнения из формулы
    a_res, dg_ = calculate_differentials(plan_, df, dg, a0, a, g_plan)
    if a_res:
        if type(a_res) == list:
            a_res = a_res[0]
        if (array(a_res.values()) == 0.0).all():
            print(necessaryNotPassedLabel)
            return
        print(necessaryPassedLabel)
    else:
        print(necessaryNotPassedLabel)
        return


    I0_plus = [ind for ind in I0 if a_res[a[ind]] > 0.0]   #  indexes where lambda greater than zero

    # найдём К
    eqs = []
    for i in I0_plus:
        eq = 0
        for li, dgi in zip(l, dg_[i]):
            eq += li * dgi
        eqs.append(eq)
    K = solve(eqs)
    # проверим К если множество
    if not K:
        print(sufficientPassedLabel) #
    else:
        ddf = []
        for xi in x:
            ddf.append([ddfi.diff(xi) for ddfi in df])
        ddf = Matrix(ddf)
        ll = Matrix(l)
        if Matrix(ddf.dot(ll.T)).dot(ll).subs(K) > 0:
            print(sufficientPassedLabel)
        else:
            print(sufficientNotPassedLabel)

