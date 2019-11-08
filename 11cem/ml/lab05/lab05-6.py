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
import codecs


import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm, datasets

from bs4 import BeautifulSoup
import re
from nltk.stem import SnowballStemmer
from nltk.tokenize import sent_tokenize, word_tokenize

class MailPreprocessor:
    def low_registry(self, message):
        return message.lower()

    def dollar(self, message):
        return message.replace("$", "dollar")

    def html_tags(self, message):
        return BeautifulSoup(message, "lxml").text

    def url(self, message):
        return re.sub(r'^https?:\/\/.*[\r\n]*', 'httpaddr', message, flags=re.MULTILINE)

    def email(self, message):
        return re.sub(r'[\w\.-]+@[\w\.-]+', 'emailaddr', message, flags=re.MULTILINE)

    def numbers(self, message):
        return re.sub(r'\d+', ' number ', message, flags=re.MULTILINE)

    def stem(self, sentence):
        lancaster = SnowballStemmer(language="english")
        token_words = word_tokenize(sentence)
        stem_sentence = []
        for word in token_words:
            stem_sentence.append(lancaster.stem(word))
            stem_sentence.append(" ")
        return "".join(stem_sentence)

    def non_letters(self, message):
        return re.sub(r'([^\s\w]|_)+', '', message, flags=re.MULTILINE)

    filter_order = [low_registry, dollar, html_tags, url, email, numbers, non_letters, stem]

    def filter(self, message):
        for method in self.filter_order:
            message = method(self, message)
        return message


def genarate_vocab_name():
    return "vocab_"+datetime.strftime(datetime.now(), "%m%d_%H%M")+".txt"


def get_vocab(file_paths):
    words = set()
    for path in tqdm(file_paths):
        print("Checking file {}...".format(path))
        f = open(path, "r")
        text = f.read()
        processor = MailPreprocessor()
        clean_text = processor.filter(text)
        for word in clean_text.split():
            words.add(word)
        f.close()
    word_list = list(words)
    word_list.sort()
    return word_list

def create_vocab(file_paths):

    word_list = get_vocab(file_paths)
    f = open(genarate_vocab_name(), "a+")
    f.write('\n'.join(word_list))
    f.close()



spam_emails=['20021010_spam.tar/20021010_spam/spam/0000.7b1b73cf36cf9dbc3d64e3f2ee2b91f1',
'20021010_spam.tar/20021010_spam/spam/0001.bfc8d64d12b325ff385cca8d07b84288',
'20021010_spam.tar/20021010_spam/spam/0002.24b47bb3ce90708ae29d0aec1da08610',
'20021010_spam.tar/20021010_spam/spam/0003.4b3d943b8df71af248d12f8b2e7a224a',
'20021010_spam.tar/20021010_spam/spam/0004.1874ab60c71f0b31b580f313a3f6e777',
'20021010_spam.tar/20021010_spam/spam/0005.1f42bb885de0ef7fc5cd09d34dc2ba54']


# task 24
# Постройте собственный словарь.
vocab = get_vocab(spam_emails)

x = []
y = []

def get_files_from_folder(folder_path):
    file_names = os.listdir(folder_path)
    for file in tqdm(file_names):
        try:
            f = open(folder_path+file, "r")
            text = f.read()
            f.close()
            yield text
        except:
            print("issue with reading, skipping")
    # returns array of file str


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
    return np.array(one_hot)

# adding spam info

def add_data(folder_path, x, y, is_spam):
    for text in get_files_from_folder(folder_path):
        processor = MailPreprocessor()
        clean_text = processor.filter(text)
        x.append(one_hot_convert(clean_text))
        y.append(int(is_spam))
    return x,y

# task 23
# Создайте свой набор данных из оригинального корпуса текстов - http://spamassassin.apache.org/old/publiccorpus/.


x,y = add_data("20021010_spam.tar/20021010_spam/spam/", x, y, True)
x,y = add_data("20030228_easy_ham.tar/easy_ham/", x, y, False)
x = np.array(x)
y = np.array(y)




model = svm.SVC(kernel='rbf', C=1)
# x = array of one_hots
# y = array of 0 and 1(not_spam and spam)
model.fit(x, y)


def get_train_quality(Xval, model, yval):
    predicted = model.predict(Xval)
    error_count = 0
    for p, val in zip(predicted, yval.squeeze()):
        error_count += 1 if p != val else 0
    print("Quality: {}%".format(100 * (len(predicted) - float(error_count)) / len(predicted)))




Xval,yval = [], []
Xval,yval = add_data("20021010_spam.tar/20021010_spam/validate/", Xval, yval, True)
Xval,yval = add_data("20030228_easy_ham.tar/validate/", Xval, yval, False)

Xval = np.array(Xval)
yval = np.array(yval)

get_train_quality(Xval, model, yval)


# task 21
# Проверьте работу классификатора на письмах из файлов emailSample1.txt, emailSample2.txt, spamSample1.txt и spamSample2.txt.





# task 25
# Как изменилось качество классификации? Почему?
# изменилась в лучшую сторону потому что изначаьлная модель не настроена на спам


# C:\Users\Harwister\AppData\Local\Programs\Python\Python36\python.exe G:/Labs/bsuir-labs/11cem/ml/lab05/lab05-6.py
# C:\Users\Harwister\AppData\Local\Programs\Python\Python36\lib\site-packages\sklearn\externals\joblib\externals\cloudpickle\cloudpickle.py:47: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
#   import imp
#   0%|          | 0/6 [00:00<?, ?it/s]Checking file 20021010_spam.tar/20021010_spam/spam/0000.7b1b73cf36cf9dbc3d64e3f2ee2b91f1...
#  17%|█▋        | 1/6 [00:00<00:00,  8.55it/s]Checking file 20021010_spam.tar/20021010_spam/spam/0001.bfc8d64d12b325ff385cca8d07b84288...
# Checking file 20021010_spam.tar/20021010_spam/spam/0002.24b47bb3ce90708ae29d0aec1da08610...
# Checking file 20021010_spam.tar/20021010_spam/spam/0003.4b3d943b8df71af248d12f8b2e7a224a...
# Checking file 20021010_spam.tar/20021010_spam/spam/0004.1874ab60c71f0b31b580f313a3f6e777...
# Checking file 20021010_spam.tar/20021010_spam/spam/0005.1f42bb885de0ef7fc5cd09d34dc2ba54...
# 100%|██████████| 6/6 [00:00<00:00, 37.97it/s]
#   8%|▊         | 20/249 [00:01<00:39,  5.77it/s]issue with reading, skipping
#  32%|███▏      | 79/249 [00:05<00:15, 11.01it/s]issue with reading, skipping
# issue with reading, skipping
# issue with reading, skipping
# 100%|██████████| 249/249 [00:13<00:00, 18.59it/s]
# 100%|██████████| 1175/1175 [00:18<00:00,  6.16it/s]
# C:\Users\Harwister\AppData\Local\Programs\Python\Python36\lib\site-packages\sklearn\svm\base.py:196: FutureWarning: The default value of gamma will change from 'auto' to 'scale' in version 0.22 to account better for unscaled features. Set gamma explicitly to 'auto' or 'scale' to avoid this warning.
#   "avoid this warning.", FutureWarning)
# 100%|██████████| 252/252 [00:06<00:00, 41.43it/s]
# 100%|██████████| 1131/1131 [00:27<00:00, 40.61it/s]
# Quality: 88.72017353579176%
#
# Process finished with exit code 0
