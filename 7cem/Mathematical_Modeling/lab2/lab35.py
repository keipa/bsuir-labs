# python27
from matplotlib import pyplot
from matplotlib.mlab import frange
import math
import scipy.stats as st
from MultiplicativeCongruentialMethod import MultiplicativeCongruentialMethod


def PlotInit():
    pyplot.style.use('seaborn')
    pyplot.figure(figsize=(6, 6))


def ExpInit():
    global _lambda, x_min, x_max, n, x, y
    _lambda = 1.5
    x_min = 0.0
    x_max = 6.0
    n = 100
    h = (x_max - x_min) / n
    x = [i * h for i in range(n)]
    # экспоненциальное распределение
    y = [_lambda * (math.e ** (-_lambda * x[i])) for i in range(len(x))]


def ReversedFunction(sourceFunc):
    return [-1.0 * (1.0 / _lambda) * math.log(1 - sourceFunc[i]) for i in range(len(sourceFunc))]


def ViewMathDetails(reversedFunc):
    M1 = sum(reversedFunc) / len(reversedFunc)
    D1 = sum([reversedFunc[i] ** 2 - M1 ** 2 for i in range(len(reversedFunc))]) / len(reversedFunc)
    print('{0} numbers. M = {1}. D = {2}'.format(len(reversedFunc), M1, D1))


def ShowHistogramAndPlot(func):
    pyplot.subplot(1, 1, 1)
    pyplot.hist(func, normed=1, color='C2')
    pyplot.plot(x, y)
    pyplot.show()


def GetFunctionOfContinuousRandomVariable(interval):
    return [1 - math.e ** (-_lambda * interval[i]) for i in range(len(interval))]


def GetCriterionOfConsentKolomogorov(practiceFunc, interval):
    teor = GetFunctionOfContinuousRandomVariable(practiceFunc)
    return math.sqrt(n) * max(abs(interval[i] - teor[i]) for i in range(len(practiceFunc)))


def ShowPointEstimateGraph(practiceFunc, interval):
    pyplot.subplot(1, 1, 1)
    pyplot.plot(practiceFunc, interval)
    pyplot.plot(x, F)
    pyplot.show()


def GetIntervalFunc(practiceFunc):
    return [i / float(len(practiceFunc)) for i in range(len(practiceFunc))]


PlotInit()
ExpInit()
#  сравнение экспоненциального распределения с гистограммой

count = 100
x1 = MultiplicativeCongruentialMethod(count)
y1 = ReversedFunction(x1)
ViewMathDetails(y1)
ShowHistogramAndPlot(y1)

count = 10000
x2 = MultiplicativeCongruentialMethod(count)
y2 = ReversedFunction(x2)
ViewMathDetails(y2)
ShowHistogramAndPlot(y2)

# phase 2 точечная оценка
PlotInit()
F = GetFunctionOfContinuousRandomVariable(x)  # функция непрерывной случайной величины

y1.sort()
F1 = GetIntervalFunc(y1)
ShowPointEstimateGraph(y1, F1)

y2.sort()
F2 = GetIntervalFunc(y2)
ShowPointEstimateGraph(y2, F2)

# phase 3

print(GetCriterionOfConsentKolomogorov(y1, F1))
print(GetCriterionOfConsentKolomogorov(y2, F2))

# интервальная оценка
x_min = 0.01
x_max = 0.99
dx = 0.01
d1 = sum([y1[i] ** 2 - (sum(y1) / len(y1)) ** 2 for i in range(len(y1))]) / len(y1)
interval = frange(x_min, x_max, dx)
s = math.sqrt(d1)  # корень из оценки дисперсии
ylist = [st.norm.ppf((i + 1) / 2) * 2 * s / math.sqrt(n - 1) for i in interval]
pyplot.plot(interval, ylist, 'b')
pyplot.show()
