.section .text

.set MEMORY_SLOT, 0xFFFF0100
.set X_TEST_TRACK, 73
.set Y_TEST_TRACK, 1
.set Z_TEST_TRACK, -19

.globl main

main:
    jal set_reading

    jal move_car

    li a7, 93
    ecall                    # exit syscall     

move_car:
    jal set_engine_forward

    li a6, MEMORY_SLOT

    li a0, X_TEST_TRACK
    li t0, 0x10
    add a1, a6, t0          # pegando x

    li a2, Y_TEST_TRACK
    li t0, 0x14
    add a3, a6, t0          # pegando y

    li a4, Z_TEST_TRACK
    li t0, 0x18
    add a5, a6, t0          # pegando z

    # dist euclidiana
    sub a0, a0, a1
    mul a0, a0, a0    # x²

    sub a2, a2, a3
    mul a2, a2, a2    # y²

    sub a4, a4, a5
    mul a4, a4, a4    # z²

    add a0, a0, a2
    add a0, a0, a4    # x² + y² + z²

    li t0, 15         # raio de alcance

    bge a0, t0, move_car   # se a dist euclidiana eh maior ou igual ao raio de alcance, o carro move

    ret     # se não, retornamos e chamamos exit syscall na main


set_reading:
    li a0, MEMORY_SLOT
    li t0, 1
    sb t0, 0(a0)

    ret

set_engine_forward:
    li a0, MEMORY_SLOT
    li t0, 0x21
    add a0, a0, t0
    li t0, 1
 
    sb t0, 0(a0)             # colocando 1 na engine


set_steering_wheel:
    li a0, MEMORY_SLOT
    li t0, 0x20
    add a0, a0, t0
    li t0, -15       # inclinação necessária p esquerda pra entrar corretamente no test track na tentativa e erro
    sb t0, 0(a0)

    ret