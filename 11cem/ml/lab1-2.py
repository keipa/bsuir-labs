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
data = pd.read_csv("lab1/ex1data2.txt", header=None, sep=",", names=['RoomCount', 'Area', 'Price'])



print data.head()


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
normalized_data= (df - df.min()) / (df.max() - df.min())

print normalized_data.head()


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