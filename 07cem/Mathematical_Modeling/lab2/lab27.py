# python27
from matplotlib import pyplot
from matplotlib.mlab import frange
import math
import scipy.stats as st


def MKM(count, n=30, k=123456789, A0=2):
    m = 2 ** n
    A = list()
    A.append(A0)
    for i in xrange(count):
        A.append((k * A[i]) % m)

    z = [A[i] / float(m) for i in xrange(1, len(A))]
    return z

pyplot.style.use('seaborn')


_lambda = 1.5
pyplot.figure(figsize=(6, 6))
x_min = 0.0
x_max = 6.0
n = 100
h = (x_max - x_min) / n
x = [i * h for i in xrange(n)]


# exponentialnoe raspredelenie
y = [_lambda * (math.e ** (-_lambda * x[i])) for i in xrange(len(x))]



# sravnenie exponentialnogo raspredeleinya s gistogrammoy
pyplot.subplot(1, 1, 1)
x1 = MKM(100)
y1 = [-1.0 * (1.0 / _lambda) * math.log(1 - x1[i]) for i in xrange(len(x1))]
pyplot.hist(y1, normed=1, color='C2')
M1 = sum(y1) / len(y1)
D1 = sum([y1[i] ** 2 - M1 ** 2 for i in xrange(len(y1))]) / len(y1)
pyplot.title('{0} numbers. M = {1}. D = {2}'.format(len(y1), M1, D1))
pyplot.plot(x, y)
pyplot.show()

pyplot.subplot(1, 1, 1)
x2 = MKM(10000)
y2 = [-1.0 * (1.0 / _lambda) * math.log(1 - x2[i]) for i in xrange(len(x2))]
pyplot.hist(y2, normed=1, color='C2')
M2 = sum(y2) / len(y2)
D2 = sum([y2[i] ** 2 - M2 ** 2 for i in xrange(len(y2))]) / len(y2)
pyplot.title('{0} numbers. M = {1}. D = {2}'.format(len(y2), M2, D2))
pyplot.plot(x, y)

pyplot.show()

pyplot.figure(figsize=(6, 6))
F = [1 - math.e ** (-_lambda * x[i]) for i in xrange(len(x))]


# functii neprerivnoy sluchaynoy velichini
pyplot.subplot(1, 1, 1)
y1.sort()
F1 = [i / float(len(y1)) for i in xrange(len(y1))]
pyplot.title("exponential function with parameter lambda : {0} and volume sample : {1}".format(_lambda, len(y1)))
pyplot.plot(y1, F1)
pyplot.plot(x, F)
pyplot.show()

pyplot.subplot(1, 1, 1)
y2.sort()
F2 = [i / float(len(y2)) for i in xrange(len(y2))]
pyplot.title("exponential function with parameter lambda : {0} and volume sample : {1}".format(_lambda, len(y2)))
pyplot.plot(y2, F2)
pyplot.plot(x, F)

pyplot.show()

# kolmogorov kriterii soglasia
F1_teor = [1 - math.e ** (-_lambda * y1[i]) for i in xrange(len(y1))]
F2_teor = [1 - math.e ** (-_lambda * y2[i]) for i in xrange(len(y2))]
print math.sqrt(n) * max(abs(F2[i] - F2_teor[i]) for i in xrange(len(y2)))

x_min = 0.01
x_max = 0.99
dx = 0.01
xlist = frange(x_min, x_max, dx)
ylist = [st.norm.ppf((i + 1) / 2) * 2 * math.sqrt(D1) / math.sqrt(n - 1) for i in xlist]
pyplot.plot(xlist, ylist, 'b')
pyplot.show()
