from random import *

# default line_separator - \n
# default block_separator - \t
# default isfixedblocks = true

def generate(block_count, block_separator,  line_count, line_separator, isnums, letter_count):
    count_of_strings = 0
    count_of_blocks = 0
    count_of_letters = 0
    # count of strings
    # count of blocks in strings
    # count of letters in blocks

    if line_separator == "\\n":
        line_separator = "\n"
    if block_separator == "\\t":
        block_separator = "\t"
    s = ""
    with open("strfiles/genrated.txt", "w") as f:
        if line_count == 0:
            count_of_strings = randint(10, 100)
        else:
            count_of_strings = int(line_count)
        for string in range(count_of_strings):
            if block_count == 0:
                count_of_blocks = randint(1, 10)
            else:
                count_of_blocks = int(block_count)
            for block in range(count_of_blocks):
                if letter_count == 0:
                    count_of_letters = randint(1, 10)
                else:
                    count_of_letters = int(letter_count)
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
