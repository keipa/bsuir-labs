from  tempfile import *
import os

def main():
    a = split_file(8380, "\n", "strfiles/genrated.txt")
    print("splitted on {0} files".format(a))
    for each in range(a):
        print("sorting generated"+str(each+1)+".txt")
        sort("strfiles/tmp/"+str(each+1)+".txt")
    print("sorted")
    # merging("strfiles/tmp", a)


def sort(path):
    b = []
    with open(path, "r") as f:
        for line in f:
            b.append(line)
        b.sort()
    with open(path, "w") as f:
        for each in b:
            f.write(each)


def split_file(buffer_size, string_separator, path):
    with open(path, "r") as file:
        count_lines = 0
        file_count = 1
        for line in file:
            if count_lines == 0:
                dest = open("strfiles/tmp/" + str(file_count) + '.txt', 'w')
            else:
                dest = open("strfiles/tmp/" + str(file_count) + '.txt', 'a')
            dest.write(line)
            count_lines += 1
            if count_lines > buffer_size-1:
                file_count += 1
                print("splitting {0} file".format(file_count))
                count_lines = 0
    return file_count


def merging(path, count):
    num = count
    list_of_files = os.listdir(path)
    if len(list_of_files) != 1:
        num += 1
        left = open(path + list_of_files[0], "r")
        right = open(path + list_of_files[1], "r")
        final = open(path + str(num), "w")
        l_str = ""
        r_str = ""

def next_line(path):
    with open(path, "r") as f:
        pass

if __name__ == '__main__':
    main()
