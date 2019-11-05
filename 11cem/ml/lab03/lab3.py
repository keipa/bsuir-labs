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

x = data['X']
y = data['y']
xval = data['Xval']
yval = data['yval']
xtest = data['Xtest']
ytest = data['ytest']
# task 2
# Постройте график, где по осям откладываются X и y из обучающей выборки.


def norm(x):
    return x / np.linalg.norm(x)

x = norm(x)
y = norm(y)


def show_data():
    train_plot = plt.plot(x, y, 'bo', label='train')
    # validation_plot = plt.plot(xval,yval, 'go', label="validation")
    # test_plot = plt.plot(xtest,ytest, 'ro', label="test")
    plt.legend(loc='upper left')
    # plt.show()


show_data() #todo uncomment

# task 3
# Реализуйте функцию стоимости потерь для линейной регрессии с L2-регуляризацией.



def sig(x):
    return 1 / (1 + np.exp(-x))


def h(theta, X):
    return sig(np.dot(theta, X.T))


def cost(theta, X, y, lambda_=0):
    m = len(y)
    h_theta = sig(np.dot(X, theta))
    J = (1.0 / m) * ((np.dot(-y.T, np.log(h_theta))) - np.dot((1 - y).T, np.log(1 - h_theta))) + (lambda_ / (2 * m)) * sum(theta[1:]**2)
    return J[0][0]

# Реализуйте функцию градиентного спуска для линейной регрессии с L2-регуляризацией.

def grad(theta, x, Y, lambda_=0):
    X = np.hstack((np.ones((len(x), 1)), x))
    record_count = len(Y)
    grad = (1.0 / record_count) * np.dot(X.T, (sig(np.dot(X, theta.T)) - Y))
    return grad.T + ((lambda_ / record_count) * theta) # new tetha


def get_initial_tetha(class_count, feature_count):
    return np.zeros((class_count, feature_count))

theta = get_initial_tetha(1, 2)
iterations = 500
cost_history = []
for _ in range(iterations):
    theta = grad(theta.copy(), x, y)
    cost_history.append(cost(theta.copy(), x, y))


eps = 0.25
y_predicted = theta[0][0]*x+theta[0][1] + eps

# Постройте модель линейной регрессии с коэффициентом регуляризации 0 и постройте график полученной функции совместно с графиком из пункта 2. Почему регуляризация в данном случае не сработает?
trained_plot = plt.plot(x, y_predicted, 'r-', label='trained')
plt.show()

plt.plot(range(len(cost_history)), cost_history, 'ro')
plt.show()


# Постройте график процесса обучения (learning curves) для обучающей и валидационной выборки. По оси абсцисс откладывается число элементов из обучающей выборки, а по оси ординат - ошибка (значение функции потерь) для обучающей выборки (первая кривая) и валидационной выборки (вторая кривая). Какой вывод можно сделать по построенному графику?

# Реализуйте функцию добавления p - 1 новых признаков в обучающую выборку (X2, X3, X4, …, Xp).
# Поскольку в данной задаче будет использован полином высокой степени, то необходимо перед обучением произвести нормализацию признаков.
# Обучите модель с коэффициентом регуляризации 0 и p = 8.
# Постройте график модели, совмещенный с обучающей выборкой, а также график процесса обучения. Какой вывод можно сделать в данном случае?
# Постройте графики из пункта 10 для моделей с коэффициентами регуляризации 1 и 100. Какие выводы можно сделать?
# С помощью валидационной выборки подберите коэффиент регуляризации, который позволяет достичь наименьшей ошибки. Процесс подбора отразите с помощью графика (графиков).
# Вычислите ошибку (потерю) на контрольной выборке.
# Ответы на вопросы представьте в виде отчета.
