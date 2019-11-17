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

from sklearn.decomposition import TruncatedSVD
svd = TruncatedSVD(n_components=3, n_iter=250, random_state=42)
thetas = svd.fit_transform(Y_rate_value)
xes = svd.components_
# task 10
#  Также обучите модель с помощью сингулярного разложения матриц. Отличаются ли полученные результаты?

predictions = thetas.dot(xes)[:,-1]
# отличаются в лучшую сторону
# модель угадывает

