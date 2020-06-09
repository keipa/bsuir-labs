#!/usr/bin/env python3

import sys
import time
import math
import argparse
from queue import Empty
from multiprocessing import Process, Queue, Event


class Tasker(Process):
    def __init__(self, event, task_queue, number):
        Process.__init__(self)
        self.event = event
        self.queue = task_queue
        self.number = number

    def is_prime(self, value):
        is_prime = True
        value = int(value[0])
        for number in range(1, int(math.sqrt(value))):
            if value % number:
                is_prime = False
                break

        return is_prime

    def count_of_even(self, value):
        count = 0
        for number in range(int(value[0]), int(value[1]) + 1):
            if not number % 2:
                count += 1

        return count

    def run(self):
        answers = []
        while self.event.is_set():
            try:
                data_pair = self.queue.get_nowait()
                if data_pair[0] == "prime":
                    answers.append(
                        ("P", data_pair[1],
                         self.is_prime(data_pair[1]))
                    )
                elif data_pair[0] == "even":
                    answers.append(("E",
                                    self.count_of_even(data_pair[1])))

            except Empty:
                time.sleep(1)

        with open("task{0}.txt".format(self.number), "w+") as out:
            for task_result in answers:
                for each in task_result:
                    out.write(str(each) + " ")

                out.write("\n")


def main():
    parser = argparse.ArgumentParser(description="KEK")
    parser.add_argument("--file", "-f", action="store", nargs=1, type=str)
    parser.add_argument("--count", "-c", action="store", nargs=1, type=int)
    args = parser.parse_args()
    if args.file:
        in_file = args.file[0]
    else:
        in_file = "input.txt"

    if args.count:
        proc_count = args.count[0]
    else:
        proc_count = 5

    print(in_file)

    event = Event()
    task_queue = Queue()
    proc_pool = [Tasker(event, task_queue, num)
                 for num in range(proc_count)]
    event.set()

    with open(in_file) as input_file:
        all_strings = input_file.read().split("\n")[:-1]
        for string in all_strings:
            key, value = string.split("?")
            value = value.split()
            task_queue.put((key, value))

    for proc in proc_pool:
        proc.start()

    while not task_queue.empty():
        time.sleep(1)

    event.clear()
    for proc in proc_pool:
        proc.join()


if __name__ == "__main__":
    sys.exit(main())