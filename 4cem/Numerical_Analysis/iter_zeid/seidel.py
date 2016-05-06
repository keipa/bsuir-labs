
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