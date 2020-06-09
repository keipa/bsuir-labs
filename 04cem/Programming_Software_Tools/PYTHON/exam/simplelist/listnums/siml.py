import sys
import time
from multiprocessing import Process, Queue, Event
from threading import Thread
import queue


class Mythread(Thread):

    def __init__(self, queue, event, func):
        Thread.__init__(self)
        self.queue = queue
        self.event = event
        self.func = func

    def run(self):
        while self.event.is_set():
            try:
                value = self.queue.get_nowait()
                print(self.func(value))
            except queue.Empty:
                time.sleep(3)



class MyProcess(Process):
    def __init__(self, queue, event, func):
        Process.__init__(self)
        self.queue = queue
        self.event = event
        self.func = func

    def run(self):
        while self.event.is_set():
            try:

                value = self.queue.get_nowait()
                print(self.func(value))
            except queue.Empty:
                time.sleep(3)


def top_func(x):
    return x ** 2



def main():

    event = Event()
    queue = Queue()
    proc_pool = [MyProcess(queue, event, top_func) for _ in range(4)]
    event.set()
    for i in range(1000):
        queue.put(i)
    for proc in proc_pool:
        proc.start()
    while not queue.empty():
        time.sleep(1)

    event.clear()
    for proc in proc_pool:
        proc.join()


if __name__ == '__main__':
    sys.exit(main())