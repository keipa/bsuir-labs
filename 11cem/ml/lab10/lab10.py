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
from sklearn.tree import DecisionTreeRegressor

import math
from sklearn.model_selection import train_test_split


# remove random
np.random.seed(42)

# task 1
# Загрузите данные с помощью библиотеки sklearn.

from sklearn.datasets import load_boston
boston = load_boston()
x = boston["data"]
y = boston["target"]


def norm(x):
    m, n = x.shape
    for columnIndex in range(n):
        column = x[:, columnIndex]
        min_value, max_value = min(column), max(column)
        denominator = max_value - min_value if (max_value - min_value) != 0 else 1
        normalize_column = (column - min_value) / denominator
        x[:, columnIndex] = normalize_column
    return x

# task 2
# Разделите выборку на обучающую (75%) и контрольную (25%).
from multiprocessing.dummy import Pool as ThreadPool
pool = ThreadPool(4)


x_train, x_test, y_train, y_test = train_test_split(x, y,train_size=.75, test_size=.25, random_state=42)
print()

# task 4
# Заведите массив для объектов DecisionTreeRegressor (они будут использоваться в качестве базовых алгоритмов) и для вещественных чисел (коэффициенты перед базовыми алгоритмами).
DecisionTreeRegressors = []
alphas = []
tree_count = 50
# for _ in range(tree_count):
def do(i):
    regressor = DecisionTreeRegressor(random_state=42, max_depth=5)
    regressor.fit(x_train, y_train)
    DecisionTreeRegressors.append(regressor)



pool.map(do, [_ for _ in range(tree_count)])

regressor = DecisionTreeRegressor(random_state=42, max_depth=5)
regressor.fit(x_train, y_train)

from sklearn.metrics import accuracy_score

y_pred = regressor.predict(x_test).squeeze()
print(accuracy_score(y_test, y_pred))


max_depth=5
random_state=42

# task 5
# В цикле обучите последовательно 50 решающих деревьев с параметрами max_depth=5 и random_state=42 (остальные параметры - по умолчанию). Каждое дерево должно обучаться на одном и том же множестве объектов, но ответы, которые учится прогнозировать дерево, будут меняться в соответствие с отклонением истинных значений от предсказанных.

# task 6
# Попробуйте всегда брать коэффициент равным 0.9. Обычно оправдано выбирать коэффициент значительно меньшим - порядка 0.05 или 0.1, но на стандартном наборе данных будет всего 50 деревьев, возьмите для начала шаг побольше.

# task 7
# В процессе реализации обучения вам потребуется функция, которая будет вычислять прогноз построенной на данный момент композиции деревьев на выборке X. Реализуйте ее. Эта же функция поможет вам получить прогноз на контрольной выборке и оценить качество работы вашего алгоритма с помощью mean_squared_error в sklearn.metrics.

# task 8
# Попробуйте уменьшать вес перед каждым алгоритмом с каждой следующей итерацией по формуле 0.9 / (1.0 + i), где i - номер итерации (от 0 до 49). Какое получилось качество на контрольной выборке?

# task 9
# Исследуйте, переобучается ли градиентный бустинг с ростом числа итераций, а также с ростом глубины деревьев. Постройте графики. Какие выводы можно сделать?

# task 10
# Сравните качество, получаемое с помощью градиентного бустинга с качеством работы линейной регрессии. Для этого обучите LinearRegression из sklearn.linear_model (с параметрами по умолчанию) на обучающей выборке и оцените для прогнозов полученного алгоритма на тестовой выборке RMSE.
