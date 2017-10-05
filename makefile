all: dir main.o sort.o
	gcc build/main.o build/sort.o -o bin/sort

main.o: dir main.c
	gcc main.c -std=c99 -c -o build/main.o

sort.o: dir sort.s
	as sort.s -o build/sort.o

dir:
	mkdir -p build bin

clean:
	rm -rf bin/ build/
