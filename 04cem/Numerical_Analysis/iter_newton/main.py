#!/usr/bin/python2.7

from sympy import *


def main():
    m = 0.3
    a = 1.0
    e = 0.0001
    x1 = Symbol("x1")
    y1 = Symbol("y1")
    count1 = 0
    x0 = 0.75
    y0 = 0.4
    x = tan(x0*y0 + m)
    y = ((1 - a*x0**2) / 2) ** 0.5
    while (abs(x - x0) > e) or (abs(y - y0) > e):
        x0 = x
        y0 = y
        x = tan(x0*y0 + m)
        y = ((1 - a*x0**2) / 2) ** 0.5
        count1 += 1

    print ("Method of simple iterations:")
    print x
    print y
    print ("iterations:")
    print count1

    f1 = tan(x1*y1 + m) - x1
    f2 = a*x1**2 + 2*y1**2 - 1
    y11 = diff(f1, x1)
    y12 = diff(f1, y1)
    y21 = diff(f2, x1)
    y22 = diff(f2, y1)
    j = Matrix([[y11, y12],
                [y21, y22]])
    j1 = j.inv()
    x0 = 0.75
    y0 = 0.4
    xn = x0 - j1[0, 0].subs(x1, x0).subs(y1, y0) * f1.subs(x1, x0).subs(y1, y0) - j1[0, 1].subs(x1, x0).subs(y1, y0) * f2.subs(x1, x0).subs(y1, y0)
    yn = y0 - j1[1, 0].subs(x1, x0).subs(y1, y0) * f1.subs(x1, x0).subs(y1, y0) - j1[1, 1].subs(x1, x0).subs(y1, y0) * f2.subs(x1, x0).subs(y1, y0)
    count2 = 0
    while (abs(xn - x0) > e) or (abs(yn - y0) > e):
        x0 = xn
        y0 = yn
        xn = x0 - j1[0, 0].subs(x1, x0).subs(y1, y0) * f1.subs(x1, x0).subs(y1, y0) - j1[0, 1].subs(x1, x0).subs(y1, y0) * f2.subs(x1, x0).subs(y1, y0)
        yn = y0 - j1[1, 0].subs(x1, x0).subs(y1, y0) * f1.subs(x1, x0).subs(y1, y0) - j1[1, 1].subs(x1, x0).subs(y1, y0) * f2.subs(x1, x0).subs(y1, y0)
        count2 += 1

    print ("Newton's method:")
    print xn
    print yn
    print ("iterations:")
    print count2

    plot_implicit(Or(Eq(a * x1 ** 2 + 2 * y1 ** 2, 1), Eq(tan(x1 * y1 + m) - x1, 0)), (x1, -5, 5), (y1, -5, 5))


if __name__ == "__main__":
    main()
