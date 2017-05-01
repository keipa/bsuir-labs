#include <iostream>
#include <thread>
#include <fstream>
#include <atomic>
#include <string>
#include <chrono>
#include <list>
#include <vector>
#include <mutex>
#include <signal.h>

// make
//./threadstring.bin superkek
// tail -f superkek


const std::string log = "Thread number: ";
volatile sig_atomic_t is_program_alive = 1;

void sig_handler(int signo)
{
    is_program_alive = 0;
}

void thread_func(int thread_number, std::ofstream &file,
                 std::mutex &mtx, bool &is_thread_alive)
{
    while(is_program_alive && is_thread_alive) {
        mtx.lock();
        file << log << std::to_string(thread_number) << std::endl;
        mtx.unlock();
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    }
}

int main(int argc, char *argv[])
{
    std::ofstream output(argv[1]);
    std::mutex mtx;
    std::list<std::thread*> thds;
    std::list<bool> threads_lifes;

    signal(SIGINT, sig_handler);
    threads_lifes.push_back(true);
    thds.push_back(new std::thread(thread_func, thds.size(), std::ref(output),
                                    std::ref(mtx), std::ref(threads_lifes.back())));

    std::string input;
    while(is_program_alive) {
        std::cin >> input;
        if (!is_program_alive) break;
        if (input == "+") {
            threads_lifes.push_back(true);
            thds.push_back(new std::thread(thread_func, thds.size(), std::ref(output),
                                    std::ref(mtx), std::ref(threads_lifes.back())));
        } else if (input == "-") {
            threads_lifes.back() = false;
            thds.back()->join();
            thds.pop_back();
            threads_lifes.pop_back();
        } else {
            is_program_alive = 0;
            for (auto *n: thds) {
                n->join();
            }
        }
    }
    return 0;
}