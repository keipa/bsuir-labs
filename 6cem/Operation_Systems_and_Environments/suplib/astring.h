#ifndef ASTRING_H
#define ASTRING_H

#include "string.h"
#include "stdint.h"
#include "stdlib.h"
#include "stdio.h"

const uint32_t START_ARRAY_SIZE = 25;
const uint32_t START_ASTRING_SIZE = 80;

typedef struct astring_t {
    char* data;
    uint32_t len;
    uint32_t capasity;
} astring;

typedef struct astring_arr_t {
    astring* data;
    uint32_t size;
} astring_arr;

int astring_resize(astring* str, uint32_t new_capasity);
void free_astring(astring* str);

int astring_arr_resize(astring_arr* arr, uint32_t new_size);
void free_astring_arr(astring_arr* arr);

#endif // ASTRING_H
