.data

in_buffer:	.skip 7

no_index_str: .asciz "-1\n"

out_buffer: .skip 50

.text

.globl _start

_start:
    li a0, 0
    la a1, in_buffer
    li a2, 7
    li a7, 63
    ecall

    la s2, in_buffer
    la s3, out_buffer
    la s4, out_buffer

    mv a1, s2  

    jal ascii_pra_int

    # em a2 está o valor da soma que queremos encontrar

    la s1, head_node     # guardando a cabeça da linked list, já que eh global
    li t4, 0
    jal find_sum                


find_sum:
    beqz s1, imprime_menosum   # se chegamos no endereço 0, printamos -1
    li t0, 0            # onde valor acumular a soma de val1 + va2
    lw t1, 0(s1)        # val1
    lw t2, 4(s1)        # val2

    add t0, t1, t2

    beq t0, a2, int_pra_ascii_pilha   # se achamos o index correto, chamamos essa função

    lw s1, 8(s1)   # next

    addi t4, t4, 1      # contador de index

    j find_sum 


imprime_menosum:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, no_index_str       # buffer
    li a2, 3          # size
    li a7, 64           # syscall write (64)
    ecall

    j finaliza_programa


int_pra_ascii_pilha:
    li t1, 0       # contador
    li t2, 10      # pra dividirmos nosso int
    li t5, 0
    bne t4, t1, loop_extracao

    li t3, '0'    # se for 0 o index
    addi t1, t1, 1
    addi sp, sp, -4
    sw t3, 0(sp)
    j loop_escreve_buffer

    # index que queremos printar está em t4

loop_extracao:
    beq t4, t5, loop_escreve_buffer

    remu t3, t4, t2        # pegamos o resto por 10
    divu t4, t4, t2         # numero dividido por 10

    addi t3, t3, 48        # transformando pra ascii
    addi t1, t1, 1         # adicionando no contador

    # PUSH - abaixando a pilha pra adicionarmos o digito
    addi sp, sp, -4
    sw t3, 0(sp)           # guardando nosso numero na pilha

    j loop_extracao


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
    sb t1, 0(s3)

    j imprime_buffer


ascii_pra_int:
    li a2, 0               # zera o acumulador do resultado
    li t1, 10              # pra multiplicar por 10
    li t3, '-'
    li a5, 1

    lb t2, 0(a1)           # lê o caractere atual
    bne t2, t3, loop_conversao # se for positivo, vai direto pra conversão

    li a5, -1
    addi a1, a1, 1
    

loop_conversao:
    lb t2, 0(a1)           # Lê o caractere atual
    
    li t3, ' '
    li t4, '\n'
    li t5, '\t'

    beq t2, t3, fim_conversao # se for um espaço a função termina.
    beq t2, t4, fim_conversao
    beq t2, t5, fim_conversao

    addi t2, t2, -48     # Converte de ASCII para número

    mul a2, a2, t1         # resultado = resultado * 10
    add a2, a2, t2         # resultado = resultado + novo_digito

    addi a1, a1, 1         # Avança o ponteiro
    
    j loop_conversao


fim_conversao:
    mul a2, a2, a5
    ret     


imprime_buffer:
    mv a1, s4      
    li a2, 0            # contador de caracteres     
    mv t0, a1           # ponteiro p percorrer o out_buffer


calcula_tamanho_loop:
    lb t1, 0(t0)

    addi a2, a2, 1     # adiciona no contador de caracteres
    addi t0, t0, 1      # adiciona no ponteiro do buffer

    li t2, '\n'

    bne t1, t2, calcula_tamanho_loop

    li a0, 1            # file descriptor = 1 (stdout)
    # a2 já tem o tamanho pq eh o contador
    li a7, 64           # syscall write (64)
    ecall

    j finaliza_programa


finaliza_programa:
    li a7, 93    # syscall exit
    ecall

