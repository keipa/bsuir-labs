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
# task 7
# Загрузите данные ex2data2.txt из текстового файла.

df = pd.read_csv("data/ex2data2.txt", header=None, sep=",", names=['Test1', 'Test2', 'IsTestPassed'])
normalized_data = (df - df.min()) / (df.max() - df.min())


# task 8
# Постройте график, где по осям откладываются результаты тестов, а точки обозначаются двумя разными маркерами в зависимости от того, прошло ли изделие контроль или нет.

def ShowData(data):
    failedTestResults = data[data['IsTestPassed'] == 0]
    passedTestResults = data[data['IsTestPassed'] == 1]
    plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
    plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')
    plt.show()


# ShowData(normalized_data) todo revert before report


x = np.array(normalized_data.iloc[:, 0:2])
y = np.array(normalized_data.IsTestPassed)


# task 9
# Постройте все возможные комбинации признаков x1 (результат первого теста) и x2 (результат второго теста), в которых степень полинома не превышает 6, т.е. 1, x1, x2, x12, x1x2, x22, …, x1x25, x26 (всего 28 комбинаций).
def GetCombinations(x):
    combination = []
    for entry in x:
        entry_combs = []
        for poly in range(6 + 1):
            for p in range(poly + 1):
                entry_combs.append((entry[0] ** p) * (entry[1] ** poly))
        combination.append(entry_combs)
    return np.array(combination)


combs = GetCombinations(x)
print(x.shape)


def get_sub_cost(tetha, x, y):
    z = tetha.dot(x.T)
    g = 1 / (1 + np.exp(-z))
    return -np.log(1 - g) if y == 0 else -np.log(g)


def get_cost(tetha, data, features_count):
    x_passed = np.array(data[data['IsTestPassed'] == 1].iloc[:, 0:features_count])
    x_failed = np.array(data[data['IsTestPassed'] == 0].iloc[:, 0:features_count])
    z = tetha.dot(np.hstack((x_passed, np.ones((x_passed.shape[0], 1)))).T)
    g = 1 / (1 + np.exp(-z))
    cost_passed = -np.log(g)

    z = tetha.dot(np.hstack((x_failed, np.ones((x_failed.shape[0], 1)))).T)
    g = 1 / (1 + np.exp(-z))
    cost_failed = -np.log(1 - g)
    return (sum(cost_failed) + sum(cost_passed)) / len(x)


def gradientDescent(x, y, theta, data, alpha=-0.5, iterations=500, features_count=2):
    tetha_history = [theta.copy()]
    cost_history = [get_cost(theta, data, features_count)]
    for _ in range(iterations):
        h = 1 / (1 + np.exp(-(np.dot(x, theta))))
        gradient = x.T.dot(h - y) / len(y)
        theta += alpha * gradient
        tetha_history.append(copy.deepcopy(theta))
        cost_history.append(get_cost(theta.copy(), data, features_count))
    return tetha_history, cost_history


# l2-regulariation
def regularization(theta, X, Y, lambda_=0.1):
    particular_costs = []
    for x, y in zip(X, Y):
        cur_sub_cost = get_sub_cost(theta, x, y) + (lambda_ / (2 * len(X))) * np.sum(theta[1:] ** 2)
        particular_costs.append(cur_sub_cost)
    return 1 / len(X) * sum(particular_costs)


X = x
data_count, feature_count = X.shape
X = np.hstack((X, np.ones((data_count, 1))))

Y = y
theta = np.array([0, 0.1, 0.2])

reg = regularization(theta, X, Y)
print("reg standart" + str(reg))
print("answer:" + str(gradientDescent(X, Y, theta, data=normalized_data)[0][-1]))


sample_tetha = np.array([1.0 for _ in range(combs.shape[1])])
reg28 = regularization(sample_tetha, combs, y)

print("reg28 " + str(reg28))


# task 10
# Реализуйте L2-регуляризацию для логистической регрессии и обучите ее на расширенном наборе признаков методом градиентного спуска.

def get_cost28(tetha, x, y, features_count):
    x_passed = x[:58]
    x_failed = x[58:]
    z = tetha.dot(x_passed.T)
    g = 1 / (1 + np.exp(-z))
    cost_passed = -np.log(g)

    z = tetha.dot(x_failed.T)
    g = 1 / (1 + np.exp(-z))
    cost_failed = -np.log(1 - g)
    return (sum(cost_failed) + sum(cost_passed)) / len(x)

alpha=-0.5
iterations=500
features_count=28
tetha = np.array([1.0 for _ in range(combs.shape[1])])

tetha_history = [tetha.copy()]
cost_history = [get_cost28(tetha, combs, y, features_count)]

for _ in range(iterations):
    h = 1 / (1 + np.exp(-(np.dot(combs, tetha))))
    gradient = combs.T.dot(h - y) / len(y)
    tetha += alpha * gradient
    tetha_history.append(tetha.copy())
    cost_history.append(get_cost28(tetha.copy(), combs, y, features_count))

print("polynom tetha")
print(tetha_history[-1], cost_history[-1])

# task 11
# Реализуйте другие методы оптимизации.

def optimized_function(x, y, lambda_=0.1):
    m, n = x.shape
    tetha = np.zeros((n + 1, 1))
    x = np.hstack((np.ones((m, 1)), x))
    return scipy.optimize.minimize(regularization, tetha, (x, y, lambda_), method='L-BFGS-B').x
tetha = optimized_function(combs, y)

print("other functions tetha")
print(tetha)

# task 12
# Реализуйте функцию предсказания вероятности прохождения контроля изделием в зависимости от результатов тестов.


print("predictions per record")
print(1 / (1 + np.exp(-np.dot(tetha.copy(), np.hstack((np.ones((combs.shape[0], 1)), combs)).T))))




def sigmoid(x):
    return

def h(theta, X):
    return



# task 13
# Постройте разделяющую кривую, полученную в результате обучения модели. Совместите прямую с графиком из пункта 7.
def task13( tetha):
    XX = np.linspace(-1, 1.5, 100)
    YY = np.linspace(-1, 1.5, 100)
    ZZ = np.zeros((len(XX), len(YY)))

    for i in range(len(XX)):
        for j in range(len(YY)):
            entry_combs = [1]
            for poly in range(6 + 1):
                for p in range(poly + 1):
                    entry_combs.append((XX[i] ** p) * (YY[j] ** poly))
            ZZ[i, j] = 1 / (1 + np.exp(-tetha.dot(np.array(entry_combs).T)))

    failedTestResults = normalized_data[normalized_data['IsTestPassed'] == 0]
    passedTestResults = normalized_data[normalized_data['IsTestPassed'] == 1]
    plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
    plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')
    plt.contour(XX, YY, ZZ, 0)


task13( tetha)
plt.show()




# task 14
# Попробуйте различные значения параметра регуляризации λ. Как выбор данного значения влияет на вид разделяющей кривой? Ответ дайте в виде графиков.
