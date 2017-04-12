# -*- coding: utf-8 -*-
"""
hcv - Hue, Saturation, Brightness — тон, насыщенность, яркость
"""
import random

import cv2


def main(n, o, secret_key, in_img, out_img):
    hsv = read_hsv(in_img)
    arr = brightness_from_hsv(hsv)
    print secondary_brightness(arr, n)  # весь файл до изменений
    do_patchwork(arr, n, o, secret_key)  # изменение части файла
    print secondary_brightness(arr, n)  # весь файл после изменений
    print search(arr, n, o, secret_key)  # часть файла после изменений
    write_file(out_img, hsv)


def read_hsv(image_name):
    img = cv2.imread(image_name)
    hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
    return hsv


def secondary_brightness(brightness_arr, n):
    sum = 0
    for _ in xrange(n):
        r = int(random.choice(brightness_arr)) - int(random.choice(brightness_arr))
        sum += r
    return sum / float(n)


def brightness_from_hsv(hsv):
    brightness_arr = hsv[:, :, 0][0]
    return brightness_arr


def do_patchwork(brightness_arr, n, o, secret_key):
    random.seed(secret_key)
    for _ in xrange(n):
        i1 = random.randint(0, len(brightness_arr) - 1)
        brightness_arr[i1] += o
        i2 = random.randint(0, len(brightness_arr) - 1)
        brightness_arr[i2] -= o


def search(brightness_arr, n, o, secret_key):
    random.seed(secret_key)
    sum = 0
    for _ in xrange(n):
        i1 = random.randint(0, len(brightness_arr) - 1)
        i2 = random.randint(0, len(brightness_arr) - 1)
        sum += int(brightness_arr[i1]) - int(brightness_arr[i2])
    return sum / float(n)


def write_file(image_name, hsv):
    img = cv2.cvtColor(hsv, cv2.COLOR_HSV2BGR)
    cv2.imwrite('out.bmp', img)


if __name__ == '__main__':
    main(20000, 4, 999, 'in.bmp', 'out.bmp')
