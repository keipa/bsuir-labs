from multiprocessing import Process
import time
import argparse
from multiprocessing import Queue
import math

class mProcess(Process):
    def __init__(self, quine, n):
        Process.__init__(self)
        self.quine = quine
        self.mynumber = n

    def run(self):
        processresults = []
        while True:
            task = 2
            try:
                new_task = self.quine.get_nowait()
                task = new_task
            except Exception:
                time.sleep(5)
                continue
            if task == None:
                self.quine.put(None)
                with open("task{0}.txt".format(self.mynumber), "w+") as out:
                    for task_result in processresults:
                        out.write(str(task_result))
                        out.write("\n")
                break
            else:
                self.distributor(task, processresults)

    def distributor(self, curtask, processresults):
        if curtask.split("\t")[0] == "count_even":
            processresults.append(self.count_of_even(curtask))
        else:
            print(curtask)
            processresults.append(self.is_prime(curtask))

    def is_prime(self, value):
        is_prime = True
        value = int(value.split("\t")[1])
        for number in range(1, int(math.sqrt(value))):
            if value % number:
                is_prime = False
                break
        return is_prime

    def count_of_even(self, value):
        count = 0
        for number in range(int(value.split("\t")[1]), int(value.split("\t")[2]) + 1):
            if not number % 2:
                count += 1
        return count
def main():
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("--config", "-c", action="store", nargs=1, type=str)
    parser.add_argument("-n", "--numbers", action="store", nargs=1, type=int)
    args = parser.parse_args()
    s = ""
    q = Queue()
    with open(args.config[0], "r") as f:
        for line in f:
            s += line
    tasks = s.split("\n")
    processes = []
    for i in range(args.numbers[0]):
        processes.append(mProcess(q, i))
    for proc in processes:
        proc.start()
    for task in tasks:
        q.put(task)
    q.put(None)

if __name__ == '__main__':
    main()