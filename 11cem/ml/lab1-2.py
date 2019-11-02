# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm



# task 6
# Загрузите набор данных ex1data2.txt из текстового файла.
data = pd.read_csv("lab1/ex1data2.txt", header=None, sep=",", names=['Area','RoomCount', 'Price'])


print("data head")
print(data.head())

def show_plot():
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(data.RoomCount, data.Area, data.Price, c='r', marker='o')
    ax.set_xlabel('X Area')
    ax.set_ylabel('Y RoomCount')
    ax.set_zlabel('Z Price')
    plt.show()


show_plot()

# task 7
# Произведите нормализацию признаков.


df = data
normalized_data = (df - df.min()) / (df.max() - df.min())
print("normalized head")
print(normalized_data.head())

# Повлияло ли это на скорость сходимости градиентного спуска? Ответ дайте в виде графика.
# ответ, да. без нормализации нет сходимости. коэффициенты выходят за вычислительный диапазон
# скорость с нормализацией 150it, без нормализации inf

def Gradient(data, tetha_start = [1,1,1], alpha = -0.01, iterations = 150):
    tetha = np.array(tetha_start)
    tethas_history = [np.array(tetha_start)]
    costs = []
    x = np.array(data.iloc[:, 0:2])
    x1 = np.array(data.RoomCount)
    x2 = np.array(data.Area)
    y_actual = np.array(data.Price)
    y_theory = x.dot(tetha[0:2]) + tetha[2]
    for i in range(iterations):

        theroyes = [tetha[0] * x1_actual + x2_actual * tetha[1] + tetha[2] for x1_actual, x2_actual in zip(x1, x2)]
        sum_diff_x1 = 0
        sum_diff_x2 = 0
        sum_diff_b = 0
        for y_theory, y_actual, x1_actual, x2_actual in zip(theroyes, data.Price, data.RoomCount, data.Area):
            sum_diff_x1 += (y_theory - y_actual) * x1_actual * 2 / len(theroyes)
            sum_diff_x2 += (y_theory - y_actual) * x2_actual * 2 / len(theroyes)
            sum_diff_b += 2 * (y_theory - y_actual) / len(theroyes)
        sum_diff_x1 *= alpha
        sum_diff_x2 *= alpha
        sum_diff_b *= alpha
        tetha = [tetha[0] + sum_diff_x1, tetha[1] + sum_diff_x2, tetha[2] + sum_diff_b]
        tethas_history.append(tetha)

        y_theory = x.dot(tetha[0:2]) + tetha[2]

        j = 0.5 * ((y_theory - y_actual).T).dot((y_theory - y_actual))/len(y_theory)
        # if len(costs) == 0 or j < costs[-1]:
        costs.append(j)
    plt.plot(range(len(costs)), costs, 'ro')
    print("costs head(last 5)")
    print(costs[:5])
    print("costs tail(last 5)")
    print(costs[-5:])
    plt.show()
    print("koefs")
    print(tethas_history[-1])
    return tethas_history[-1]



tetha = Gradient(normalized_data)

Gradient(normalized_data, iterations=15000)

def ShowGradientResult(data, feature, tetha, tetha_ind):
    # global x, k, b, i, y
    normalized_data.plot.scatter(x=feature, y='Price', c='DarkBlue')
    plt.grid()
    plt.axis('equal')
    x = np.arange(0, 1, 0.01)
    k = tetha[0]
    b = tetha[2]
    y = [i * k + b for i in x]
    plt.plot(x, y, 'b-')
    plt.show()


ShowGradientResult(normalized_data, 'RoomCount', tetha,0)
ShowGradientResult(normalized_data, 'Area', tetha,1)


# normalized_data.plot.scatter(x='Area', y='Price', c='DarkBlue')
# plt.grid()
# plt.axis('equal')
#
# x = np.arange(0.0, 1.0, 0.01)
# k = tetha[1]
# b = tetha[2]
# y = [i * k + b for i in x]
# plt.plot(x, y, 'b-')
# plt.show()




# Gradient(data, tetha_start=[3, 2104, 1], alpha=1)




# alpha = -0.01
# tetha = [1, 0]
# tetha_x = []
# tetha_y = []
# costs = []
# iterations_count = 1015
#
# def cost(k, b, x_actual, y_actual): # task - minimize cost
#     theroyes = [k * x_i + b for x_i in x_actual]
#     J = 0
#     for y_theory, y_actual in zip(theroyes, y_actual):
#         J += abs(y_theory - y_actual)
#     return J
#
# for i in tqdm(range(iterations_count)):
#     theroyes = [tetha[0] * x_actual + tetha[1] for x_actual in data.sort_values(by="Popularity").Popularity]
#     sum_diff_k = 0
#     sum_diff_b = 0
#     for y_theory, y_actual, x_actual in zip(theroyes, data.sort_values(by="Popularity").Profit,
#                                             data.sort_values(by="Popularity").Popularity):
#         sum_diff_k += (y_theory - y_actual) * x_actual * 2 / len(theroyes)
#         sum_diff_b += 2 * (y_theory - y_actual) / len(theroyes)
#     sum_diff_k *= alpha
#     sum_diff_b *= alpha
#     tetha = [tetha[0] + sum_diff_k, tetha[1] + sum_diff_b]
#     tetha_x.append(tetha[0])
#     tetha_y.append(tetha[1])
#     costs.append(cost(tetha[0], tetha[1],data.sort_values(by="Popularity").Popularity,data.sort_values(by="Popularity").Profit))
#
#
# print(tetha)