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


# task 1
# Загрузите данные ex6data1.mat из файла.

data = loadmat('data/ex6data1.mat')

X = data["X"]
# y = data["y"]



X0, X1 = X[:, 0], X[:, 1]
plt.scatter(X0, X1,  cmap=plt.cm.coolwarm, s=20, edgecolors='k')

plt.show()

