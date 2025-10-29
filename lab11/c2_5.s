.globl node_creation

node_creation:
    addi sp, sp, -16

    sw   ra, 8(sp)

    li   t0, 30
    li   t1, 25
    li   t2, 64
    li   t3, -12

    sw   t0, 0(sp)      
    sb   t1, 4(sp)      
    sb   t2, 5(sp)      
    sh   t3, 6(sp)   

    mv   a0, sp
    
    jal  mystery_function

    lw   ra, 8(sp)
    addi sp, sp, 16

    ret