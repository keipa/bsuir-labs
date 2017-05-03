# -*- coding: utf-8 -*-
from numpy import *
import scipy.optimize as opt





def convex(df, dg_I0, d_down, d_up, b):

    l = opt.linprog(df, A_eq=dg_I0, b_eq=b, bounds=zip(d_down, d_up))
    f = -l.fun
    print f
    print l.x
    print l.success
    print l.status





df = array([2.0,5.0,-1.0,-1.0,3.0,4.0,5.0,0.0])
d_down = array([0.0,0.0,-1.0,-1.0,-1.0,-1.0,-1.0,0.0])
d_up = array([6.0,5.0,6.0, 4.0,6.0,5.0,5.0,7.0])

A = array([
    [1.0, 3.0, 6.0, 1.0, 0.0, 0.0, -6.0, 2.0],
    [0.0, -2.0, 3.0, 4.0, 0.0, 1.0, 4.0, -1.0],
    [1.0, 1.0, -1.0, 3.0, 1.0, 0.0, 3.0, 4.0],


])
b =  A.dot(df)
c = array([2.0, -1.0, 3.0, -4.0, -3.0, 6.0, 6.0, -2.0])
convex(-c, A, d_down, d_up, b)
print 5
print [4,6,-1]
print array([2, 6 ,8])
print [1,0,40, 29, 2, 0, -9 , 0]