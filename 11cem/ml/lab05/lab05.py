# -*- coding: utf-8 -*-

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
from sklearn import svm

# task 1
# Загрузите данные ex5data1.mat из файла.

data = loadmat('data/ex5data1.mat')

x = data["X"]
y = data["y"]
x1 = x[:, 0]
x2 = x[:, 1]

y_red = y[20:50]
x1_red = x1[20:50]
x2_red = x2[20:50]

y_temp = list(y)
x1_temp = list(x1)
x2_temp = list(x2)
del y_temp[20:50]
del x1_temp[20:50]
del x2_temp[20:50]

y_blue = np.array(y_temp)
x1_blue = np.array(x1_temp)
x2_blue = np.array(x2_temp)


# task 2
# Постройте график для загруженного набора данных: по осям - переменные X1, X2, а точки, принадлежащие различным классам должны быть обозначены различными маркерами.

def show_data(x1_red, x2_red,x1_blue, x2_blue ):
    plt.plot(x1_red, x2_red, 'ro')#, label='train')
    plt.plot(x1_blue, x2_blue, 'bo')#, label="validation")
    # plt.plot(xtest, ytest, 'ro', label="test")
    plt.legend(loc='upper left')
    plt.show()

print("Task 1")
show_data(x1_red, x2_red,x1_blue, x2_blue)

import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm, datasets


def make_meshgrid(x, y, h=.02):
    """Create a mesh of points to plot in

    Parameters
    ----------
    x: data to base x-axis meshgrid on
    y: data to base y-axis meshgrid on
    h: stepsize for meshgrid, optional

    Returns
    -------
    xx, yy : ndarray
    """
    x_min, x_max = x.min() - 1, x.max() + 1
    y_min, y_max = y.min() - 1, y.max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                         np.arange(y_min, y_max, h))
    return xx, yy


def SVM_classify(X, y, C=1.0):
    clf = svm.SVC(kernel='linear', C=C).fit(X, y)
    X0, X1 = X[:, 0], X[:, 1]
    xx, yy = make_meshgrid(X0, X1)
    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)
    plt.contourf(xx, yy, Z, cmap=plt.cm.coolwarm, alpha=0.8)
    plt.scatter(X0, X1, c=y, cmap=plt.cm.coolwarm, s=20, edgecolors='k')
    plt.show()

# task 3
# Обучите классификатор с помощью библиотечной реализации SVM с линейным ядром на данном наборе.
C = 1.0
SVM_classify(x, y.squeeze(), C)