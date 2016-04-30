#!/usr/bin/python2.7

import numpy


def main():
    print("Start working")
    A = numpy.array([[42.18, 4.32, 3.85], [5.31, 41.32, 1.52], [3.49, 4.85, 34.32]], "f")
    b = numpy.array([[40.21], [10.24], [12.82]], "f")
    c = numpy.array([[0], [0], [0]], "f")
    B = numpy.array([[0, 0, 0], [0, 0, 0], [0, 0, 0]], "f")
    x = numpy.zeros((3, 1))
    y = numpy.zeros((3, 1))
    e = 0.00001

    for i in range(len(A)):
        c[i] = b[i] / A[i][i]
        for j in range(len(A)):
            B[i][j] = -A[i][j] / A[i][i]

        B[i][i] = 0

    print (B)
    print( c)

    maxx = [0, 0, 0]
    for i in range(len(A)):
        for j in range(len(A)):
            maxx[i] = maxx[i] + abs(B[i][j])

    print (max(maxx))

    xk = numpy.zeros((3, 1))
    xk = c
    x = numpy.dot(B, xk) + c
    count1 = 0
    while abs(max((x - xk).flatten())) > e:
        xk = x
        x = numpy.dot(B, xk) + c
        count1 += 1

    print (x)
    print (count1)

    yk = numpy.zeros((3, 1))
    yk = c
    y = numpy.dot(B, yk) + c
    count2 = 0
    while abs(max((y - yk).flatten())) > e:
        yk = y
        for i in range(len(A)):
            y[i] = 0
            for j in range(i - 1):
                y[i] = y[i] + B[i][j] * y[j]

            for j in range(i - 1, len(A)):
                y[i] = y[i] + B[i][j] * yk[j]

            y[i] = y[i] + c[i]

        count2 += 1

    print( y)
    print (count2)

if __name__ == "__main__":
    main()
