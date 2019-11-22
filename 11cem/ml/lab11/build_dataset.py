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
from sklearn.linear_model import LinearRegression

from sklearn.tree import *
from sklearn.ensemble import *




import os


max_attrsize = 128
max_files = 1
max_lines = 1000

path = "C:\\Users\\keipa\\Desktop\\labs\\bsuir-labs\\11cem\\ml\\lab11\\dataset\\"


files = [path+file for file in os.listdir(path)][:max_files]

x = []
y = []
for file in files:
    with open(file) as f:
        contents = f.readlines()[:max_lines]
        for content in contents:
            sub_x, sub_y = content.split()
            x_elem = [0 for _ in range(max_attrsize - len(sub_x))]+[int(ch) for ch in sub_x]
            x.append(x_elem)
            y.append(int(sub_y))


x = np.array(x)
y = np.array(y)



pass
