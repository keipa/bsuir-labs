defaultConfig = {'m': 2 ** 32, 'k': 987654321, 'A0': 2}


def MultiplicativeCongruentialMethod(count, config=defaultConfig):
    A0, k, m = Init(config)
    A = [A0]
    for i in range(count):
        newItem = (k * A[i]) % m
        A.append(newItem)
    return [A[i] / float(m) for i in range(1, len(A))]


def Init(config):
    A0 = config['A0']
    k = config['k']
    m = config['m']
    return A0, k, m
