.section .text

.set BASE_SERIAL_PORT, 0xFFFF0100

.globl main

main:
    jal read_operation   # seta 1 na read, lê char, a0 tem o char
    mv s1, a0           # por segurança

    jal read_operation

    li t0, 49
    beq s1, t0, operation_1

    li t0, 50
    beq s1, t0, operation_2

    li t0, 51
    beq s1, t0, operation_3

    li t0, 52
    beq s1, t0, operation_4

    li a7, 93
    ecall

read_operation:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_operation:
    lb t2, 2(a1)
    bnez t2, wait_read_operation

    lb a0, 3(a1)

    ret


operation_1:
    jal read_char_op1

    jal write_char_op1

    li t1, '\n'
    bne t1, a0, operation_1

    li a7, 93
    ecall

read_char_op1:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_op1:
    lb t2, 2(a1)
    bnez t2, wait_read_op1        # enquanto base+2 for 1, esperamos no loop

    lb a0, 3(a1)

    ret

write_char_op1:
    li a1, BASE_SERIAL_PORT

wait_write_op1:
    lb t1, 0(a1)
    bnez t1, wait_write_op1     # enquanto base for 1, esperamos no loop

    sb a0, 1(a1)

    li t2, 1
    sb t2, 0(a1)

    ret

operation_2:
    li t0, 0            # tcontador de bytes

read_word_op2:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)        # setando 1 na read

wait_read_word_op2:
    lb t2, 2(a1)
    bnez t2, wait_read_word_op2         # enquanto base+2 for 1, esperamos no loop

    lb t2, 3(a1)

    li t3, '\n'
    beq t2, t3, write_reversed_op2      # se o char lido for um \n, acabou a leitura

    addi sp, sp, -4
    sb t2, 0(sp)          # empilhando cada byte na pilha 
    addi t0, t0, 1           # contador pra ver quantos bytes foram lidos

    j read_word_op2

write_reversed_op2:
    beqz t0, write_newline_op2          # contador de bytes igual a 0, escrevemos o \n final

    lb a0, 0(sp)       # tira char da pilha
    addi sp, sp, 4     # add na pilha

write_char_loop_op2:
    li a1, BASE_SERIAL_PORT

    lb t1, 0(a1)
    bnez t1, write_char_loop_op2     # enquanto base for 1, esperamos no loop

    sb a0, 1(a1)     # coloca no lugar certo

    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

wait_write_op2:
    lb t1, 0(a1)
    bnez t1, wait_write_op2     # esperamos a escrita terminar, ou seja ficar igual a 0

    addi t0, t0, -1             # decrementa no contador de bytes
    j write_reversed_op2

write_newline_op2:
    li a0, '\n'
    li a1, BASE_SERIAL_PORT

wait_newline_write_op2:
    lb t1, 0(a1)
    bnez t1, wait_newline_write_op2

    sb a0, 1(a1)      # escreve \n final
    li t2, 1
    sb t2, 0(a1)      # set 1 no write p escrever

wait_newline_complete_op2:
    lb t1, 0(a1)
    bnez t1, wait_newline_complete_op2     # esperamos a escrita terminar, ou seja ficar igual a 0

    li a7, 93
    ecall

operation_3:
    li s2, 0            # acumulador decimal
    li s1, 1            # sinal
    li s4, 0            # contador de dígitos hex
    
    jal read_char_op3   # lê primeiro caractere
    
    li t5, '-'
    beq a0, t5, is_negative_op3
    
    # primeiro char é dígito
    j process_digit_op3

is_negative_op3:
    li s1, -1           # marca como negativo
    jal read_char_op3   # lê próximo caractere
    j process_digit_op3

read_loop_op3:
    jal read_char_op3
    
process_digit_op3:
    li t4, '\n'
    beq a0, t4, convert_to_hex_op3  # se \n, terminou leitura
    
    # converte char para dígito
    addi t0, a0, -48    # '0' = 48
    
    # multiplica acumulador por 10 e soma dígito
    li t1, 10
    mul s2, s2, t1
    add s2, s2, t0
    
    j read_loop_op3

