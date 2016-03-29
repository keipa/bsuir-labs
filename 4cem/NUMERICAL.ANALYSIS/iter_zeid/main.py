import numpy as n


def seidel(m, b, eps):
    en = len(m)
    ran = range(en)
    x = [0 for i in ran]
    brk = False
    while not brk:
        p = x.copy()
        for i in ran:
            var = sum(m[i][j] * x[j] for j in range(i))
            var += sum(m[i][j] * p[j] for j in range(i+1, en))
            x[i] = (b[i] - var) / m[i][i]
        brk = sum((x[i]-p[i])**2 for i in ran) < eps
    return x

a = [[40.42, 2.42, 3.86], [2.31, 32.49, 1.52], [1.49, 2.85, 20.92]]
b = [10.75, 20.16, 22.51]
eps = 0.0001
print(seidel(a, b, eps))
a = n.matrix("40.42 2.42 3.86;"
             " 2.31 32.49 1.52;"
             " 1.49 2.85 20.92")
e = n.matrix("1 0 0; 0 1 0; 0 0 1")
b = n.matrix("10.75 20.16 22.51")
eps = 0.00001
xp = n.matrix("0 0 0")
xc = n.matrix("0 0 0")
diag = n.matrix("40.42 32.49 20.92")
for i in range(3):
    a[i, i] = 0
B = a/diag
c = b/diag
print("---==Simple iterations method==---")
print("iterative view: (x=B*x+c)")
print("x = ", B, "*x+", c)
first_time = True
k = 0
while first_time or (abs(xc-xp)[0, 0] > eps and abs(xc-xp)[0, 1] > eps and abs(xc-xp)[0, 2] > eps):
    xp = xc
    first_time = False
    xc = xp*B+c
    k += 1
print("Count of iterations to get eps: ", k)
print("x = ", xc)
print("---==Simple iterations method==---")
print("---==Zeidel's method==---")
a = [[40.42, 2.42, 3.86], [2.31, 32.49, 1.52], [1.49, 2.85, 20.92]]
b = [10.75, 20.16, 22.51]
eps = 0.0001
# print("x = ", seidel(a, b, eps))
print("x = ", xc)
print("---==Zeidel's method==---")