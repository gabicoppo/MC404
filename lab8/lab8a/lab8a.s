.data

image_file: .asciz "image.pgm"

header: .skip 262415

size: .skip 10

.text
.globl main

_start:
    jal ra, main

    li a7, 93    # syscall exit
    ecall

main:
    la a0, image_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open
    ecall

    mv s0, a0  # movendo fd pro rd s0 tb

    jal proccess_header

    mv a0, s1      # largura
    mv a1, s2          # altura
    li a7, 2201            # syscall setCanvasSize 
    ecall

    # Invoke the syscall exit to finalize the program.
    li a0, 0         
    li a7, 93        
    ecall            # Invoke the syscall

read:
    li a0, 0  # file descriptor = 0 (stdin)
    la a1, in_buffer #  buffer to write the data
    li a2, 20  # size (reads 20 bytes)
    li a7, 63 # syscall read (63)
    ecall

proccess_header:
    li a0, s0  # file descriptor = s0 (image)
    la a1, header 
    li a2, 262415
    li a7, 63 # syscall read (63)
    ecall

    la s3, header # agoora vamos usar o ponteiro s3, que aponta pro inicio do header, pra fazer o parsing

    jal ignore
    #vamos voltar pra essa função quando chegarmos num numero, e.g, o tamanho da imagem

    jal ascii_pra_int # quando encontrar a linha do tamanho, chama isso aqui

    mv s1, a0 # salvando o primeiro numero em s1

    jal ascii_pra_int # no inicio, já ta apontando pra largura pq demos addi no "fim_conversao"

    mv s2, a0 # salvando o segundo numero em s2

    jal loop_pular_maxval # pra pular o "255"

    ret

ignore:
    lb t1, 0(s3) # olahmos o caractere atual

    li t2, '\n'
    li t3, ' '
    li t4, '#'
    li t5, 'P'

    beq t1, t4, loop_pular_linha # se encontramos um '#' ou 'P', pulamos a linha
    beq t1, t5, loop_pular_linha
    beq t1, t2, loop_parse # se encontramos espaço ou \n, avançamos o ponteiro s3
    beq t1, t3, loop_parse

    ret # se chegamos aqui, encontramos o tamanho

loop_pular_linha:
    addi s3, s3, 1 # se não, movemos pro prox caractere
    lb t1, 0(s3) # olahmos o caractere atual

    li t2, '\n'
    bne t1, t2, loop_pular_linha # se nao tivermos chegados no fim da linha, chamamos essa f de novo

    addi s3, s3, 1 # vamos pra linha seguinte
    
    j ignore

loop_parse:
    addi s3, s3, 1 # se não, movemos pro prox caractere
    lb t1, 0(s3) # olahmos o caractere atual

    j ignore

ascii_pra_int:
    li a0, 0               # Zera o acumulador do resultado
    li t2, 10              # Constante para multiplicar por 10

loop_conversao:
    lb t1, 0(s3)           # Lê o caractere atual
    
    li t3, ' '
    li t4, '\n'
    beq t1, t3, fim_conversao # se for um espaço a função termina.
    beq t1, t4, fim_conversao

    addi t1, t1, -48     # Converte de ASCII para número

    mul a0, a0, t2         # resultado = resultado * 10
    add a0, a0, t1         # resultado = resultado + novo_digito

    addi s3, s3, 1         # Avança o ponteiro
    j loop_conversao

fim_conversao:
    addi s3, s3, 1
    ret     

loop_pular_maxval:
    addi s3, s3, 1 # se não, movemos pro prox caractere
    lb t1, 0(s3) # olahmos o caractere atual

    li t2, '\n'
    bne t1, t2, loop_pular_linha # se nao tivermos chegados no fim da linha, chamamos essa f de novo

    addi s3, s3, 1 # vamos pra linha seguinte

    ret        



