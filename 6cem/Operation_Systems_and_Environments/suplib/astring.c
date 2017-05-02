#include "./astring.h"

int astring_resize(astring* str, uint32_t new_capasity)
{
    char* new_str = (char*)calloc(new_capasity, sizeof(char));
    if (new_str == NULL) {
        return 1;
    }

    if (str->data != NULL) {
        strcpy(new_str, str->data);
        free(str->data);
    }

    str->data = new_str;
    str->capasity = new_capasity;
    return 0;
}

void free_astring(astring* str)
{
    free(str->data);
}

int astring_arr_resize(astring_arr* arr, uint32_t new_size)
{
    astring* new_data = (astring*)calloc(new_size, sizeof(astring));
    if (new_data == NULL) {
        return 1;
    }

    if (arr->data != NULL) {
        memcpy(new_data, arr->data, arr->size * sizeof(astring));
        free(arr->data);
    }
    arr->data = new_data;
    arr->size = new_size;
    return 0;
}

void free_astring_arr(astring_arr* arr)
{
    if (arr != NULL) {
        for (uint32_t i = 0; i < arr->size; i++) {
            free_astring(&(arr->data[i]));
        }
        free(arr->data);
    }
}
