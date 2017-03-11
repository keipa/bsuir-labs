from numpy import *


def ultimate_method(A, d, B, x0, J0, J):
    D = B.T.dot(B)
    c = -d.dot(B)
    J0 -= 1
    J -= 1
    m, n = A.shape
    to_step_3 = False
    iterations = 0
    while True:
        if not to_step_3:
            iterations += 1
            not_J = delete(arange(n), J)
            #compute grade
            _c = c + D.dot(x0)
            A0 = A[:, J0]
            inv_A0 = linalg.inv(A0)
            u = -_c[J0].dot(inv_A0)
            delta = u.dot(A) + _c
            # compute grade
            # check_optimality_criterion
            j0 = 0
            if (delta[not_J] >= 0).all():
                print(list(map(lambda _x: round(float(_x), 3), list(x0))), "- оптимальный план")
                print("max = ", c.dot(x0) + 0.5 * x0.dot(D).dot(x0))
                print("Количество итераций", iterations)
                return x0, c.dot(x0) + 0.5 * x0.dot(D).dot(x0), iterations
            else:
                index_0 = (argmin(delta[not_J]))
                j0 = not_J[index_0]
            # check_optimality_criterion
        # the_direction_of_change_plan
        to_step_3 = False
        l = zeros(n)
        l[j0] = 1.0
        H = zeros((m + len(J), m + len(J)))
        H[:len(J), :len(J)] = D[J][:, J]
        H[len(J):, :len(J)] = A[:, J]
        H[:len(J), len(J):] = A[:, J].T
        bb = zeros(m + len(J))
        bb[:len(J)] = D[j0][J]
        bb[len(J):] = A[:, j0]
        v = -linalg.inv(H).dot(bb)
        l[J] = v[:len(J)]
        # the_direction_of_change_plan
        # steps_count
        Q = [-x0[i] / l[i] if l[i] < 0 else inf for i in J]
        j1 = argmin(Q)
        k = (l.T).dot(D).dot(l)
        if abs(k) <= 1.0e-10:
            Q_j0 = inf
        elif k > 0:
            Q_j0 = abs(delta[j0]) / k
        if Q[j1] >= Q_j0:
            j1 = j0
            Q_0 = Q_j0
        else:
            Q_0 = Q[j1]
            j1 = J[j1]
        if isinf(Q_0):
            Q_0 = None
            print("No solution")
        # steps_count
        if Q_0 is None:
            break
        x0 += Q_0 * l
        if j0 == j1:
            J = append(J, j0)
        elif j1 in J and not j1 in J0:
            J = J[J != j1]
            delta[j0] += Q_0 * k
            to_step_3 = True
        else:
            s = J0.tolist().index(j1)
            e_s = eye(m)[s]
            is_plus = False
            for index in [elem for elem in J if not elem in J0]:
                if e_s.dot(inv_A0).dot(A[:, index]) != 0:
                    j_plus = index
                    is_plus = True
                    break
            if is_plus:
                J0 = append(J0[J0 != j1], j_plus)
                J = J[J != j1]
                delta[j0] += Q_0 * k
                to_step_3 = True
            else:
                J0 = append(J0[J0 != j1], j0)
                J = append(J[J != j1], j0)
        J0.sort()
        J.sort()
