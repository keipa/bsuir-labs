from  tempfile import *


def sort():
    split_file(10,"\n","strfiles/genrated.txt")

def split_file(buffer_size, string_separator, path):
    with open(path, "r") as file:
        count_lines = 0
        file_count = 1
        for line in file:

            if count_lines == 0:
                dest = open("strfiles/tmp/generated" + str(file_count) + '.txt', 'w')
            else:
                dest = open("strfiles/tmp/generated" + str(file_count) + '.txt', 'a')
            dest.write(line)
            count_lines += 1

            if count_lines > buffer_size-1:
                file_count += 1
                count_lines = 0

if __name__ == '__main__':
    sort()
