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

def show_head(array):
    print(array[:5])
show_head(theta_1)

print("Network structure layer 1 = {}, layer 2 = {}".format(theta_1.shape, theta_2.shape))
print("input neuron layer: count {}+one bias neuron={} equal to features count(pixel count)".format(theta_1.shape[1]-1, theta_1.shape[1]))
print("hidden neuron layer count {}+one bias neuron={} sets analytically".format(theta_1.shape[0], theta_2.shape[1]))
print("output neuron layer count {} equals to count of classes [1..10]".format(theta_2.shape[1]))


# task 3
# Реализуйте функцию прямого распространения с сигмоидом в качестве функции активации.

# sigmoid
def activation(x):
    return 1 / (1 + np.exp(-x))


def println(message):
    print("\n{0}".format(message))

# функция прямого распространения
def predict(x, theta_1, theta_2):
    # theta_1 and theta_2 is neural network config for lay1 and lay2
    ex_x = np.hstack((np.ones((len(x), 1)), x)) #расширение матрицы для умножения с первым слоем
    lay_1_out = activation(ex_x.dot(theta_1.T)) #векторное умножение с последующим применением функции  активации
    ex_lay_1_out = np.hstack((np.ones((len(lay_1_out), 1)), lay_1_out)) #расширение результирующей матрицы для умножения со вторым слоем
    lay_2_out = activation(ex_lay_1_out.dot(theta_2.T)) #векторное умножение с последующим применением функции активации даёт на выходе матрицу ответов от нейронной сети(матрица предсказаний)
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

println("PREDEFINED NETWORK")
show_prediction_quality(predictions, y)
print("logistic regression prediction quality = 95.98%")
print("newural network has better result")

# task 5
# Перекодируйте исходные метки классов по схеме one-hot.

# onehot means
# 1 equals to [1 0 0 0 0 0 0 0 0 0]
# 2 equals to [0 1 0 0 0 0 0 0 0 0]
# 0 equals to [0 0 0 0 0 0 0 0 0 1]

def one_hot_convert(y):
    new_y = []
    for answer in y.squeeze():
        onehot = np.zeros(10)
        onehot[answer - 1] = 1
        new_y.append(onehot)
    return np.array(new_y)

one_hot_y = one_hot_convert(y)

# task 6
# Реализуйте функцию стоимости для данной нейронной сети.

def cost_with_devide(predictions, one_hot_y):
    batch_cost_accumulate = 0
    for y_pred, y_act in zip(predictions, one_hot_y):  # predicted and real answers
        record_cost_accumulate = sum((y_act-y_pred)**2)/len(y_act)  # 10
        batch_cost_accumulate += record_cost_accumulate
    batch_cost_accumulate /= len(one_hot_y) # 5000
    return batch_cost_accumulate

def cost(predictions, one_hot_y):
    batch_cost_accumulate = 0
    for y_pred, y_act in zip(predictions, one_hot_y):  # predicted and real answers
        record_cost_accumulate = sum((y_act-y_pred)**2)#/len(y_act)  # 10
        batch_cost_accumulate += record_cost_accumulate
    # batch_cost_accumulate /= len(one_hot_y) # 5000
    return batch_cost_accumulate



def get_wrong_prediction(y):
    import random
    new_y = []
    for _ in y.squeeze():
        onehot = np.zeros(10)
        onehot[random.randint(0,9)] = 1
        new_y.append(onehot)
    return np.array(new_y)

# task 7
# Добавьте L2-регуляризацию в функцию стоимости.

# not layer 2
# y should be one hotted
def l2cost(theta_1,theta_2, x,y, lambda_=10000):
     predictions = predict(x, theta_1, theta_2)
     return sum(sum((predictions - y) ** 2) * lambda_ / (2 * len(y)))

print("Predefined thetas cost: {}".format(cost(predictions, one_hot_y)))


print("Predefined thetas l2 cost: {}".format(l2cost(theta_1,theta_2, x,one_hot_y)))


# task 8
# Реализуйте функцию вычисления производной для функции активации.
def sigmoid_speed(x):
    return np.exp(-x) / ((1 + np.exp(-x)) ** 2)


def create_random_theha(shape):
    import random
    theta = []
    for _ in range(shape[0]):
        theta.append(np.array([random.uniform(-1,1) for _ in range(shape[1])]))
    return np.array(theta)

# task 9
# Инициализируйте веса небольшими случайными числами.

println("RANDOM THETA SET")
rand_tetha_1 = create_random_theha((25, 401))
rand_tetha_2 = create_random_theha((10, 26))

rand_predictions = predict(x, rand_tetha_1, rand_tetha_2)
show_prediction_quality(rand_predictions, y)

pass
