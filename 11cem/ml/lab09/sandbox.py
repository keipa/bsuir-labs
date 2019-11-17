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

y = np.array([
    [5, 5, 1, 1],
    [5, 0, 0, 1],
    [0, 4, 1, 0],
    [1, 1, 5, 4],
    [1, 1, 5, 0]
])

users = np.array(
    [
        [0, 5, 0],
        [0, 5, 0],
        [0, 0, 5],
        [0, 0, 5]
    ]
)
janres = np.array(
    [
        [1, .9, 0],
        [1, 1, 0.01],
        [1, 0.99, 0],
        [1, .1, 1.0],
        [1, 0, 0.9]
    ]
)
print(janres.dot(users.T))
print(np.sum((janres.dot(users.T)-y)**2))
