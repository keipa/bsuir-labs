from numpy import *


def inputValues(path="input"):
    N, C, F = 0, 0, []
    with open(path) as f:
        N = int(f.readline())
        C = int(f.readline())
        for n in range(N):
            F.append([float(number) for number in f.readline().split(" ")])
    return N, C, array(F)


class Solution:
    # F = array([[0.0, 3.0, 2.0, 5.0, 8.0, 9.0, 10.0],
    #            [0.0, 2.0, 3.0, 7.0, 9.0, 12.0, 13.0],
    #            [0.0, 1.0, 4.0, 6.0, 11.0, 11.0, 13.0]])
    # N = 3
    # C = 6
    N, C, F = inputValues()

    B = zeros((N, C + 1))
    Z = zeros((N, C + 1))


def output(sol):
    s = "X\t"
    for j in range(sol.C + 1):
        s += str(j) + "\t\t\t"
    s += "\n"
    for i in range(sol.N):
        s += "B\t"
        for j in range(sol.C + 1):
            s += str(sol.B[i, j]) + "(" + str(sol.Z[i, j]) + ")     "
        s += "\n"
    s += "\nSolution: "
    best = ""
    c = sol.C

    for i in range(sol.N - 1, -1, -1):
        best = str(sol.Z[i, c]) + " " + best
        c -= int(sol.Z[i, c])
    s += best
    return s


def SolveBellman(sol, n, c):
    if sol.B[n, c] != 0:
        return sol.B[n, c]
    result = 0
    resultZ = 0
    if n == 0:
        result = sol.F[n, c]
        resultZ = c
    else:
        bestZ = 0
        bestB = 0
        for z in range(c + 1):
            b = sol.F[n, z] + (SolveBellman(sol, n - 1, c - z))
            if b > bestB:
                bestB = b
                bestZ = z
        result = bestB
        resultZ = bestZ
    sol.B[n, c] = result
    sol.Z[n, c] = resultZ
    return result


def resources_allocation():
    sol = Solution()
    N1 = sol.N
    C1 = sol.C
    for n in range(N1):
        for c in range(C1 + 1):
            SolveBellman(sol, n, c)
    return sol


inputValues()
print(output(resources_allocation()))
