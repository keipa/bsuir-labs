
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
from scipy.spatial.distance import cdist
from matplotlib.animation import FuncAnimation



# task 2
# Реализуйте функцию случайной инициализации K центров кластеров.

def get_random_centroids_coords(cluster_count=3):
    centroids = np.random.normal(loc=0.5, scale=0.2, size=cluster_count*2)
    return centroids.reshape((cluster_count, 2)) # 2 means x and y coords

# task 4
# Реализуйте функцию пересчета центров кластеров.
def recalculate_centroid(X, centroids, labels):
    centroids = centroids.copy()
    centroids[0, :] = np.mean(X[labels == 0, :], axis=0)
    centroids[1, :] = np.mean(X[labels == 1, :], axis=0)
    centroids[2, :] = np.mean(X[labels == 2, :], axis=0)
    return centroids


def learn(X, cluster_count=3):
    # Прибьём рандомность и насыпем три случайные центроиды для начала
    np.random.seed(seed=42)
    cent_history = kmeans(X, cluster_count)
    # show_learn_progress(X, cent_history)
    show_animated_learn_progress(X, cent_history)


def show_learn_progress(X, cent_history):
    plt.figure(figsize=(8, 8))
    for i in range(4):
        labels = cdist(X, cent_history[i]).argmin(axis=1)
        plt.subplot(2, 2, i + 1)
        plt.scatter(X[labels == 0, 0], X[labels == 0, 1], edgecolors="k", s=30, c='red')
        plt.scatter(X[labels == 1, 0], X[labels == 1, 1], edgecolors="k", s=30, c='yellow')
        plt.scatter(X[labels == 2, 0], X[labels == 2, 1], edgecolors="k", s=30, c='green')
        plt.plot(cent_history[i][:, 0], cent_history[i][:, 1], 'bX')
        plt.title('Step {:}'.format(i + 1))
    plt.show()

def show_animated_learn_progress(X, cent_history):
    fig = plt.figure()

    labels = cdist(X, cent_history[0]).argmin(axis=1)
    cl1, = plt.plot(X[labels == 0, 0], X[labels == 0, 1], 'ro')
    cl2, = plt.plot(X[labels == 1, 0], X[labels == 1, 1], 'yo')
    cl3, = plt.plot(X[labels == 2, 0], X[labels == 2, 1], 'go')
    centers, = plt.plot(cent_history[0][:, 0], cent_history[0][:, 1], 'kX')


    def animate(i):
        labels = cdist(X, cent_history[i]).argmin(axis=1)
        cl1.set_data(X[labels == 0, 0], X[labels == 0, 1])
        cl2.set_data(X[labels == 1, 0], X[labels == 1, 1])
        cl3.set_data(X[labels == 2, 0], X[labels == 2, 1])
        centers.set_data(cent_history[i][:, 0], cent_history[i][:, 1])
        return centers,cl1,cl2,cl3

    # do not delete variable
    anim = FuncAnimation(fig, animate, frames=len(cent_history), interval=500, blit=True, repeat=True)

    plt.show()
    plt.cla()
    plt.clf()
    plt.close()


def kmeans(X, cluster_count):
    centroids = get_random_centroids_coords(cluster_count)
    cent_history = [centroids]
    for i in range(10):
        # Считаем расстояния от наблюдений до центроид
        # Смотрим, до какой центроиде каждой точке ближе всего
        labels = cdist(X, centroids).argmin(axis=1)
        # Положим в каждую новую центроиду геометрический центр её точек
        centroids = recalculate_centroid(X, centroids, labels)
        cent_history.append(centroids)
    return cent_history


def get_random_data():
    X = np.zeros((150, 2))
    np.random.seed(seed=42)
    X[:50, 0] = np.random.normal(loc=0.0, scale=.3, size=50)
    X[:50, 1] = np.random.normal(loc=0.0, scale=.3, size=50)

    X[50:100, 0] = np.random.normal(loc=2.0, scale=.5, size=50)
    X[50:100, 1] = np.random.normal(loc=-1.0, scale=.2, size=50)

    X[100:150, 0] = np.random.normal(loc=-1.0, scale=.2, size=50)
    X[100:150, 1] = np.random.normal(loc=2.0, scale=.5, size=50)

    plt.figure(figsize=(5, 5))
    plt.plot(X[:, 0], X[:, 1], 'bo')
    plt.show()
    return X


# X = get_random_data()
# learn(X)

# task 1
# Загрузите данные ex6data1.mat из файла.


def get_task_data():
    data = loadmat('data/ex6data1.mat')
    X = data["X"]
    X /= 10
    X0, X1 = X[:, 0], X[:, 1]
    plt.scatter(X0, X1, cmap=plt.cm.coolwarm, s=20, edgecolors='k')
    plt.show()
    return X
X = get_task_data()
learn(X)

