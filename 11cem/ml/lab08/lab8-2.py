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


# task 1
# Загрузите данные ex8data1.mat из файла.
plt.style.use('dark_background')
data = loadmat("data/ex8data1.mat")

X = data["X"]
Xval = data["Xval"]
yval = data["yval"].squeeze()



# task 3
# Представьте данные в виде двух независимых нормально распределенных случайных величин.

def independent_transform(x):
    normal = []
    for i in range(x.shape[1]):
        mu, sigma = stats.norm.fit(x[:, i])
        value = 1 / math.sqrt(2*math.pi*sigma**2)*math.e**(-((x[:,i]-mu)**2/2*sigma**2))
        normal.append(value)
    return np.array(normal).T

x_n = independent_transform(X)
xval_n = independent_transform(Xval)

def show_data(x_n):
    print(x_n)
    _, ax = plt.subplots()
    ax.scatter(x_n[:,0],x_n[:,1])
    plt.show()

# show_data(x_n) #todo uncomment
# show_data(xval_n) #todo uncomment


# x = normalized x
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

# task 4
# Оцените параметры распределений случайных величин.
get_stats(x_n)
get_stats(xval_n)


# task 5
# Постройте график плотности распределения получившейся случайной величины в виде изолиний, совместив его с графиком из пункта 2.



def show_isolines(x):
    with sns.axes_style('white'):
        sns.jointplot(x[:, 0], x[:, 1]).plot_joint(sns.kdeplot)
    plt.show()

show_isolines(X)
show_isolines(x_n)

pass




# task 6
# Подберите значение порога для обнаружения аномалий на основе валидационной выборки. В качестве метрики используйте F1-меру.

from sklearn import metrics
#F1 = 2 * (precision * recall) / (precision + recall)

def f1(ypred,yact):
    tp=0.
    tn=0.
    fp=0.
    fn=0.
    for yp,ya in zip(ypred, yact):
        if ya==1 and yp==1:
            tp+=1
        if ya==0 and yp==0:
            tn+=1
        if yp==0 and ya==1:
            fn+=1
        if yp==1 and ya==0:
            fp+=1
    precision = tp/(tp+fp)
    recall = tp/(tp+fn)
    f1 = 2 * (precision * recall) / (precision + recall)
    return f1

# equal
print(metrics.f1_score([1,1,1], [1,0,1]))
print(f1([1,1,1], [1,0,1]))



x0_val = Xval[:,0]
x0_val_std = x0_val.std()
x0_val_mean = x0_val.mean()

x1_val = Xval[:,1]
x1_val_std = x1_val.std()
x1_val_mean = x1_val.mean()

limit =0
f1_history = []
limit_history= []

while limit<10:
    y_pred = []
    # Z-оценка и уточненный метод Iglewicz и Hoaglin
    for x0, x1 in zip(x0_val, x1_val):
        y_pred.append(1 if abs(x0- x0_val_mean)/x0_val_std > limit or abs(x1- x1_val_mean)/x1_val_std > limit else 0)
    limit_history.append(limit)
    f1_history.append(metrics.f1_score(y_pred, yval))
    limit+=0.001


limit = limit_history[np.argmax(f1_history)]
print(limit)
print(max(f1_history))

# 3.075
# 0.8750000000000001




# task 7
# Выделите аномальные наблюдения на графике из пункта 5 с учетом выбранного порогового значения.

x0_train = X[:,0]
x0_train_std = x0_train.std()
x0_train_mean = x0_train.mean()

x1_train= Xval[:,1]
x1_train_std = x1_train.std()
x1_train_mean = x1_train.mean()


y_pred = []
# Z-оценка и уточненный метод Iglewicz и Hoaglin
for x0, x1 in zip(x0_val, x1_val):
    y_pred.append(1 if abs(x0 - x0_val_mean)/x0_val_std > limit or abs(x1- x1_val_mean)/x1_val_std > limit else 0)




_, ax = plt.subplots()

ax.scatter(x0_train,x1_train,c=y_pred.squeeze())
ax.set_title("Trained")

plt.show()






pass