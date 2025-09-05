lab5a.s: lab5a.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab5a.c -S -o lab5a.s

lab5a.o: lab5a.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab5a.s -c -o lab5a.o

prog.x: lab5a.o
	ld.lld lab5a.o -o executable.x