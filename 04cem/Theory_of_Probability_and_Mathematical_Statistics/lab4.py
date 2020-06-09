import random
from prettytable import PrettyTable
import matplotlib.pyplot as plt
import matplotlib as mlab

import numpy as np


def f(t):
    return np.exp(-t) * np.cos(2*np.pi*t)


def func(x):
    return x*x


def cdf(x):
    return x**.5/2


def RandomSetNoView(count):
    pirsen = PrettyTable()
    pirsen.field_names = ["Xi", "Yi"]
    a = -2
    b = 2
    ea = []
    p200 = []
    for _ in range(count):
        ea.append(random.random())
    ea.sort()
    for each in ea:
        p200.append(func(each*(b-a)+a))
        pirsen.add_row([each*(b-a)+a, func(each*(b-a)+a)])
    p200.sort()
    return p200

def RandomSet(count):
    pirsen = PrettyTable()
    pirsen.field_names = ["Xi", "Yi"]
    a = -2
    b = 2
    ea = []
    p200 = []
    for _ in range(count):
        ea.append(random.random())
    ea.sort()
    for each in ea:
        p200.append(func(each*(b-a)+a))
        pirsen.add_row([each*(b-a)+a, func(each*(b-a)+a)])
    p200.sort()
    print(pirsen)
    return p200

def main():
    pirsen = RandomSet(200)
    print("function:\n x*x")
    print("density function:\n"
          "0 -> (-inf; 0)\n"
          "1/(4*y**.5) -> [0; 4)\n"
          "0 -> [4; +inf)")
    print("cumulative distribution function(CDF): \n"
          "0 -> (-inf; 0)\n"
          "(y**.5)/2 -> [0; 4)\n"
          "1 -> [4; +inf)")
    print("pi = CDF(right)-CDF(left)")
    pirsen_table = PrettyTable()
    pirsen_table.field_names = ["CDF(A)", "CDF(B)", "pi", "(vi-n*pi)**2/(n*pi)"]
    ind = 1
    hisum = []
    while ind < 200:
        interval = []
        while ind % 14 != 0:
            try:
                interval.append(pirsen[ind-1])
                ind += 1
            except:
                break
        ind+=1
        cdfa = cdf(interval[0])
        cdfb = cdf(interval[len(interval)-1])
        pi = abs(cdfb-cdfa)
        to_hi = (len(interval)-200*pi)**2/(200*pi)
        hisum.append(to_hi)
        pirsen_table.add_row([cdfa,
                              cdfb,
                              pi,
                              to_hi])
    print(pirsen_table)
    hi = 0
    for each in hisum:
        hi += each
    print("count of intervals: ", len(hisum))
    print("hi: ", hi)
    kolmogorov = RandomSet(30)
    k = 1 / len(kolmogorov)
    cur = 0
    plot_x = []
    plot_y = []
    for each in range(len(kolmogorov) - 1):
        plot_x.append(kolmogorov[each])
        plot_y.append(cur)
        cur += k
    plot_y.append(cur)
    plot_x.append(4)
    gi = RandomSetNoView(5000)
    cur = 0
    o = 1 / 5000
    plot_a = []
    plot_b = []
    for each in range(len(gi) - 1):
        plot_a.append(gi[each])
        plot_b.append(cur)
        cur += o
    findmax = 0
    indmax = 0
    ind = 0
    for each in range(len(plot_y)-1):
        ind = 0
        while plot_b[ind] < plot_y[each]:
            ind += 1
        try:
            if abs(plot_a[ind]-plot_x[each]) > findmax:
                findmax = abs(plot_a[ind]-plot_x[each])
                indmax = plot_y[each]
        except:
            continue
    lam= findmax*(30**.5)
    print("lambda: ", lam/10, indmax)
    mizes = RandomSet(50)
    k = 1 / len(mizes)
    cur = 0
    plot_x = []
    plot_y = []
    for each in range(len(mizes) - 1):
        plot_x.append(mizes[each])
        plot_y.append(cur)
        cur += k
    plot_y.append(cur)
    plot_x.append(4)
    gi = RandomSetNoView(5000)
    cur = 0
    o = 1 / 5000
    plot_a = []
    plot_b = []
    for each in range(len(gi) - 1):
        plot_a.append(gi[each])
        plot_b.append(cur)
        cur += o
    findmax = 0
    for each in range(len(plot_y)-1):
        ind = 0
        while plot_b[ind] < plot_y[each]:
            ind += 1
        findmax += abs(plot_a[ind]-plot_x[each])
    omega = findmax + (1/(12*50))
    print("omega: ", omega/100)





if __name__ == '__main__':
    main()