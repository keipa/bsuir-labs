import random
from prettytable import PrettyTable
import matplotlib.pyplot as plt
import numpy as np


# def f(t):
#     return np.exp(-t) * np.cos(2*np.pi*t)


def func(x):
    return x*x


def main():
    a = -2
    b = 2
    ea = []
    results = []
    yi = []
    for _ in range(int(input("N: "))):
        ea.append(random.random())
    table = PrettyTable()
    table.field_names = ["Xi", "Yi"]
    ea.sort()
    for each in ea:
        yi.append(func(each*(b-a)+a))
        results.append([each*(b-a)+a, func(each*(b-a)+a)])
        table.add_row([each*(b-a)+a, func(each*(b-a)+a)])
    mo = 0
    m20 = 0
    for i in yi:
        mo += i/len(yi)
        m20 += i*i/len(yi)


    print("M: ", mo)
    print("D: ", m20-mo*mo)
    print(table)
    print()
    yi.sort()
    k = 1/len(yi)
    cur = 0
    plot_x = [0]
    plot_y = [0]
    for each in range(len(yi)-1):
        plot_x.append(yi[each])
        plot_x.append(yi[each])
        plot_y.append(cur)
        cur += k
        plot_y.append(cur)
    plot_y.append(cur)
    plot_x.append(4)
    plt.xlabel("x")
    plt.ylabel("y")
    plt.plot(plot_x, plot_y, 'k')
    na = []
    gi = []
    for _ in range(5000):
        na.append(random.random())
    na.sort()
    for each in na:
        gi.append(func(each*(b-a)+a))
    gi.sort()
    cur = 0
    o = 1/5000
    plot_a = []
    plot_b = []
    for each in range(len(gi) - 1):
        plot_a.append(gi[each])
        plot_b.append(cur)
        cur += o
    plt.plot(plot_a, plot_b, 'r')
    plt.grid(True)
    plt.show()

if __name__ == '__main__':
    main()
