from numpy import inf, isinf

from ford_falkerson import FordFalkersonSolver


class AssignmentProblemSolver(object):
  def __init__(self, c):
    self.c = c
    self.n = len(c[0])

  def change_rows(self):
    for i in range(self.n):
      m = min(self.c[i])
      if isinf(m):
        raise ValueError("The restriction are not compatible")
      self.c[i] = [self.c[i][j] - m for j in range(self.n)]

  def change_columns(self):
    for i in range(self.n):
      m = min(self.c[j][i] for j in range(self.n))
      if isinf(m):
        raise ValueError("The restriction are not compatible")
      for j in range(self.n):
        self.c[j][i] -= m

  def change_c(self):
    self.change_rows()
    self.change_columns()

  def create_u1(self):
    for i in xrange(1, self.n + 1):
      self.net.append([0, i, 1])
  def create_u_ast(self):
    for i in xrange(self.n + 1, 2*self.n + 1):
      self.net.append([i, 2*self.n + 1, 1])

  def create_u0(self):
    for i in xrange(self.n):
      for j in xrange(self.n):
        if self.c[i][j] == 0:
          self.net.append([i + 1, j + 1 + self.n, inf])

  def create_net(self):
    self.net = []
    self.create_u1()
    self.create_u_ast()
    self.create_u0()

  def create_answer(self):
    self.ans = [0 for _ in xrange(self.n)]
    for i, j, c, x in self.max_flow.edges:
      if i in xrange(1, self.n + 1) and j in xrange(self.n + 1, 2 * self.n + 1) and x==1:
        self.ans[i - 1] = j - self.n - 1
    return self.ans

  def create_N(self):
    self.N1 = set([])
    self.N2 = set([])
    for index in self.max_flow.i_ast:
      i, j, c, x = self.max_flow.edges[index]
      for var in [i, j]:
        if var == 0:
          continue
        if var > self.n:
          self.N2.add(var - self.n - 1)
        else:
          self.N1.add(var - 1)

  def calculate_alpha(self):
    self.alpha = inf
    for i in self.N1:
      for j in xrange(self.n):
        if j not in self.N2 and self.c[i][j] < self.alpha:
          self.alpha = self.c[i][j]

  def add_alpha_to_c(self):
    for i in xrange(self.n):
      for j in xrange(self.n):
        if i in self.N1 and j not in self.N2:
          self.c[i][j] -= self.alpha
        elif i not in self.N1 and j in self.N2:
          self.c[i][j] += self.alpha

  def solve(self):
    self.change_c()
    while True:
      self.create_net()
      s, t, size = 0, 2* self.n + 1, 2*self.n + 2
      self.max_flow = FordFalkersonSolver(self.net, size, s, t).solve()
      if self.max_flow.flow == self.n:
        return self.create_answer()
      self.create_N()
      self.calculate_alpha()
      self.add_alpha_to_c()

if __name__ == '__main__':
  c = [
    [2, 10, 9, 7],
    [15, 4, 14, 8],
    [13, 14, 16, 11],
    [4, 15, 13, 19]
  ]
  print AssignmentProblemSolver(c).solve()
