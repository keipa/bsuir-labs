import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("lab1/ex1data1.txt", header=None, sep=",", names=['Popularity', 'Profit'])

# print(data)
# print(len(data))

# print(data[0].value_counts())
# print(data[1].value_counts())
print(data.sort_values(by="Profit"))

# data.plot.bar()

data.sort_values(by="Popularity").plot.line(x='Popularity', y='Profit', c='DarkBlue')
plt.show()