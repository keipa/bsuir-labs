from numpy import *

titleLabel = "Решение задачи квадратичного программирования конечным методом:"
optPlanLabel = "- оптимальный план"
maxLabel = "max = "
iterationsCountLabel = "Количество итераций"
noSolutionsLabel = "Нет решений, т.к целевая функция не ограничена снизу на множестве планов"


# конечный метод
def ultimate_method(A, d, B, x0, J0, J, D, c):
    print(titleLabel)
    if B is not None and d is not None:
        D = B.T.dot(B)
        c = -d.dot(B)
    if D is None:
        D = B.T.dot(B)
    J0 -= 1
    J -= 1
    m, n = A.shape
    skip_12 = False
    iterations = 0
    j0 = 0
    while True:
        if not skip_12:
            iterations += 1
            not_J = delete(arange(n), J)
            _c = c + D.dot(x0)
            inv_A0 = linalg.inv(A[:, J0])  # inverted matrix A with
            u = -_c[J0].dot(inv_A0)
            delta = u.dot(A) + _c
            if (delta[not_J] >= 0).all():
                print(list(map(lambda _x: round(float(_x), 3), list(x0))), optPlanLabel)
                print(maxLabel, c.dot(x0) + 0.5 * x0.dot(D).dot(x0))
                print(iterationsCountLabel, iterations)
                return x0.tolist(), c.dot(x0) + 0.5 * x0.dot(D).dot(x0), iterations
            else:
                index_0 = argmin(delta[not_J])
                j0 = not_J[index_0]
        skip_12 = False
        l = zeros(n)
        l[j0] = 1.0
        H = zeros((m + len(J), m + len(J)))
        H[:len(J), :len(J)], H[len(J):, :len(J)], H[:len(J), len(J):] = D[J][:, J], A[:, J], A[:, J].T
        bb = zeros(m + len(J))
        bb[:len(J)], bb[len(J):] = D[j0][J], A[:, j0]
        Hbb = -linalg.inv(H).dot(bb)
        l[J] = Hbb[:len(J)]
        theta = [-x0[i] / l[i] if l[i] < 0 else inf for i in J]
        j1 = argmin(theta)
        small_delta = l.T.dot(D).dot(l)
        # may catch exception. be careful with input
        theta_j0 = inf if 0 < abs(small_delta) <= 1.0e-10 else abs(delta[j0]) / small_delta
        theta_0, j1 = (theta_j0, j0) if theta[j1] >= theta_j0 else (theta[j1], J[j1])
        if isinf(theta_0):
            print(noSolutionsLabel)
            return None
        x0 += theta_0 * l
        if j1 == j0:  # case a
            J = append(J, j0)
        elif j1 in set(J) - set(J0):  # case b
            J = J[J != j1]
            delta[j0] += theta_0 * small_delta
            skip_12 = True
        else:
            s = where(J0 == j1)  # return index of j1 in J0
            e_s = eye(m)[s]
            case_c_indexes = list(filter(lambda i: e_s.dot(inv_A0).dot(A[:, i]) != 0, set(J) - set(J0)))
            if case_c_indexes:  # case c
                J0 = append(J0[J0 != j1], case_c_indexes[0])
                J = J[J != j1]
                delta[j0] += theta_0 * small_delta
                skip_12 = True
            else:  # case d
                J0 = append(J0[J0 != j1], j0)
                J = append(J[J != j1], j0)
        J0.sort()
        J.sort()
