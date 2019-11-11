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
from sklearn import metrics


# task 1
plt.style.use('dark_background')
data = loadmat("data/ex8data1.mat")

X = data["X"]
Xval = data["Xval"]
yval = data["yval"].squeeze()


x0_val = Xval[:,0]
x0_val_std = x0_val.std()
x0_val_mean = x0_val.mean()

x1_val = Xval[:,1]
x1_val_std = x1_val.std()
x1_val_mean = x1_val.mean()



limit =0
f1_history = []
limit_history= []

while limit<10:
    y_pred = []
    # Z-оценка и уточненный метод Iglewicz и Hoaglin
    for x0, x1 in zip(x0_val, x1_val):
        y_pred.append(1 if abs(x0- x0_val_mean)/x0_val_std > limit or abs(x1- x1_val_mean)/x1_val_std > limit else 0)
    limit_history.append(limit)
    f1_history.append(metrics.f1_score(y_pred, yval))
    limit+=0.001


print(limit_history[np.argmax(f1_history)])
print(max(f1_history))
