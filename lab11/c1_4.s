.data
.globl operation

operation:
    # a0 a a7 já que a-h
    lw t0, 0(sp) # i
    lw t1, 4(sp) # j
    lw t2, 8(sp) # k
    lw t3, 12(sp) # l
    lw t4, 16(sp)  # m
    lw t5, 20(sp)  # n

    add a0, a1, a2
    sub a0, a0, a5
    add a0, a0, a7
    add a0, a0, t2
    sub a0, a0, t4

    ret