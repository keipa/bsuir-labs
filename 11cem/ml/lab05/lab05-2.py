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


def SVM_classify(X, y, C=1.0, gamma=10, kernel='linear'):
    clf = svm.SVC(kernel=kernel, C=C,gamma=gamma).fit(X, y)
    X0, X1 = X[:, 0], X[:, 1]
    xx, yy = make_meshgrid(X0, X1)
    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)
    plt.contourf(xx, yy, Z, cmap=plt.cm.coolwarm, alpha=0.8)
    plt.scatter(X0, X1, c=y, cmap=plt.cm.coolwarm, s=20, edgecolors='k')
    plt.show()



# task 5
#Реализуйте функцию вычисления Гауссового ядра для алгоритма SVM.
#k(x1,x2) = exp(-q * ||x1-x2||^2), q>0 \\ q=1/(2*sigm^2)

def gauss_kernel(x, gamma=0.5): #q>0
    x0, x1 = x[:, 0], x[:, 1]
    return np.exp(-gamma * max(x0 - x1) ** 2)


# task 6
# Загрузите данные ex5data2.mat из файла.
data = loadmat('data/ex5data2.mat')

x = data["X"]
y = data["y"]

# task 7
#Обработайте данные с помощью функции Гауссового ядра.

# task 8
#Обучите классификатор SVM.
# task 9
#Визуализируйте данные вместе с разделяющей кривой (аналогично пункту 4).

SVM_classify(x,y.squeeze(), gamma=gauss_kernel(x), kernel='rbf', C=1)
SVM_classify(x,y.squeeze(), gamma=gauss_kernel(x), kernel='rbf', C=1000000)