convert_to_hex_op3:
    # aplica sinal
    mul s2, s2, s1
    
    # se negativo, já está em complemento de 2 (representação interna)
    mv a1, s2           # copia para a1
    
    # caso especial zero
    bnez a1, hex_loop_op3
    
    # escreve '0'
    li t1, '0'
    addi sp, sp, -4
    sw t1, 0(sp)
    addi s4, s4, 1   # acrescenta no contador de digitos
    j write_digits_op3

hex_loop_op3:
    beqz s4, check_more_digits_op3
    j write_digits_op3

check_more_digits_op3:
    beqz a1, write_digits_op3  # terminou conversão
    
    li a3, 16
    remu t1, a1, a3     # resto 
    divu a1, a1, a3     # quociente
    
    li t2, 10
    blt t1, t2, is_digit_op3
    
    # A = 65
    addi t1, t1, 55
    j push_digit_op3

is_digit_op3:
    addi t1, t1, 48      # converte p char

push_digit_op3:
    addi sp, sp, -4
    sw t1, 0(sp)         # coloca o dígito na pilha
    addi s4, s4, 1
    
    j check_more_digits_op3   

write_digits_op3:
    beqz s4, write_newline_op3   # se acabou os digitos, escrevemos \n
    
    lw a0, 0(sp)         # tiramos da pilha
    addi sp, sp, 4
    
    jal write_char_op3   # chamamos f que escreve
    
    addi s4, s4, -1      # decrementa do contador de digitos
    j write_digits_op3

write_newline_op3:
    li a0, '\n'
    jal write_char_op3
    
    li a7, 93          # escrevemos \n e acaba a operação 3
    ecall

read_char_op3:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)

wait_read_op3:
    lb t2, 2(a1)
    bnez t2, wait_read_op3
    
    lb a0, 3(a1)
    ret

write_char_op3:
    li a1, BASE_SERIAL_PORT

wait_write_ready_op3:
    lb t1, 0(a1)
    bnez t1, wait_write_ready_op3
    
    sb a0, 1(a1)           # coloca o char no lugar
    li t2, 1
    sb t2, 0(a1)           # e escreve

wait_write_complete_op3:
    lb t1, 0(a1)
    bnez t1, wait_write_complete_op3
    
    ret

operation_4:
    li s2, 0            # acumulador 
    li s1, 1            # sinal
    li s4, 0            # contador de dígitos de saída
    
    jal read_char_op4   # le primeiro caractere

    li s5, '-'
    beq a0, s5, is_negative_op4_num1
    
    # primeiro char eh dígito, process
    j process_digit_op4_num1

is_negative_op4_num1:
    li s1, -1           # eh negativo
    jal read_char_op4   # le prox caractere
    j process_digit_op4_num1

read_loop_op4_num1:
    jal read_char_op4
    
process_digit_op4_num1:
    li t4, ' '
    beq a0, t4, read_operator       # espaço ent terminou o num1, vai ler o operador
    
    # converte char para dígito
    addi t0, a0, -48  
    
    # multiplica acumulador por 10 e soma dígito
    li t1, 10
    mul s2, s2, t1
    add s2, s2, t0
    
    j read_loop_op4_num1

read_operator:
    # num1 está em s2, sinal em s1
    mul s2, s2, s1      # aplica o sinal ao número em s2
    mv s0, s2       # salva o primeiro número (completo) em s0
    
    jal read_char_op4   # lê o caractere do operador

    li s5, '-'
    li s6, '+'
    li s7, '*'
    li s8, '/'
    beq a0, s5, is_sub_op4
    beq a0, s6, is_add_op4
    beq a0, s7, is_mul_op4
    beq a0, s8, is_div_op4
    
is_sub_op4:
    li s3, 1
    j read_num2_start
is_add_op4:
    li s3, 2
    j read_num2_start
is_mul_op4:
    li s3, 3
    j read_num2_start
is_div_op4:
    li s3, 4
    j read_num2_start

read_num2_start:
    li s2, 0         # reseta acumulador para o num2
    li s1, 1      # reseta sinal para o num2

