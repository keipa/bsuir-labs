from numpy import inf, isinf, zeros
import copy


def inputValues(file_name):
    matrix = []
    with open(file_name, 'r') as fin:
        for line in fin:
            matrix.append(list(map(float, line.split())))
    return matrix


def pretty(matrix):
    s = [[str(e) for e in row] for row in matrix]
    lens = [max(map(len, col)) for col in zip(*s)]
    fmt = '\t'.join('{{:{}}}'.format(x) for x in lens)
    table = [fmt.format(*row) for row in s]
    print('\n'.join(table))


def benchmark(func):
    import time
    def wrapper(*args, **kwargs):
        start_time = int(round(time.time() * 1000))
        res = func(*args, **kwargs)
        print("--- {0} milliseconds ---".format(int(round(time.time() * 1000)) - start_time))
        return res

    return wrapper


class FloydSolver(object):
    def __init__(self, g):
        self.weight_map = copy.deepcopy(g)
        self.n = len(g[0])
        self.history_map = [[i for i in range(self.n)] for _ in [i for i in range(self.n)]]

    @benchmark
    def solve(self):
        for k in range(self.n):
            for i in range(self.n):
                if not self.weight_map == inf:
                    for j in range(self.n):
                        if self.weight_map[i][k] < inf and self.weight_map[k][j] < inf:
                            if self.weight_map[i][j] > self.weight_map[i][k] + self.weight_map[k][j]:
                                self.weight_map[i][j] = self.weight_map[i][k] + self.weight_map[k][j]
                                self.history_map[i][j] = self.history_map[i][k]
        return self


g = inputValues('09')
res = FloydSolver(g).solve()
pretty(res.weight_map)
print('-' * 20)
pretty(res.history_map)
