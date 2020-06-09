import numpy as np
import sys
from lab_8 import ford_fulkerson


def load_matrix(file_name):
    matrix = []
    with open(file_name, 'r') as fin:
        for line in fin:
            matrix.append(list(map(int, line.split())))

    return np.array(matrix)


def first_reduction_of_matrix(matrix):
    n, m = matrix.shape

    for i in range(n):
        matrix[i, :] -= min(matrix[i, :])
    for i in range(m):
        matrix[:, i] -= min(matrix[:, i])

    return matrix


def second_reduction_of_matrix(matrix):
    n, m = matrix.shape
    del_x, del_y = [], []

    # наибольшее
    temp_matrix = np.zeros(matrix.shape)
    for i in range(n):
        for j in range(n):
            if matrix[i, j] == 0:
                temp_matrix[i, j] = 1

    # максимальное
    while True:
        x, y = np.array([0] * n), np.array([0] * n)

        for i in range(n):
            x[i] = sum(temp_matrix[i, :])
        for i in range(n):
            y[i] = sum(temp_matrix[:, i])

        arg_max_x, arg_max_y = np.argmax(x), np.argmax(y)
        if x[arg_max_x] == 0 and y[arg_max_y] == 0:
            break

        if x[arg_max_x] >= y[arg_max_y]:
            del_x.append(arg_max_x)
            for i in range(n):
                if temp_matrix[arg_max_x, i] == 1:
                    temp_matrix[arg_max_x, i] = 0
        else:
            del_y.append(arg_max_y)
            for i in range(n):
                if temp_matrix[i, arg_max_y] == 1:
                    temp_matrix[i, arg_max_y] = 0

    min_elem = np.min(matrix[list(set(range(n)) - set(del_x))][:, list(set(range(n)) - set(del_y))])
    alpha_conversion(del_x, del_y, matrix, min_elem, n)

    return matrix


def alpha_conversion(del_x, del_y, matrix, min_elem, n):
    for i in list(set(range(n)) - set(del_x)):
        for j in list(set(range(n)) - set(del_y)):
            matrix[i, j] -= min_elem
    for i in del_x:
        for j in del_y:
            matrix[i, j] += min_elem


def solve(matrix_c):
    n, m = matrix_c.shape
    matrix = first_reduction_of_matrix(matrix_c.copy())

    while True:
        c = np.zeros((2 * n + 2, 2 * n + 2))
        c[2 * n, :n] = 1
        c[n:2 * n, 2 * n + 1] = 1
        for i in range(n):
            for j in range(n):
                if matrix[i, j] == 0:
                    c[i, j + n] = 1

        f, v = ford_fulkerson(c, 2 * n, 2 * n + 1)  # если фалкерсон даёт совершенное, то заканчиваем итерецию
        if v == n:
            ans, cost = [], 0
            cost = PrepareAnswer(ans, cost, f, matrix_c, n)
            return ans, cost
        else:
            matrix = second_reduction_of_matrix(matrix)


def PrepareAnswer(ans, cost, f, matrix_c, n):
    for i in range(n):
        for j in range(n):
            if f[i, j + n] == 1:
                ans.append((i, j))
                cost += matrix_c[i, j]
    return cost


matrix = load_matrix('10')
ans, cost = solve(matrix)
for i, j in ans:
    print(i, '->', j)
print('cost =', cost)
