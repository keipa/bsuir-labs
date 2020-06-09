import unittest

from numpy import *

import lab2


class DoubleSimplexTest(unittest.TestCase):
    # пример 1 из книги
    def test1(self):
        m = 3
        n = 8
        c = array([2.0, 2.0, 1.0, -10.0, 1.0, 4.0, -2.0, -3.0])
        b = array([-2.0, 4.0, 3.0])
        A = array([  # массив условий
            [-2.0, -1.0, 1.0, -7.0, 0.0, 0.0, 0.0, 2.0],
            [4.0, 2.0, 1.0, 0.0, 1.0, 5.0, -1.0, -5.0],
            [1.0, 1.0, 0.0, -1.0, 0.0, 3.0, -1.0, 1.0],
        ])
        J = array([2, 5, 7])
        y = array([1.0, 1.0, 1.0])
        small_delta = array([1.0, 0.0, 1.0, 2.0, 0.0, 4.0, 0.0, 1.0])

        correct_result = ([0, 2.666666666666667, 0, 0, 0.33333333333333393, 0, 0, 0.33333333333333337], 3)

        assert correct_result == lab2.double_simplex(m, n, c, b, A, J, y, small_delta)

    # пример 2 из книги(с ошибкой)
    def test2(self):
        m = 3
        n = 8
        c = array([2.0, 2.0, 1.0, -10.0, 1.0, 4.0, -2.0, -3.0])
        b = array([-2.0, 4.0, 3.0])
        A = array([  # массив условий
            [-2.0, -1.0, 1.0, -7.0, 0.0, 0.0, 0.0, 2.0],
            [4.0, 2.0, 1.0, 0.0, 1.0, 5.0, -1.0, -5.0],
            [1.0, 1.0, 0.0, -1.0, 0.0, 3.0, -1.0, 1.0],
        ])
        J = array([2, 5, 7])
        y = array([1.0, 1.0, 1.0])
        small_delta = array([1.0, 0.0, 1.0, 4.0, 0.0, 4.0, 0.0, 1.0])

        correct_result = -1

        assert correct_result == lab2.double_simplex(m, n, c, b, A, J, y, lab2.make_small_delta(c, A, y))

    # самостоятельная задача1
    def test3(self):
        m = 3
        n = 8
        A = array([
            [-2.0, -1.0, 1.0, -7.0, 0.0, 0.0, 0.0, 2.0],
            [4.0, 2.0, 1.0, 0.0, 1.0, 5.0, -1.0, -5.0],
            [1.0, 1.0, 0.0, -1.0, 0.0, 3.0, -1.0, 1.0]
        ])
        b = array([-2.0, -4.0, -2.0])
        c = array([5.0, 2.0, 3.0, -16.0, 1.0, 3.0, -3.0, -12.0])
        y = array([1.0, 2.0, -1.0])
        J = array([1, 2, 3])
        correct_result = ([0, 0, 0, 0.40000000000000002, 0, 0, 2.0000000000000004, 0.39999999999999997], 4)
        assert correct_result == lab2.double_simplex(m, n, c, b, A, J, y, lab2.make_small_delta(c, A, y))


        # самостоятельная задача2

    def test4(self):
        m = 3
        n = 8
        A = array([
            [-2.0, -1.0, 1.0, -7.0, 1.0, 0.0, 0.0, 2.0],
            [-4.0, 2.0, 1.0, 0.0, 5.0, 1.0, -1.0, 5.0],
            [1.0, 1.0, 0.0, -1.0, 0.0, 3.0, -1.0, 1.0]
        ])
        b = array([-2.0, 4.0, -2.0])
        c = array([-12.0, 2.0, 2.0, -6.0, 10.0, -1.0, -9.0, 8.0])
        y = array([1.0, 2.0, -1.0])
        J = array([2, 4, 6])
        correct_result = ([0, 0, 5.0, 1.0, 0, 0, 1.0, 0], 4)
        assert correct_result == lab2.double_simplex(m, n, c, b, A, J, y, lab2.make_small_delta(c, A, y))

        # самостоятельная задача3

    def test5(self):
        m = 3
        n = 8
        A = array([
            [-2.0, -1.0, 1.0, -7.0, 1.0, 0.0, 0.0, 2.0],
            [-4.0, 2.0, 1.0, 0.0, 5.0, 1.0, -1.0, 5.0],
            [1.0, 1.0, 0.0, 1.0, 4.0, 3.0, 1.0, 1.0]
        ])
        b = array([-2.0, 8.0, -2.0])
        c = array([12.0, -2.0, -6.0, 20.0, -18.0, -5.0, -7.0, -20.0])
        y = array([-3.0, -2.0, -1.0])
        J = array([2, 4, 6])
        correct_result = 1

        assert correct_result == lab2.double_simplex(m, n, c, b, A, J, y, lab2.make_small_delta(c, A, y))


if __name__ == "__main__":
    unittest.main()
