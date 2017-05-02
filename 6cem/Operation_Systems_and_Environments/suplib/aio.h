#ifndef AIO_H
#define AIO_H

#include "stdint.h"
#include "unistd.h"

#include "syslog.h"

#include "./astring.h"

const uint8_t BYTE_SIZE = 8;

typedef enum READ_STATE_T {
    START_STATE = 0,
    SPACE_STATE,
    TEXT_STATE,
    NEW_LINE_STATE,
    EOF_STATE,
    NO_MEMORY,
    IO_ERROR,
    END_IO_CYCLE,
} READ_STATE;

READ_STATE readword(int fd, astring* str);
READ_STATE readline(int fd, astring* str);
READ_STATE readlines(int fd, astring_arr* arr);
READ_STATE readwords(int fd, astring_arr* arr);
READ_STATE readall_to_oneline(int fd, astring* str);

#endif // AIO_H
