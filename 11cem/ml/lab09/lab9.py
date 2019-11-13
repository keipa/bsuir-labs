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


# task 1

# Загрузите данные ex9_movies.mat из файла.

data = loadmat("data/ex9_movies.mat")

R_is_rated = data["R"]
Y_rate_value = data["Y"]


pass


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
n = 3
# task 2
# Выберите число признаков фильмов (n) для реализации алгоритма коллаборативной фильтрации.

# task 3
# Реализуйте функцию стоимости для алгоритма.

# task 4
# Реализуйте функцию вычисления градиентов.
# task 5
# При реализации используйте векторизацию для ускорения процесса обучения.
# task 6
# Добавьте L2-регуляризацию в модель.
# task 7
# Обучите модель с помощью градиентного спуска или других методов оптимизации.
# task 8
# Добавьте несколько оценок фильмов от себя. Файл movie_ids.txt содержит индексы каждого из фильмов.
# task 9
# Сделайте рекомендации для себя. Совпали ли они с реальностью?
# task 10
# svd
# https://habr.com/ru/company/yandex/blog/241455/
# Также обучите модель с помощью сингулярного разложения матриц. Отличаются ли полученные результаты?
