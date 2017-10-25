from numpy import *

class SimplexMethodSolver(object):
  def __init__(self, A, b, c, x = None, basicIndexes = None, nonBasicIndexes = None):
    self.A = A
    self.b = b
    self.c = c
    self.x = x
    self.m, self.n = A.shape
    self.basicIndexes = basicIndexes
    self.nonBasicIndexes = nonBasicIndexes
    self.eps = finfo(float).eps

  def is_zero(self, value):
    return abs(value) < self.eps

  def normalize(self):
    if (self.b < 0).any():
      indexes = self.b < 0
      self.b[indexes] *= -1
      self.A[indexes, :] *= -1

  def first_phase(self):
    self.normalize()
    new_A = append(self.A.transpose(), eye(self.m, dtype=float64), axis = 0).transpose()
    x = append(zeros(self.n, dtype=float64), self.b)
    c = append(zeros(self.n, dtype=float64), -ones(self.m, dtype=float64))
    
    nonBasicIndexes = [i for i in range(self.n)]
    basicIndexes = [i for i in range(self.n, self.n + self.m)]

    J = set(nonBasicIndexes)
    Ju = set(basicIndexes)
  
    result_x = self.second_phase(new_A, self.b, c, x, basicIndexes, nonBasicIndexes)
    
    if not (abs(result_x[-self.m:]) < self.eps).all():
      raise Exception("This task has no solution, because her restrictions is not compatible")

    B = linalg.inv(new_A[:, basicIndexes])
    lost_indexes = list(J - set(basicIndexes))

    while True:
      if not set(basicIndexes) & set(Ju):
        lJ = list(J)
        self.A = new_A[:, lJ]
        self.c = self.c[lJ]
        self.x = result_x[lJ]
        self.basicIndexes = [lJ.index(el) for el in basicIndexes]
        self.nonBasicIndexes = [i for i in lJ if i not in self.basicIndexes]
        return self

      jk = (set(basicIndexes) & set(Ju)).pop()
      k = jk - self.n
      ek = eye(self.m)[:, k]

      tmp = dot(ek, B)
      alpha = dot(tmp, new_A[:, lost_indexes])
      
      if not (abs(alpha) < self.eps).all():
        s = list(abs(alpha) > self.eps).index(True)
        js = lost_indexes[s]
        basicIndexes[k] = js
      else:
        del basicIndexes[k]
        Ju.remove(jk)
        new_A = delete(new_A, k, axis=0)
        self.b = delete(self.b, k)
        B = delete(B, k, axis=0)
        B = delete(B, k, axis=1)
        self.m -= 1

  def get_index(self, a, el):
    try:
      return a.index(el)
    except ValueError:
      return -1

  def change_B(self, z, s, m):
    zk = z[s]
    z[s] = -1
    z /= -zk
    M = eye(m)
    M[:, s] = z
    self.B = dot(M, self.B)

  def second_phase(self, A, b, c, x, basicIndexes, nonBasicIndexes):
    m, n = A.shape
    basic_a = A[:, basicIndexes]
    self.B = linalg.inv(basic_a)
    while True:
      basic_c = array([c[i] for i in basicIndexes])

      #Create potential and estimate vectors
      u = dot(basic_c, self.B)
      delta = array(subtract(dot(u, A), c))

      k = self.get_index([delta[j] < 0 and not self.is_zero(delta[j]) for j in nonBasicIndexes], True)
      if not ~k:
        return x
      j0 = nonBasicIndexes[k]

      z = dot(self.B, A[:, j0])

      if all(z <= self.eps):
        raise ValueError("This task has no solution, because her target function is not limited at plans set")

      basic_x = x[basicIndexes]
      rangem = [i for i in range(m)]
      tetta = [basic_x[j] / z[j] if z[j] > 0 and not self.is_zero(z[j]) else inf for j in rangem]
      tetta0 = min(tetta)
      s = self.get_index(tetta, tetta0)
      index_tetta0 = basicIndexes[s]

      for i, j in enumerate(basicIndexes):
        x[j] = x[j] - tetta0 * z[i] 
      x[j0] = tetta0

      basicIndexes[s] = j0
      basic_a[:, s] = A[:, j0]
      self.change_B(z, s, m)

      nonBasicIndexes[k] = index_tetta0


  def solve(self):
    if self.x is None:
      self.first_phase()
    self.x = self.second_phase(self.A, self.b, self.c, self.x, self.basicIndexes, self.nonBasicIndexes)
    return self 

if __name__ == '__main__':
  #Variant #2
  a = array([
      [0.0, 1.0, 1.0, 1.0, 0.0, -8.0, 1.0, 5.0],
      [0.0, -1.0, 0.0, -7.5, 0.0, 0.0, 0.0, 2.0],
      [0.0, 2.0, 1.0, 0.0, -1.0, 3.0, -1.4, 0.0],
      [1.0, 1.0, 1.0, 1.0, 0.0, 3.0, 1.0, 1.0],
      [1.0, 1.0, 1.0, 1.0, 0.0, 3.0, 1.0, 1.0]
  ])
  b = array([15.0, -45.0, 1.8, 19.0, 19.0])
  c = array([-6.0, -9.0, -5.0, 2.0, -6.0, 0.0, 1.0, 3.0])

  x = array([4.0, 0.0, 6.0, 6.0, 0.0, 0.0, 3.0, 0.0])

  basicIndexes = [0, 2, 3, 6]
  nonBasicIndexes = [1, 4, 5, 7]

  res = SimplexMethodSolver(a, b, c).solve()
  print(res.x)
  print(res.basicIndexes)


