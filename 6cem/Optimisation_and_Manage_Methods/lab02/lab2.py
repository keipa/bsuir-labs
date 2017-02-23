from numpy import *


def double_simplex(m, n, c, b, A, J, y, small_delta):
    iter_count = 1
    J -= 1
    x_0 = [0 for _ in range(n)]
    while True:
        not_J = delete(arange(n), J)
        B = linalg.inv(A[:, J])
        chi = B.dot(b)
        if (chi >= 0).all():
            for j, _chi in zip(J, chi):
                x_0[j] = _chi
            print("Количество итераций : ", iter_count)
            print("Максимальная прибыль : ", c.dot(x_0))
            print(list(map(lambda _x: round(float(_x), 3), list(x_0))), "- оптимальный план")
            return x_0, iter_count
        k = argmin(chi)
        j = J[k]
        mu = B[k].dot(A)
        sigma = []
        for _not_j in not_J:
            if mu[_not_j] >= 0:
                sigma.append(inf)
            else:
                sigma.append(-small_delta[_not_j] / mu[_not_j])
        sigma_0_ind = not_J[argmin(sigma)]
        sigma_0 = min(sigma)
        if sigma_0 == inf:
            print("Задача не имеет решения, т.к. пусто множество ее допустимых планов.")
            return 1
        y += sigma_0 * B[k]
        small_delta += sigma_0 * mu
        J[k] = sigma_0_ind
        iter_count += 1


def make_small_delta(c, A, y):
    return y.dot(A) - c
