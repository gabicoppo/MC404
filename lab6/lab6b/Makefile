lab6b.o: lab6b.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab6b.s -c -o lab6b.o

prog.x: lab6b.o
	ld.lld lab6b.o -o executable.x