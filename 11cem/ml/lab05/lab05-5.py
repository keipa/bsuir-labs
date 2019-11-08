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

from bs4 import BeautifulSoup
import re
from nltk.stem import SnowballStemmer
from nltk.tokenize import sent_tokenize, word_tokenize


# task 17
# Реализуйте функцию предобработки текста письма

# import nltk #1.11.0
# nltk.download('punkt')
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

# task 18
# Загрузите коды слов из словаря vocab.txt.

# task 19
# Реализуйте функцию замены слов в тексте письма после предобработки на их соответствующие коды.

# task 20
# Реализуйте функцию преобразования текста письма в вектор признаков (в таком же формате как в файлах spamTrain.mat и spamTest.mat).

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


train_data = loadmat('data/spamTrain.mat')

x = train_data["X"]
y = train_data["y"]

test_data = loadmat('data/spamTest.mat')

x_test = test_data["Xtest"]
y_test = test_data["ytest"]

model = svm.SVC(kernel='rbf', C=1)

model.fit(x, y.squeeze())


def get_train_quality(Xval, model, yval):
    predicted = model.predict(Xval)
    error_count = 0
    for p, val in zip(predicted, yval.squeeze()):
        error_count += 1 if p != val else 0
    print("Quality: {}%".format(100 * (len(predicted) - float(error_count)) / len(predicted)))


# print("Train...")
# get_train_quality(x, model, y)

# print("Test...")
# get_train_quality(x_test, model, y_test)

# print(model.predict(x_test[:10]))
# print(y_test[:10].squeeze())

def spam_check(file_path, model):
    print("Checking file {}...".format(file_path))
    f = open(file_path, "r")
    text = f.read()
    processor = MailPreprocessor()
    clean_text = processor.filter(text)
    # print(clean_text)
    print("Spam: {}".format(model.predict(one_hot_convert(clean_text))[0] == 1))


# task 21
# Проверьте работу классификатора на письмах из файлов emailSample1.txt, emailSample2.txt, spamSample1.txt и spamSample2.txt.


spam_check("data/spamSample1.txt", model)
spam_check("data/spamSample2.txt", model)

spam_check("data/emailSample1.txt", model)
spam_check("data/emailSample2.txt", model)
# print(clf.predict(x_test[0]))


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


vector_to_message(x_test[0])

print("my examples")
# Также можете проверить его работу на собственных примерах.
print("Spam: {}".format(model.predict(one_hot_convert(vector_to_message(x_test[0])))[0] == 1))
my_spam="be below call charset citi commiss commun content do doe don each encod fight fill for form format from go here html httpaddr immedi in increas inform instead insur is iso it keep legal list mail messag mime more multi name nbsp new nextpart not notic now number numberbit numberdnumb or our out part payment per phone plain pleas premium printabl profession quot rang receiv remove"
print("Spam: {}".format(model.predict(one_hot_convert(my_spam))[0] == 1))





# task 23
# Создайте свой набор данных из оригинального корпуса текстов - http://spamassassin.apache.org/old/publiccorpus/.

# task 24
# Постройте собственный словарь.



# task 25
# Как изменилось качество классификации? Почему?
# изменилась в лучшую сторону потому что изначаьлная модель не настроена на спам





