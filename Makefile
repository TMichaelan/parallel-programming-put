CC=gcc
OFLAGS=-O3 -g
WFLAGS=-Wall -Werror
LDFLAGS=-lm
CFLAGS=$(OFLAGS) $(WFLAGS)
OMPFLAGS=-fopenmp

SRC :=	quick_sequence.c \
	merge_sequence.c \
	quick_parallel.c \
	merge_parallel.c \

ALL :=  $(foreach src,$(SRC),$(subst .c,,$(src)))

default: $(ALL)

tags: $(SRC)
	ctags $^

quick_sequence: quick_sequence.c
	$(CC) $(CFLAGS) $(OMPFLAGS) $^ -o $@ $(LDFLAGS)

merge_sequence: merge_sequence.c get_time.o
	$(CC) $(CFLAGS) $(OMPFLAGS) $^ -o $@ $(LDFLAGS)

quick_parallel: quick_parallel.c
	$(CC) $(CFLAGS) $(OMPFLAGS) $^ -o $@ $(LDFLAGS)

merge_parallel: merge_parallel.c
	$(CC) $(CFLAGS) $(OMPFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	@- rm -f get_time.o
	@- rm -f $(ALL) tags
