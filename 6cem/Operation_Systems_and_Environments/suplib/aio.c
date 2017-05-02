#include "./aio.h"

typedef READ_STATE (*io_state_f)(READ_STATE, astring*, uint8_t);
typedef READ_STATE (*io_read_f)(int, astring*);


static int increase_astring_for_one_char(astring* str)
{
    if (str->len == str->capasity) {
        uint32_t s = !str->capasity ? START_ASTRING_SIZE : str->capasity * 2;
        return astring_resize(str, s);
    }
    return 0;
}

READ_STATE io_cycle(int fd, io_state_f func, astring* str)
{
    uint8_t buf;
    int8_t read_status;
    READ_STATE curs = START_STATE;
    while ((read_status = read(fd, &buf, sizeof(buf))) > 0) {
        if (increase_astring_for_one_char(str)) {
            goto no_memory;
        }
        if ((curs = func(curs, str, buf)) == END_IO_CYCLE) {
            break;
        }
    }

    if (read_status == -1) {
        curs = IO_ERROR;
        goto read_error;
    } else if (read_status == 0) {
        return EOF_STATE;
    }
    return curs;

 read_error:
    syslog(LOG_ERR, "AUTOLIB: IO cycle - IO error!");
    goto error_exit;
 no_memory:
    syslog(LOG_ERR, "AUTOLIB: IO cycle - No memory!\n");
 error_exit:
    if (str->data != NULL) {
        free_astring(str);
    }
    return curs;
}

static READ_STATE readword_state(READ_STATE curs, astring* str, uint8_t c)
{
    if ((c == '\n' && str->len != 0)
        || ((c == ' ' || c == '\t') && str->len != 0)) {
        str->data[str->len] = '\0';
    }
    if ((curs == START_STATE
         || curs == NEW_LINE_STATE
         || curs == SPACE_STATE)
        && c == '\n') {
        return NEW_LINE_STATE;
    } else if ((curs == START_STATE
                || curs == SPACE_STATE
                || curs == NEW_LINE_STATE)
               && (c == ' ' || c == '\t')) {
        return SPACE_STATE;
    } else if (curs == TEXT_STATE && (c == '\n' || c == ' ' || c == '\t')) {
        return END_IO_CYCLE;
    }

    str->data[str->len++] = c;
    return TEXT_STATE;
}

READ_STATE readword(int fd, astring* str)
{
    if (str->capasity != 0) {
        str->len = 0;
        str->data[0] = '\0';
    }
    return io_cycle(fd, readword_state, str);
}


static READ_STATE readline_state(READ_STATE curs, astring* str, uint8_t c)
{
    if (c == '\n') {
        str->data[str->len] = '\0';
        return END_IO_CYCLE;
    }

    str->data[str->len++] = c;
    return TEXT_STATE;
}

READ_STATE readline(int fd, astring* str)
{
    return io_cycle(fd, readline_state, str);
}

static READ_STATE readall_to_oneline_state(READ_STATE curs,
                                           astring* str, uint8_t c)
{
    str->data[str->len++] = c;
    return TEXT_STATE;
}

READ_STATE readall_to_oneline(int fd, astring* str)
{
    return io_cycle(fd, readall_to_oneline_state, str);
}


READ_STATE io_read_array_cycle(int fd, astring_arr* arr, io_read_f func)
{
    uint32_t cur_el_num = 0;
    READ_STATE curs = START_STATE;

    if (astring_arr_resize(arr, START_ARRAY_SIZE) == 1) {
        goto no_memory;
    }
    while (curs != EOF_STATE && curs != NO_MEMORY && curs != IO_ERROR) {
        if (cur_el_num == arr->size
            && astring_arr_resize(arr, arr->size * 2) == 1) {
            goto no_memory;
        }
        curs = func(fd, &(arr->data[cur_el_num++]));
    }

    if (curs == NO_MEMORY) {
        goto no_memory;
    } else if (curs == IO_ERROR) {
        goto io_error;
    }
    return curs;

 io_error:
    syslog(LOG_ERR, "AUTOLIB: IO read array cycle - IO error!\n");
    goto error_exit;
 no_memory:
    syslog(LOG_ERR, "AUTOLIB: IO read array cycle - No memory!\n");
 error_exit:
    free_astring_arr(arr);
    return NO_MEMORY;
}


READ_STATE readlines(int fd, astring_arr* arr)
{
    return io_read_array_cycle(fd, arr, readline);
}

READ_STATE readwords(int fd, astring_arr* arr)
{
    return io_read_array_cycle(fd, arr, readword);
}
