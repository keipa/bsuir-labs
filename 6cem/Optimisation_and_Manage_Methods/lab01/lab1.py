from config import *
iter_count = 0
J -= 1
while True:
    Theta = []
    B = linalg.inv(A[:, J])
    u = c[J].dot(B)
    not_J = delete(arange(n), J)
    deltas = list(map(lambda x: u.dot(A[:, x]) - c[x], list(not_J)))
    min_delta_ind = not_J[argmin(deltas)]
    if u.dot(A[:, min_delta_ind]) - c[min_delta_ind] >= 0:
        print(list(map(lambda x: round(float(x), 3), list(x_0))), "- оптимальный план")
        print("Максимальная прибыль : ", c.dot(x_0))
        print("Количество итераций :", iter_count)
        break
    z = B.dot(A[:, min_delta_ind])
    if max(z) <= 0:
        print("Нет решений.")
        break
    for i, _z in zip(J, z):
        if _z > 0:
            Theta.append(x_0[i] / _z)
        else:
            Theta.append(inf)
    s = argmin(Theta)
    x_0[not_J] = 0
    x_0[min_delta_ind] = Theta[s]
    for index, _z in zip(J, z):
        x_0[index] -= Theta[s] * _z
    J[s] = min_delta_ind
    iter_count += 1
