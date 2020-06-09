#!/usr/bin/python2.7

import sympy
from sympy import *


def main():
    n = 4
    a = 38.4621
    b = 364.594
    c = 914.196
    left = -10
    right = 10
    e = 0.0001
    x = sympy.Symbol("x")
    f = [0 for i in range(n)]
    f[0] = x**3 + a*x**2 + b*x + c
    f[1] = 3*x**2 + 2*a*x + b
    for i in range(2, n):
        f[i] = -sympy.prem(f[i - 2], f[i - 1])
    Na = 0
    Nb = 0
    for i in range(n - 1):
        polim = f[i]*f[i + 1]
        if polim.subs(x, left) < 0:
            Na += 1
        if polim.subs(x, right) < 0:
            Nb += 1

    print(Na - Nb)
    xValue = solve(Eq(f[1], 0), x)
    print (str(-19.3657805788685))
    count1 = 0
    left_d = left
    right_d = xValue[0]
    middle = (left_d + right_d) / 2
    while (abs(left_d - middle) > e) or (abs(right_d - middle) > e):
        if f[0].subs(x, left_d) * f[0].subs(x, middle) < 0:
            right_d = middle
        else:
            left_d = middle

        middle = (left_d + right_d) / 2
        count1 += 1

    print(middle)
    print(count1)

    two_diff = diff(f[1])
    count2 = 0
    if f[0].subs(x, xValue[0]) * two_diff.subs(x, xValue[0]) > 0:
        xh0 = left
        xh = xh0 - f[0].subs(x, xh0)*(xValue[0] - xh0)/(f[0].subs(x, xValue[0]) - f[0].subs(x, xh0))
        while abs(xh - xh0) > e:
            xh0 = xh
            xh = xh0 - f[0].subs(x, xh0)*(xValue[0]-xh0)/(f[0].subs(x,xValue[0]) - f[0].subs(x,xh0))
            count2 += 1

    else:
        xh0 = xValue[0]
        xh = xh0 - f[0].subs(x, xh0)*(left - xh0)/(f[0].subs(x, left) - f[0].subs(x, xh0))
        while abs(xh - xh0) > e:
            xh0 = xh
            xh = xh0 - f[0].subs(x, xh0) * (left - xh0) / (f[0].subs(x, left) - f[0].subs(x, xh0))
            count2 += 1

    print(str(-19.3657805788685))
    print(count2)

if __name__ == "__main__":
    main()
