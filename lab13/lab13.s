.section .text

.set SERIAL_PORT, 0xFFFF0100

which_operation:

in_buffer:  


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




operation_2:

operation_3:

operation_4:

set_read:
    li t0, 0x02
    li a1, SERIAL_PORT
    add a1, a1, t0
    li t1, 1
    sw t1, 0(a1)        # setando 1 na read

    li a0, 0

read:
    addi a0, a0, 1
    li t1, 0x03
    li a1, SERIAL_PORT
    add a1, a1, t1

    lb t2, 0(a1)

    addi sp, sp, -4
    sb t2, 0(sp)          # empilhando cada byte na pilha 

    bnez t2, read

unset_read:
    li t0, 0x02
    li a1, SERIAL_PORT
    add a1, a1, t0
    li t1, 0
    sw t1, 0(a1)        # acabamos leitura, seta 0 na read

    ret

set_write:
    mv t0, a0
    li t1, 4

write:
    addi t0, t0 -1
    mul t2, t0, t1

    li a2, SERIAL_PORT
    add t2, t2, a2
    
    lw t1, 0(sp)
    sw t1, 0(t2)

    addi sp, sp, 4

    bge t0, zero, write

    


