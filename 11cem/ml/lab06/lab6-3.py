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


# Начинаем с того, что высыпаем на каждую точку свой кластер
# Сортируем попарные расстояния между центрами кластеров по возрастанию
# Берём пару ближайших кластеров, склеиваем их в один и пересчитываем центр кластера
# Повторяем п. 2 и 3 до тех пор, пока все данные не склеятся в один кластер


def show_image(img):
    plt.imshow(img)
    plt.show()


def read_mat(path='data/bird_small.mat'):
    # loading the png image as a 3d matrix
    img = loadmat(path)["A"]
    show_image(img)
    # scaling it so that the values are small
    return img / 255


def read_png(path='horse.png'):
    img = misc.imread(path)
    show_image(img)
    # uncomment the below code to view the loaded image
    return img / 255

img = read_png()

points = np.reshape(img, (img.shape[0] * img.shape[1], img.shape[2]))

distance_mat = pdist(points) # pdist посчитает нам верхний треугольник матрицы попарных расстояний

# task 11
# Реализуйте алгоритм иерархической кластеризации на том же изображении. Сравните полученные результаты.
# Single linkage — минимум попарных расстояний между точками из двух кластеров
Z = hierarchy.linkage(distance_mat, 'single') # linkage — реализация агломеративного алгоритма
max_d = .3
while max_d > 0.005:
    max_d *= .5
    print(max_d)
    clusters = fcluster(Z, max_d, criterion='distance')
    meshx, meshy = np.meshgrid(np.arange(128), np.arange(128))
    plt.axis('equal')
    plt.axis('off')
    plt.scatter(meshx, -(meshy - 128), c=clusters.reshape(128, 128), cmap='inferno', marker=',')
    plt.show()

pass
