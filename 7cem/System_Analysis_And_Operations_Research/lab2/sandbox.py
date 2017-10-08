from numpy import *
from Simplex import *

A = array([[1.0, -5.0, 3.0, 1.0, 0.0, 0.0],
           [4.0, -1.0, 1.0, 0.0, 1.0, 0.0],
           [2.0, 4.0, 2.0, 0.0, 0.0, 1.0]])
b = array([-8.0, 22.0, 30.0])

c = array([7.0, -2.0, 6.0, 0.0, 5.0, 2.0, ])

dmin = array([2.0, 1.0, 0.0, 0.0, 1.0, 1.0])
dmax = array([6.0, 6.0, 5.0, 2.0, 4.0, 6.0])

J = array([4, 5, 6])
m = 3
n = 6

tasks = [Simplex(m, n, c, b, A, J, dmin, dmax)]
counter = 0
r0 = -inf
mu0 = 1
mu = [i for i in range(n)]


def IsInteger(number):
    e = 0.0001
    return abs(number - round(number)) < e


while True:
    counter += 1
    if len(tasks) == 0:
        if mu0 == 1:
            print("Solution: Optimal plan:", mu)
            exit()
        if mu0 == 0:
            exit("Solution doesn't exists")
    task = tasks[0]
    tasks.remove(task)
    solution = task.x_0
    value = task.cx if task.cx is not None else 0
    if solution is not None:
        print("Solution:", solution)
        print(value)
    else:
        print("Solution doesn't exists")
    if solution is None or value <= r0:
        continue
    if all([IsInteger(isint) for isint in solution]):
        mu = solution
        mu0 = 1
        r0 = value
        continue
    j0 = -1
    for index in range(n):
        if not IsInteger(solution[index]):
            j0 = index
            break

    l = floor(solution[j0])  ## mistake
    if (l < 0 and l > solution[j0]):
        l -= 1
    newdmax = task.dmax
    newdmax[j0] = l
    tasks.append(Simplex(task.m, task.n, task.c, task.b, task.A, task.J, task.dmin, newdmax))
    newdmin = task.dmin
    newdmin[j0] = l + 1
    tasks.append(Simplex(task.m, task.n, task.c, task.b, task.A, task.J, newdmin, task.dmax))
