from patchwork import *
from config import *


hsv = read_hsv(in_img)
arr = brightness_from_hsv(hsv)
print get_brightness(arr, n)
patchworking(arr, n, o, secret_key)
print get_brightness(arr, n)
print search(arr, n, o, secret_key)
write_file(out_img, hsv)
