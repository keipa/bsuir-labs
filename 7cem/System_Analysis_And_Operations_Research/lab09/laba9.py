from numpy import inf, isinf, zeros
import copy

class FloydSolver(object):
  def __init__(self, g):
    self.g = copy.deepcopy(g)
    self.n = len(g[0])
    self.p = [[i for i in range(self.n)] for _ in [i for i in range(self.n)]]

  def solve(self):
    for k in range(self.n):
      for i in range(self.n):
        for j in range(self.n):
          if (self.g[i][k] < inf and self.g[k][j] < inf):
            if self.g[i][j] > self.g[i][k] + self.g[k][j]:
              self.g[i][j] = self.g[i][k] + self.g[k][j]
              self.p[i][j] = self.p[i][k]
    return self

if __name__=='__main__':
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
  print(res.g)
  print(res.p)