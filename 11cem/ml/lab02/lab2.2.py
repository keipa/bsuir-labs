# -*- coding: utf-8 -*-

import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from matplotlib.animation import FuncAnimation



plt.grid()
plt.axis('equal')
# task 7
# Загрузите данные ex2data2.txt из текстового файла.

df = pd.read_csv("data/ex2data2.txt", header=None, sep=",", names=['Test1', 'Test2', 'IsTestPassed'])
normalized_data = (df - df.min()) / (df.max() - df.min())

# task 8
# Постройте график, где по осям откладываются результаты тестов, а точки обозначаются двумя разными маркерами в зависимости от того, прошло ли изделие контроль или нет.

failedTestResults = normalized_data[normalized_data['IsTestPassed'] == 0]
passedTestResults = normalized_data[normalized_data['IsTestPassed'] == 1]
plt.plot(failedTestResults.Test1, failedTestResults.Test2, 'ro')
plt.plot(passedTestResults.Test1, passedTestResults.Test2, 'go')
plt.show()


# task 9
# Постройте все возможные комбинации признаков x1 (результат первого теста) и x2 (результат второго теста), в которых степень полинома не превышает 6, т.е. 1, x1, x2, x12, x1x2, x22, …, x1x25, x26 (всего 28 комбинаций).
#
# task 10
# Реализуйте L2-регуляризацию для логистической регрессии и обучите ее на расширенном наборе признаков методом градиентного спуска.
#
# task 11
# Реализуйте другие методы оптимизации.
#
# task 12
# Реализуйте функцию предсказания вероятности прохождения контроля изделием в зависимости от результатов тестов.
#
# task 13
# Постройте разделяющую кривую, полученную в результате обучения модели. Совместите прямую с графиком из пункта 7.
#
# task 14
# Попробуйте различные значения параметра регуляризации λ. Как выбор данного значения влияет на вид разделяющей кривой? Ответ дайте в виде графиков.



