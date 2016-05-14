import tempfile
import sys
import select
import hashlib

def benchmark(func):
    import time
    def wrapper(*args, **kwargs):
        start_time = time.time()
        res = func(*args, **kwargs)
        print("--- {0} seconds ---".format(time.time() - start_time))
        return res
    return wrapper


def md5(fname):
    hash_md5 = hashlib.md5()
    with open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

@benchmark
def main(block_separator, line_separator, input_file, output_file, buffer_size, reverse, checked,  keys = []):
    # selfish_sort()
    if len(keys) == 0:
        list_of_split_tmp = split_file(buffer_size, line_separator, input_file)
        list_of_sorted_tmp = []
        count = 1
        for each in range(len(list_of_split_tmp)):
            list_of_split_tmp[each].seek(0)
        for each in range(len(list_of_split_tmp)):
            list_of_sorted_tmp.append(sorting(list_of_split_tmp[each], line_separator, block_separator))
            print("sorting {0}".format(str(count)))
            count += 1
        merging(list_of_sorted_tmp, block_separator, line_separator, output_file)
    else:
        key_sort(block_separator, line_separator, input_file, output_file, keys)
    if reverse:
        print("re")
        reversion(output_file)
    if checked:
        if md5(output_file) != md5(input_file):
            print(str(False))
        else:
            print(str(True))

def reversion(output_file):
    f = open(output_file, "r")
    s = f.readlines()
    f.close()
    f = open(output_file, "w")
    s.reverse()
    for item in s:
        f.write(str(item))
    f.close()

# def sorting(temp_file, line_splitter, block_splitter):
#     a = next_temp_line(temp_file, line_splitter)
#     destination = tempfile.TemporaryFile()
#     original_string = []
#     while a is not None:
#         original_string.append(a)
#         a = next_temp_line(temp_file, line_splitter)
#     original_string.sort()
#     for each in original_string:
#         destination.write(bytes(each, encoding="UTF-8"))
#     destination.seek(0)
#     return destination

def sorting(temp_file, line_splitter, block_splitter):
    a = next_temp_line(temp_file, line_splitter)
    destination = tempfile.TemporaryFile()
    original_string = {}
    while a is not None:
        val = a.split(block_splitter)
        actual_string = ""
        for each in val:
            actual_string+=each
        original_string[a] = actual_string
        a = next_temp_line(temp_file, line_splitter)
    original_string = list(original_string.items())
    original_string.sort(key=lambda tup: tup[1])
    for each in original_string:
        destination.write(bytes(each[0], encoding="UTF-8"))
    destination.seek(0)
    return destination

def next_temp_line(temp_file, line_splitter):
    buf_string = ""
    while True:
        symbol = temp_file.read(1)
        symbol = str(symbol, encoding='UTF-8')
        if not symbol:
            return None
        elif symbol != line_splitter:
            buf_string += symbol
        else:
            buf_string += symbol
            return buf_string


def show_all_tmp(temp_file, line_splitter):
    a = next_temp_line(temp_file, line_splitter)
    while a is not None:
        a = next_temp_line(temp_file, line_splitter)
        print(a)


def split_file(buffer_size, string_separator, path):
    # type
    # if select.select([sys.stdin,],[],[],0.0)[0]:
    #     data = sys.stdin.readlines()
    #     if len(data) != 0 and type(data) is not None:
    #         with open(path, "w") as f:
    #             for each in data:
    #                 f.write(each)

    with open(path, "r") as file:
        count_lines = 0
        file_count = 1
        file_list = []
        for line in file:
            if count_lines == 0:
                destination = tempfile.TemporaryFile()
                file_list.append(destination)
            destination.write(bytes(line, encoding="UTF-8"))
            count_lines += 1
            if count_lines > buffer_size-1:
                file_count += 1
                print("splitting {0} file".format(file_count-1))
                count_lines = 0
    return file_list


