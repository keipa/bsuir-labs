CC = g++
CFLAGS = -c -std=gnu++11 -Wall -Wextra
LDFLAGS = -L./../suplib -lsuplib -lc -Wl,-rpath ./../suplib

LABS = $(wildcard *.c)
OBJECTS = $(LABS:.c=.o)
BINARIES = $(OBJECTS:.o=.bin)

all: clean build_suplib $(OBJECTS) $(BINARIES)
	echo "Compiled!"

build_suplib:
	cd ./../suplib; make; cd ./../lab03

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

%.bin: %.o
	$(CC) $(LDFLAGS) $< -o $@

clean:
	-make -C ./../suplib clean
	-rm -r *.o *.bin *~ *.new
