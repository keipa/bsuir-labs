import unittest

from numpy import *

import lab08_27
import lab08


class OptimalControl(unittest.TestCase):
    # example 1
    def test1(self):
        D = array([[5, 0, 9],
                   [0, 1, 0],
                   [9, 0, 17]])

        A = array([[-1, 1, 0],
                   [0, 0, 1],
                   [0, -1, 0]])

        b = array([0, 0, 1])
        c = array([-1.5, 0.5, -1])
        x = array([-5, -4, -3])
        H = array([1, 1, 1])
        g = array([-6.5139])
        t0 = 0.
        t1 = 6.
        lab08.alg(D, A, b, c, x, H, g, t0, t1)


    # task 2
    def test2(self):
        t0 = 0.
        t1 = 10.
        D = array([[5, 0, 9],
                   [0, 1, 0],
                   [9, 0, 17]])

        A = array([[0, 1, 0],
                   [0, 0, 1],
                   [0, 0, 0]])

        b = array([0, 0, 1])
        c = array([1, 0.5, -1])
        x = array([-5, -4, -3])
        H = array([[1, 0, 1],
                   [1, 0, -1]])
        g = array([-198.0, -192.0])

        lab08_27.optimalControl(D, A, b, c, x, H, g, t0, t1)

    # example 1
    def test3(self):
        D = array([[1, 0, 0],
                   [0, 1, 0],
                   [0, 0, 1]])

        A = array([[-1, 1, 0],
                   [0, 0, 1],
                   [0, -1, 0]])

        b = array([0, 0, 1])
        c = array([0, 1, 0])
        x = array([1, -1, 3])
        H = array([[1, 0, 1],
                   [1, -1, 0]])
        g = array([0.3916, -0.3916])
        t0 = 0.
        t1 = 5.
        lab08_27.optimalControl(D, A, b, c, x, H, g, t0, t1)






