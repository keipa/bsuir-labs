from sympy import Symbol, symbols

import lab07

x1, x2, x3 = Symbol("x1"), Symbol("x2"), Symbol("x3")
x = [x1, x2, x3]
a1, a2, a3 = Symbol("a1", nonnegative=True),\
             Symbol("a2", nonnegative=True), \
             Symbol("a3", nonnegative=True)
a = [a1, a2, a3]
plan = [0.0, 1.0, 0.0]
f = 3 * x2 ** 2 - 11 * x1 - 3 * x2 - x3
g = [x1 - 7 * x2 + 3 * x3 + 7, 5 * x1 + 2 * x2 - x3 - 2, -x3]
l = symbols("l1 l2 l3", nonzero=True)
lab07.СheckСonditions(x, plan, a, f, g, l)

# x1, x2, x3, x4, x5 = Symbol("x1"), Symbol("x2"), Symbol("x3"), Symbol("x4"), Symbol("x5")
# x = [x1, x2, x3, x4, x5]
# a1, a2, a3, a4, a5 = Symbol("a1", nonnegative=True),\
#                      Symbol("a2", nonnegative=True),\
#                      Symbol("a3", nonnegative=True), \
#                      Symbol("a4", nonnegative=True),\
#                      Symbol("a5", nonnegative=True)
# a = [a1, a2, a3, a4, a5]
# plan = [6.0, 14.0, 0.0, 0.0, 0.0]
# f = (x1 - x2 - x3) / (2 * x1 + x3 + 1)
# g = [-x1 + x2 + 3 * x3 - 8, 2 * x1 - x2 - x3 + 2, -x1, -x2, -x3]
# l = symbols("l1 l2 l3", nonzero=True)
# lab07.check_of_condition(x, plan, a, f, g, l)





# def task_1():
#     x1, x2 = Symbol("x1"), Symbol("x2")
#     a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
#     a = [a1, a2, a3]
#     plan = [0.0, 1.0]
#     x = [x1, x2]
#     f = exp(x1 - x2) - x1 - x2
#     g = [x1 + x2 -1, -x1, -x2]
#     l = symbols("l1 l2", nonzero=True)
#     check_of_condition(x, plan, a, f, g, l, '1.1')
#     plan = [1.0, 1.0]
#     check_of_condition(x, plan, a, f, g, l, '1.2')
#
# def task_2():
#     x1, x2 = Symbol("x1"), Symbol("x2")
#     x = [x1, x2]
#     a1 = Symbol("a1", nonnegative=True)
#     a = [a1]
#     plan = [3.0, 9.0]
#     f = x1**2 + x2**2 - 8*x1
#     g = [x1**2 + (x2 - 9)**2 - 9]
#     l = symbols("l1 l2", nonzero=True)
#     check_of_condition(x, plan, a, f, g, l, '2')
#
# def task_3():
#     x1, x2 = Symbol("x1"), Symbol("x2")
#     x = [x1, x2]
#     a1, a2 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True)
#     a = [a1, a2]
#     plan = [6*10**0.5/5.0, 2*10**0.5/5.0]
#     f = 3*x1 + x2
#     g = [-x1*x2 + 2, x1**2 + x2**2 - 16]
#     l = symbols("l1 l2", nonzero=True)
#     check_of_condition(x, plan, a, f, g, l, '3')
#
# def task_4():
#     x1, x2, x3 = Symbol("x1"), Symbol("x2"), Symbol("x3")
#     x = [x1, x2, x3]
#     a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
#     a = [a1, a2, a3]
#     plan = [0.0, 1.0, 0.0]
#     f = 3*x2**2 - 11*x1 -3*x2 - x3
#     g = [x1-7*x2+3*x3+7, 5*x1+2*x2-x3-2, -x3]
#     l = symbols("l1 l2 l3", nonzero=True)
#     return check_of_condition(x, plan, a, f, g, l)
#
# def task_5():
#     x1, x2 = Symbol("x1"), Symbol("x2")
#     x = [x1, x2]
#     a1, a2, a3 = Symbol("a1", nonnegative=True), Symbol("a2", nonnegative=True), Symbol("a3", nonnegative=True)
#     a = [a1, a2, a3]
#     plan = [3.0, 4.0]
#     f = 9*(x1-5)**2+4*(x2-5)**2
#     g = [x1**2-3*x2+1, x2-x1-1, x1-x2]
#     l = symbols("l1 l2", nonzero=True)
#     check_of_condition(x, plan, a, f, g, l, '5')
