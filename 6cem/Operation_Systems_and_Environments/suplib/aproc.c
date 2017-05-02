#include "./aproc.h"

/* Create new process
   Return to parent(is_child = 0) and to child(is_child = 1) structure
   for process communication

   Return NULL if fork unsuccessed
*/
proc_dp* create_process_dp(int8_t* is_child)
{
    pid_t pid = 0;
    int pipe_pair_pr[2]; // For parent read
    int pipe_pair_pw[2]; // For parent write

    proc_dp* proc = (proc_dp*)calloc(1, sizeof(proc_dp));
    if (proc == NULL) {
        syslog(LOG_WARNING, "AUTOLIB: No memory for process creating!\n");
        goto memory_alloc_failed;
    }

    if (pipe(pipe_pair_pr) == -1) {
        syslog(LOG_WARNING, "AUTOLIB: Can't open pipe!\n");
        goto parent_read_pipe_failed;
    }
    if (pipe(pipe_pair_pw) == -1) {
        syslog(LOG_WARNING, "AUTOLIB: Can't open pipe!\n");
        goto parent_write_pipe_failed;
    }

    pid = fork();
    if (pid == 0) { // Child
        *is_child = 1;
        proc->pid = getpid();
        close(pipe_pair_pr[0]); // Close in parent-read pipe read descriptor
        close(pipe_pair_pw[1]); // Close in parent-write pipe write descriptor
        proc->pipes.readd = pipe_pair_pw[0];
        proc->pipes.writed = pipe_pair_pr[1];
    } else if (pid < 0) { // Fork failed
        close(pipe_pair_pw[1]);
        close(pipe_pair_pw[0]);
        close(pipe_pair_pr[1]);
        close(pipe_pair_pr[0]);
        syslog(LOG_ERR, "AUTOLIB: Fork failed!\n");
        goto fork_failed;
    } else { // Parent
        *is_child = 0;
        close(pipe_pair_pr[1]); // Close in parent-read pipe write descriptor
        close(pipe_pair_pw[0]); // Close in parent-write pipe read descriptor
        proc->pid = pid;
        proc->pipes.readd = pipe_pair_pr[0];
        proc->pipes.writed = pipe_pair_pw[1];
    }
    return proc;

parent_write_pipe_failed:
    close(pipe_pair_pr[1]);
    close(pipe_pair_pr[0]);
parent_read_pipe_failed:
fork_failed:
    free(proc);
memory_alloc_failed:
    *is_child = 0;
    return NULL;
}

/* Create processes, that can communicate with parent through the unnamed pipes
   Return NULL and is_child = 0 if no one process created

   Return pointer to pointer on proc_dp struct if it child, is_child = 1,
   count=1;

   Return array, which size equal to count, is_child = 0, count unchanged, if
   all processes successfully created

   Return array, which size equal to count, is_child = 0, count changed, if
   not all processes successfully created
*/
proc_dp** create_processes_dp(int* count, int8_t* is_child)
{
    int i = 0;
    proc_dp** processes;
    proc_dp** single_proc;
    *is_child = 0;
    processes = (proc_dp**)malloc(*count * sizeof(proc_dp*));
    if (processes == NULL) {
        syslog(LOG_WARNING, "AUTOLIB: No memory for process group!\n");
        goto proc_group_memory_alloc_failed;
    }

    single_proc = (proc_dp**)malloc(sizeof(proc_dp*));
    if (single_proc == NULL) {
        syslog(LOG_WARNING, "AUTOLIB: No memory for single group!\n");
        goto single_proc_memory_alloc_failed;
    }

    for (i = 0; i < *count; i++) {
        proc_dp* proc = create_process_dp(is_child);
        if (proc == NULL) {
            if (i == 0) {
                syslog(LOG_WARNING, "AUTOLIB: No on process created!\n");
                goto fork_failed_i_is_equal_zero;
            }
        } else if (*is_child == 1) {
            for (int j = 0; j < i; j++) {
                free(processes[j]);
            }
            free(processes);
            *count = i;
            single_proc[0] = proc;
            return single_proc;
        } else {
            processes[i] = proc;
        }
    }
    free(single_proc);
    return processes;

fork_failed_i_is_equal_zero:
    free(processes);
    free(single_proc);
proc_group_memory_alloc_failed:
    *count = 0;
    return NULL;
single_proc_memory_alloc_failed:
    *count = 0;
    free(processes);
    return NULL;
}