read_num2_skip_space:
    jal read_char_op4
    li t0, ' '
    beq a0, t0, read_num2_skip_space        # ignora espaço antes do num2

    # primeiro char (depois do espaço depois do operador)
    li s5, '-'
    beq a0, s5, is_negative_op4_num2
    
    # é dígito, processa
    j process_digit_op4_num2

is_negative_op4_num2:
    li s1, -1                      # marca como negativo
    jal read_char_op4               # lê próximo caractere
    j process_digit_op4_num2

read_loop_op4_num2:
    jal read_char_op4
    
process_digit_op4_num2:
    li t4, '\n'
    beq a0, t4, do_operation           # terminou o num2, vai calcular
    
    # char para dígito
    addi t0, a0, -48  
    
    # multiplica acumulador por 10 e soma dígito
    li t1, 10
    mul s2, s2, t1
    add s2, s2, t0
    
    j read_loop_op4_num2

do_operation:
    # num2 EM S2 SINAL S1
    mul s2, s2, s1      # aplica o sinal ao número em s2
    # num1 está em s0
    
    li t0, 1
    beq t0, s3, sub_op
    li t0, 2
    beq t0, s3, add_op
    li t0, 3
    beq t0, s3, mul_op
    li t0, 4
    beq t0, s3, div_op

sub_op:
    sub a0, s0, s2    # a0 = s0 - s2
    j write_result
add_op:
    add a0, s0, s2    # a0 = s0 + s2
    j write_result
mul_op:
    mul a0, s0, s2    # a0 = s0 * s2
    j write_result
div_op:
    div a0, s0, s2    # a0 = s0 / s2


write_result:
    mv a1, a0           # copia resultado para a1 para impressão
    li s4, 0            # zera contador de dígitos da pilha

    blt a1, zero, print_minus_op4   # se a1 menor q 0, imprime -
    
    # caso especial zero
    bnez a1, dec_loop_op4
    
    # escreve '0'
    li t1, '0'
    addi sp, sp, -4
    sw t1, 0(sp)
    addi s4, s4, 1   # acrescenta no contador de digitos
    j write_digits_op4

dec_loop_op4:
    beqz a1, write_digits_op4  # terminou conversão
    
    li a3, 10
    remu t1, a1, a3     # resto 
    divu a1, a1, a3     # quociente
    
    addi t1, t1, 48      # converte p char

push_digit_op4:
    addi sp, sp, -4
    sw t1, 0(sp)         # coloca o dígito na pilha
    addi s4, s4, 1
    
    j dec_loop_op4   

write_digits_op4:
    beqz s4, write_newline_op4   # se acabou os digitos, escrevemos \n
    
    lw a0, 0(sp)         # tiramos da pilha
    addi sp, sp, 4
    
    jal write_char_op4   # chamamos f que escreve
    
    addi s4, s4, -1      # decrementa do contador de digitos
    j write_digits_op4

write_newline_op4:
    li a0, '\n'
    jal write_char_op4
    
    li a7, 93          # fim
    ecall

print_minus_op4:
    addi sp, sp, -4
    sw a1, 0(sp)         # salva a1 na pilha

    li a0, '-'
    jal write_char_op4   # sinal '-'

    lw a1, 0(sp)         
    addi sp, sp, 4
    
    sub a1, zero, a1     # modulo
    j dec_loop_op4      # imprime


read_char_op4:
    li a1, BASE_SERIAL_PORT
    li t1, 1
    sb t1, 2(a1)
wait_read_op4:
    lb t2, 2(a1)
    bnez t2, wait_read_op4
    
    lb a0, 3(a1)
    
    ret

write_char_op4:
    li a1, BASE_SERIAL_PORT
wait_write_ready_op4:
    lb t1, 0(a1)
    bnez t1, wait_write_ready_op4
    sb a0, 1(a1)           # coloca o char no lugar
    li t2, 1
    sb t2, 0(a1)           # e escreve
wait_write_complete_op4:
    lb t1, 0(a1)
    bnez t1, wait_write_complete_op4
    ret

