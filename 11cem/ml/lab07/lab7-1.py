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


# task 3
# Реализуйте функцию вычисления матрицы ковариации данных.
def get_covariation_matrix(X):
    # averages of x1 and x2
    averages, _ = np.average(X, axis=1, returned=True)
    # normalize
    X -= averages[:, None]
    c = X.dot(X.T)
    return c.squeeze()


def get_task_data(path):
    data = loadmat(path)
    X = data["X"]
    X /= 10
    return X, X[:, 0], X[:, 1]

# task 1
# Загрузите данные ex7data1.mat из файла.
# task 2
# Постройте график загруженного набора данных.


data, xData, yData = get_task_data('data/ex7data1.mat')



# normalizing
mu = data.mean(axis=0)
data = data - mu
# task 4
# Вычислите координаты собственных векторов для набора данных с помощью сингулярного разложения матрицы ковариации (разрешается использовать библиотечные реализации матричных разложений).
eigenvectors, _, _ = np.linalg.svd(data.T, full_matrices=False)

projected_data = np.dot(data, eigenvectors)
sigma = projected_data.std(axis=0).mean()
plt.scatter(xData, yData)
for vector in eigenvectors:
    start, end = mu, mu + sigma * vector
    # task 5
    # Постройте на графике из пункта 2 собственные векторы матрицы ковариации.
    plt.annotate('', xy=end, xycoords='data', xytext=start, textcoords='data', arrowprops=dict())
plt.axis('equal')
plt.show()


# task 7
# Реализуйте функцию вычисления обратного преобразования.

def restore(X_reduced,X, vec, m, element_number=9):
    Xrestored = np.dot(X_reduced[element_number], vec) + m
    print('Restored: ', Xrestored)
    print('Original: ', X[:, element_number])


# task 6
# Реализуйте функцию проекции из пространства большей размерности в пространство меньшей размерности с помощью метода главных компонент.

# return vals
# x reduced features dataset
# restored x with losses
def PCA_m(X,x,y):
    Xcentered = (X[0] - x.mean(), X[1] - y.mean())
    m = (x.mean(), y.mean())
    covmat = get_covariation_matrix(Xcentered)
    _, vecs = np.linalg.eig(covmat)
    Xnew = np.dot(-vecs[:, 1], Xcentered)
    # example of restored x with losses
    restore(Xnew,X, -vecs[:, 1],m )
    return Xnew




_,x,y = get_task_data('data/ex7data1.mat')
X = np.vstack((x,y))
x_reduced = PCA_m(X,x,y)



#task 8
# Постройте график исходных точек и их проекций на пространство меньшей размерности (с линиями проекций).



fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')

ax = fig.gca(projection='3d')


# Plot scatterplot data (20 2D points per colour) on the x and z axes.

# By using zdir='y', the y value of these points is fixed to the zs value 0
# and the (x,y) points are plotted on the x and z axes.
ax.scatter(x, y, zs=0)

ax.scatter(x, y, x_reduced)
for x_i, y_i, z_i in zip(x, y, x_reduced):
    ax.plot(np.array([x_i,x_i]),np.array([y_i,y_i]),np.array([0,z_i]), c="black")





# Make legend, set axes limits and labels
ax.legend()
# ax.set_xlim(0, 1)
# ax.set_ylim(0, 1)
# ax.set_zlim(0, 1)
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Customize the view angle so it's easier to see that the scatter points lie
# on the plane y=0
ax.view_init(elev=20., azim=-35)

plt.show()