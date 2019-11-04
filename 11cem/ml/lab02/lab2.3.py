# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm
from scipy.io import loadmat
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.animation import FuncAnimation
import scipy.optimize

# task 15
# Загрузите данные ex2data3.mat из файла.
data = loadmat('data/ex2data3.mat')
x = data['X']
y = data['y']

def show_digit(x):
    plt.imshow(np.array(np.split(x, 20)).T, interpolation='gaussian', cmap='inferno')
    plt.show()


# task 16
# Визуализируйте несколько случайных изображений из набора данных. Визуализация должна содержать каждую цифру как минимум один раз.
def show_database(x, y):
    digits = set()
    i = 0
    while len(digits) != 10:
        if y[i][0] not in digits:
            print(y[i][0])
            show_digit(x[i])
            digits.add(int(y[i][0]))
        i += 1
        continue

# show_database(x, y) # todo uncomment


X = np.hstack((np.ones((len(x), 1)), x))
_, feature_count = X.shape
l = 0.1
class_count = 10
theta = np.zeros((class_count, feature_count))


# task 17
# Реализуйте бинарный классификатор с помощью логистической регрессии с использованием векторизации (функции потерь и градиентного спуска).


def sig(x):
    return 1 / (1 + np.exp(-x))


def h(theta, X):
    return sig(np.dot(theta, X.T))


def cost(theta, X, y, lambda_=0):
    m = len(y)
    h_theta = sig(np.dot(X, theta))
    J = (1.0 / m) * ((np.dot(-y.T, np.log(h_theta))) - np.dot((1 - y).T, np.log(1 - h_theta))) + (lambda_ / (2 * m)) * sum(theta[1:]**2)
    return J


def grad(theta, X, Y, lambda_=0):
    record_count = len(Y)
    grad = (1.0 / record_count) * np.dot(X.T, (sig(np.dot(X, theta.T)) - Y))
    return grad.T + ((lambda_ / record_count) * theta) # new tetha


cost(theta[0], X, y)
grad(theta, X, y)


# task 18
# Добавьте L2-регуляризацию к модели.

l = 0.01
cost(theta[0], X, y, l)
grad(theta[0], X, y, l)

# task 19
# Реализуйте многоклассовую классификацию по методу “один против всех”.

def classify(theta, k, X, Y, C=0.1):
    for i in range(k):
        digit_class = i if i else 10
        current_y = (Y == digit_class).flatten().astype(np.int)
        theta[i] = scipy.optimize.fmin_cg(f=cost, x0=theta[i], fprime=grad, args=(X, current_y, C), maxiter=100)
    return theta


theta = classify(theta, class_count, X, y)
print(theta)

# task 20
# Реализуйте функцию предсказания класса по изображению с использованием обученных классификаторов.


def show_results(X,x,theta):
    for x_extened, x_regular in zip(X, x):
        predictions = [print(str(index) + ":" + str(class_.T.dot(x_extened))) for index, class_ in enumerate(theta)]
        show_digit(x_regular)
        print("___")


# show_results(X,x,theta)


# task 21
# Процент правильных классификаций на обучающей выборке должен составлять около 95%.

successfull_predictions = 0

for x, y_ in zip(X,y):
    predictions = [class_.T.dot(x) for index, class_ in enumerate(theta)]
    cur_y = 0 if y_[0] == 10 else y_[0]
    successfull_predictions += 1 if predictions.index(max(predictions)) == cur_y else 0

print("prediction: " +str(round(successfull_predictions/len(y)*100,2)))