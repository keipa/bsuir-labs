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
import networkx as nx


# task 1
# Загрузите данные ex4data1.mat из файла.
data = loadmat('data/ex4data1.mat')

x = data['X']
y = data['y']

def show_digit(x):
    plt.imshow(np.array(np.split(x, 20)).T, interpolation='gaussian', cmap='inferno')
    plt.show()


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

weights = loadmat('data/ex4weights.mat')

# task 2
# Загрузите веса нейронной сети из файла ex4weights.mat, который содержит две матрицы Θ(1) (25, 401) и Θ(2) (10, 26). Какова структура полученной нейронной сети?
theta_1 = weights['Theta1']
theta_2 = weights['Theta2']


print("Network structure layer 1 = {}, layer 2 = {}".format(theta_1.shape, theta_2.shape))
print("input neuron layer: count {}+one bias neuron={} equal to features count(pixel count)".format(theta_1.shape[1]-1, theta_1.shape[1]))
print("hidden neuron layer count {}+one bias neuron={} sets analytically".format(theta_1.shape[0], theta_2.shape[1]))
print("output neuron layer count {} equals to count of classes [1..10]".format(theta_2.shape[1]))


# task 3
# Реализуйте функцию прямого распространения с сигмоидом в качестве функции активации.

# sigmoid
def activation(x):
    return 1 / (1 + np.exp(-x))


# функция прямого распространения
def predict(x, theta_1, theta_2):
    # theta_1 and theta_2 is neural network config for lay1 and lay2
    ex_x = np.hstack((np.ones((len(x), 1)), x))
    lay_1_out = activation(ex_x.dot(theta_1.T))
    ex_lay_1_out = np.hstack((np.ones((len(lay_1_out), 1)), lay_1_out))
    lay_2_out = activation(ex_lay_1_out.dot(theta_2.T))
    return lay_2_out

predictions = predict(x, theta_1, theta_2)


# task 4
# Вычислите процент правильных классификаций на обучающей выборке. Сравните полученный результат с логистической регрессией.
# from run at 07/11/2019 - prediction: 95.98

def show_prediction_quality(predictions, y):
    digits = [[] for _ in range(10)]
    overall_stat = []
    for index, value in enumerate(y.squeeze()):
        is_predicted_correctly = value == np.argmax(predictions[index]) + 1
        digits[value - 1].append(is_predicted_correctly)
        overall_stat.append(is_predicted_correctly)
    for index, digits_prediction_results in enumerate(digits):
        correct = len([item for item in digits_prediction_results if item == True])
        whole = len(digits_prediction_results)
        percentage = round(100 * correct / whole, 1)
        print("{0}: {1} out of {2} = {3}%".format(index, correct, whole, percentage))
    print("prediction quality: {}%".format(
        round(100 * len([item for item in overall_stat if item == True]) / len(overall_stat), 1)))

print("PREDEFINED NETWORK")
show_prediction_quality(predictions, y)
print("logistic regression prediction quality = 95.98%")
print("newural network has better result")