def key_sort(block_separator, line_separator, input_file, output_file, keys):
    b = []
    s = []
    with open(input_file, "r") as file:
        for line in file:
            b.append(line)
    for each in range(len(keys)-1):
        s.append(b[int(keys[each])-1])
    s.sort()
    for each in range(len(s)-1):
        b[int(keys[each])-1] = s[each]
    with open(output_file, "w") as f:
        for each in range(len(b)-1):
            f.write(b[each])


def merging(list_of_sorted_tmp, block_separator, line_separator, output_file):
    big_sort = []
    temp = tempfile.TemporaryFile()
    big_sort.append(temp)
    if len(list_of_sorted_tmp) >= 2:
        line = next_temp_line(list_of_sorted_tmp[0], line_separator)
        while line is not None:
            big_sort[0].write(bytes(line, encoding="UTF-8"))
            line = next_temp_line(list_of_sorted_tmp[0], line_separator)
        big_sort[0].seek(0)
    else:
        line = next_temp_line(list_of_sorted_tmp[0], line_separator)
        while line is not None:
            big_sort[0].write(bytes(line, encoding="UTF-8"))
            line = next_temp_line(list_of_sorted_tmp[0], line_separator)
        big_sort[0].seek(0)
        with open(output_file, "w") as f:
            tmp_line = next_temp_line(big_sort[0], line_separator)
            while tmp_line is not None:
                f.write(tmp_line)
                tmp_line = next_temp_line(big_sort[len(big_sort) - 1], line_separator)
        return
    current = 0
    for tmp_index in range(len(list_of_sorted_tmp)-1):
        print("merging "+str(current+1))
        current += 1
        new_temp = tempfile.TemporaryFile()
        big_sort.append(new_temp)
        left_line = next_temp_line(big_sort[current - 1], line_separator)
        right_line = next_temp_line(list_of_sorted_tmp[tmp_index + 1], line_separator)
        val = left_line.split(block_separator)
        actual_left_string = ""
        for each in val:
            actual_left_string += each
        val = right_line.split(block_separator)
        actual_right_string = ""
        for each in val:
            actual_right_string += each
        while left_line is not None and right_line is not None:
            if actual_left_string < actual_right_string:
                big_sort[current].write(bytes(left_line, encoding="UTF-8"))
                left_line = next_temp_line(big_sort[current - 1], line_separator)
                if left_line is not None and right_line is not None:
                    val = left_line.split(block_separator)
                    actual_left_string = ""
                    for each in val:
                        actual_left_string += each
            else:
                big_sort[current].write(bytes(right_line, encoding="UTF-8"))
                right_line = next_temp_line(list_of_sorted_tmp[tmp_index + 1], line_separator)
                if left_line is not None and right_line is not None:
                    val = right_line.split(block_separator)
                    actual_right_string = ""
                    for each in val:
                        actual_right_string += each
        if left_line is None:
            while right_line is not None:
                big_sort[current].write(bytes(right_line, encoding="UTF-8"))
                right_line = next_temp_line(list_of_sorted_tmp[tmp_index + 1], line_separator)
                if left_line is not None and right_line is not None:
                    val = right_line.split(block_separator)
                    actual_right_string = ""
                    for each in val:
                        actual_right_string += each
        if right_line is None:
            while left_line is not None:
                big_sort[current].write(bytes(left_line, encoding="UTF-8"))
                left_line = next_temp_line(big_sort[current - 1], line_separator)
                if left_line is not None and right_line is not None:
                    val = left_line.split(block_separator)
                    actual_left_string = ""
                    for each in val:
                        actual_left_string += each
        big_sort[current].seek(0)
    print("merging complete")
    with open(output_file, "w") as f:
        tmp_line = next_temp_line(big_sort[current], line_separator)
        while tmp_line is not None:
            f.write(tmp_line)
            tmp_line = next_temp_line(big_sort[len(big_sort) - 1], line_separator)
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
