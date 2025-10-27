.data
.globl swap_int
.globl swap_short
.globl swap_char

swap_int:
    # word
    lw t0, 0(a0)
    lw t1, 0(a1)
    sw t1, 0(a0)
    sw t0, 0(a1)

    li a0, 0

    ret

swap_short:
    # halfword
    lh t0, 0(a0)
    lh t1, 0(a1)
    sh t1, 0(a0)
    sh t0, 0(a1)

    li a0, 0

    ret

swap_char:
    # byte
    lb t0, 0(a0)
    lb t1, 0(a1)
    sb t1, 0(a0)
    sb t0, 0(a1)

    li a0, 0

    ret