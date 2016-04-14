from random import *
import argparse


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', "--program", default='generate')
    parser.add_argument('-n', "--nums",  default='0')
    parser.add_argument('-b', "--fixedblocks",  default='0')
    parser.add_argument('-l', "--fixedlines",  default='0')
    parser.add_argument('-ls', "--lineseparator", default='\n')
    parser.add_argument('-bs', "--blockseparator", default='\t')
    return parser


# default line_separator - \n
# default block_separator - \t
# default isfixedblocks = true

def generate(block_count, block_separator,  line_count,line_separator, isnums):

    count_of_strings = randint(10, 100)
    # count of strings
    count_of_blocks = randint(1, 30)
    # count of blocks in strings
    count_of_letters = randint(1, 10)
    # count of letters in blocks
    if line_separator == "\\n":
        line_separator = "\n"
    if block_separator == "\\t":
        block_separator = "\t"
    s = ""
    with open("strfiles/genrtd.txt", "w") as f:
        for string in range(count_of_strings):
            for block in range(count_of_blocks):
                for letter in range(count_of_letters):
                    s += random_chr(isnums)
                if block == count_of_blocks-1:
                    s += line_separator
                else:
                    s += block_separator
            f.write(s)
            s = ""

def random_chr(isnums):
    if isnums == '0':
        return str(randint(0, 9))
    else:
        return chr(randint(97, 122))


def menu():
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "generate":
        generate(int(namespace.fixedblocks),
                 namespace.blockseparator,
                 int(namespace.fixedlines),
                 namespace.lineseparator,
                 namespace.nums)


if __name__ == '__main__':
    menu()