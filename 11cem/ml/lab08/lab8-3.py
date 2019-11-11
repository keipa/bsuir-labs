# -*- coding: utf-8 -*-


import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as img
from scipy import misc
from datetime import datetime
from tqdm import tqdm
import seaborn as sns
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
import os
from sklearn import svm
from scipy.spatial.distance import cdist
from scipy.cluster.hierarchy import fcluster
from scipy.cluster import hierarchy
from scipy.spatial.distance import pdist
from scipy import stats
import math
from sklearn import metrics

# task 8
# Загрузите данные ex8data2.mat из файла.


data = loadmat("data/ex8data2.mat")

X = data["X"]
Xval = data["Xval"]
yval = data["yval"].squeeze()
print(Xval.shape)

# task 9
# Представьте данные в виде 11-мерной нормально распределенной случайной величины.

def independent_transform(x):
    normal = []
    for i in range(x.shape[1]):
        mu, sigma = stats.norm.fit(x[:, i])
        value = 1 / math.sqrt(2*math.pi*sigma**2)*math.e**(-((x[:,i]-mu)**2/2*sigma**2))
        normal.append(value)
    return np.array(normal).T

x_n = independent_transform(X)
print(x_n)



def get_stats(x):
    for i in range(x.shape[1]):
        math_expect = x[:, i].mean()
        standard_deviation = x[:, i].std()
        median = np.median(x[:, i])
        mode = stats.mode(x[:, i])
        dispersion = x[:, i].var()
        print()
        print("величина {}".format(i))
        print("Математическое ожидание: {}".format(math_expect))
        print("Дисперсия: {}".format(dispersion))
        print("Стандартное отклонение: {}".format(standard_deviation))
        print("Медиана: {}".format(median))
        print("Мода: значение {} повторяется {} раз".format(mode.mode[0],mode.count[0]))

# task 10
# Оцените параметры распределений случайных величин.
get_stats(x_n)

pass

stds = []
means = []
for dimension in range(Xval.shape[1]):
    stds.append(Xval[:, dimension].std())
    means.append(Xval[:, dimension].mean())
stds = np.array(stds)

means = np.array(means)





limit = 0
f1_history = []
limit_history = []
while limit <10:

    anomaly_detector_vector = []
    is_anomaly_vector = abs(Xval-means)/stds > limit
    for record in is_anomaly_vector:
        anomalies =0
        for dim in record:
            anomalies += 1 if dim else 0
        anomaly_detector_vector.append(anomalies)

    y_pred = []
    for i in anomaly_detector_vector:
        y_pred.append(1 if i>=1 else 0)
    #
    # for s, m, index in zip(stds, means, range(Xval.shape[1])):
    #     criterias = []
    #     for index in range(Xval.shape[0]):
    #
    #     # y_pred.append(1 if abs(x0 - x0_val_mean)/x0_val_std > limit or abs(x1- x1_val_mean)/x1_val_std > limit else 0)
    #     y_pred.append(1 if any(criterias) else 0)


    # Подберите значение порога для обнаружения аномалий на основе валидационной выборки. В качестве метрики используйте F1-меру.
    f1_history.append(metrics.f1_score(y_pred, yval))
    limit_history.append(limit)
    limit+=0.001

# task 11
# Подберите значение порога для обнаружения аномалий на основе валидационной выборки. В качестве метрики используйте F1-меру.

print("best f1 found")
print(max(f1_history))
print("limit:")
print(limit_history[np.argmax(f1_history)])

anomaly_detector_vector = []
is_anomaly_vector = abs(Xval - means) / stds > limit_history[np.argmax(f1_history)]
for record in is_anomaly_vector:
    anomalies = 0
    for dim in record:
        anomalies += 1 if dim else 0
    anomaly_detector_vector.append(anomalies)

y_pred = []
for i in anomaly_detector_vector:
    y_pred.append(1 if i >= 1 else 0)

print("xval  found anomalies")
print(np.count_nonzero(y_pred))


print("xval  actual anomalies")
print(np.count_nonzero(yval))


anomaly_detector_vector = []
is_anomaly_vector = abs(X - means) / stds > limit_history[np.argmax(f1_history)]
for record in is_anomaly_vector:
    anomalies = 0
    for dim in record:
        anomalies += 1 if dim else 0
    anomaly_detector_vector.append(anomalies)

y_pred = []
for i in anomaly_detector_vector:
    y_pred.append(1 if i >= 1 else 0)

# task 11
# Выделите аномальные наблюдения в обучающей выборке. Сколько их было обнаружено? Какой был подобран порог?

print("X  found anomalies")
print(np.count_nonzero(y_pred))

# x0_val_std = x0_val.std()
# x0_val_mean = x0_val.mean()
#
# x1_val = Xval[:,1]
# x1_val_std = x1_val.std()
# x1_val_mean = x1_val.mean()
#
# limit = 0
# f1_history = []
# limit_history= []
#
# while limit<10:
#     y_pred = []
#     # Z-оценка и уточненный метод Iglewicz и Hoaglin
#     for x0, x1 in zip(x0_val, x1_val):
#         y_pred.append(1 if abs(x0 - x0_val_mean)/x0_val_std > limit or abs(x1- x1_val_mean)/x1_val_std > limit else 0)
#     limit_history.append(limit)
#     f1_history.append(metrics.f1_score(y_pred, yval))
#     limit+=0.001
#
#
# limit = limit_history[np.argmax(f1_history)]
# print(limit)
# print(max(f1_history))






pass