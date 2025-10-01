.data

in_buffer_1line:  .skip 17

in_buffer_2line:  .skip 20

resultados_coordenadas: .skip 8

resultados_tempo: .skip 16

out_buffer: .skip 20

.text

.globl _start

loop_convert_int_to_char:
    # guardando cada dígito em um rd
    lbu t0, 0(s0)   
    lbu t1, 1(s0) 
    lbu t2, 2(s0)
    lbu t3, 3(s0)

    # convertendo cada dígito em ints
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
    mv a1, t0 # copiei pro registrador a1, já que vamos usar como parametro de função

    li a5, 2
    srli a2, a1, 1

    li t0, 0
    li t1, 10

convert_line1_number: # LIDAR COM NUMEROS NEGATIVOS
    li s0, 1 # inicialmente, setamos s0 pra 1
    lbu t0, 0(s0)   

    li t1, 45  # compara o caractere com o valor ASCII de '-' (45)
    li t2, 43

    beq t0, t1, is_neg_l1
    beq t0, t2, skip_sign_l1

is_neg_l1:
    li t3, -1

skip_sign_l1:
    addi s0, s0, 1         # pula o sinal

parse_digits_l1:
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

    mv a0, t0 
    addi s1, s1, 5

    ret


convert_line2_number: # reutilizando codigo do 6a
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

    mv a0, t0 
    addi s1, s1, 5

ret

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
    la s2, resultados_tempo
    la s3, out_buffer

    # ----------------- CONVERTENDO YB, XC  (linha 1) -----------------

    call convert_line1_number
    la t0, resultados_coordenadas
    sw a0, 0(t0)            # YB
    mv a5, a0

    call convert_line1_number
    sw a0, 4(t0)            # XC
    mv a4, a0

    # ----------------- CONVERTENDO Ta Tb Tc Tr (linha 2) -----------------

    call convert_line2_number
    la t1, resultados_tempo
    sw a0, 0(t1)

    call convert_line2_number
    sw a0, 4(t1)

    call convert_line2_number
    sw a0, 8(t1)

    call convert_line2_number
    sw a0, 12(t1)

    la t1, resultados_tempo
    lw a1, 0(t1)    # Ta
    lw a2, 4(t1)    # Tb
    lw a3, 8(t1)    # Tc
    lw a4, 12(t1)   # Tr


    # calculating_distances
    sub a1, a4, a1 # diferença entre Ta e Tr
    sub a2, a4, a2 # diferença entre Tb e Tr
    sub a3, a4, a3 # diferença entre Tc e Tr

    li t2, 3
    li t3, 10

    mul a1, a1, t2 # multiplica por 3
    div a1, a1, t3 # divide por 10

    mul a2, a2, t2
    div a2, a2, t3

    mul a3, a3, t2
    div a3, a3, t3

    # a1 = dA, a2 = dB, a3 = dC
    # a5 = Yb, a6 = Xc

    la t4, resultados_coordenadas
    sw a1, 0(t4)   # dA
    sw a2, 4(t4)   # dB
    sw a3, 8(t4)   # dC

    # equation_4:

    slli t3, a5, 1        # 2*YB

    mul a1, a1, a1        # dA²
    mul a2, a2, a2        # dB²
    mul a5, a5, a5        # YB²

    add t1, a1, a2        # dA² + YB²
    sub t2, t1, a2        # dA² + YB² - dB²

    div a6, t2, t3        # y = dA² + YB² - dB² / 2*YB

    mv t5, a6

    # equation_5:
    lw t5, 12(t2)       # y

    mul t5, t5, t5      # y²

    sub t6, a1, t5      # dA² - y²

    # a1 = dA², a2 = dB², a3 = dC
    # a5 = Yb², a4 = Xc, a6 = y

    # raiz quadrada inteira de t6
    mv a7, t6

    # a7 = dA² - y²

    srli a2, a7, 1 # first guess a7 / 2
    li t0, 0
    li t1, 21

    # infelizmente não consegui continuar o lab a partir daqui. as contas não estão dando certo e não
    # tenho tempo o suficiente para debuggar.

square_root: # reutilizando do lab a
    divu t4, a7, a2        # a3 = a1 / a2
    add a2, a2, t4         # a2 = a2 + a3
    srli a2, a2, 1         # a2 = a2 / 2
    addi t0, t0, 1
    bne t0, t1, square_root

    mv a5, a2            # retorno em a0 X PRÉ TESTE

    # testanto qiual X uso

    # x positivo

    mul a4, a4, a4 # a4 = Xc²
    mul a3, a3, a3 # a3 = dc²

    sub a5, a5, a4 # a5 = x - Xc²

    mul a5, a5, a5 # ao quadrdao
    mul t5, t5, t5 # y²

    add a5, a5, t5
    mv t0, a5 # (x - Xc²) + y² POSITIVO

    # x negativo 
    li t4, -1
    mul t4, t4, a5 # -x

    sub a5, t4, a4 # a5 = x - Xc²
    mul a5, a5, a5 # ao quadrdao

    add a5, a5, t5
    mv t1, a5 # (x - Xc²) + y² NEGATIVO

    # vendo a diferença

    sub t0, t0, a3 # POSITIVO
    sub t1, t1, a3 # NEGATIVO

    slt t2, t0, t1 # SE O POSITIVO FOR MENOR QUE O NEGATIVO, GUARDAMOS 1 EM T2

    li t3, 1

    
    bnez t2, convert_int_to_char

convert_int_to_char:
    mv t0, a2
    la a1, out_buffer

    li t1, 1000
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 0(s1) # guardando o primeiro numero no buffer de saída
    remu t0, t0, t1 # pegando o resto da divisão por 1000 pra  converter prox digito

    li t1, 100
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 1(s1) # guardando o segundo numero no buffer de saída
    remu t0, t0, t1  # pegando o resto da divisão por 100 pra  converter prox digito

    li t1, 10
    divu t2, t0, t1
    addi t2, t2, 48
    sb t2, 2(s1) # guardando o terceiro numero no buffer de saída
    remu t0, t0, t1  # pegando o resto da divisão por 10 pra converter prox digito

    addi t2, t0, 48 # só somamos 48
    sb t2, 3(s1) # e colocamos no buffer de saída

    li t2, ' '
    sb t2, 4(s1)

    # avança input/output
    addi s0, s0, 5
    addi s1, s1, 5

    addi s2, s2, -1
    bnez s2, loop_convert_int_to_char

    # último número: trocar espaço por '\n'
    li t2, '\n'
    sb t2, -1(s1)

    #write
    li a0, 1            # file descriptor = 1 (stdout)
    la s1, out_buffer       # buffer
    li a2, 20           # size
    li a7, 64           # syscall write (64)
    ecall

    # Invoke the syscall exit to finalize the program.
    li a0, 0         
    li a7, 93        
    ecall            # Invoke the syscall