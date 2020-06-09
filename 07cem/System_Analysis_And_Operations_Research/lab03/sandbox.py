from numpy import *
from Gomorian import Gomorian


def manualInput(objtype, f):
    return [objtype(number) for number in f.readline().split()]


def inputValues(path="input"):
    m, n, A, b, c, dmin, dmax, J = 0, 0, [], [], [], [], [], []
    with open(path) as f:
        m, n = manualInput(int, f)
        for _ in range(m):
            A.append(manualInput(float, f))
        A = array(A)
        b = array(manualInput(float, f))
        c = array(manualInput(float, f))
    return A, b, c


A, b, c = inputValues("01.txt")
sol = Gomorian(A, b, c).run()
print(sol.GetBestPlan())
print(sol.GetBestResult())
