square_root.o: square_root.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax square_root.s -c -o square_root.o

prog.x: square_root.o
	ld.lld square_root.o -o executable.x