from config import *

iter_count = 0
B = linalg.inv(A[:, J])
while True:
    Q = []
    u = c[J].dot(B)
    not_J = delete(arange(n), J)
    j = argmin(map(lambda x: u.dot(A[:, x]) - c[x], not_J))
    j = not_J[j]
    if u.dot(A[:, j]) - c[j] >= 0:
        print("x = ", x_0, "is optimal plan.")
        print("max cx = ", c.dot(x_0))
        print("iterations :", iter_count)
        break
    z = B.dot(A[:, j])
    if max(z) <= 0:
        print("There is no solution.")
        break
    for i, _z in zip(J, z):
        if _z > 0:
            Q.append(x_0[i] / _z)
        else:
            Q.append(inf)
    s = argmin(Q)
    x_0[not_J] = 0
    x_0[j] = Q[s]
    for index, _z in zip(J, z):
        x_0[index] -= Q[s] * _z
    J[s] = j
    M = eye(m)
    z_s = z[s]
    z[s] = -1
    M[:, s] = -z / z_s
    B = M.dot(B)
    iter_count += 1
