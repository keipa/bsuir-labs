import tempfile
import os
import time

def benchmark(func):
    import time
    def wrapper(*args, **kwargs):
        start_time = time.time()
        res = func(*args, **kwargs)
        print("--- {0} seconds ---".format(time.time() - start_time))
        return res
    return wrapper


@benchmark
def main():
    selfish_sort()
    # list_of_splitted_tmp = split_file(8500, "\n", "strfiles/genrated.txt")
    # list_of_sorted_tmp = []
    # count = 1
    # for each in range(len(list_of_splitted_tmp)):
    #     list_of_splitted_tmp[each].seek(0)
    # for each in range(len(list_of_splitted_tmp)):
    #     list_of_sorted_tmp.append(sorting(list_of_splitted_tmp[each], "\n", 0))
    #     print("sorting {0}".format(str(count)))
    #     count += 1
    # # for each in list_of_sorted_tmp:
    # #     show_all_tmp(each)
    # merging(list_of_sorted_tmp)

def sorting(temp_file, line_splitter, block_splitter):
    a = next_templine(temp_file, line_splitter)
    dest = tempfile.TemporaryFile()
    b = []
    while a != None:
        b.append(a)
        a = next_templine(temp_file, line_splitter)
    b.sort()
    for each in b:
        dest.write(bytes(each, encoding="UTF-8"))
    dest.seek(0)
    return dest


def next_templine(temp_file, line_splitter):
    bufString = ""
    while True:
        symbol = temp_file.read(1)
        symbol = str(symbol, encoding='UTF-8')
        if not symbol:
            return None
        elif symbol != line_splitter:
            bufString += symbol
        else:
            bufString += symbol
            return bufString

def show_all_tmp(temp_file, line_splitter):
    a = next_templine(temp_file, line_splitter)
    while a != None:
        a = next_templine(temp_file, line_splitter)
        print(a)


def split_file(buffer_size, string_separator, path):
    with open(path, "r") as file:
        count_lines = 0
        file_count = 1
        file_list = []
        for line in file:
            if count_lines == 0:
                dest = tempfile.TemporaryFile()
                file_list.append(dest)
            dest.write(bytes(line, encoding="UTF-8"))
            count_lines += 1
            if count_lines > buffer_size-1:
                file_count += 1
                print("splitting {0} file".format(file_count-1))
                count_lines = 0
    return file_list


def merging(list_of_sorted_tmp):
    big_sort = []
    # prepearing
    temp = tempfile.TemporaryFile()
    big_sort.append(temp)
    if len(list_of_sorted_tmp) >= 2:
        line = next_templine(list_of_sorted_tmp[0], "\n")
        while line is not None:
            big_sort[0].write(bytes(line, encoding="UTF-8"))
            line = next_templine(list_of_sorted_tmp[0], "\n")
        big_sort[0].seek(0)
    current = 0
    for tmp_index in range(len(list_of_sorted_tmp)-1):
        print("merging "+str(current))
        current += 1
        new_temp = tempfile.TemporaryFile()
        big_sort.append(new_temp)
        left_line = next_templine(big_sort[current-1], "\n")
        right_line = next_templine(list_of_sorted_tmp[tmp_index+1], "\n")
        while left_line is not None and right_line is not None:
            if left_line < right_line:
                big_sort[current].write(bytes(left_line, encoding="UTF-8"))
                left_line = next_templine(big_sort[current-1], "\n")
            else:
                big_sort[current].write(bytes(right_line, encoding="UTF-8"))
                right_line = next_templine(list_of_sorted_tmp[tmp_index+1], "\n")
        if left_line is None:
            while right_line is not None:
                big_sort[current].write(bytes(right_line, encoding="UTF-8"))
                right_line = next_templine(list_of_sorted_tmp[tmp_index+1], "\n")
        if right_line is None:
            while left_line is not None:
                big_sort[current].write(bytes(left_line, encoding="UTF-8"))
                left_line = next_templine(big_sort[current-1], "\n")
        big_sort[current].seek(0)
    print("merging complete")
    with open("strfiles/sorted.txt", "w") as f:
        tmp_line = next_templine(big_sort[current], "\n")
        while tmp_line is not None:
            f.write(tmp_line)
            tmp_line = next_templine(big_sort[len(big_sort)-1], "\n")

    print("Success!")

def selfish_sort():
    b = []
    with open("strfiles/genrated.txt", "r") as f:
        for line in f:
            b.append(line)
        b.sort()
    with open("strfiles/selfish_sorted.txt", "w") as f:
        for each in b:
            f.write(each)


if __name__ == '__main__':
    main()
