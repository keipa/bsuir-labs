import sympy


def solver(eq2, n):
    x = []
    for each in range(n):
        x.append(0)
    for j in range(n):
        for i in range(n):
            if i > j:
                c = eq2[i][j]/eq2[j][j]
                for k in range(n+1):
                    eq2[i][k] -= c*eq2[j][k]
    print(eq2)
    x[n-1] = eq2[n-1][n]/eq2[n-1][n-1]
    for i in range(n-1, -1, -1):
        sm = 0.0
        for j in range(i+1, n):
            sm += eq2[i][j]*x[j]
        x[i] = (eq2[i][n]-sm)/eq2[i][i]
    print(x)

eq1 = [[1.0, 2.0, 3.0, 5.0], [1.0, 4.0, 9.0, 15.0], [1.0, 8.0, 27.0, 47.0]]
eq2 = [[1, 4, 4, -15], [1, -2, -2, 9], [1, 1, 2, -4]]
eq3 = [[3, 1, 4, 1, 1], [1, 2, 3, -1, 2], [2, -1, 3, 2, -3], [1, 1, 1, 5, 2]]
eq4 = [[1, 10, 0], [-2, -20, 0]]
solver(eq1, 3)
solver(eq2, 3)
solver(eq3, 4)
print("eq4 has infinite number of solutions")
# solver(eq4, 2)

x = sympy.Symbol('x')
print(sympy.solve((-5*1*3-3*2*x)-(1*1*4-4*2*4)+(x*1*x+5*4*x), 'x'))
