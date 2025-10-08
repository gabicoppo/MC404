.data

in_buffer:	.skip 4

no_index: .asciz "-1"

out_buffer: .skip 50

.text

.globl main

main:
    li a0, 0
    la a1, in_buffer
    li a2, 4
    li a7, 63
    ecall

    la s2, in_buffer
    la s3, out_buffer
    la s4, no_index

    jal ascii_pra_int

    # em a0 está o valor da soma que queremos encontrar

    la s1, head_node     # guardando a cabeça da linked list, já que eh global

    li t4, 0

    jal find_sum

    li a0, 0
    la a1, out_buffer
    li a2, 50
    li a7, 64
    ecall


find_sum:
    addi t4, t4, 1      # contador de index
    li t0, 0            # onde valor acumular a soma de val1 + va2
    lw t1, 0(s1)        # val1
    lw t2, 4(s1)        # val2

    add t0, t1, t2

    beq t0, a0, int_pra_ascii_pilha   # se achamos o index correto, chamamos essa função

    lw t3, 8(s1)   # next

    mv s1, t3

    beqz s1, no_index   # se chegamos no endereço 0, printamos -1

    j find_sum 

no_index:
    li a0, 1            # file descriptor = 1 (stdout)
    la s1, no_index       # buffer
    li a2, 20           # size
    li a7, 64           # syscall write (64)
    ecall

    li a7, 93    # syscall exit
    ecall

int_pra_ascii_pilha:
    li t1, 0       # contador
    li t2, 10      # pra dividirmos nosso int

    # index que queremos printar está em t0
loop_extração:
    li t5, 0
    beq t0, t5, loop_escreve_buffer

    remu t3, t0, t2        # pegamos o resto por 10
    div t0, t0, t2         # numero dividido por 10

    addi t3, t3, 48        # transformando pra ascii
    addi t1, t1, 1         # adicionando no contador

    # PUSH - abaixando a pilha pra adicionarmos o digito
    addi sp, sp, -4
    sw t3, 0(sp)           # guardando nosso numero na pilha

    j loop_extração

loop_escreve_buffer:
    beq t1, t5, fim_escrita_buffer    # se o contador for 0, terminamos a escrita

    lw t3, 0(sp)
    addi sp, sp, 4

    sb t3, 0(s3)    # colocando gisisto ascii no buffer
    addi s3, s3, 1
    addi t1, t1, -1

    j loop_escreve_buffer


fim_escrita_buffer:
    li t1, '\n'
    lw t1, 0(s3)

    ret

ascii_pra_int:
    li a0, 0               # Zera o acumulador do resultado
    li t2, 10              # Constante para multiplicar por 10

loop_conversao:
    lb t1, 0(a1)           # Lê o caractere atual
    
    li t3, ' '
    li t4, '\n'
    beq t1, t3, fim_conversao # se for um espaço a função termina.
    beq t1, t4, fim_conversao

    addi t1, t1, -48     # Converte de ASCII para número

    mul a0, a0, t2         # resultado = resultado * 10
    add a0, a0, t1         # resultado = resultado + novo_digito

    addi a1, a1, 1         # Avança o ponteiro
    j loop_conversao

fim_conversao:
    addi a1, a1, 1
    ret     

