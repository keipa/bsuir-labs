


def niter(iterate, n):
    if not hasattr(iterate, "__iter__"):
        raise TypeError("send me iter")
    futer = [iterate for _ in range(n)]


    return tuple(futer)



if __name__ == '__main__':
    a = range(10)
    a.step = 5
    print(niter(a, 5))
    niter(10,5)