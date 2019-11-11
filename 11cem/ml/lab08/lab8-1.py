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
# Загрузите данные ex8data1.mat из файла.
plt.style.use('dark_background')
data = loadmat("data/ex8data1.mat")

X = data["X"]
Xval = data["Xval"]
yval = data["yval"]

_, ax = plt.subplots()

ax.scatter(X[:,0],X[:,1])
ax.set_title("Train")
plt.show()

# task 2
# Постройте график загруженных данных в виде диаграммы рассеяния.

_, ax = plt.subplots()

ax.scatter(Xval[:,0],Xval[:,1],c=yval.squeeze())
ax.set_title("Validate")

plt.show()

# task 3
# Представьте данные в виде двух независимых нормально распределенных случайных величин.

def independent_transform(x):
    normal = []
    for i in range(x.shape[1]):
        mu, sigma = stats.norm.fit(x[:,i])
        value = 1 / math.sqrt(2*math.pi*sigma**2)*math.e**(-((x[:,i]-mu)**2/2*sigma**2))
        normal.append(value)
    return np.array(normal).T



pass