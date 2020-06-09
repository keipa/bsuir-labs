#include "stdio.h"

#include "../suplib/astring.h"
#include "../suplib/aio.h"


int main()
{
    astring word = {NULL, 0, 0};
    READ_STATE result = START_STATE;

    while ((result = readword(STDIN_FILENO, &word)) != EOF_STATE
           && result != NO_MEMORY) {
        printf("%s   --- %d\n", word.data, word.len);
        word.data[0] = '\0';
        word.len = 0;
    }
    return 0;
}
