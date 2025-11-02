.section .text

.set BASE_SERIAL_PORT, 0xFFFF0100


.globl main

main:
    jal read_operation   # seta 1 na read, lê char, a0 tem o char
    mv s1, a0           # por segurança

    jal read_operation

    li t0, 49
    beq s1, t0, operation_1

    li t0, 50
    beq s1, t0, operation_2

    li t0, 51
    beq s1, t0, operation_3

    li t0, 52
    beq s1, t0, operation_4

    li a7, 93
    ecall

read_operation:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_operation:
    lb t2, 2(a1)
    bnez t2, wait_read_operation

    lb a0, 3(a1)

    ret


operation_1:
    jal read_char_op1

    jal write_char_op1

    li t1, '\n'
    bne t1, a0, operation_1

    li a7, 93
    ecall

read_char_op1:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_op1:
    lb t2, 2(a1)
    bnez t2, wait_read_op1        # enquanto base+2 for 1, esperamos no loop

    lb a0, 3(a1)

    ret

write_char_op1:
    li a1, BASE_SERIAL_PORT

wait_write_op1:
    lb t1, 0(a1)
    bnez t1, wait_write_op1     # enquanto base for 1, esperamos no loop

    sb a0, 1(a1)

    li t2, 1
    sb t2, 0(a1)

    ret

operation_2:
    li t0, 0            # tcontador de bytes

read_word_op2:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_word_op2:
    lb t2, 2(a1)
    bnez t2, wait_read_word_op2         # enquanto base+2 for 1, esperamos no loop

    lb t2, 3(a1)

    li t3, '\n'
    beq t2, t3, write_reversed_op2      # se o char lido for um \n, acabou a leitura

    addi sp, sp, -4
    sb t2, 0(sp)          # empilhando cada byte na pilha 
    addi t0, t0, 1           # contador pra ver quantos bytes foram lidos

    j read_word_op2

write_reversed_op2:
    beqz t0, write_newline_op2          # contador de bytes igual a 0, escrevemos o \n final

    lb a0, 0(sp)       # tira char da pilha
    addi sp, sp, 4     # add na pilha

write_char_loop_op2:
    li a1, BASE_SERIAL_PORT

    lb t1, 0(a1)
    bnez t1, write_char_loop_op2     # enquanto base for 1, esperamos no loop

    sb a0, 1(a1)     # coloca no lugar certo

    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

wait_write_op2:
    lb t1, 0(a1)
    bnez t1, wait_write_op2     # esperamos a escrita terminar, ou seja ficar igual a 0

    addi t0, t0, -1             # decrementa no contador de bytes
    j write_reversed_op2

write_newline_op2:
    li a0, '\n'
    li a1, BASE_SERIAL_PORT

wait_newline_write_op2:
    lb t1, 0(a1)
    bnez t1, wait_newline_write_op2

    sb a0, 1(a1)      # escreve \n final
    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

wait_newline_complete_op2:
    lb t1, 0(a1)
    bnez t1, wait_newline_complete_op2     # esperamos a escrita terminar, ou seja ficar igual a 0

    li a7, 93
    ecall

operation_3:
    li a1, 0
    li a2, 10
    li a3, 16
    li s4, 0
    li s1, 1    # sinal
    jal convert_until_newline

convert_until_newline:
    li a4, '\n'
    bne a0, a4, read_char_op3
    # em a1 tem o inteiro decimal recebido

convert_hexadecimal: # se chgeamos aqui, chegou no ultimo newline
    beqz a1, write_digits_op3     # se o quociente é zero, terminamos
    
    remu t1, a1, a3    # resto
    divu a1, a1, a3    # quociente

    li t2, 10
    blt t1, t2, is_digit
    
    # 'A' = 65
    addi t1, t1, 55
    j push_digit

is_digit:
    addi t1, t1, 48    # '0'

push_digit:
    addi sp, sp, -4
    sw t1, 0(sp)
    addi s4, s4, 1       # contador de digitos escritos

    j convert_hexadecimal

write_digits_op3:
    beqz s4, finish_op3

    lb a0, 0(sp)       # tira char da pilha
    addi sp, sp, 4     # add na pilha

write_char_loop_op3:
    li a1, BASE_SERIAL_PORT

    lb t1, 0(a1)
    bnez t1, write_char_loop_op3     # enquanto base for 1, esperamos no loop

    sb a0, 1(a1)     # coloca no lugar certo

    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

wait_write_op3:
    lb t1, 0(a1)
    bnez t1, wait_write_op3     # esperamos a escrita terminar, ou seja ficar igual a 0

    addi s4, s4, -1             # decrementa no contador de digitos 
    j write_digits_op3

finish_op3:
    li t1, '\n'
    li a1, BASE_SERIAL_PORT

    lb t1, 0(a1)
    bnez t1, write_char_loop_op3     # enquanto base for 1, esperamos no loop

    sb t1, 1(a1)     # coloca no lugar certo

    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

last_wait_write_op3:
    lb t1, 0(a1)
    bnez t1, last_wait_write_op3     # esperamos a escrita terminar, ou seja ficar igual a 0

    li a7, 93
    ecall

read_char_op3:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    li t5, 45         # '-'
    sb t1, 2(a1)        # setando 1 na read

wait_read_op3:
    lb t2, 2(a1)
    bnez t2, wait_read_op3        # enquanto base+2 for 1, esperamos no loop

    lb a0, 3(a1)
    mv t0, a0

    beq a0, t5, is_negative      # se o primeiro char eh "-", eh negativo, s1 = -1

    j convert_decimal

is_negative:
    li s1, -1

convert_decimal:
    mul a1, a1, a2
    addi t0, t0, -48

    add a1, a1, t0

    j convert_until_newline

operation_4:
