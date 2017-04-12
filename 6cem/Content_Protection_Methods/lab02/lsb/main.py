from lsb import *
from sys import argv as av
import config
import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-e', '--encrypt', action='store_true')
parser.add_argument('-r', '--restore', action='store_true')
args = parser.parse_args(av[1:])
if args.encrypt:
    hide_text_into_image(config.image_input, config.text_input, config.image_output)
elif args.restore:
    restore_text_from_image(config.image_output, config.text_output)
