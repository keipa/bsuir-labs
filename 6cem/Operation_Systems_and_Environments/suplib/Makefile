CC = g++
CFLAGS = -std=gnu++11 -c -O2 -fPIC -Wall
LDFLAGS = -shared

SRC = $(wildcard *.c)
OBJECTS = $(SRC:.c=.o)
LIBNAME = libsuplib.so

all: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $(LIBNAME) $(OBJECTS)
	echo "Library Compiled!"

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	-rm -r *.o *~ *.so
