.data

.globl middle_value_int
.globl middle_value_short
.globl middle_value_char
.globl value_matrix

middle_value_int:
    li t0, 2
    divu a1, a1, t0
    li t0, 4
    mul a1, a1, t0
    add t1, a0, a1
    lw a0, 0(t1)
    
    ret

middle_value_short:
    li t0, 2
    divu a1, a1, t0
    li t0, 2
    mul a1, a1, t0
    add t1, a0, a1
    lh a0, 0(t1)
    
    ret

middle_value_char:
    li t0, 2
    divu a1, a1, t0
    add t1, a0, a1
    lb a0, 0(t1)
    
    ret

value_matrix:
    li   t0, 42

    mul  t1, a1, t0      # r * 42
    add  t1, t1, a2      # (r * 42) + c
    
    slli t2, t1, 2       # t1 * 4
    
    add  t3, a0, t2      # base + offset
    
    lw   a0, 0(t3)       
    
    ret