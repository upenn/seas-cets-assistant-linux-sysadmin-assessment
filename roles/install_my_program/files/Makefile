hello:
	echo "hello world"

my_program: my_program.o
	cc my_program.o -o my_program

my_program.o: my_program.c
	cc -c my_program.c -o my_program.o

my_program.c:
	echo '#include <stdio.h>' > my_program.c
	echo 'int main() { printf("Hello, World!\\n"); return 0; }' >> my_program.c
