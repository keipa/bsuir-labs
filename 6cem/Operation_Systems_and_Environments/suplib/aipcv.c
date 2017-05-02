#include "./aipcv.h"

semv* excreate_semv_k(key_t key, uint32_t count)
{
    int oflag = IPC_CREAT | IPC_EXCL | 0666;
    semv* sem = (semv*)malloc(sizeof(semv));
    if (sem == NULL) {
        goto malloc_error;
    } else if ((sem->semid = semget(key, count, oflag)) < 0) {
        printf("Can't create semaphore group. "
               "Please check group key, maybe this group exist yet.\n");
        goto semget_error;
    }
    union semun arg;
    arg.val = 1;
    semctl(sem->semid, 0, SETVAL, arg);
    return sem;

semget_error:
    free(sem);
malloc_error:
    return NULL;
}

semv* excreate_semv(const char* gsem_name, int project_id, uint32_t count)
{
    key_t key;
    if ((key = ftok(gsem_name, project_id)) == -1) {
        printf("Key error!\n");
        goto key_error;
    }
    return excreate_semv_k(key, count);

key_error:
    return NULL;
}

semv* create_semv_k(key_t key, uint32_t count)
{
    int oflag = IPC_CREAT | 0666;
    semv* sem = (semv*)malloc(sizeof(semv));
    if (sem == NULL) {
        goto malloc_error;
    } else if ((sem->semid = semget(key, count, oflag)) < 0) {
        printf("Can't create semaphore group. "
               "Please check group key, maybe this group exist yet.\n");
        goto semget_error;
    }
    union semun arg;
    arg.val = 1;
    semctl(sem->semid, 0, SETVAL, arg);
    return sem;

semget_error:
    free(sem);
malloc_error:
    return NULL;
}

semv* create_semv(const char* gsem_name, int project_id, uint32_t count)
{
    key_t key;
    if ((key = ftok(gsem_name, project_id)) == -1) {
        printf("Key error!\n");
        goto key_error;
    }
    return create_semv_k(key, count);

key_error:
    return NULL;
}

semv* get_semv_k(key_t key)
{
    union semun arg;
    struct semid_ds seminfo;
    const int WAIT_TIMES = 12;
    semv* sem = (semv*)malloc(sizeof(semv));
    if (sem == NULL) {
        goto malloc_error;
    }   else if ((sem->semid = semget(key, 0, 0)) < 0) {
        printf("Get sem error!\n");
        goto get_error;
    }

    arg.buf = &seminfo;
    for (int i = 0; i < WAIT_TIMES; i++) {
        semctl(sem->semid, 0, IPC_STAT, arg);
        if (arg.buf->sem_otime != 0) {
            return sem;
        }
        sleep(1);
    }

get_error:
    free(sem);
malloc_error:
    return NULL;
}

semv* get_semv(const char* gsem_name, int project_id)
{
    key_t key;
    if ((key = ftok(gsem_name, project_id)) == -1) {
        printf("Key error!\n");
        goto key_error;
    }
    return get_semv_k(key);

key_error:
    return NULL;
}

int destroy_semv_k(const char* gsem_name, int project_id)
{
    key_t key;
    int semid;
    if ((key = ftok(gsem_name, project_id)) == -1) {
        printf("Key error!\n");
        goto key_error;
    } else if ((semid = semget(key, 0, 0)) < 0) {
        printf("Get sem error!\n");
        goto get_error;
    }
    semctl(semid, 0, IPC_RMID);
    return 0;

get_error:
key_error:
    return 1;
}

int semwait_semv(int semid, int semnum)
{
    struct sembuf ops;
    ops.sem_num = semnum;
    ops.sem_op = -1;
    return semop(semid, &ops, 1);
}

int semwait_empty_semv(int semid, int semnum)
{
    struct sembuf ops;
    ops.sem_num = semnum;
    ops.sem_op = 0;
    return semop(semid, &ops, 1);
}

int semtrywait_semv(int semid, int semnum)
{
    struct sembuf ops;
    ops.sem_num = semnum;
    ops.sem_op = -1;
    ops.sem_flg |= IPC_NOWAIT;
    return semop(semid, &ops, 1);
}

int sempost_semv(int semid, int semnum)
{
    struct sembuf ops;
    ops.sem_num = semnum;
    ops.sem_op = 1;
    return semop(semid, &ops, 1);
}
