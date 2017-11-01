from numpy import inf, copy
from lab10 import *
from lab11.lab10 import *
from functools import reduce

def load_matrix(file_name):
    matrix = []
    with open(file_name, 'r') as fin:
        for line in fin:
            matrix.append(list(map(float, line.split())))
    return matrix

class Comivoyager(object):
  def __init__(self, c):
    self.c = c
    self.n = len(c[0])
    self.r = reduce(lambda s, x: s + x, [c[i][i+1] for i in range(self.n - 1)]) + c[self.n - 1][0]
    self.plan = list(range(self.n)).append(0)

  def calculate_plan(self, res):
    return reduce(lambda s, x: s + x, [self.c[i][res[i]] for i in range(self.n)])

  def dfs(self, v):
    self.used[v] = True
    self.components[self.comp_index].append((v, self.assigment_problem_res[v]))
    if not self.used[self.assigment_problem_res[v]]:
      self.dfs(self.assigment_problem_res[v])

  def create_components(self):
    self.used = [False for _ in range(self.n)]
    self.components = []
    self.comp_index = 0
    for i in range(self.n):
      if not self.used[i]:
        self.components.append([])
        self.dfs(i)
        self.comp_index += 1

  def branch_and_bound(self):
    self.assigment_problem_res = MatchSolve(copy(self.c)).solve()
    r = self.calculate_plan(self.assigment_problem_res)
    if r >= self.r:
      return
    self.create_components()

    if len(self.components) == 1:
      self.plan = [c[0] for c in self.components[0]]
      self.plan.append(0)
      self.r = r
    else:
      for component in self.components:
        for i, j in component:
          cij = self.c[i][j]
          self.c[i][j] = inf
          self.branch_and_bound()
          self.c[i][j] = cij

  def solve(self):
    self.branch_and_bound()
    return self



c = load_matrix('11')
res = Comivoyager(c).solve()
print(res.plan)
print(res.r)