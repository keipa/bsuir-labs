#ifndef AIPCV_H
#define AIPCV_H

#include "stdio.h"
#include "stdint.h"
#include "unistd.h"
#include "stdlib.h"

#include "syslog.h"

#include "sys/ipc.h"
#include "sys/sem.h"
#include "sys/types.h"

#if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
/* union semun is defined by including <sys/sem.h> */
#else
/* according to X/OPEN we have to define it ourselves */
union semun {
    int val;                  /* value for SETVAL */
    struct semid_ds *buf;     /* buffer for IPC_STAT, IPC_SET */
    unsigned short *array;    /* array for GETALL, SETALL */
    /* Linux specific part: */
    struct seminfo *__buf;    /* buffer for IPC_INFO */
};
#endif

typedef struct semv_t {
    int semid;
    int semnum;
} semv;

semv* excreate_semv_k(key_t key, uint32_t count);
semv* create_semv_k(key_t key, uint32_t count);
semv* get_semv_k(key_t key);

semv* excreate_semv(const char* gsem_name, int project_id, uint32_t count);
semv* create_semv(const char* gsem_name, int project_id, uint32_t count);
semv* get_semv(const char* gsem_name, int project_id);

int destroy_semv_k(const char* gsem_name, int project_id);
int destroy_semv(int semid);

int semwait_semv(int semid, int semnum);
int semwait_empty_semv(int semid, int semnum);
int semtrywait_semv(int semid, int semnum);
int sempost_semv(int semid, int semnum);

#endif // AIPCV_H
