.data

.globl middle_value_int
.globl middle_value_short
.globl middle_value_char

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