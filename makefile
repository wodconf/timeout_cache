CC = gcc
SRCS = ./test/test.c ./src/toentrytable.c
DEBUG=-g 
CFALGS = -O3
INC_DIR = -I./include
all:test-realease test-debug

test-realease:$(SRCS)
	$(CC) $(CFALGS) $(INC_DIR) -o $@ $^ -pg
test-debug:$(SRCS)
	$(CC) $(DEBUG) $(INC_DIR) -o $@ $^ -pg