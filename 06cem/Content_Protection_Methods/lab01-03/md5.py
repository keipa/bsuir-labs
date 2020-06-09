from functools import reduce

from config import *


# Выравнивание потока и добавление длины сообщения
def alignment(msg):
    msg_len = len(msg) * 8
    msg.append(0x80)
    while len(msg) % 64 != 56:
        msg += [0]
    for i in range(8):
        msg.append(msg_len >> i * 8)
    return msg


# 4 функции для 4 раундов от трех параметров
def F(x, y, z):
    return (x & y) | ((~x) & z)


def G(x, y, z):
    return (x & z) | (~z) & y


def H(x, y, z):
    return x ^ y ^ z


def I(x, y, z):
    return y ^ ((~z) | x)


# циклический сдвиг влево на n бит
def cycle_left(x, n):
    x &= 0xFFFFFFFF
    return ((x << n) | (x >> (32 - n))) & 0xFFFFFFFF


def to_little_endian(word):
    res = 0
    res |= ((word >> 0) & 0xFF) << 24
    res |= ((word >> 8) & 0xFF) << 16
    res |= ((word >> 16) & 0xFF) << 8
    res |= ((word >> 24) & 0xFF) << 0
    return res


def operator(fun, a, b, c, d, x, s, ac):
    a = a + fun(b, c, d) + x + ac
    a = cycle_left(a, s)
    a = a + b
    return a


def rounds(buf, x):
    a = buf[0]
    b = buf[1]
    c = buf[2]
    d = buf[3]

    # # Определяем константы, которые потребуются далее

    Tind, Sind = 0, 0
    funcs = [F, G, H, I]
    for foo in funcs:
        for xi in range(4):
            a = operator(foo, a, b, c, d, x[xind[Tind]], S[Sind], T[Tind])
            d = operator(foo, d, a, b, c, x[xind[Tind + 1]], S[Sind + 1], T[Tind + 1])
            c = operator(foo, c, d, a, b, x[xind[Tind + 2]], S[Sind + 2], T[Tind + 2])
            b = operator(foo, b, c, d, a, x[xind[Tind + 3]], S[Sind + 3], T[Tind + 3])
            Tind += 4
        Sind += 4

    # cуммируем с результатом предыдущего цикла

    buf[0] += a
    buf[1] += b
    buf[2] += c
    buf[3] += d

    return buf


def calc_md5(data):
    data = [ord(i) for i in data]

    # Шаг 1 Выравнивание потока
    # Шаг 2 Добавление длины сообщения
    data = alignment(data)

    # Шаг 3 Инициализация буфера
    buf = [0] * 4
    buf[0] = bufinit[0]
    buf[1] = bufinit[1]
    buf[2] = bufinit[2]
    buf[3] = bufinit[3]

    # поток байт разбиваем на поток слов
    data_words = list(range(int(len(data) / 4)))
    for i in range(int(len(data) / 4)):
        q = 0
        for j in range(4):
            q |= data[i * 4 + j] << j * 8
        data_words[i] = q

    # Шаг 4: Вычисление в цикле
    # разбиваем поток на блоки по 16 слов
    for i in range(int(len(data_words) / 16)):
        # х блок данных
        x = data_words[i * 16:i * 16 + 16]
        buf = rounds(buf, x)

    # Шаг 5: Результат вычислений находся в буфере
    # Если выводить побайтово, начиная с младшего байта и закончив старшим байтом,
    # то получится MD5-хеш из 32 шестнадцатеричных цифр

    res = ""
    for i in buf:
        res += "{:08x}".format(to_little_endian(i))

    return res


def hash_file(raw, hashed):
    with open(raw, "r") as f:
        a = reduce(lambda string, item: string + item, f, "")
    with open(hashed, "w") as text_file:
        md5hash = calc_md5(a)
        text_file.write(a + "\n" + md5hash)
    return md5hash


def unhash_file(decrypted_hashed, decrypted):
    with open(decrypted_hashed, "r") as f:
        a = f.readlines()
        md5hash = a[len(a) - 1].replace("\x00", "")
        a.remove(a[len(a) - 1])
        a[len(a) - 1] = a[len(a) - 1][:2]
    with open(decrypted, "w") as text_file:
        text_file.writelines(a)
    return md5hash


def get_hash(file):
    with open(file, "r") as f:
        a = reduce(lambda string, item: string + item, f, "")
        return calc_md5(a)


def check_hashes(hashA, hashB):
    if str(hashA) == str(hashB):
        print("Message is not damaged")
    else:
        print("Message is corrupted")


print(calc_md5("hello_my_frien"))
# add_hash(CONTENT_INPUT, CONTENT_INPUT_HASHED)
# get_hash(CONTENT_DECRYPTED_HASHED, CONTENT_DECRYPTED)
