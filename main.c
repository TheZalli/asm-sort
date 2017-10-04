#include <stdio.h>
#include <stdint.h>

// defined in sort.asm
extern void sort(int64_t* arr, size_t length);

#ifndef ARRAY_LEN
#define ARRAY_LEN 5
#endif

int64_t array[ARRAY_LEN] = {4, -4, 0, 1, -7};

int main(int argc, char **argv) {
    sort(array, ARRAY_LEN);

    for (size_t i = 0; i < ARRAY_LEN; i++) {
        printf("%i, ", array[i]);
    }
    printf("\n");

    return 0;
}
