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

def get_train_quality(Xval, model, yval):
    predicted = model.predict(Xval)
    error_count = 0
    for p, val in zip(predicted, yval.squeeze()):
        error_count += 1 if p != val else 0
    print("Train quality: {}%".format(100*(len(predicted)-float(error_count)) / len(predicted)))

def SVM_classify(X, y, Xval, yval,C=1.0, gamma=10, kernel='linear'):
    model = svm.SVC(kernel=kernel, C=C, gamma=gamma).fit(X, y)
    clf = model.fit(X, y)
    print(model.get_params())

    get_train_quality(Xval, model, yval)

    X0, X1 = X[:, 0], X[:, 1]
    X0val, X1val = Xval[:, 0], Xval[:, 1]
    xx, yy = make_meshgrid(X0, X1)
    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)
    plt.contourf(xx, yy, Z, cmap=plt.cm.coolwarm, alpha=0.8)
    plt.scatter(X0, X1, c=y, cmap=plt.cm.coolwarm, s=30, edgecolors='none') #no edges = train
    plt.scatter(X0val, X1val, c=yval, cmap=plt.cm.coolwarm, s=50, edgecolors='k') # edges = validate
    plt.show()

# task 10
# Загрузите данные ex5data3.mat из файла.

def gauss_kernel(x, gamma=0.5): #q>0
    x0, x1 = x[:, 0], x[:, 1]
    return np.exp(-gamma * max(x0 - x1) ** 2)



data = loadmat('data/ex5data3.mat')

x = data["X"]
y = data["y"]
xval = data["Xval"]
yval = data["yval"]

# task 11
#Вычислите параметры классификатора SVM на обучающей выборке, а также подберите параметры C и σ2
#на валидационной выборке.

# task 12
#Визуализируйте данные вместе с разделяющей кривой (аналогично пункту 4).

SVM_classify(x,y.squeeze(),xval,yval.squeeze(), gamma=gauss_kernel(x), kernel='rbf', C=100)

