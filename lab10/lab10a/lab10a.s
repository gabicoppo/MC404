.data

in_buffer:	.skip 100

no_index_str: .asciz "-1\n"

newline_str: .asciz "\n"

out_buffer: .skip 50

.text

.globl _start

.globl gets

.globl puts

.globl atoi


gets:
    li a0, 0
    li a1, in_buffer
    li a2, 100
    li a7, 63
    ecall

    mv t0, a0     # t0 temporário pra guardarmos o n de byes lidos
    mv t1, a1     # t1 ponteiro pra andar no buffer
    li t2, 10     # '\n'


loop_gets:
    lb t3, 0(t1)
    beq t2, t3, found_newline

    addi t1, t1, 1
    j loop_gets

found_newline:
    sw zero, 0(t1)    # mudamos o último caractere de '\n' pra '\0'

end_gets:
    ret

puts:
    addi sp, sp, -4
    sw s0, 0(sp)      # empilhando o valor inicial de s0 para garantirmos que no final deixemos ele como estava

    mv s0, a0
    mv t0, a0
    li t1, zero

loop_puts:
    lb t2, a(t0)
    beq t2, zero, write_buffer

    addi t0, t0, 1    # andando no buffer
    addi t1, t1, 1    # somando no contador

    j loop_puts

write_buffer:
    li a0, 1
    mv a1, s0        # onde guardamos o endereço
    mv a2, t1        # o contador de caracteres
    li a7, 64
    ecall

    li a0, 1
    li a1, newline_char
    li a2, 1
    li a7, 64
    ecall

    li a0, 0         # retorno --nem precisa

    lw s0, 0(sp)
    addi sp, sp, 4   # desempilhando 

fim_puts:
    ret

atoi:
    addi sp, sp, -12
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)       # empilhando os rds s0,s1,s2 q vamos usar de ponteiro, sinal e somatório.

    mv s0, a0
    li s1, 1
    li s2, 0

check_whitespace_tab:
    lb t0, 0(s0)
    li t1, ' '
    beq t0, t1, skip_whitespace_tab
    li t1, '\t'
    beq t0, t1, skip_whitespace_tab      # se for um espaço ou tab, vamos pro prox char

    j check_signal                       # se chegamos aqui, estamos no sinal

skip_whitespace_tab:
    addi s0, s0, 1
    j check_whitespace_tab

check_signal:
    lb t0, 0(s0)
    li t1, '-'
    bne t0, t1, check_plus_sign         # se não é um sinal de '-', pode ter ou não um sinal de '+'

    li s1, -1
    addi s0, s0, 1                      # se é um sinal de '-', s1 vira -1 e avançamos buffer

check_plus_sign:
    lb t0, 0(s0)
    li t1, '+'

    bne t0, t1, loop_convert            # se não tem um '+' explícito, já eh o número

    addi s0, s0, 1                      # se tiver, só avançamos no buffer

loop_atoi:
    lb t0, 0(s0)
    li t1, '0'
    blt t0, t1, end_loop_atoi
    li t1, 58
    bge t0, t1, end_loop_atoi          # se chegamos num char menor que 0 ou maior que 9, acabou o número

    addi t0, t0, -48                   # converte char

    li t1, 10
    mul s2, s2, t1                     # adiciona uma casa no resultado anterior
    addi s2, s2, t0                    # soma ao char convertido

    addi s0, s0, 1                     # avança buffer

    j loop_atoi

end_loop_atoi:
    mul s2, s2, s1                     # adiciona o sinal

    mv a0, s2

    lw s2, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)                       # desempilhamos/devolvemos os valores iniciais dos rds s0, s1, s2
    addi sp, sp, 12

end_atoi:
    ret

itoa:
    addi sp, sp -16
    lw s0, 12(sp)
    lw s1, 8(sp)
    lw s2, 4(sp)
    lw s3, 0(sp)

    mv s0, a1          # ponteiro pra buffer final está em s0, mas esse vamos modificar
    mv s3, s0          # em s3 está o ponteiro inicial que não vamos mudar
    mv s1, a0          # index que vamos printar está em s1
    mv s2, a2          # base em s2

    li t0, 0
    bne s1, zero, loop_extracao

    li t1, '0'
    addi t0, t0, 1
    addi sp, sp, -4
    lw t1, 0(sp)
    j loop_escreve_buffer

loop_extracao:
    li t1, 10
    beq t1, s2, is_decimal
    li t1, 16
    beq t1, s2, is_hexadecimal

is_decimal:
    beq s1, zero, loop_escreve_buffer
    
    remu t1, s1, s2
    divu s1, s1, s2

    addi t1, t1, 48
    addi t0, t0, 1

    addi sp, sp -4
    sw t1, 0(sp)

    j is_decimal

is_hexadecimal:
    beq s1, zero, loop_escreve_buffer

    remu t1, s1, s2
    divu s1, s1, s2

    li t2, 10
    bge t1, t2, is_letter

    addi t1, t1, 48
    addi t0, t0, 1

    addi sp, sp -4
    sw t1, 0(sp)

    j is_hexadecimal


is_letter:
    addi t1, t1, 87
    addi t0, t0, 1

    addi sp, sp -4
    sw t1, 0(sp)

    j is_hexadecimal


loop_escreve_buffer:
    beq t0, zero, fim_escrita_buffer
    lw t1, 0(sp)

    addi sp, sp, 4
    sb t1, 0(s0)

    addi s0, s0, 1
    addi, t0, t0 -1

    j loop_escreve_buffer

fim_escrita_buffer:
    sb zero, 0(s0)

fim_itoa:
    mv a0, s3

    lw s3, 12(sp)
    lw s2, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)

    addi sp, sp, 16

end_itoa:
    ret


