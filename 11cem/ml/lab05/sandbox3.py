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

test_data = loadmat('data/spamTest.mat')

x_test = test_data["Xtest"]
y_test = test_data["ytest"]


def vector_to_message(vector):
    vocab_file = open("data/vocab.txt", "r")
    vocab = vocab_file.readlines()
    # one_hot = [int(record.split()[1] in message) for record in vocab]
    message_words = []
    for vocab_record, vector_enterance in zip(vocab, vector):
        is_trigger_word = bool(vector_enterance)
        word = vocab_record.split()[1]
        if is_trigger_word:
            message_words.append(word)
    return " ".join(message_words)


message = vector_to_message(x_test[0])


def one_hot_convert(message):
    message_words = message.split()
    message_words.sort()
    vocab_file = open("data/vocab.txt", "r")
    vocab = vocab_file.readlines()
    # one_hot = [int(record.split()[1] in message) for record in vocab]
    one_hot = []
    for record in vocab:
        word = record.split()[1]
        one_hot.append(int(word in message_words))
        pass
    return np.array([one_hot])
one_hot_convert()