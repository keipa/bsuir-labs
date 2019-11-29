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




def show_image(img):
    plt.imshow(img)
    plt.show()

def normalize_image(img):
    # return (2*img / 255)-1
    return img / 255


def denormalize_image(img):
    # return ((img + 1)*255/2).astype('int32')
    return (img * 255).astype('int32')

def read_png(path='roadpng.png'):
    img = misc.imread(path).astype('int32')
    # show_image(img)
    # uncomment the below code to view the loaded image
    return img

img = read_png()
img =  normalize_image(img)


def rect_split(img, h=10, w=10):
    rects = []
    for height in range(int(img.shape[0]/h)):
        for width in range(int(img.shape[1]/w)):
            rects.append(img[width*w:width*w+w, height*h:height*h+h].flatten())
    rects = np.array(rects)
    return rects


def rect_join(rects, h=10, w=10, rh=800, rw=800):
    i = 0
    img = None
    for height in range(int(rh / h)):
        row = None
        for width in range(int(rw / w)):
            restore = rects[i].reshape(h,w,3)
            i += 1
            row = restore if row is None else np.vstack((row, restore))
        img = row if img is None else np.hstack((img,row))
    return img




rects = rect_split(img)
print(rects.shape)

# sigmoid
def activation(x):
    return 1 / (1 + np.exp(-x))


# функция прямого распространения
def predict(x, theta_1, theta_2, return_hidden_layer = False):
    # theta_1 and theta_2 is neural network config for lay1 and lay2
    ex_x = np.hstack((np.ones((len(x), 1)), x)) #расширение матрицы для умножения с первым слоем
    lay_1_out = activation(ex_x.dot(theta_1.T)) #векторное умножение с последующим применением функции  активации
    ex_lay_1_out = np.hstack((np.ones((len(lay_1_out), 1)), lay_1_out)) #расширение результирующей матрицы для умножения со вторым слоем
    lay_2_out = activation(ex_lay_1_out.dot(theta_2.T)) #векторное умножение с последующим применением функции активации даёт на выходе матрицу ответов от нейронной сети(матрица предсказаний)
    return ex_lay_1_out if return_hidden_layer else lay_2_out

def create_random_theha(shape):
    import random
    theta = []
    for _ in range(shape[0]):
        theta.append(np.array([random.uniform(-1, 1) for _ in range(shape[1])]))
    return np.array(theta)


rand_tetha_1 = create_random_theha((280, 301))
rand_tetha_2 = create_random_theha((300, 281))

predictions = predict(rects, rand_tetha_1, rand_tetha_2)

# initial output
img = rect_join(predictions)
img = denormalize_image(img)
# show_image(img)

def sigmoid_speed(x):
    return np.exp(-x) / ((1 + np.exp(-x)) ** 2)


def revert_error_spread_train(x, rand_tetha_1, rand_tetha_2, y):
    for _ in tqdm(range(20)):
        predicted = predict(x, rand_tetha_1, rand_tetha_2)
        lay_1_predicted = predict(x, rand_tetha_1, rand_tetha_2, return_hidden_layer=True)
        l2error = y - predicted
        l2delta = l2error * sigmoid_speed(predicted)
        l1error = np.dot(l2delta, rand_tetha_2)
        l1delta = l1error * sigmoid_speed(lay_1_predicted)
        l1delta = np.delete(l1delta, 0, 1)
        ex_x = np.hstack((np.ones((len(x), 1)), x))  # расширение матрицы для умножения с первым слоем
        rand_tetha_1 += np.dot(ex_x.T, l1delta).T
        rand_tetha_2 += np.dot(lay_1_predicted.T, l2delta).T
    return rand_tetha_1, rand_tetha_2


# la 1
# al 1000
# i 10
def gradient(x,  base_theta_1, base_theta_2, y, lambda_=10000, alpha=1000000, iterations = 100):
    for _ in tqdm(range(int(iterations))):
        ex_x = np.hstack((np.ones((len(x), 1)), x))  # расширение матрицы для умножения с первым слоем
        layer1 = activation(np.dot(ex_x, base_theta_1.T))
        ex_lay_1_out = np.hstack((np.ones((len(layer1), 1)), layer1))  # расширение результирующей матрицы для умножения со вторым слоем
        layer2 = activation(np.dot(ex_lay_1_out, base_theta_2.T))
        layer2delta = (layer2 - y) * (layer2 * (1-layer2))
        layer1delta = np.dot(layer2delta, base_theta_2) * (ex_lay_1_out * (1-ex_lay_1_out))
        l2_regularization = 1 - lambda_ / len(x)
        base_theta_2 = base_theta_2 * l2_regularization - alpha * np.dot(ex_lay_1_out.T, layer2delta).T
        layer1delta = np.delete(layer1delta, 0, 1)
        base_theta_1 = base_theta_1 * l2_regularization - alpha * np.dot(ex_x.T, layer1delta).T
    return np.array([base_theta_1, base_theta_2])




def inp(string, defalut):
    user = input(string)
    if user == "":
        return defalut
    else:
        return float(user)


def expect():
    la = 10
    al = 0
    i = 20

    while True:
        # try:
            la = inp("lambda", la)
            al = inp("alpha", al)
            i = inp("iter", i)
            trained_tetha_1, trained_tetha_2 = gradient(rects, rand_tetha_1, rand_tetha_2, rects, lambda_=la, alpha=al, iterations = i)
            predictions = predict(rects, trained_tetha_1, trained_tetha_2)
            # initial output
            img = rect_join(predictions)
            img = denormalize_image(img)
            show_image(img)

expect()

# trained_tetha_1, trained_tetha_2 = revert_error_spread_train(rects, rand_tetha_1, rand_tetha_2, rects)
# print(trained_tetha_1)
# print(trained_tetha_2)
# predictions = predict(rects, trained_tetha_1, trained_tetha_2)
# # initial output
# img = rect_join(predictions)
# img = denormalize_image(img)
# show_image(img)
#


# 0
# 1000
# 10












