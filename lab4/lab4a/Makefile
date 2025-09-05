lab4a.s: lab4a.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab4a.c -S -o lab4a.s

lab4a.o: lab4a.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab4a.s -c -o lab4a.o

prog.x: lab4a.o
	ld.lld lab4a.o -o executable.x