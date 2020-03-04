from __future__ import absolute_import, division, print_function, unicode_literals

import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib.pyplot as plt


import matplotlib.pyplot as plt
import numpy as np
import os
import sys
import tarfile
from IPython.display import display, Image
from scipy import ndimage
from sklearn.linear_model import LogisticRegression
from six.moves.urllib.request import urlretrieve
from six.moves import cPickle as pickle
import urllib.request
from scipy.io import loadmat

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

def maybe_extract(filename, force=False):
    return loadmat(filename)


model = tf.keras.models.load_model('../model2/')

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('inpath', type=str)
args = parser.parse_args()

def newest(path):
    files = os.listdir(path)
    paths = [os.path.join(path, basename) for basename in files]
    paths = filter(lambda k: '.jpg' in k, paths)
    res = max(paths, key=os.path.getctime)
    print(res)
    return res
    

def resize_image(path):
    import cv2
    im = cv2.imread(path)
    resized_image = cv2.resize(im, (32, 32))
    new_path = path.replace('.jpg', '_small.jpg')
    cv2.imwrite(new_path, resized_image)
    return new_path
	
def convert_to_array(path):
    from PIL import Image
    arr = np.asarray(Image.open(path,'r'))
    return arr/255

img = (np.expand_dims(convert_to_array(resize_image(newest(args.inpath))),0))
predictions_single = model.predict(img)
print(np.argmax(predictions_single[0]))