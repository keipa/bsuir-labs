from numpy import inf, isinf, zeros
import copy


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
    self.g = copy.deepcopy(g)
    self.n = len(g[0])
    self.p = [[i for i in range(self.n)] for _ in [i for i in range(self.n)]]
  @benchmark
  def solve(self):
    for k in range(self.n):
      for i in range(self.n):
        if not self.g == inf:
            for j in range(self.n):
              if self.g[i][k] < inf and self.g[k][j] < inf:
                if self.g[i][j] > self.g[i][k] + self.g[k][j]:
                  self.g[i][j] = self.g[i][k] + self.g[k][j]
                  self.p[i][j] = self.p[i][k]
    return self




g = [
  [0, 9, inf, 3, inf, inf ,inf ,inf],
  [9, 0, 2, inf, 7, inf, inf, inf],
  [inf, 2, 0, 2, 4, 8, 6, inf],
  [3, inf, 2, 0, inf, inf, 5, inf],
  [inf, 7, 4, inf, 0, 10, inf, inf],
  [inf, inf, 8, inf, 10, 0, 7, inf],
  [inf, inf, 6, 5, inf, 7, 0, inf],
  [inf, inf, inf, inf, 9, 12, 10, 0]
]
res = FloydSolver(g).solve()
pretty(res.g)
print('-'*20)
pretty(res.p)
