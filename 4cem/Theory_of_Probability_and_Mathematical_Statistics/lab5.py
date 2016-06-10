from prettytable import PrettyTable
import random
from math import sqrt
import matplotlib.pyplot as plt
import matplotlib as mlab
from scipy.stats import t, chi2
from sympy import *
import numpy as np


def func(x):
    return x * x

def point_m(array):
    return sum(array) / len(array)

def dispersion(array, m):
    tmp = 0
    for x in array:
        tmp += (x - m) ** 2
    # tmp = [((x - m) ** 2) for x in array]
    print 'tmp: {}'.format(tmp / (len(array) - 1))
    return tmp / (len(array) - 1)

def credible_interval(array, m, s, student):
    # print 'm: {}'.format(m)
    # print 's: {}'.format(s)
    # print 'student: {}'.format(student)
    # print (m - (sqrt(s) * student))
    return ((m - (sqrt(s) * student)) / (sqrt(len(array) - 1)),
            (m + (sqrt(s) * student)) / (sqrt(len(array) - 1)))

def credible_interval_d(array, s, ventil):
    return ((len(array) * s) / (chi2.ppf((1 - ventil) / 2, len(array) - 1)),
            (len(array) * s) / (chi2.ppf((1 + ventil) / 2, len(array) - 1)))
    # return (((len(array) * s) / chi2((1 - ventil) / 2, len(array) - 1)),
    #         ((len(array) * s) / chi2((1 + ventil) / 2, len(array) - 1)))



def randomSet(count):
    pirsen = PrettyTable()
    pirsen.field_names = ['Xi', 'Yi']
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
    print pirsen
    p200.sort()
    return p200


def di_ma(size, student, significante_values):
    selection = randomSet(size)
    m = point_m(selection)
    d = dispersion(selection, m)

    print 'Size: {}'.format(size)
    print 'M: {}'.format(m)
    print 'D: {}'.format(d)

    intervals = []
    for i in range(8):
        interval = credible_interval(selection, m, d, student[i])
        intervals.append(abs(interval[0] - interval[1]))
        # print 'Credible interval for significante value {0} - {1}'.format(significante_values[i], interval)

    plt.plot(significante_values, intervals, 'k')
    res = intervals[0]

    intervals = []
    x = symbols('x')
    teor_d = integrate(((x - m) ** 2) * (sqrt(x) / 2), (x, -2, 2)) #  1.61 - m ** 2
    for i in range(8):
        interval = credible_interval(selection, m, teor_d, student[i])
        intervals.append(abs(interval[0] - interval[1]))
        # print 'Credible interval for significante value {0} - {1}'.format(significante_values[i], interval)
    plt.axis([0.80, 0.995, 0, 5])
    plt.plot(significante_values, intervals, 'k')

    plt.xlabel("valuing level")
    plt.ylabel("trusted interval")    
    plt.show()

    return res


def di_d(size):
    selection = randomSet(size)
    m = point_m(selection)
    d = dispersion(selection, m)

    print 'Size: {}'.format(size)
    print 'M: {}'.format(m)
    print 'D: {}'.format(d)

    intervals = []

    significante_values = [i for i in np.arange(0.01, 1, 0.01)]
    for i in np.arange(0.01, 1, 0.01):
        interval = credible_interval_d(selection, d, i)
        intervals.append(abs(interval[0] - interval[1]))
        # print 'Credible interval for significante value {0} - {1}'.format(significante_values[i], interval)
    plt.plot(significante_values, intervals, 'k')
    res = intervals[90]
    
    intervals = []
    x = symbols('x')
    teor_d = integrate(((x - m) ** 2) * (sqrt(x) / 2), (x, -2, 2)) #  1.61 - m ** 2
    significante_values = [i for i in np.arange(0.01, 1, 0.01)]
    for i in np.arange(0.01, 1, 0.01):
        interval = credible_interval_d(selection, teor_d, i)
        intervals.append(abs(interval[0] - interval[1]))
        # print 'Credible interval for significante value {0} - {1}'.format(significante_values[i], interval)
    plt.plot(significante_values, intervals, 'r')

    plt.xlabel("valuing level")
    plt.ylabel("trusted interval")
    plt.show()
    return res


def main():
    significante_values = (0.80, 0.90, 0.95, 0.98, 0.99, 0.995, 0.998, 0.999) # urovni znachimosti 
    student = [
            [1.3253, 1.7247, 2.08600, 2.5280, 2.8453, 3.1534, 3.5518, 3.8495],
            [1.3104, 1.6973, 2.0423, 2.4573, 2.7500, 3.0298, 3.3852, 3.6460],
            [1.298, 1.6759, 2.0086, 2.4033, 2.6778, 3.9370, 3.2614, 3.4060],
            [1.2938, 1.6689, 1.9944, 2.3808, 2.6479, 3.8987, 3.2108, 3.4350],
            [1.2901, 1.6602, 1.9840, 2.3642, 2.6259, 2.8707, 3.1737, 3.3905],
            [1.2872, 1.6551, 1.9759, 2.3515, 2.6090, 2.8482, 3.1455, 3.3566],
            ]
    sizes = [20, 30, 50, 70, 100, 150]

    intervals = []
    for i in range(len(sizes)):
        intervals.append(di_ma(sizes[i], student[i], significante_values))
        raw_input()
    plt.xlabel("size")
    plt.ylabel("trusted interval")
    plt.plot(sizes, intervals, 'k')
    plt.show()

    intervals = []
    for i in range(len(sizes)):
        intervals.append(di_d(sizes[i]))
        # raw_input()
    plt.xlabel("size")
    plt.ylabel("trusted interval")
    plt.plot(sizes, intervals, 'k')
    # xmin = 20
    # xmax = 160
    # dx = 0.01
    # xlist = np.arange(xmin, xmax, dx)
    # ylist = [0.1 * ((i-0.1) ** (-0.99)) for i in xlist]
    # plt.plot(xlist, ylist, "b")
    plt.show()



if __name__ == '__main__':
    main()