import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm


# plt.style.use('dark_background')

# Task 1
data = pd.read_csv("ex1data1.txt", header=None, sep=",", names=['Popularity', 'Profit'])

print(data.sort_values(by="Profit"))

# Task 2
data.sort_values(by="Popularity").plot.scatter(x='Popularity', y='Profit', c='DarkBlue')
plt.grid()
plt.axis('equal')

x = range(0, 25, 1)
k = 1.5
b = -7
y = [i * k + b for i in x]
plt.plot(x, y, 'b-')

print("Therory function blue line f(x)=" + str(k) + "*x+" + str(b))

theroyes = [k * x_actual + b for x_actual in data.sort_values(by="Popularity").Popularity]

# plt.plot(data.sort_values(by="Popularity").Popularity,theroyes, 'bo' )

J = 0
for y_theory, y_actual in zip(theroyes, data.sort_values(by="Popularity").Profit):
    J += (y_theory - y_actual) ** 2
J /= 2 * len(theroyes)

# Task 3
print("Loss func J(theta)=" + str(round(J, 2)))

# Task 4


alpha = -0.01
tetha = [1, 0]
tetha_x = []
tetha_y = []
costs = []
iterations_count = 1015

def cost(k, b, x_actual, y_actual): # task - minimize cost
    theroyes = [k * x_i + b for x_i in x_actual]
    J = 0
    for y_theory, y_actual in zip(theroyes, y_actual):
        J += abs(y_theory - y_actual)
    return J

for i in tqdm(range(iterations_count)):
    theroyes = [tetha[0] * x_actual + tetha[1] for x_actual in data.sort_values(by="Popularity").Popularity]
    sum_diff_k = 0
    sum_diff_b = 0
    for y_theory, y_actual, x_actual in zip(theroyes, data.sort_values(by="Popularity").Profit,
                                            data.sort_values(by="Popularity").Popularity):
        sum_diff_k += (y_theory - y_actual) * x_actual * 2 / len(theroyes)
        sum_diff_b += 2 * (y_theory - y_actual) / len(theroyes)
    sum_diff_k *= alpha
    sum_diff_b *= alpha
    tetha = [tetha[0] + sum_diff_k, tetha[1] + sum_diff_b]
    tetha_x.append(tetha[0])
    tetha_y.append(tetha[1])
    costs.append(cost(tetha[0], tetha[1],data.sort_values(by="Popularity").Popularity,data.sort_values(by="Popularity").Profit))


print(tetha)
print(costs[-1])

x = range(0, 25, 1)
k = tetha[0]
b = tetha[1]
y = [i * k + b for i in x]
plt.plot(x, y, 'r-')

min_index = costs.index(min(costs))



x = range(0, 25, 1)
k = tetha_x[min_index]
b = tetha_y[min_index]
y = [i * k + b for i in x]
plt.plot(x, y, 'y-')

plt.show()
plt.plot(range(len(costs)),costs, 'ro')

plt.show()

# fig = plt.figure()
# ax = fig.gca(projection='3d')
# ax.set_xlabel('x')
# ax.set_ylabel('y')
# ax.set_zlabel('cost')

# print(np.array(tetha_x).shape, np.array(tetha_y).shape)
x, y = np.array([x for x in np.arange(-10.0,10.0, 0.2)]), np.array([y for y in np.arange(-10.0,10.0, 0.2)])

z = np.zeros(np.meshgrid(x, y)[0].shape)


#
for rowIndex in range(len(z)):
    for colIndex in range(len(z)):
        z[rowIndex][colIndex] = cost(x[rowIndex], y[colIndex], data.sort_values(by="Popularity").Popularity,data.sort_values(by="Popularity").Profit)

x, y = np.meshgrid(x, y)

fig = plt.figure()
ax = plt.axes(projection='3d')

ax.plot_surface(x, y, z, cmap='viridis', edgecolor='none')

plt.show()
# df = pd.DataFrame({'x': tetha_x, 'y': tetha_y, 'z': costs})
# surf = ax.plot_trisurf(df.x, df.y, df.z, linewidth=0.1)

fig = plt.figure()
ax = plt.axes(projection='3d')
cset = ax.contour(x,y,z)

plt.show()

fig, ax = plt.subplots()
CS = ax.contour(x,y,z)
ax.clabel(CS, inline=1, fontsize=10)

plt.show()

# fig = plt.figure()
# ax = fig.gca(projection='3d')
# ax.set_xlabel('x')
# ax.set_ylabel('y')
# ax.set_zlabel('cost')
#
#
# df = pd.DataFrame({'x': tetha_x, 'y': tetha_y, 'z': costs})
# # countour = ax.contour(df.x, df.y, df.z, cmap=cm.coolwarm)
# cset = ax.contour(df.x, df.y, df.z, zdir='z', offset=-100, cmap=cm.coolwarm)
#
# plt.show()
# rotate the axes and update
# for angle in range(0, 360):
#     ax.view_init(30, angle)
#     plt.draw()
#     plt.pause(.001)

