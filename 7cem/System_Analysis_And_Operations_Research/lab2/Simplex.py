from numpy import *


def Step3CheckForOptimum(_pseudoPlanB, J, dmin, dmax):
    isOptimum = True
    for index, value in enumerate(_pseudoPlanB):
        isOptimum &= dmin[J[index]] - _pseudoPlanB[index] <= 0 <= dmax[J[index]] - _pseudoPlanB[index]
    return isOptimum


def Step4FindK(_pseudoPlanB, dmin, dmax, J):
    for index, value in enumerate(_pseudoPlanB):
        if not (dmin[J[index]] - _pseudoPlanB[index] <= 0 <= dmax[J[index]] - _pseudoPlanB[index]):
            return index
    raise Exception


def getEstim(estimations, index):
    for we in estimations:
        if we[0] == index:
            return we[1]
class Simplex:


    def __init__(self, m, n, c, b, A, J, dmin, dmax):
        self.setAttibutes(m, n, c, b, A, J, dmin, dmax)
        iter_count = 1
        J -= 1
        not_J = delete(arange(n), J)
        all_j = arange(n)
        B = linalg.inv(A[:, J])  # Step1CalculateB
        y_ = c[J].dot(B)  # GetFirstBasePlan
        deltas = list(map(lambda all_j: y_.dot(A[:, all_j]) - c[all_j], list(all_j)))
        not_JMinus = []
        not_JPlus = []
        # map(lambda not_j: not_JMinus.append(not_J) if deltas[not_J] < 0 else not_JPlus.append(not_J), list(not_J))
        for _not_J in not_J:
            if deltas[_not_J] < 0:
                not_JMinus.append(_not_J)
            else:
                not_JPlus.append(_not_J)
        while True:
            print("Итерация: ", iter_count)
            iter_count += 1
            print(y_)
            print("базовые индексы итерации", J)
            # calculate pseudo plan
            newB = copy(b)
            for _not_J in not_J:
                tmp = dmin[_not_J] if _not_J in not_JPlus else dmax[_not_J]
                newB += -A[:, _not_J] * tmp
            _pseudoPlanB = B.dot(newB)
            print(_pseudoPlanB)
            if Step3CheckForOptimum(_pseudoPlanB, J, dmin, dmax):
                x_0 = [0 for _ in range(n)]
                for index, value in enumerate(_pseudoPlanB):
                    x_0[J[index]] = _pseudoPlanB[index]
                for _not_J in not_J:
                    x_0[_not_J] = dmax[_not_J] if _not_J in not_JMinus else dmin[_not_J]
                print("решение найдено")
                self.x_0 = x_0
                self.cx = c.dot(x_0)
                return
            k = Step4FindK(_pseudoPlanB, dmin, dmax, J)
            jK = J[k]
            mJk = 1 if _pseudoPlanB[k] - dmin[J[k]] < 0 else -1
            es = array([0 for _ in range(len(J))])
            es[k] = 1
            deltaY = multiply(es.dot(B), mJk)  # mistake
            estimations = []
            for _not_J in not_J:
                mJ = deltaY.dot(A[:, _not_J])
                estimations.append((_not_J, mJ))
            sigma0 = inf
            j0 = -1
            for mJ in estimations:
                if (mJ[0] in not_JPlus and mJ[1] < 0) or (mJ[0] in not_JMinus and mJ[1] > 0):
                    sigma = -deltas[mJ[0]] / mJ[1]
                    if sigma < sigma0:
                        sigma0 = sigma
                        j0 = mJ[0]
            if isinf(sigma0):
                print("not result - Solution doesn't exists(inconsistent)")
                return
            print("Sigma0:", sigma0)
            print("правка индекса", j0)
            # пересчёт коплана
            for index in range(n):
                if index in J and J[k] != index:
                    deltas[index] = 0.0
                else:
                    tmp = 0.0
                    if J[k] == index:
                        tmp = sigma0 * jK
                    else:
                        tmp = sigma0 * getEstim(estimations, index)
                    deltas[index] += tmp
            # пересчёт плана
            J[k] = j0
            J = list(J)
            J.sort()
            J = array(J)
            # step 10
            if mJk == 1:
                if j0 in not_JPlus:
                    not_JPlus.remove(j0)
                not_JPlus.append(jK)
            else:
                if j0 in not_JPlus:
                    not_JPlus.remove(j0)
            not_JMinus = []
            for index in range(n):
                if index not in J and index not in not_JPlus:
                    not_JMinus.append(index)
            B = linalg.inv(A[:, J])  # Step1CalculateB
            not_J = delete(arange(n), J)

    def setAttibutes(self, m, n, c, b, A, J, dmin, dmax):
        self.x_0 = None
        self.cx = None
        self.m = m
        self.n = n
        self.c = c
        self.b = b
        self.A = A
        self.J = J
        self.dmin = dmin
        self.dmax = dmax
