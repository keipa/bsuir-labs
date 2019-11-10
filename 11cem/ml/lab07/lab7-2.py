# -*- coding: utf-8 -*-
from sklearn.decomposition import PCA

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
import math



def get_task_data(path):
    data = loadmat(path)
    X = data["X"]
    X += 128
    return X

# task 9
# Загрузите данные ex7faces.mat из файла.

data = get_task_data('data/ex7faces.mat')


def show_data(data):
    meshx, meshy = np.meshgrid(np.arange(32), np.arange(32))
    fig, axs = plt.subplots(10, 10, figsize=(10, 10), sharey=True)
    np.random.seed(42)
    indexes = [np.random.randint(0, len(data)) for _ in range(len(data))]
    count = 0
    for i in range(10):
        for j in range(10):
            # axs[i][j].scatter(meshx, -(meshy - 32), c=data[indexes[count]].reshape((32, 32)).T, marker=",",
            #                   cmap="inferno")
            axs[i][j].imshow(data[indexes[count]].reshape((32, 32)).T, cmap='inferno')
            axs[i][j].axis("off")
            axs[i][j].title.set_text(str(indexes[count]))
            count += 1

    # task 10
    # Визуализируйте 100 случайных изображений из набора данных.
    plt.show()


show_data(data)

def get_my_vector(data):
    pca = PCA(n_components = 36)
    pca.fit_transform(data)

# task 11
# С помощью метода главных компонент вычислите собственные векторы.

def show_components(data,n ):
    pca = PCA(n_components = n)
    pca.fit(data)
    fig, axes = plt.subplots(int(n/math.sqrt(n)),int(n/math.sqrt(n)),figsize=(10,10), subplot_kw={'xticks':[], 'yticks':[]}, gridspec_kw=dict(hspace=0.01, wspace=0.01))
    for i, ax in enumerate(axes.flat):
        ax.imshow(pca.components_[i].reshape(32,32).T,cmap='inferno')
    plt.show()

# task 12
# Визуализируйте 36 главных компонент с наибольшей дисперсией.
# task 13
# Как изменилось качество выбранных изображений?

show_components(data,36)

# task 14
# Визуализируйте 100 главных компонент с наибольшей дисперсией.
# task 15
# Как изменилось качество выбранных изображений?
show_components(data,100)

pass


# task 16
# Используйте изображение, сжатое в лабораторной работе №6 (Кластеризация).
compressedImage = misc.imread('data/l6.png')
print(compressedImage.shape)

compressedImage = compressedImage.reshape(16384, 3)
print(compressedImage)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(compressedImage[:, 1], compressedImage[:, 2], compressedImage[:, 0], c='Red')


# task 17
# С помощью метода главных компонент визуализируйте данное изображение в 3D и 2D.
plt.show()
plt.plot(compressedImage[:, 0], compressedImage[:, 1], 'ro')
plt.show()




