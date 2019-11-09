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


def show_image(img):
    plt.imshow(img)
    plt.show()


def read_mat(path='data/bird_small.mat'):
    # loading the png image as a 3d matrix
    img = loadmat(path)["A"]
    show_image(img)
    # scaling it so that the values are small
    return img / 255


def read_png(path='horse.png'):
    img = misc.imread(path)
    show_image(img)
    # uncomment the below code to view the loaded image
    return img / 255


def initialize_means(img, clusters):
    # reshaping it or flattening it into a 2d matrix
    points = np.reshape(img, (img.shape[0] * img.shape[1], img.shape[2]))
    m, n = points.shape

    # clusters is the number of clusters 
    # or the number of colors that we choose. 

    # means is the array of assumed means or centroids.  
    means = np.zeros((clusters, n))

    # seed pushing prevents from other results on anoher run
    np.random.seed(seed=42)
    # random initialization of means.  
    for i in range(clusters):
        rand1 = int(np.random.random(1) * 10)
        rand2 = int(np.random.random(1) * 8)
        means[i, 0] = points[rand1, 0]
        means[i, 1] = points[rand2, 1]
    return points, means


# Function to measure the euclidean 
# distance (distance formula) 
def distance(x1, y1, x2, y2):
    dist = np.square(x1 - x2) + np.square(y1 - y2)
    dist = np.sqrt(dist)
    return dist


def k_means(points, centroids, clusters, iterations = 10):
    m, n = points.shape

    # these are the index values that 
    # correspond to the cluster to 
    # which each pixel belongs to. 
    index = np.zeros(m)

    # k-means algorithm.
    centroids_history = [centroids]
    index_history = [index]
    for _ in tqdm(range(iterations)):

        for j in range(len(points)):
            # initialize minimum value to a large value 
            minv = 1000
            for k in range(clusters):

                x_p = points[j, 0]
                y_p = points[j, 1]
                x_c = centroids[k, 0]
                y_c = centroids[k, 1]

                dist = distance(x_p, y_p, x_c, y_c)
                if dist < minv:
                    minv = dist
                    index[j] = k

        for k in range(clusters):
            sumx = 0
            sumy = 0
            count = 0
            for j in range(len(points)):
                if index[j] == k:
                    sumx += points[j, 0]
                    sumy += points[j, 1]
                    count += 1
            count = 1 if count == 0 else count
            centroids[k, 0] = float(sumx / count)
            centroids[k, 1] = float(sumy / count)

        centroids_history.append(centroids)
        index_history.append(index)
    return centroids_history, index_history


def show_result(means, index, img):
    # recovering the compressed image by
    # assigning each pixel to its corresponding centroid. 
    centroid = np.array(means)
    plt.plot(centroid[:,0]*128, centroid[:,1]*128, "wX")
    # plotting the compressed image. 
    meshx, meshy = np.meshgrid(np.arange(128), np.arange(128))
    plt.axis('equal')
    plt.axis('off')
    plt.scatter(meshx, -(meshy - 128), c=100 * (index.reshape(128, 128) + 1) / clusters, cmap='inferno', marker=',')
    plt.show()



# task 7
img = read_mat()

# task 10
# Реализуйте алгоритм K-средних на другом изображении.

# img = read_png()
# task 8
# С помощью алгоритма K-средних используйте 16 цветов для кодирования пикселей.

clusters = 4



# task 9
# Насколько уменьшился размер изображения? Как это сказалось на качестве?
print("Исходный размер {} байт".format((256*3)*128*128/1024))


points, centroid = initialize_means(img, clusters)

centroid, index = k_means(points, centroid, clusters)
print("Размер после кластеризации {} байт".format((16*3)*128*128/1024))
print("размер уменьшился в {} раз".format(256/clusters))
print("качествно уменьшено")
show_result(centroid[-1], index[-1], img)
