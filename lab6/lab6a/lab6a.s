# Inform the assembler that, from now on, we want to add information to the .data section.
.data

# This is a buffer with 20 bytes that will be used to 
# read data from the stdin.
# - The in_buffer label identifies the address of the first byte in the buffer
# - The .skip 20 directive instructs the assembler to reserve 20 bytes on the .data section.
in_buffer:	.skip 20

# buffer que vamos usar pra escrever a saída
out_buffer: .skip 20

# Inform the assembler that, from now on, we want to add information to the .text section.
.text

# Inform the assembler that the _start symbol is a global symbol.
# This will allow the linker to identify the program entry point.
.globl _start

_start:
    # read
    li a0, 0  # file descriptor = 0 (stdin)
    la a1, in_buffer #  buffer to write the data
    li a2, 20  # size (reads 20 bytes)
    li a7, 63 # syscall read (63)
    ecall

    # guardadndo address do input in a0 e do output em s2
    la s0, in_buffer
    la s1, out_buffer  
    li s2, 4 # loop dos 4 n de entrada

loop_convert_int_to_char:
    # guardando cada dígito em um rd
    lbu t0, 0(s0)   
    lbu t1, 1(s0) 
    lbu t2, 2(s0)
    lbu t3, 3(s0)

    # convertendo cada dígito em ints
    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a1, t0 # copiei pro registrador a1, já que vamos usar como parametro de função

    li a5, 2
    srli a2, a1, 1

    li t0, 0
    li t1, 10

square_root:
    divu t5, a1, a2        # a3 = a1 / a2
    add a2, a2, t5         # a2 = a2 + a3
    srli a2, a2, 1         # a2 = a2 / 2
    addi t0, t0, 1
    bne t0, t1, square_root

convert_int_to_char:
    mv t0, a2
    la a1, out_buffer

    li t1, 1000
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 0(s1) # guardando o primeiro numero no buffer de saída
    remu t0, t0, t1 # pegando o resto da divisão por 1000 pra  converter prox digito

    li t1, 100
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 1(s1) # guardando o segundo numero no buffer de saída
    remu t0, t0, t1  # pegando o resto da divisão por 100 pra  converter prox digito

    li t1, 10
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 2(s1) # guardando o terceiro numero no buffer de saída
    remu t0, t0, t1  # pegando o resto da divisão por 10 pra converter prox digito

    addi t2, t0, 48 # só somamos 48
    sb t2, 3(s1) # e colocamos no buffer de saída

    li t2, ' '
    sb t2, 4(s1)

    # avança input/output
    addi s0, s0, 5
    addi s1, s1, 5

    addi s2, s2, -1
    bnez s2, loop_convert_int_to_char

    # último número: trocar espaço por '\n'
    li t2, '\n'
    sb t2, -1(s1)

    #write
    li a0, 1            # file descriptor = 1 (stdout)
    la s1, out_buffer       # buffer
    li a2, 20           # size
    li a7, 64           # syscall write (64)
    ecall

    # Invoke the syscall exit to finalize the program.
    li a0, 0         
    li a7, 93        
    ecall            # Invoke the syscall