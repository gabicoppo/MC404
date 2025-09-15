lab5b.s: lab5b.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab5b.c -S -o lab5b.s

lab5b.o: lab5b.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab5b.s -c -o lab5b.o

prog.x: lab5b.o
	ld.lld lab5b.o -o executable.x