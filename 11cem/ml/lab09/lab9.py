# -*- coding: utf-8 -*-


import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as img
from scipy import misc
from datetime import datetime
from tqdm import tqdm
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


# remove random
np.random.seed(42)
# task 1

# Загрузите данные ex9_movies.mat из файла.

data = loadmat("data/ex9_movies.mat")

R_is_rated = data["R"]
Y_rate_value = data["Y"]

new_R = []
for film in R_is_rated:
    f = list(film)
    f.append(0)
    new_R.append(f)

new_Y = []
for film in Y_rate_value:
    # normalizing
    f = list(film/5)
    f.append(0)
    new_Y.append(f)


# task 8
# Добавьте несколько оценок фильмов от себя. Файл movie_ids.txt содержит индексы каждого из фильмов.

my_rating =[
[0, 4],
[49, 4],
[61, 5],
[68, 5],
[71, 4],
[81, 2],
[88, 3],
[93, 5],
[94, 4],
[95, 4],
[186, 5],
[154, 4],
[241, 3],
[249, 5],
[256, 4],
[258, 5],
[312, 4],
[342, 4],
[404, 3],
[567, 4],
[1158, 4]
]
for keipa_film in my_rating:
    new_R[keipa_film[0]][-1] = 1
    new_Y[keipa_film[0]][-1] = keipa_film[1]/5

R_is_rated = np.array(new_R)
Y_rate_value = np.array(new_Y)



# 0 - means no rated
# rows - movies 1682
# colums - users 943


# rmse
# sqrt(1/N*sum((ypred-ypred)**2))





# идея
# похожим пользователям нравятся похожие объекты
# вычисляется не по контенту, а по истории оценок
# минусы - холодный старт
# плюсы работет лучше чем content base

# task 3
# Реализуйте функцию стоимости для алгоритма.

def cost(x_features, thetha_favs, y, lambda_=10.):
    p1 = .5*(np.sum((x_features.T.dot(thetha_favs)-y)**2))
    p2 = .5*lambda_*(np.sum(x_features**2))
    p3 = .5 * lambda_*(np.sum(thetha_favs**2))
    return p1+p2+p3



def ret(opt_x, opt_th, c):
    print("best c:{}".format(round(c, 2)))
    return opt_x, opt_th, c

# task 2
# Выберите число признаков фильмов (n) для реализации алгоритма коллаборативной фильтрации.
# task 4
# Реализуйте функцию вычисления градиентов.
# task 5
# При реализации используйте векторизацию для ускорения процесса обучения.
# task 6
# Добавьте L2-регуляризацию в модель.
# task 7
# Обучите модель с помощью градиентного спуска или других методов оптимизации.
def grad(y, iterations=250,alpha=.000001, lambda_=-0.1, features=2, minimizing_rand = 100000000):
    n = features
    x_features = np.vstack((np.zeros(R_is_rated.shape[0]), np.random.rand(n, R_is_rated.shape[0]) / minimizing_rand))
    thetha_favs = np.vstack((np.zeros(R_is_rated.shape[1]), np.random.rand(n, R_is_rated.shape[1]) / minimizing_rand))
    best_cost = np.inf
    opt_theta = thetha_favs
    opt_x = x_features
    cost_history = []
    for i in range(iterations):
        pass
        x_features -= alpha*(np.sum((x_features.T.dot(thetha_favs)-y).dot(thetha_favs.T)))+lambda_*x_features
        thetha_favs -= alpha*(np.sum(x_features.dot(x_features.T.dot(thetha_favs)-y)))+lambda_*thetha_favs
        c = cost(x_features, thetha_favs, y, lambda_)
        # print(c)
        if np.isinf(c) or np.isnan(c):
            print("iteration: {}".format(i))
            break
        if c < best_cost:
            best_cost = c
            opt_theta = thetha_favs
            opt_x = x_features
            cost_history.append(c)
    plt.plot(cost_history)
    plt.show()
    return ret(opt_x, opt_theta, best_cost)


x_features, thetha_favs, c = grad(Y_rate_value)
# optimize these twos ^^

# task 9
# Сделайте рекомендации для себя. Совпали ли они с реальностью?
predictions = x_features.T.dot(thetha_favs)[:,-1]
# нет

print()

pass




