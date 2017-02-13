#!/usr/bin/python2.7
# -*- coding: utf-8 -*-

func_E = [32, 1, 2, 3, 4, 5,
          4, 5, 6, 7, 8, 9,
          8, 9, 10, 11, 12, 13,
          12, 13, 14, 15, 16, 17,
          16, 17, 18, 19, 20, 21,
          20, 21, 22, 23, 24, 25,
          24, 25, 26, 27, 28, 29,
          28, 29, 30, 31, 32, 1]

p_transformation = [16, 7, 20, 21, 29, 12, 28, 17,
                    1, 15, 23, 26, 5, 18, 31, 10,
                    2, 8, 24, 14, 32, 27, 3, 9,
                    19, 13, 30, 6, 22, 11, 4, 25]

s_transformation = [
    [[14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7],
     [0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8],
     [4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0],
     [15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13]],

    [[15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10],
     [3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5],
     [0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15],
     [13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9]],

    [[10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8],
     [13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1],
     [13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7],
     [1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12]],

    [[7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15],
     [13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9],
     [10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4],
     [3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14]],

    [[2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9],
     [14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6],
     [4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14],
     [11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3]],

    [[12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11],
     [10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8],
     [9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6],
     [4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13]],

    [[4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1],
     [13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6],
     [1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2],
     [6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12]],

    [[13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7],
     [1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2],
     [7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8],
     [2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11]]
]

c0 = [57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18,
      10, 2, 59, 51, 43, 35, 27, 19, 11, 3, 60, 52, 44, 36]

d0 = [63, 55, 47, 39, 31, 23, 15, 7, 62, 54, 46, 38, 30, 22,
      14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 28, 20, 12, 4]

finish_permutation = [14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4,
                      26, 8, 16, 7, 27, 20, 13, 2, 41, 52, 31, 37, 47, 55, 30, 40,
                      51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32]

number_of_shifts = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]

ip_initial_permutation = [58, 50, 42, 34, 26, 18, 10, 2, 60, 52, 44, 36, 28, 20, 12, 4,
                          62, 54, 46, 38, 30, 22, 14, 6, 64, 56, 48, 40, 32, 24, 16, 8,
                          57, 49, 41, 33, 25, 17, 9, 1, 59, 51, 43, 35, 27, 19, 11, 3,
                          61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23, 15, 7]

ip_1 = [40, 8, 48, 16, 56, 24, 64, 32, 39, 7, 47, 15, 55, 23, 63, 31,
        38, 6, 46, 14, 54, 22, 62, 30, 37, 5, 45, 13, 53, 21, 61, 29,
        36, 4, 44, 12, 52, 20, 60, 28, 35, 3, 43, 11, 51, 19, 59, 27,
        32, 2, 42, 10, 50, 18, 58, 26, 33, 1, 41, 9, 49, 17, 57, 25]


def text_into_a_binary_view(text):
    bin_text = ""
    for i in text:
        tmp = str(bin(ord(i)))[2:]
        if len(tmp) != 8:
            tmp = "0" * (8 - len(tmp)) + tmp
        bin_text += tmp
    return bin_text


def binary_view_into_a_text(bin_text):
    text = ""
    while len(bin_text) > 0:
        text += chr(int(bin_text[:8], 2))
        bin_text = bin_text[8:]
    return text


def permutation(bin_text, table):
    permutation_text = ""
    for elem in table:
        permutation_text += bin_text[elem - 1]
    return permutation_text


def modulo(a, b):
    result = ""
    for elem in range(len(a)):
        result += str(int(a[elem]) ^ int(b[elem]))
    return result


def gen_b_blocks(bin_text):
    B = []
    while len(bin_text) > 0:
        B.append(bin_text[:6])
        bin_text = bin_text[6:]
    return B


def transform(B, S):
    result = ""
    for x, y in zip(B, range(8)):
        a = int(str(x[0]) + str(x[5]), 2)
        b = int(str(x[1]) + str(x[2]) + str(x[3]) + str(x[4]), 2)
        temp = str((bin(S[y][a][b]))[2:])
        if len(temp) != 8:
            temp = "0" * (8 - len(temp)) + temp
        result += temp
    return result


def key_gen(bin_key):
    K = []
    key_result = ""
    while len(bin_key) > 0:
        K.append(bin_key[:7])
        bin_key = bin_key[7:]
    for i in K:
        count = 0
        for x in i:
            if x == '1':
                count += 1
        if count % 2 == 0:
            key_result += i + str(1)
        else:
            key_result += i + str(0)

    new_key = []
    shift = 0
    for i in range(16):
        c_d = ""
        shift += number_of_shifts[i]
        c = c0[shift:] + c0[:shift]
        d = d0[shift:] + d0[:shift]
        for x in c:
            c_d += key_result[x]
        for y in d:
            c_d += key_result[y]
        finish_key = ""
        for elem in finish_permutation:
            finish_key += key_result[elem]
        new_key.append(finish_key)
    return new_key


def function_feystel(R, bin_key):
    return transform(gen_b_blocks(modulo(permutation(R, func_E), bin_key)), s_transformation)


def encryption_cycle(bin_text, bin_key):
    L = bin_text[:32]
    R = bin_text[32:]
    for x in range(16):
        L, R = R, modulo(L, function_feystel(R, key_gen(bin_key)[x]))
    # print L, R
    result = L + R
    return result


def decryption_cycle(bin_text, bin_key):
    L = bin_text[:32]
    R = bin_text[32:]
    for x in range(15, -1, -1):
        R, L = L, modulo(R, function_feystel(L, key_gen(bin_key)[x]))
    # print L, R
    result = L + R
    return result


def encryption(text, key):
    if len(text) % 8 != 0:
        text += (8 - (len(text) % 8)) * "0"
    blocks = []
    while len(text) > 0:
        blocks.append(text[:8])
        text = text[8:]

    encryption_text = ""
    for block in blocks:
        encryption_text += binary_view_into_a_text(permutation(
            encryption_cycle(permutation(text_into_a_binary_view(block), ip_initial_permutation),
                             text_into_a_binary_view(key)), ip_1))
    return encryption_text


def decryption(text, key):
    if len(text) % 8 != 0:
        text += (8 - (len(text) % 8)) * "0"
    blocks = []
    while len(text) > 0:
        blocks.append(text[:8])
        text = text[8:]

    decryption_text = ""
    for block in blocks:
        decryption_text += binary_view_into_a_text(permutation(
            decryption_cycle(permutation(text_into_a_binary_view(block), ip_initial_permutation),
                             text_into_a_binary_view(key)), ip_1))
    return decryption_text


text = "00000000"
key = "7777777"

print(encryption(text, key))
print(decryption(encryption(text, key), key))
