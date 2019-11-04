# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm
from scipy.io import loadmat
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.animation import FuncAnimation

# task 15
# Загрузите данные ex2data3.mat из файла.
mat = loadmat('data/ex2data3.mat')
x = mat['X']
y = mat['y']

def show_digit(index):
    plt.imshow(np.array(np.split(x[index], 20)).T, interpolation='gaussian', cmap='inferno')
    plt.show()


# task 16
# Визуализируйте несколько случайных изображений из набора данных. Визуализация должна содержать каждую цифру как минимум один раз.
def show_database():
    digits = set()
    i = 0
    while len(digits) != 10:
        if y[i][0] not in digits:
            print(y[i][0])
            show_digit(i)
            digits.add(int(y[i][0]))
        i += 1
        continue


show_database()


#
# task 17
# Реализуйте бинарный классификатор с помощью логистической регрессии с использованием векторизации (функции потерь и градиентного спуска).


#
# task 18
# Добавьте L2-регуляризацию к модели.
#


# task 19
# Реализуйте многоклассовую классификацию по методу “один против всех”.
#


# task 20
# Реализуйте функцию предсказания класса по изображению с использованием обученных классификаторов.
#


# task 21
# Процент правильных классификаций на обучающей выборке должен составлять около 95%.
