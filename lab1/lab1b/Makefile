start.s: start.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax start.c -S -o start.s

start.o: start.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax start.s -c -o start.o