import argparse

def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', "--program", default='string')
    parser.add_argument('-t', "--type", nargs='?', default='repeats')
    parser.add_argument('-s', "--source", default='nums', nargs='?')
    return parser


def main():
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "sort":
        with open(namespace.source, 'r') as f:
            if namespace.type == "quick":
                quick_sort(f.read())
            elif namespace.type == "merge":
                merge_sort(f.read())
            elif namespace.type == "digit":
                digit_sort(f.read())
            elif namespace.type is None:
                quick_sort(f.read())
            else:
                print("err Parameter -t")
    elif namespace.program == "fib":
        for n in fib.fib(int(input("how many fibs?"))):   # используем генератор fibonacci() как итератор
            print(n)
    elif namespace.program == "string":
        if namespace.source == 'nums':
            namespace.source = 'text'
        with open(namespace.source, 'r') as f:
            if namespace.type is None:
                print("enter -t parameter *top*, *medium*,*average* or *repeats* ")
            elif namespace.type == "top":
                top_most_repeat_letter_grams(f.read())
            elif namespace.type == "medium":
                median_count_of_words_in_sentences(f.read())
            elif namespace.type == "average":
                average_count_of_words_in_sentences(f.read())
            elif namespace.type == "repeats":
                word_repeats(f.read())
            elif namespace.type == "show":
                show_source(f.read())
            else:
                print("err no such parameter -t")
    elif namespace.program == "set":
        init_storage()
    else:
        print("there is no such parameter")


def prepare_for_sort(st):
    return [int(n) for n in st.split()]


# list comprehension
###################################################################
def algorithm_quick_sort(lst):
    if len(lst) <= 1:
        return lst
    smaller = [x for x in lst[1:] if x < lst[0]]
    larger = [x for x in lst[1:] if x >= lst[0]]
    return algorithm_quick_sort(smaller) + [lst[0]] + algorithm_quick_sort(larger)


def quick_sort(st):
    print(algorithm_quick_sort(prepare_for_sort(st)))


###################################################################
def merge_sort(st):
    algorithm_merge_sort(prepare_for_sort(st))


def algorithm_merge_sort(sorting_list):
    print("Splitting ", sorting_list)
    if len(sorting_list) > 1:
        mid = len(sorting_list) // 2
        left_half = sorting_list[:mid]
        right_half = sorting_list[mid:]

        algorithm_merge_sort(left_half)
        algorithm_merge_sort(right_half)

        i = 0
        j = 0
        k = 0
        while i < len(left_half) and j < len(right_half):
            if left_half[i] < right_half[j]:
                sorting_list[k] = left_half[i]
                i += 1
            else:
                sorting_list[k] = right_half[j]
                j += 1
            k += 1

        while i < len(left_half):
            sorting_list[k] = left_half[i]
            i += 1
            k += 1

        while j < len(right_half):
            sorting_list[k] = right_half[j]
            j += 1
            k += 1
    print("Merging ", sorting_list)


###################################################################
# не ест float (45.1321)
# для работы заменить в (5) float → int
def algorithm_digit_sort(sorting_list):
    length = len(str(max(sorting_list)))
    rang = 10
    for i in range(length):
        b = [[] for _ in range(rang)]
        for x in sorting_list:
            figure = x // 10**i % 10
            b[figure].append(x)
        sorting_list = []
        for k in range(rang):
            sorting_list += b[k]
    print(sorting_list)


def digit_sort(string):
    algorithm_digit_sort(prepare_for_sort(string))

import re
func = input("wat regexp: ")
valid = input("enter example: ")
if func == "email":
    if re.match(r"[^@]+@[^@]+\.[^@]+", valid):
        print("ok")
    else:
        print("not valid")
if func == "float":
    if re.match(r'[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?', valid):
        print("valid")
    else:
        print("not valid")
if func == "url":
    if re.match(r'https://.+\.+[a-z]+/+', valid):
        print("valid")
    else:
        print("not valid")

def fib(num):
    a = 0
    b = 1
    while a < num:
        yield a
        a, b = b, a + b


def init_storage():
    import re
    storage = set()
    print("Set Is on the go")
    input_string = ""
    while input_string != "exit":
        input_string = input("-->")
        if input_string == "list":
            print(storage)
        elif input_string.split()[0] == "add":
            for each in input_string.split()[1:]:
                storage.add(each)
            # print("added")
        elif input_string.split()[0] == "remove":
            for each in input_string.split()[1:]:
                storage.discard(each)
        elif input_string.split()[0] == "find":
            for each in input_string.split()[1:]:
                if each in storage:
                    print(each)
                else:
                    print("There is no", each, "in list")
        elif input_string.split()[0] == "save":
            print("saving...")
            with open(input_string.split()[1], "w") as f:
                for each in storage:
                    f.write(each+' ')
            print("saved.")
        elif input_string.split()[0] == "load":
            storage.clear()
            print("loading...")
            with open(input_string.split()[1], "r") as f:
                for each in f.read().split():
                    storage.add(each)
            print("load.")
        elif input_string.split()[0] == "grep":
            for each in storage:
                if re.match(input_string.split()[1], each):
                    print(each, " - valid")
        else:
            print("err")


# word_repeats
def word_repeats(st):
    words = str(st).split()
    repeat = dict()
    for each in words:
        repeat[each] = 0
    for each in words:
        repeat[each] += 1
    for each in repeat:
        print(each, ":", repeat[each])


# average_count_of_words_in_sentences
def average_count_of_words_in_sentences(st):

    sentences = st.split(".")
    counts = dict()
    a = 0
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a += counts[each]
    print("average: ", round(a/len(counts)))


# median_count_of_words_in_sentences
def median_count_of_words_in_sentences(st):
    sentences = st.split(".")
    counts = dict()
    a = list()
    for each in sentences:
        counts[each] = len(each.split())
    for each in counts:
        a.append(counts[each])
    a.sort()
    print(a[round(len(a)/2)])


def show_source(st):
    print(st)


# top k most repeatable letter n-grams
def top_most_repeat_letter_grams(st):
    k = ""
    n = ""

    while True:
        a = input("Use default settings?(y/n): ")
        if a == 'y':
            k = 10
            n = 4
            print("k = 10, n = 4")
            break
        if a == 'n':
            while not k.isdigit():
                k = input("Input K: ")
            while not n.isdigit():
                n = input("Input N: ")
            print("k = ", k,  ", n = ", n)
            break
    k = int(k)
    n = int(n)
    # print(k-n)
    gram_collection = dict()
    top = dict()
    all_gram = list()
    words = st.split()
    for each in words:
        gram_word = dict()
        for i in range(0, len(each)-n+1):
                if len(each)-n+1 <= 0:
                    break
                gram_word[i] = each[i:i+n]
                all_gram.append(each[i:i+n])
        gram_collection[each] = gram_word
    for gram in all_gram:
        top[gram] = all_gram.count(gram)
    for i in range(1, k):
        fav = 0
        g = ""
        for each in top:
            if top[each] > fav:
                g = each
                fav = top[each]
        try:
            del top[g]
        except KeyError:
            print("K or N is too strange nums for this stroke restart the app")
            print("please, look at your input and think a little")
            print(st)
            break
        print(i, ") ", g, " - ", fav, "t.")


if __name__ == '__main__':
    main()
