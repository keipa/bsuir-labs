import pandas as pd
import matplotlib.pyplot as plt
from tqdm import tqdm

# Task 1
data = pd.read_csv("lab1/ex1data1.txt", header=None, sep=",", names=['Popularity', 'Profit'])

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


alpha = -0.0001
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
