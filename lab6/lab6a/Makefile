lab6a.o: lab6a.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab6a.s -c -o lab6a.o

prog.x: lab6a.o
	ld.lld lab6a.o -o executable.x