import matplotlib

matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np

plt.style.use('classic')
plt.style.use('seaborn-whitegrid')
data = np.random.multivariate_normal([0, 0], [[43, 2], [5, 1.2]], size=25000)
data = pd.DataFrame(data, columns=['x', 'y'])
with sns.axes_style('white'):
    sns.jointplot("x", "y", data, kind='kde')

plt.show()