.data

in_buffer_1line:  .skip 17

in_buffer_2line:  .skip 20

out_buffer: .skip 20

.text

.globl _start

_start:
    # read
    li a0, 0  # = 0 (stdin)
    la a1, in_buffer_1line # buffer to write times Ta, Tb, Tc, Tr
    li a2, 17  # size 
    li a7, 63 # syscall read (63)
    ecall

    # read
    li a0, 0  # = 0 (stdin)
    la a1, in_buffer_2line # buffer to write times Ta, Tb, Tc, Tr
    li a2, 20  # size 
    li a7, 63 # syscall read (63)
    ecall

    # guardadndo address do input in a0 e do output em s2
    la s0, in_buffer_1line
    la s1, in_buffer_2line
    la s2, out_buffer  

convert_int_to_char_line2: # reutilizando codigo do 6a
# ---------- Ta ----------
    lbu t0, 0(s1)   
    lbu t1, 1(s1) 
    lbu t2, 2(s1)
    lbu t3, 3(s1)

    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a1, t0 

# ---------- Tb ----------
    # avança input
    addi s1, s1, 5

    lbu t0, 0(s1)   
    lbu t1, 1(s1) 
    lbu t2, 2(s1)
    lbu t3, 3(s1)

    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a2 t0 

# ---------- Tc ----------
    # avança input
    addi s1, s1, 5

    lbu t0, 0(s1)   
    lbu t1, 1(s1) 
    lbu t2, 2(s1)
    lbu t3, 3(s1)

    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a3, t0

# ---------- Tr ----------
    # avança input
    addi s1, s1, 5

    lbu t0, 0(s1)   
    lbu t1, 1(s1) 
    lbu t2, 2(s1)
    lbu t3, 3(s1)

    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a4, t0

calculating_distances:
    sub a1, a4, a1 # diferença entre Ta e Tr
    sub a2, a4, a2 # diferença entre Tb e Tr
    sub a3, a4, a3 # diferença entre Tc e Tr

    li t0, 3
    li t1, 10

    mul a1, a1, t0 # multiplica por 3
    div a1, a1, t1 # divide por 10

    mul a2, a2, t0
    div a2, a2, t1

    mul a3, a3, t0
    div a3, a3, t1

    li t0, 0
    li t1, 2

check_sign:
    addi t0, t0, 1
    li s0, 1 # inicialmente, setamos s0 pra 1
    lbu t0, 0(s0)   

    li   t1, 45  # Compara o caractere com o valor ASCII de '-' (45)
    bne  t0, t1, check_for_digit # Se nao for '-', pula para a conversao

    li s0, -1 # se for negativo, s0 vira -1

convert_int_to_char_line1:    # LIDAR COM NUMEROS NEGATIVOS
# ---------- coord X ---------- 
    lbu t1, 1(s0) 
    lbu t2, 2(s0)
    lbu t3, 3(s0)
    lbu t4, 4(s0)

    addi t0, t0, -48
    li t5, 1000
    mul t0, t0, t5

    addi t1, t1, -48
    li t5, 100
    mul t1, t1, t5

    add t0, t0, t1

    addi t2, t2, -48
    li t5, 10
    mul t2, t2, t5

    add t0, t0, t2

    addi t3, t3, -48

    add t0, t0, t3 # aqui terminei de somar os numeros convertidos
    mv a5, t0

    mul a5, a5, s0 # multiplicamos pelo sinal encontrado em 'check digit'

    addi s0, s0, 6
    bne t0, t1, check_for_digit

equation_1:


equation_2:

equation_3:

    