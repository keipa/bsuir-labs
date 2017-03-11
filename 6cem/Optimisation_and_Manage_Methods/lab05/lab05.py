import numpy as np
import sys

'''
m = 3
n = 8
A = np.array([
             [11, 0, 0, 1, 0, -4, -1, 1],
             [1, 1, 0, 0, 1, -1, -1, 1],
             [1, 1, 1, 0, 1, 2, -2, 1]
             ])
b = np.array([8, 2, 5])
d = np.array([6, 10, 9])
B = np.array([[1, -1, 0, 3, -1, 5, -2, 1], 
              [2, 5, 0, 0, -1, 4, 0, 0], 
              [-1, 3, 0, 5, 4, -1, -2, 1]])

D = B.T.dot(B)
c = -d.dot(B)
x0 = np.array([0.7273, 1.2727, 3.0, 0, 0, 0, 0, 0])
J0 = np.array([1, 2, 3])
J0 -= 1
J = np.array([1, 2, 3])
J -= 1
'''

m = 3
n = 8
A = np.array([
             [0.0, 2.0, 1.0, 4.0, 3.0, 0.0, -5.0, 10.0],
             [-1.0, 3.0, 1.0, 0.0, 1.0, 3.0, -5.0, -6.0],
             [1.0, 1.0, 1.0, 0.0, 1.0, -2.0, -5.0, 8.0]
             ])
b = np.array([6.0, 4.0, 14.0])
#d = np.array([6, 10, 9])
#B = np.array([[1, -1, 0, 3, -1, 5, -2, 1], 
#              [2, 5, 0, 0, -1, 4, 0, 0], 
#              [-1, 3, 0, 5, 4, -1, -2, 1]])

#D = B.T.dot(B)
D = np.array([
                [1.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0],
                [0.0, 1.0,0.0,0.0,0.0,0.0,0.0,0.0],
                [0.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0],
                [0.0, 0.0,0.0,1.0,0.0,0.0,0.0,0.0],
                [0.0, 0.0,0.0,0.0,1.0,0.0,0.0,0.0],
                [0.0, 0.0,0.0,0.0,0.0,1.0,0.0,0.0],
                [0.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0],
                [0.0, 0.0,0.0,0.0,0.0,0.0,0.0,1.0]
    ])
#c = -d.dot(B)
c = np.array([1.0,3.0,-1.0,3.0,5.0,2.0,-2.0,0.0])
x0 = np.array([0.0, 2.0, 0.0, 0.0, 4.0, 0.0, 0.0, 1.0])
J0 = np.array([2, 5, 8])
J0 -= 1
J = np.array([2, 5, 8])
J -= 1

def compute_grade(c, D, x0, J0):
    _c = c + D.dot(x0)
    A0 = A[:, J0]
    inv_A0 = np.linalg.inv(A0)
    u = -_c[J0].dot(inv_A0)
    delta = u.dot(A) + _c
    return inv_A0, delta, c

def check_optimality_criterion(delta, c, x0, D):
    if (delta[not_J] >= 0).all():
        print "Optimal plan", x0
        print "max = ", c.dot(x0) + 0.5*x0.dot(D).dot(x0)
        j0 = None
    else:
        index_0 = np.argmin(delta[not_J])
        j0 = not_J[index_0]
    return j0

def the_direction_of_change_plan(j0, J, m):
    to_step_3 = False
    l = np.zeros(n)
    l[j0] = 1.0
    H = np.zeros((m+len(J), m+len(J)))
    H[:len(J), :len(J)] = D[J][:, J]
    H[len(J):, :len(J)] = A[:, J]
    H[:len(J), len(J):] = A[:, J].T
    bb = np.zeros(m+len(J))
    bb[:len(J)] = D[j0][J]
    bb[len(J):] = A[:, j0]
    v = -np.linalg.inv(H).dot(bb)
    l[J] = v[:len(J)]
    return to_step_3, l

def steps_count(x0, l, D):
    Q = [-x0[i]/l[i] if l[i] < 0 else np.inf for i in J]
    j1 = np.argmin(Q)
    k = (l.T).dot(D).dot(l)
    if abs(k) <= 1.0e-10:
        Q_j0 = np.inf
    elif k > 0:
        Q_j0 = abs(delta[j0]) / k
    if Q[j1] >= Q_j0:
        j1 = j0
        Q_0 = Q_j0
    else:
        Q_0 = Q[j1]
        j1 = J[j1]
    if np.isinf(Q_0):
        Q_0 = None
        print "No solution"
    return Q_0, j1, k

def rebuild_sets(j0, j1, J0, Q_0, k, m, J, to_step_3):
    if j0 == j1:
        J = np.append(J, j0)
    elif j1 in J and not j1 in J0:
        J = J[J != j1]
        delta[j0] += Q_0*k
        to_step_3 = True
    else:
        s = J0.tolist().index(j1)
        e_s = np.eye(m)[s]
        is_plus = False
        for index in [elem for elem in J if not elem in J0]:
            if e_s.dot(inv_A0).dot(A[:, index]) != 0:
                j_plus = index
                is_plus = True
                break
        if is_plus:
            J0 = np.append(J0[J0 != j1], j_plus)
            J = J[J != j1]
            delta[j0] += Q_0*k
            to_step_3 = True
        else:
            J0 = np.append(J0[J0 != j1], j0)
            J = np.append(J[J != j1], j0)
    return J, J0, to_step_3, delta


m, n = A.shape
not_J = np.delete(np.arange(n), J)
to_step_3 = False
it = 0
while True:
    if not to_step_3:
        it += 1
        not_J = np.delete(np.arange(n), J)
        inv_A0, delta, c = compute_grade(c, D, x0, J0)
        j0 = check_optimality_criterion(delta, c, x0, D)
        if j0 is None:
            break
    to_step_3, l = the_direction_of_change_plan(j0, J, m)
    Q_0, j1, k = steps_count(x0, l, D)
    if Q_0 is None:
        break
    x0 += Q_0*l
    J, J0, to_step_3, delta = rebuild_sets(j0, j1, J0, Q_0, k, m, J, to_step_3)

        
    J0.sort()
    J.sort()