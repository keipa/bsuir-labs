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

# X = np.zeros((150, 2))
#
# np.random.seed(seed=42)
# X[:50, 0] = np.random.normal(loc=0.0, scale=.3, size=50)
# X[:50, 1] = np.random.normal(loc=0.0, scale=.3, size=50)
#
# X[50:100, 0] = np.random.normal(loc=2.0, scale=.5, size=50)
# X[50:100, 1] = np.random.normal(loc=-1.0, scale=.2, size=50)
#
# X[100:150, 0] = np.random.normal(loc=-1.0, scale=.2, size=50)
# X[100:150, 1] = np.random.normal(loc=2.0, scale=.5, size=50)
#
# distance_mat = pdist(X) # pdist посчитает нам верхний треугольник матрицы попарных расстояний
# # Single linkage — минимум попарных расстояний между точками из двух кластеров
# Z = hierarchy.linkage(distance_mat, 'single') # linkage — реализация агломеративного алгоритма
# plt.figure(figsize=(10, 5))
#
# # plt.scatter(X[:,0],X[:,1])
# # plt.show()
#
# dn = hierarchy.dendrogram(Z, color_threshold=0.5)
# plt.show()
#
# max_d = .5
# clusters = fcluster(Z, max_d, criterion='distance')
# plt.scatter(X[:,0], X[:,1], c=clusters, cmap='prism')  # plot points with cluster dependent colors
# plt.show()