# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm
from scipy.io import loadmat
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
import copy
from matplotlib import cm
from matplotlib.animation import FuncAnimation
import scipy.optimize


# task 1
# зарузите данные ex3data1.mat из файла.

def normalize(df):
    return (df - df.min()) / (df.max() - df.min())


data = loadmat('data/ex3data1.mat')


def row(field):
    return data[field].squeeze()

x = data["X"]
y = data["y"].squeeze()
xval = data["Xval"]
yval = data["yval"].squeeze()
xtest = data["Xtest"]
ytest = data["ytest"].squeeze()


# task 2
# Постройте график, где по осям откладываются X и y из обучающей выборки.

def show_data():
    plt.plot(x, y, 'bo', label='train')
    plt.plot(xval, yval, 'go', label="validation")
    plt.plot(xtest, ytest, 'ro', label="test")
    plt.legend(loc='upper left')
    plt.show()


show_data()


# task 3
# Реализуйте функцию стоимости потерь для линейной регрессии с L2-регуляризацией.

def cost(theta, x, y, lambda_):
    prediction = theta.dot(x.T)
    difference = prediction - y.squeeze()
    sqareDifference = sum(difference ** 2)
    l2Parameter = lambda_ * sum(theta ** 2)
    return (sqareDifference + l2Parameter) / (2 * len(y))


def get_init_data(x, y):
    extendedX = np.hstack((np.ones((len(x), 1)), x))
    theta = np.ones(extendedX.shape[1])
    return extendedX, theta


X, theta = get_init_data(x, y)
lambda_ = 1
print(cost(theta, X, y, lambda_))


def line(x, theta):
    return x*theta[0] + theta[1]


# task 4
# Реализуйте функцию градиентного спуска для линейной регрессии с L2-регуляризацией.

def grad(theta, x, y, lmbda):
    predictions = theta.dot(x.T)
    gradient = np.dot(x.T, (predictions - y))
    regularization = lmbda * theta
    return (gradient + regularization) / len(y)

print(grad(theta, X, y, lambda_))

theta = scipy.optimize.minimize(cost, theta, (X, y, 0), method='CG').x
print(theta)


plt.scatter(x, y)
plt.plot(x, line(x, theta))
plt.show()


# task 6
# Постройте график процесса обучения (learning curves) для обучающей и валидационной выборки. По оси абсцисс откладывается число элементов из обучающей выборки, а по оси ординат - ошибка (значение функции потерь) для обучающей выборки (первая кривая) и валидационной выборки (вторая кривая). Какой вывод можно сделать по построенному графику?

def show_learn_progress(theta, x, y, lambda_, style="ro", show_plot=False):
    cost_history = []
    for iteration in range(1, len(x)):
        theta = scipy.optimize.minimize(cost, theta, (x, y, 0), method='CG').x
        cost_history.append(cost(theta, x[:iteration], y[:iteration], lambda_))
    plt.plot(range(len(cost_history)), cost_history, style)
    if show_plot:
        plt.show()


Xval, thetaval = get_init_data(xval, yval)

show_learn_progress(theta, X, y, lambda_, "r-")
show_learn_progress(thetaval, Xval, yval, lambda_, "b-", show_plot=True)


# task 7
#Реализуйте функцию добавления p - 1 новых признаков в обучающую выборку (X2, X3, X4, …, Xp).

def add_param(x, count):
    return np.hstack((x, np.zeros((len(x), count-1))))

newX = add_param(x, 2)
print(newX)

# task 8
# Поскольку в данной задаче будет использован полином высокой степени,
# то необходимо перед обучением произвести нормализацию признаков.

# Xnorm = (X - Xmin) / (Xmax - Xmin)


def norm(x):
    m, n = x.shape
    for columnIndex in range(n):
        column = x[:, columnIndex]
        min_value, max_value = min(column), max(column)
        denominator = max_value - min_value if (max_value - min_value) != 0 else 1
        normalize_column = (column - min_value) / denominator
        x[:, columnIndex] = normalize_column
    return x


norm(newX)

# task 9
# Обучите модель с коэффициентом регуляризации 0 и p = 8.

def model(x, lambda_=0, p=8):
    newX = add_param(x, 8)
    norm(newX)
    extendedNewX, newTheta = get_init_data(newX, y)
    newTheta = scipy.optimize.minimize(cost, newTheta, (extendedNewX, y, lambda_), method='CG').x
    return extendedNewX, newTheta


newX, theta = model(x)

# task 10
# Постройте график модели, совмещенный с обучающей выборкой, а также график процесса обучения.
# Какой вывод можно сделать в данном случае?

def train(theta, x, y, lambda_=0):
    plt.scatter(x[:, 1], y)
    plt.plot(x, theta.dot(x.T))
    plt.show()
    show_learn_progress(theta, x, y, lambda_, show_plot=True)


train(theta, newX, y)


# task 11
#Постройте графики из пункта 10 для моделей с коэффициентами регуляризации 1 и 100. Какие выводы можно сделать?

newX, theta = model(x, lambda_=1)
train(theta, newX, y)

newX, theta = model(x, lambda_=100)
train(theta, newX, y)

# task 12
# С помощью валидационной выборки подберите коэффиент регуляризации, который позволяет достичь наименьшей ошибки.
# Процесс подбора отразите с помощью графика (графиков).

lambdas = [10, 1, 0, 0.01, 0.0001]

costs = []

for lambda_ in lambdas:
    x, theta = get_init_data(xval, yval)
    costs.append(cost(theta, x, xval, lambda_))

plt.plot(lambdas, costs)
plt.show()


# task 12
#Вычислите ошибку (потерю) на контрольной выборке.

xResult, thetaResult = get_init_data(xtest, ytest)
thetaResult = scipy.optimize.minimize(cost, thetaResult, (xResult, ytest, 0), method='CG').x
print(cost(thetaResult, xResult, ytest, lambda_))
# Ответы на вопросы представьте в виде отчета.
