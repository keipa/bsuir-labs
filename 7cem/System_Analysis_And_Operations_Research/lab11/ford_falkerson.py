from numpy import inf, isinf
import Queue

class FordFalkersonSolver(object):
  def add_values(self, i, j, c, x):
    self.g[i].append(len(self.edges))
    self.edges.append([i, j, c, x])

  def create_graph(self, inp):
    for i, j, c in inp:
      self.add_values(i, j, c, 0)
      self.add_values(j, i, 0, 0)

  def __init__(self, inp, n, s, t):
    self.n = n
    self.g = [[] for _ in range(n)]
    self.edges = []
    self.create_graph(inp)
    self.s = s
    self.t = t
    self.flow = 0

  def dfs(self, v):
    for index in self.g[v]:
      if self.used[self.t]:
        return
      i, j, c, x = self.edges[index]
      if not self.used[j] and c - x > 0:
        self.used[j] = True
        self.edges_in_increasing_path.append(index)
        self.i_ast.append(index)
        self.dfs(j)
        if self.used[self.t]:
          return
        self.edges_in_increasing_path.pop()
        self.used[j] = False

  def set_min_cut(self):
    self.min_cut = inf
    for index in self.edges_in_increasing_path:
      i, j, c, x = self.edges[index]
      self.min_cut = min(self.min_cut, c - x)
    self.flow += self.min_cut

  def create_increasing_path(self):
    self.used = [False for _ in range(self.n)]
    self.edges_in_increasing_path = []
    self.i_ast = []
    self.used[0] = True
    self.dfs(0)

  def change_flow(self):
    for index in self.edges_in_increasing_path:
      self.edges[index][3] += self.min_cut
      self.edges[index^1][3] -= self.min_cut

  def solve(self):
    while True:
      self.create_increasing_path()
      if not self.used[self.t]:
        return self
      self.set_min_cut()
      self.change_flow()

  def get_x(self):
    return [x for index, [i, j, c, x] in enumerate(self.edges) if index % 2 == 0]

if __name__ == '__main__':
  inp = [
    [0, 1, 4],
    [0, 3, 9],
    [1, 3, 2],
    [1, 4, 4],
    [2, 4, 1],
    [2, 5, 10],
    [3, 2, 1],
    [3, 5, 6],
    [4, 5, 1],
    [4, 6, 2],
    [5, 6, 9]
  ]
  s = 0
  t = 6
  n = 7
  print FordFalkersonSolver(inp, n, s, t).solve().flow()