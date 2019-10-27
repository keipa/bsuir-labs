import pandas as pd
import matplotlib.pyplot as plt

# Task 1
data = pd.read_csv("lab1/ex1data1.txt", header=None, sep=",", names=['Popularity', 'Profit'])

print(data.sort_values(by="Profit"))

# Task 2
data.sort_values(by="Popularity").plot.scatter(x='Popularity', y='Profit', c='DarkBlue')
plt.grid()
plt.axis('equal')

x = range(0,25,1)
k = 1.5
b = -7
y = [i*k+b for i in x]
plt.plot(x, y, 'b-')

print("Therory function blue line f(x)=" + str(k) + "*x+" + str(b))

theroyes = [k*x_actual+b for x_actual in data.sort_values(by="Popularity").Popularity]

# plt.plot(data.sort_values(by="Popularity").Popularity,theroyes, 'bo' )

J = 0
for y_theory, y_actual in zip(theroyes,data.sort_values(by="Popularity").Profit):
    J += (y_theory - y_actual)**2
J /= 2 * len(theroyes)

# Task 3
print("Loss func J(theta)="+str(round(J,2)))


plt.show()
