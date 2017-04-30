#include "stdio.h"
#include "stdint.h"
#include "stdlib.h"
#include "unistd.h"
#include "sys/types.h"

static const uint8_t BYTE_SIZE = 8;

void print_byte_bits(uint8_t byte)
{
    printf("0b");
    for (uint8_t i = 0; i < BYTE_SIZE; i++) {
        if ((byte << i) & 0b10000000) {
            printf("1");
        } else {
            printf("0");
        }
    }
    printf("\n");
}

uint8_t reverse_bits(uint8_t input)
{
    uint8_t output = 0;
    for (uint8_t i = 0; i < BYTE_SIZE; i++) {
        if ((input >> i) & 0b1) {
            output |= (0b1 << (BYTE_SIZE - 1 - i));
        }
    }
    return output;
}

int main(int argc, char* argv[])
{
    uint8_t buf[1];
    while (read(STDIN_FILENO, buf, sizeof(buf))) {
        buf[0] = reverse_bits(buf[0]);
        write(STDOUT_FILENO, buf, sizeof(buf));
    }
    return 0;
}
