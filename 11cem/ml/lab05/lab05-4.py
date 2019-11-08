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


import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm, datasets

# task 13
# Загрузите данные spamTrain.mat из файла.

train_data = loadmat('data/spamTrain.mat')

x = train_data["X"]
y = train_data["y"]

# task 15
# Загрузите данные spamTest.mat из файла.

test_data = loadmat('data/spamTest.mat')

x_test = test_data["Xtest"]
y_test = test_data["ytest"]


# task 16
# Подберите параметры C и σ2.

model = svm.SVC(kernel='rbf', C=1)
# task 14
# Обучите классификатор SVM.
model.fit(x, y.squeeze())

def get_train_quality(Xval, model, yval):
    predicted = model.predict(Xval)
    error_count = 0
    for p, val in zip(predicted, yval.squeeze()):
        error_count += 1 if p != val else 0
    print("Quality: {}%".format(100*(len(predicted)-float(error_count)) / len(predicted)))

# print("Train...")
# get_train_quality(x, model, y)

print("Test...")
get_train_quality(x_test, model, y_test)

print(model.predict(x_test[:10]))
print(y_test[:10].squeeze())





# print(clf.predict(x_test[0]))
