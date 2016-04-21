def benchmark(func):
    """
    Декоратор, выводящий время, которое заняло
    выполнение декорируемой функции.
    """
    #import time
    #startTime = time.
    from datetime import datetime

    def wrapper(*args, **kwargs):
        t = datetime.utcnow()
        print(t)
        # t = time.clock()
        # startTime = time.time()
        res = func(*args, **kwargs)
        k = datetime.utcnow()
        print(k)
        t = k - t
        print(t)
        # print(func.__name__, time.clock() - t , "Elapsed time: {:.3f} sec".format(time.time() - startTime))
        print(func.__name__, "Elapsed time: {:.3f} sec".format(t.total_seconds()))
        return res
    return wrapper


def logging(func):
    """
    Декоратор, логирующий работу кода.
    (хорошо, он просто выводит вызовы, но тут могло быть и логирование!)
    """
    def wrapper(*args, **kwargs):
        res = func(*args, **kwargs)
        print(func.__name__, args, kwargs)
        return res
    return wrapper


def counter(func):
    """
    Декоратор, считающий и выводящий количество вызовов
    декорируемой функции.
    """
    def wrapper(*args, **kwargs):
        wrapper.count += 1
        res = func(*args, **kwargs)
        print("{0} была вызвана: {1}x".format(func.__name__, wrapper.count))
        return res
    wrapper.count = 0
    return wrapper


@benchmark
def reverse_string(string):
    return 2**10000000

reverse_string("А роза упала на лапу Азора")

# выведет:
# reverse_string ('А роза упала на лапу Азора',) {}
# wrapper 0.0
# reverse_string была вызвана: 1x
# арозА упал ан алапу азор А
# reverse_string ('A man, a plan, a canoe, pasta, heros, rajahs, a coloratura, maps, snipe, percale, macaroni, a gag, a banana bag, a tan, a tag, a banana bag again (or a camel), a crepe, pins, Spam, a rut, a Rolo, cash, a jar, sore hats, a peon, a canal: Panama!',) {}
# wrapper 0.0
# reverse_string была вызвана: 2x
# !amanaP :lanac a ,noep a ,stah eros ,raj a ,hsac ,oloR a ,tur a ,mapS ,snip ,eperc a ,)lemac a ro( niaga gab ananab a ,gat a ,nat a ,gab ananab a ,gag a ,inoracam ,elacrep ,epins ,spam ,arutaroloc a ,shajar ,soreh ,atsap ,eonac a ,nalp a ,nam A