import random
from prettytable import PrettyTable
import matplotlib.pyplot as plt
import matplotlib as mlab

import numpy as np


def f(t):
    return np.exp(-t) * np.cos(2*np.pi*t)


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
    print(table)
    yi.sort()
    count_of_values_in_intervals = int(len(yi)**.5)
    probability_density = []
    ind = 0
    interval = []
    for value in range(len(yi)-1):
        if value == 0 or value % count_of_values_in_intervals != 0:
            interval.append(yi[value])
        else:
            probability_density.append(count_of_values_in_intervals/((interval[len(interval)-1]-interval[0])*len(yi)))
            interval = []
    print(probability_density)
    cur = 0
    length_of_interval = 1 / len(probability_density)
    plot_x_gist = [0]
    plot_y_gist = [0]
    plot_x_pol = []
    plot_y_pol = []
    previous = probability_density[0]
    for each in range(len(probability_density) - 1):
        plot_x_gist.append(probability_density[each])
        plot_x_gist.append(probability_density[each])
        plot_y_gist.append(cur)
        plot_y_pol.append(cur+length_of_interval/2)
        cur += length_of_interval
        plot_y_gist.append(cur)
        plot_x_pol.append(probability_density[each])
        previous = probability_density[each]
    plot_x_gist.append(0)
    plot_y_gist.append(cur)
    plt.plot(plot_y_gist, plot_x_gist, 'k')
    plt.plot(plot_y_pol, plot_x_pol, 'r')
    # plt.axis([0, 4, 0, 1])
    xmin = 0.01
    xmax = 4
    dx = 0.01
    xlist = np.arange(xmin, xmax, dx)
    ylist = [0.1 * ((i-0.1) ** (-0.99)) for i in xlist]
    plt.plot(ylist, xlist, "b")
    plt.show()



if __name__ == '__main__':
    main()