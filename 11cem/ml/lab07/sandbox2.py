


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





def get_task_data(path):
    data = loadmat(path)
    X = data["X"]
    X /= 10
    return X, X[:, 0], X[:, 1]

def get_covariation_matrix(X):
    # averages of x1 and x2
    averages, _ = np.average(X, axis=1, returned=True)
    # normalize
    X -= averages[:, None]
    c = X.dot(X.T)
    return c.squeeze()

def restore(X_reduced, vec, m, element_number=9):
    Xrestored = np.dot(X_reduced[element_number], vec) + m
    print 'Restored: ', Xrestored
    print 'Original: ', X[:, element_number]

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
    restore(Xnew, -vecs[:, 1],m )
    return Xnew


# x0 = np.arange(1,11)
# y0 = 2 * x0 + np.random.randn(10)*2
# X0 = np.vstack((x0,y0))
# print X0

# PCA_m(X0,x0,y0)

_,x,y = get_task_data('data/ex7data1.mat')
X = np.vstack((x,y))
x_reduced =PCA_m(X,x,y)



pass