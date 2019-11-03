# -*- coding: utf-8 -*-


import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm
import copy
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.animation import FuncAnimation
import scipy.optimize

plt.grid()
plt.axis('equal')
# task 1
# Загрузите данные ex2data1.txt из текстового файла.


df = pd.read_csv("data/ex2data1.txt", header=None, sep=",", names=['Test1', 'Test2', 'IsTestPassed'])
normalized_data = (df - df.min()) / (df.max() - df.min())



# task 2
# Постройте график, где по осям откладываются оценки по предметам, а точки обозначаются двумя разными маркерами в зависимости от того, поступил ли данный студент в университет или нет.

failedTestResults = normalized_data[normalized_data['IsTestPassed'] == 0]
passedTestResults = normalized_data[normalized_data['IsTestPassed'] == 1]


def ShowData():
    plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
    plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')
    plt.show()


ShowData()


# tetha = np.array([1, 0])
def InitialApproximation(x, y):
    return np.linalg.inv(x.T.dot(x)).dot(x.T).dot(y)

x = np.array(normalized_data.iloc[:, 0:2])
y = np.array(normalized_data.IsTestPassed)

x_passed = np.array(passedTestResults.iloc[:, 0:2])
y_passed = np.array(passedTestResults.IsTestPassed)

x_failed = np.array(failedTestResults.iloc[:, 0:2])
y_failed = np.array(failedTestResults.IsTestPassed)


# tetha = InitialApproximation(x, y)
tetha = np.array([-2.0,0.0])
print("Initial Approximation: "+str(tetha))


# task 3
# Реализуйте функции потерь J(θ) и градиентного спуска для логистической регрессии с использованием векторизации.

def get_cost(tetha):
    z = tetha.dot(x_passed.T)
    g = 1/(1+np.exp(-z))
    cost_passed = -np.log(g)
    z = tetha.dot(x_failed.T)
    g = 1/(1+np.exp(-z))
    cost_failed = -np.log(1-g)
    return (sum(cost_failed)+sum(cost_passed))/len(x)
print(get_cost(tetha))


def gradientDescent(x, y, theta, alpha=0.5, iterations = 500):
    tetha_history = [copy.deepcopy(theta)]
    cost_history = [get_cost(copy.deepcopy(theta))]
    for _ in range(iterations):
        h = 1 / (1 + np.exp(-(np.dot(x, theta))))
        gradient = x.T.dot(h - y) / len(y)
        theta -= alpha * gradient
        tetha_history.append(copy.deepcopy(theta))
        cost_history.append(get_cost(copy.deepcopy(theta)))
    return tetha_history, cost_history


# task 6
# Постройте разделяющую прямую, полученную в результате обучения модели. Совместите прямую с графиком из пункта 2.
def ShowAnimatedGradientResult(tetha_history):
    fig = plt.figure()
    ax = plt.axes(xlim=(-0.5, 1.5), ylim=(-0.5, 1.5))

    plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
    plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')
    x = np.arange(-10, 10, 0.01)
    k = tetha_history[0][0]
    b = tetha_history[0][1]
    y = [-(i * k + b-1.5) for i in x]
    print("result linear function model")
    line, = plt.plot(x, y, 'b-')

    def animate(i):
        x = np.arange(-10, 10, 0.01)
        k = tetha_history[i][0]
        b = tetha_history[i][1]
        y = [-(i * k + b-1.5) for i in x]
        line.set_data(x, y)
        return line,

    anim = FuncAnimation(fig, animate, frames=len(tetha_history), interval=20, blit=True, repeat=False)
    plt.show()
    plt.cla()
    plt.clf()
    plt.close()

tetha_history, cost_history = gradientDescent(x,y,tetha)
ShowAnimatedGradientResult(tetha_history)

print("tetha result"+str(tetha_history[-1]))

print("function y={0:+f}*x{1:+f}".format(-(round(tetha_history[-1][0], 2)),-(round(tetha_history[-1][1]-1.5, 2))))

def show_linear_plot(data):
    plt.plot(range(len(data)), data, 'ro')
    plt.show()

show_linear_plot(cost_history)


# task 5
# Реализуйте функцию предсказания вероятности поступления студента в зависимости от значений оценок по экзаменам.

def isTestPassed(tetha, test):
    if test[1]>-(tetha[0]*test[0]+tetha[1] - 1.5):
        print("test passed")
    else:
        print("test failed")


isTestPassed(tetha_history[-1], [0.8, 0.76])
isTestPassed(tetha_history[-1], [0.1, 0.93])
isTestPassed(tetha_history[-1], [0.12, 0.3])
isTestPassed(tetha_history[-1], [0.61, 0.03])




# task 4
# Реализуйте другие методы (как минимум 2) оптимизации для реализованной функции стоимости (например, Метод Нелдера — Мида, Алгоритм Бройдена — Флетчера — Гольдфарба — Шанно, генетические методы и т.п.). Разрешается использовать библиотечные реализации методов оптимизации (например, из библиотеки scipy).

my_tetha = tetha_history[-1]
print("mead")

mead_theta =scipy.optimize.minimize(get_cost, [1.0, 1.0], method='Nelder-Mead').x
print(mead_theta)
print("Powell")
powell_tetha =scipy.optimize.minimize(get_cost, [1.0, 1.0], method='Powell').x
print(powell_tetha)



def ShowComparedData():
    plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
    plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')

    x = np.arange(0, 1, 0.01)
    k = my_tetha[0]
    b = my_tetha[1]
    y = [-(i * k + b-1.5) for i in x]
    line, = plt.plot(x, y, 'b-')

    x = np.arange(0, 1, 0.01)
    k = mead_theta[0]
    b = mead_theta[1]
    y = [-(i * k + b-1.5) for i in x]
    line, = plt.plot(x, y, 'r-')

    x = np.arange(0, 1, 0.01)
    k = powell_tetha[0]
    b = powell_tetha[1]
    y = [-(i * k + b-1.5) for i in x]
    line, = plt.plot(x, y, 'g-')

    plt.show()

ShowComparedData()