.data

in_buffer:	.skip 100

no_index_str: .asciz "-1\n"

newline_str: .asciz "\n"

out_buffer: .skip 50

.text

.globl _start

gets:
    li a0, 0
    li a1, in_buffer
    li a2, 100
    li a7, 63
    ecall

    mv t0, a0     # t0 temporário pra guardarmos o n de byes lidos
    mv t1, a1     # t1 ponteiro pra andar no buffer
    li t2, 10     # '\n'


loop_gets:
    lb t3, 0(t1)
    beq t2, t3, found_newline

    addi t1, t1, 1
    j loop_gets

found_newline:
    sw zero, 0(t1)    # mudamos o último caractere de '\n' pra '\0'

end_gets:
    ret

puts:
    addi sp, sp, -4
    sw s0, 0(sp)      # empilhando o valor inicial de s0 para garantirmos que no final deixemos ele como estava

    mv s0, a0
    mv t0, a0
    li t1, zero

loop_puts:
    lb t2, a(t0)
    beq t2, zero, write_buffer

    addi t0, t0, 1    # andando no buffer
    addi t1, t1, 1    # somando no contador

    j loop_puts

write_buffer:
    li a0, 1
    mv a1, s0        # onde guardamos o endereço
    mv a2, t1        # o contador de caracteres
    li a7, 64
    ecall

    li a0, 1
    li a1, newline_char
    li a2, 1
    li a7, 64
    ecall

    li a0, 0         # retorno

    lw s0, 0(sp)
    addi sp, sp, 4   # desempilhando 

fim_puts:
    ret

