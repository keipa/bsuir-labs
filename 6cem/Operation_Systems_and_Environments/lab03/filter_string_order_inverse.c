#include "stdint.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "sys/types.h"
#include "unistd.h"
#include "fcntl.h"

#include "../suplib/astring.h"
#include "../suplib/aio.h"

int main()
{
    astring_arr arr = {NULL, 0};
    astring_arr_resize(&arr, START_ARRAY_SIZE);
    READ_STATE read_state = readlines(STDIN_FILENO, &arr);

    if (read_state == IO_ERROR || read_state == NO_MEMORY) {
        return 1;
    }

    for (int64_t i = arr.size - 1; i >= 0; i--) {
        if (arr.data[i].data != NULL) {
            printf("%s\n", arr.data[i].data);
        }
    }

    free_astring_arr(&arr);
    return 0;
}
