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




# task 7
# Выделите аномальные наблюдения на графике из пункта 5 с учетом выбранного порогового значения.





pass