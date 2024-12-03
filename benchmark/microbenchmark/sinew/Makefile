debug: CFLAGS += -g
debug: all

all: sinew_test

sinew_test: ../json.o sinew_test.o document.o schema.o hash_table.o ../lib/jsmn/libjsmn.a

%.o: %.c
	$(CC) -c $(CFLAGS) $^ -o $@

test: clean-test
	./sinew_test ~/sinew/json_files/test_json_input.out deser.out project.out mproject.out

clean: clean-build clean-test

clean-build:
	rm -f *.o *.a sinew_test

clean-test:
	rm -f *.out *.schema *.db

# Build the jsmn static library
../lib/jsmn/libjsmn.a: ../lib/jsmn/jsmn.o
	ar rcs $@ $^

../lib/jsmn/jsmn.o: ../lib/jsmn/jsmn.c
	$(CC) -c $(CFLAGS) $< -o $@
