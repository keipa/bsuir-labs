#ifndef APROC_H
#define APROC_H

#include "stdio.h"
#include "stdlib.h"
#include "unistd.h"

#include "syslog.h"

typedef struct dup_pipe_t
{
    int readd; // For reading
    int writed; // For writing
} dup_pipe;

typedef struct proc_dp_t
{
    pid_t pid;
    dup_pipe pipes;
} proc_dp;

proc_dp* create_process_dp(int8_t* is_child);
proc_dp** create_processes_dp(int* count, int8_t* is_child);

#endif // APROC_H
