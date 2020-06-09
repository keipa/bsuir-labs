def encrypt(key, path):
    data = path.open('r').read()


def form_dict():
    d = {}
    iter = 0
    for i in range(0, 127):
        d[iter] = chr(i)
        iter = iter +1
    return d

print(form_dict())


