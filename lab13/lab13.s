.section .text

.set BASE_SERIAL_PORT, 0xFFFF0100


.globl main

main:
    jal set_read   # seta 1 na read, lê, quando acaba leitura seta 0, a0 tem numero de bytes lidos 

    lb a1, 0(sp)   # desempilhamos o numero da operação em a1
    addi sp, sp, 4

    li t0, '1'
    beq a1, t0, operation_1

    li t0, '2'
    beq a1, t0, operation_2

    li t0, '3'
    beq a1, t0, operation_3

    li t0, '4'
    beq a1, t0, operation_4




operation_1:
    jal set_read 
    # em ao temos o numeros de bytes lidos

    jal set_write


set_read:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sw t1, 2(a1)        # setando 1 na read

wait_read:
    lw t2, 2(a1)
    bnez t2, wait_read         # enquanto base+2 for 1, esperamos no loop

    li a0, 0

read:
    addi a0, a0, 1
    li a1, BASE_SERIAL_PORT

    lb t2, 3(a1)

    addi sp, sp, -4
    sb t2, 0(sp)          # empilhando cada byte na pilha 

    bnez t2, read

unset_read:
    li t0, 0x02
    li a1, BASE_SERIAL_PORT
    add a1, a1, t0
    li t1, 0
    sw t1, 0(a1)        # acabamos leitura, seta 0 na read

    ret

set_write:
    mv t0, a0

write:
    addi t0, t0, -1

    li a2, BASE_SERIAL_PORT
    add t2, t0, a2   # base + offset
    
    lb t1, 0(sp)     # tira char da pilha
    sb t1, 0(t2)     # coloca no lugar certo

    addi sp, sp, 4  # add na pilha

    bge t0, zero, write   # se o numero de bytes lidos ainda nao eh 0, continuamos escrevendo

    li t3, 0x01
    add a2, a2, t3

    li t3, 1
    sw t3, 0(s2)   # write

    ret








