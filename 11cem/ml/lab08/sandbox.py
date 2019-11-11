import matplotlib.pyplot as plt
import seaborn as sns
from scipy.io import loadmat


data = loadmat("data/ex8data1.mat")
X = data["X"]


with sns.axes_style('white'):
    sns.jointplot(X[:,0],X[:,1]).plot_joint(sns.kdeplot)

plt.show()