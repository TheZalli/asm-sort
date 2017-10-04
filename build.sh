#!/bin/sh
mkdir -p build bin
cc main.c -std=c99 -c -o build/main.o
as sort.asm -o build/sort.o
gcc build/main.o build/sort.o -o bin/sort
