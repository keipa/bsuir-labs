from numpy import *


def balance(C, a, b):
    if sum(a) > sum(b):  # проверка на сбалансированность
        print("Задача является открытой (несбалансированной). Приведение к сбалансированной...")
        b = list(b)
        b.append(sum(a) - sum(b))
        new_C = zeros((len(a), len(b)))
        new_C[:, :-1] = C
        print("Задача сбалансирована.")
        return new_C,  array(b)
    elif sum(a) == sum(b):
        print("Задача сбалансирована.")
        return C,  b
    else:  # не хватает продукции для восполнения потребности заказчика
        return Exception()


def north_west_corner(C, a, b):
    m, n = C.shape
    r_ind, c_ind = range(m), range(n)
    x = zeros((m, n), dtype=float)
    U = []
    while r_ind and c_ind:
        if a[r_ind[0]] >= b[c_ind[0]]:
            x[r_ind[0], c_ind[0]] = b[c_ind[0]]
            a[r_ind[0]] -= b[c_ind[0]]
            U.append((r_ind[0], c_ind[0]))
            c_ind = c_ind[1:]
        else:  # добавление недостающих клеток для получения невырожденного плана N=n+m-1
            x[r_ind[0], c_ind[0]] = a[r_ind[0]]
            b[c_ind[0]] -= a[r_ind[0]]
            U.append((r_ind[0], c_ind[0]))
            r_ind = r_ind[1:]
    return x, U, m, n


def potentials(C, U):
    m, n = C.shape
    u, v = zeros(m), zeros(n)
    u[1:], v[:] = inf, inf
    current_U = []
    while len(current_U) != len(U):
        for i, j in U:
            if not (i, j) in current_U and not (isinf(u[i]) and isinf(v[j])):
                if isinf(u[i]):
                    u[i] = C[i, j] - v[j]
                elif isinf(v[j]):
                    v[j] = C[i, j] - u[i]
                current_U.append((i, j))
    return u, v


def cycle(U, x, m):
    _U = list(map(lambda u: (u[0] - (m + 1), u[1]), U))
    current_graph = create_graph(_U)
    path = dfs(current_graph, x[0] - (m + 1), [], x[1])[1]
    cycle = [x]
    for i in range(len(path) - 1):
        if i % 2 == 0:
            cycle.append((path[i] + m + 1, path[i + 1]))
        else:
            cycle.append((path[i + 1] + m + 1, path[i]))
    return cycle


def create_graph(E):
    G = {}
    for x, y in E:
        if x in G:
            G[x].append(y)
        else:
            G[x] = [y]
        if y in G:
            G[y].append(x)
        else:
            G[y] = [x]
    return G


def dfs(G, v, path, finish):
    path.append(v)
    if v == finish:
        return True, path
    for w in G[v]:
        if not w in path:
            res = dfs(G, w, path, finish)
            if res[0]:
                return res
    path.pop()
    return False, []


def method_of_potentials(C, a, b):
    prep = balance(C, a, b)
    if prep is None:
        print("No solution")
        return
    C, b = prep
    x, U, m, n = north_west_corner(C, a, b)  # построение начального плана и базиса
    iterations = 0
    while True:  # итерация улучшения плана
        u, v = potentials(C, U)  # Составим вспомогательную рабочую матрицу затрат
        deltas = zeros((m, n))
        for i in range(m):
            for j in range(n):
                deltas[i, j] = C[i, j] - u[i] - v[j]
        if (deltas >= 0).all():
            print("Оптимальный план перевозок: \n", x)
            print("Максимальная издержка = ", sum(array(C) * array(x)))
            print("Итераций улучшения плана затрачено: ", iterations)
            return x.tolist(), sum(array(C) * array(x))
        index = argmin(deltas)
        i0 = int(index / n)
        j0 = index % n
        cycl = cycle(U, (i0, j0), m)
        m_cycle = cycl[1::2]
        ind = argmin(list(map(lambda _m: x[_m[0], _m[1]], m_cycle)))
        i1, j1 = m_cycle[ind]
        theta = x[i1, j1]
        for ind, (i, j) in enumerate(cycl):
            if ind % 2 == 0:
                x[i, j] += theta
            else:
                x[i, j] -= theta
        U.remove((i1, j1))
        U.append((i0, j0))
        iterations += 1
