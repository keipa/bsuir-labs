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
data = loadmat('data/ex3data1.mat')


x = data["X"]
y = data["y"]
xval = data["Xval"]
yval = data["yval"].squeeze()
xtest = data["Xtest"]
ytest = data["ytest"].squeeze()


def f(theta, x):
    return theta[0]*x+theta[1]


def cost(theta):
    difference = np.array([f(theta, cur_x)-cur_y for cur_x, cur_y in zip(x, y)])
    return sum(difference ** 2)/(2 * len(x))


def cal_cost(X, y, theta):
    m = len(y)
    predictions = X.dot(theta)
    cost = (1 / 2 * m) * np.sum(np.square(predictions - y))
    return cost




# normalized
# x = [
#     [1,0.232]
#     [1, 0.232]
#     [1, 0.232]
# ...
# ]
# normalized
# y = [
#     [1]
#     [0.232]
#     [0]
# ...
# ]
# theta = [[1],[1]]

def grad(X, y, theta, learning_rate=0.01, iterations=1000):
    m = len(y)
    cost_history = np.zeros(iterations)
    theta_history = np.zeros((iterations,2))
    for it in range(iterations):
        prediction = np.dot(X, theta)
        theta = theta -(1/m)*learning_rate*( X.T.dot((prediction - y)))
        theta_history[it,:] = theta.T
        cost_history[it]  = cal_cost(X, y, theta)
    return theta

def norm(x):
    m, n = x.shape
    for columnIndex in range(n):
        column = x[:, columnIndex]
        min_value, max_value = min(column), max(column)
        denominator = max_value - min_value if (max_value - min_value) != 0 else 1
        normalize_column = (column - min_value) / denominator
        x[:, columnIndex] = normalize_column
    return x

def add_param(x, new_count):
    return np.hstack((x, np.zeros((len(x), new_count - 1))))

# x = x.squeeze()
theta = np.ones(2)



# print("theta initial")
# print(theta)
#
# print("x initial")
# print(x)
#
# print("y initial")
# print(y)
#
# print("initial cost")
# print(cost(theta))
#
# print("init predicted")
# init_pred = [f(theta, cur_x) for cur_x, cur_y in zip(x.squeeze(), y)]
# print(init_pred)
# plt.plot(x, init_pred, "ro")


plt.plot(norm(x).squeeze(), norm(y), "go")


lr =0.01
n_iter = 1000

x = norm(x)
X_b = np.c_[np.ones((len(x),1)),x]
y = norm(y)
theta = np.array([[1],[1]])



theta = grad(X_b, y, theta, lr, n_iter)
print(theta)
predicted = X_b.dot(theta)

plt.plot(x.squeeze(), predicted.squeeze(), "ro")
plt.show()


theta = scipy.optimize.minimize(cal_cost, x, (y, np.array([[1],[1]])), method='CG').x
print("theta optimized")
print(theta)
#
# print("optimized predicted")
# opt_pred = [f(theta, cur_x) for cur_x, cur_y in zip(x, y)]
# print(opt_pred)
# plt.plot(x, opt_pred , "yo")
#
# print("optimized cost")
# print(cost(theta))

plt.show()