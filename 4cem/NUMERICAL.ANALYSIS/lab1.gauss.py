from sympy.solvers import solve
from sympy import Symbol

eq2 = [[1.0, 2.0, 3.0, 5.0], [1.0, 4.0, 9.0, 15.0], [1.0, 8.0, 27.0, 47.0]]
# eq1 = [[10,-7,3,5],[-6,8,4,7],[2,6,9,-1]]
x = [0, 0, 0]
sum = 0.0
n = 3

for j in range(n):
    for i in range(n):
        if i > j:
            c = eq2[i][j]/eq2[j][j]
            for k in range(n+1):
                eq2[i][k] -= c*eq2[j][k]
print(eq2)







#
# for j in range(1, n):
#     for i in range(1, n):
#         if i > j:
#             c = eq1[i][j]/eq1[j][i]
#             for k in range(n+1):
#                 eq1[i][k] = eq1[i][k] - c*eq1[j][k]
# print(eq1)
# # x[3] = eq1[3][4]/eq1[3][3]
# for i in range(n-1, 1):
#     sum = 0
#     for j in range(i+1, n):
#         sum += eq1[i, j]*x[j]
#     x[i] = (eq1[i][3+1]-sum)/eq1[i][i]
# print(x)
# x = Symbol('x')
# print(solve(x**2 - 1, x))