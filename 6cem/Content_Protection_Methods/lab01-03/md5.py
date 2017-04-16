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
def rotate_left(x, n):
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
    a = rotate_left(a, s)
    a = a + b
    return a


def rounds(buf, x):
    a = buf[0]
    b = buf[1]
    c = buf[2]
    d = buf[3]

    # Определяем константы, которые потребуются далее
    S11 = 7
    S12 = 12
    S13 = 17
    S14 = 22

    S21 = 5
    S22 = 9
    S23 = 14
    S24 = 20

    S31 = 4
    S32 = 11
    S33 = 16
    S34 = 23

    S41 = 6
    S42 = 10
    S43 = 15
    S44 = 21

    # раунд 1
    a = operator(F, a, b, c, d, x[0], S11, 0xd76aa478)
    d = operator(F, d, a, b, c, x[1], S12, 0xe8c7b756)
    c = operator(F, c, d, a, b, x[2], S13, 0x242070db)
    b = operator(F, b, c, d, a, x[3], S14, 0xc1bdceee)
    a = operator(F, a, b, c, d, x[4], S11, 0xf57c0faf)
    d = operator(F, d, a, b, c, x[5], S12, 0x4787c62a)
    c = operator(F, c, d, a, b, x[6], S13, 0xa8304613)
    b = operator(F, b, c, d, a, x[7], S14, 0xfd469501)
    a = operator(F, a, b, c, d, x[8], S11, 0x698098d8)
    d = operator(F, d, a, b, c, x[9], S12, 0x8b44f7af)
    c = operator(F, c, d, a, b, x[10], S13, 0xffff5bb1)
    b = operator(F, b, c, d, a, x[11], S14, 0x895cd7be)
    a = operator(F, a, b, c, d, x[12], S11, 0x6b901122)
    d = operator(F, d, a, b, c, x[13], S12, 0xfd987193)
    c = operator(F, c, d, a, b, x[14], S13, 0xa679438e)
    b = operator(F, b, c, d, a, x[15], S14, 0x49b40821)
    # раунд 2
    a = operator(G, a, b, c, d, x[1], S21, 0xf61e2562)
    d = operator(G, d, a, b, c, x[6], S22, 0xc040b340)
    c = operator(G, c, d, a, b, x[11], S23, 0x265e5a51)
    b = operator(G, b, c, d, a, x[0], S24, 0xe9b6c7aa)
    a = operator(G, a, b, c, d, x[5], S21, 0xd62f105d)
    d = operator(G, d, a, b, c, x[10], S22, 0x2441453)
    c = operator(G, c, d, a, b, x[15], S23, 0xd8a1e681)
    b = operator(G, b, c, d, a, x[4], S24, 0xe7d3fbc8)
    a = operator(G, a, b, c, d, x[9], S21, 0x21e1cde6)
    d = operator(G, d, a, b, c, x[14], S22, 0xc33707d6)
    c = operator(G, c, d, a, b, x[3], S23, 0xf4d50d87)
    b = operator(G, b, c, d, a, x[8], S24, 0x455a14ed)
    a = operator(G, a, b, c, d, x[13], S21, 0xa9e3e905)
    d = operator(G, d, a, b, c, x[2], S22, 0xfcefa3f8)
    c = operator(G, c, d, a, b, x[7], S23, 0x676f02d9)
    b = operator(G, b, c, d, a, x[12], S24, 0x8d2a4c8a)
    # раунд 3
    a = operator(H, a, b, c, d, x[5], S31, 0xfffa3942)
    d = operator(H, d, a, b, c, x[8], S32, 0x8771f681)
    c = operator(H, c, d, a, b, x[11], S33, 0x6d9d6122)
    b = operator(H, b, c, d, a, x[14], S34, 0xfde5380c)
    a = operator(H, a, b, c, d, x[1], S31, 0xa4beea44)
    d = operator(H, d, a, b, c, x[4], S32, 0x4bdecfa9)
    c = operator(H, c, d, a, b, x[7], S33, 0xf6bb4b60)
    b = operator(H, b, c, d, a, x[10], S34, 0xbebfbc70)
    a = operator(H, a, b, c, d, x[13], S31, 0x289b7ec6)
    d = operator(H, d, a, b, c, x[0], S32, 0xeaa127fa)
    c = operator(H, c, d, a, b, x[3], S33, 0xd4ef3085)
    b = operator(H, b, c, d, a, x[6], S34, 0x4881d05)
    a = operator(H, a, b, c, d, x[9], S31, 0xd9d4d039)
    d = operator(H, d, a, b, c, x[12], S32, 0xe6db99e5)
    c = operator(H, c, d, a, b, x[15], S33, 0x1fa27cf8)
    b = operator(H, b, c, d, a, x[2], S34, 0xc4ac5665)
    # раунд 4
    a = operator(I, a, b, c, d, x[0], S41, 0xf4292244)
    d = operator(I, d, a, b, c, x[7], S42, 0x432aff97)
    c = operator(I, c, d, a, b, x[14], S43, 0xab9423a7)
    b = operator(I, b, c, d, a, x[5], S44, 0xfc93a039)
    a = operator(I, a, b, c, d, x[12], S41, 0x655b59c3)
    d = operator(I, d, a, b, c, x[3], S42, 0x8f0ccc92)
    c = operator(I, c, d, a, b, x[10], S43, 0xffeff47d)
    b = operator(I, b, c, d, a, x[1], S44, 0x85845dd1)
    a = operator(I, a, b, c, d, x[8], S41, 0x6fa87e4f)
    d = operator(I, d, a, b, c, x[15], S42, 0xfe2ce6e0)
    c = operator(I, c, d, a, b, x[6], S43, 0xa3014314)
    b = operator(I, b, c, d, a, x[13], S44, 0x4e0811a1)
    a = operator(I, a, b, c, d, x[4], S41, 0xf7537e82)
    d = operator(I, d, a, b, c, x[11], S42, 0xbd3af235)
    c = operator(I, c, d, a, b, x[2], S43, 0x2ad7d2bb)
    b = operator(I, b, c, d, a, x[9], S44, 0xeb86d391)

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
    buf[0] = 0x67452301
    buf[1] = 0xefcdab89
    buf[2] = 0x98badcfe
    buf[3] = 0x10325476

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
        x = data_words[i * 16:i*16 + 16]
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
        text_file.write(a+"\n"+md5hash)
    return md5hash


def unhash_file(decrypted_hashed, decrypted):
    with open(decrypted_hashed, "r") as f:
        a = f.readlines()
        md5hash = a[len(a)-1].replace("\x00", "")
        a.remove(a[len(a)-1])
        a[len(a)-1] = a[len(a)-1][:2]
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

# # print(calc_md5("hello_my_frien"))
# add_hash(CONTENT_INPUT, CONTENT_INPUT_HASHED)
# get_hash(CONTENT_DECRYPTED_HASHED, CONTENT_DECRYPTED)
