#include "stdio.h"

#include "../suplib/astring.h"
#include "../suplib/aio.h"


int main()
{
    astring_arr arr = {NULL, 0};
    READ_STATE read_state = readlines(STDIN_FILENO, &arr);
    if (read_state == NO_MEMORY || read_state == IO_ERROR) {
        return 1;
    }

    for (int64_t i = 0; i < arr.size; i++) {
        if (arr.data[i].data != NULL) {
            for (int64_t j = arr.data[i].len; j > -1; j--) {
                printf("%c", arr.data[i].data[j]);
            }
            printf("\n");
        }
    }
    return 0;
}
