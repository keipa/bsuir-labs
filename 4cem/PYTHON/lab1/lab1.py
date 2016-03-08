import fib
import strproc
import sorts
import storage
import argparse


def create_parser():
    parser = argparse.ArgumentParser()
    parser.add_argument('-p', "--program", default='sort')
    parser.add_argument('-t', "--type", nargs='?', default='digit')
    parser.add_argument('-s', "--source", default='nums', nargs='?')
    return parser


def main():
    parser = create_parser()
    namespace = parser.parse_args()
    if namespace.program == "sort":
        with open(namespace.source, 'r') as f:
            if namespace.type == "quick":
                sorts.quick_sort(f.read())
            elif namespace.type == "merge":
                sorts.merge_sort(f.read())
            elif namespace.type == "digit":
                sorts.digit_sort(f.read())
            elif namespace.type is None:
                sorts.quick_sort(f.read())
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
                strproc.top_most_repeat_letter_grams(f.read())
            elif namespace.type == "medium":
                strproc.median_count_of_words_in_sentences(f.read())
            elif namespace.type == "average":
                strproc.average_count_of_words_in_sentences(f.read())
            elif namespace.type == "repeats":
                strproc.wr(f.read())
            elif namespace.type == "show":
                strproc.show_source(f.read())
            else:
                print("err no such parameter -t")
    elif namespace.program == "set":
        storage.init_storage()
    else:
        print("there is no such parameter")


if __name__ == '__main__':
    main()
