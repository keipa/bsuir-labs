import numpy as np
import matplotlib.pyplot as plt

plt.axis([0, 100, 0, 1])
# plt.ion()

for i in range(100):
    y = np.random.random()
    plt.scatter(i, y, marker="^")

    plt.axhline(y=0.2, xmin=0, xmax=1, c="blue", linewidth=0.5, zorder=1)

    plt.bar(i, y, 1, color='red')
    plt.pause(0.05)



# while True:
#     plt.pause(0.05)
