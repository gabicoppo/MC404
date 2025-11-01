.section .text

.set BASE, 0xFFFF0100
.set WRITE_TRIGGER, 0xFFFF0100    # base+0x00
.set WRITE_DATA, 0xFFFF0101       # base+0x01
.set READ_TRIGGER, 0xFFFF0102     # base+0x02
.set READ_DATA, 0xFFFF0103        # base+0x03

.globl _start

_start:
    # Lê o número da operação
    jal read_byte
    mv s0, a0           # s0 = código da operação
    
    # Lê o '\n' após o número da operação
    jal read_byte
    
    # Decide qual operação executar
    li t0, '1'
    beq s0, t0, operation_1
    
    li t0, '2'
    beq s0, t0, operation_2
    
    li t0, '3'
    beq s0, t0, operation_3
    
    li t0, '4'
    beq s0, t0, operation_4
    
    # Se chegou aqui, operação inválida
    j exit

# ========================================
# OPERAÇÃO 1: Ler string e escrever de volta
# ========================================
operation_1:
    jal read_string     # Lê até '\n', empilha na stack
    jal write_string    # Escreve da stack
    j exit

# ========================================
# OPERAÇÃO 2: Ler string e escrever invertida
# ========================================
operation_2:
    jal read_string     # Lê até '\n', empilha na stack
    # A string já está invertida na pilha!
    # Precisamos re-empilhar na ordem correta
    mv t0, s1           # s1 tem o tamanho
    mv t1, sp           # posição atual da pilha
    
reverse_loop:
    beqz t0, reverse_done
    lb t2, 0(t1)
    addi sp, sp, -1
    sb t2, 0(sp)
    addi t1, t1, 1
    addi t0, t0, -1
    j reverse_loop
    
reverse_done:
    jal write_string
    j exit

# ========================================
# OPERAÇÃO 3: Decimal para Hexadecimal
# ========================================
operation_3:
    jal read_string     # Lê o número em decimal
    
    # Converte string decimal para número
    li s2, 0            # acumulador do número
    mv t0, s1           # contador de caracteres
    
parse_decimal:
    beqz t0, decimal_done
    lb t1, 0(sp)
    addi sp, sp, 1
    
    # Verifica se é '\n'
    li t2, '\n'
    beq t1, t2, decimal_done
    
    # Converte char para dígito
    addi t1, t1, -'0'
    
    # s2 = s2 * 10 + dígito
    li t2, 10
    mul s2, s2, t2
    add s2, s2, t1
    
    addi t0, t0, -1
    j parse_decimal
    
decimal_done:
    # Converte número para hexadecimal string
    # Empilha dígitos hex na ordem reversa
    li t3, 0            # contador de dígitos
    mv t0, s2           # número a converter
    
    beqz t0, hex_zero   # caso especial: número é 0
    
hex_convert_loop:
    beqz t0, hex_convert_done
    
    # t1 = t0 % 16
    andi t1, t0, 0xF
    srli t0, t0, 4      # t0 = t0 / 16
    
    # Converte dígito para char
    li t2, 10
    blt t1, t2, hex_digit
    addi t1, t1, 'A' - 10
    j hex_push
hex_digit:
    addi t1, t1, '0'
    
hex_push:
    addi sp, sp, -1
    sb t1, 0(sp)
    addi t3, t3, 1
    j hex_convert_loop

hex_zero:
    li t1, '0'
    addi sp, sp, -1
    sb t1, 0(sp)
    li t3, 1
    
hex_convert_done:
    # Adiciona '\n'
    li t1, '\n'
    addi sp, sp, -1
    sb t1, 0(sp)
    addi t3, t3, 1
    
    mv s1, t3           # tamanho da string
    jal write_string
    j exit

# ========================================
# OPERAÇÃO 4: Expressão aritmética
# ========================================
operation_4:
    # Lê primeiro número
    jal read_number
    mv s2, a0           # s2 = primeiro operando
    
    # Lê operador
    jal read_byte
    mv s3, a0           # s3 = operador
    
    # Lê segundo número
    jal read_number
    mv s4, a0           # s4 = segundo operando
    
    # Lê '\n'
    jal read_byte
    
    # Executa operação
    li t0, '+'
    beq s3, t0, op_add
    li t0, '-'
    beq s3, t0, op_sub
    li t0, '*'
    beq s3, t0, op_mul
    li t0, '/'
    beq s3, t0, op_div
    j exit
    
op_add:
    add s2, s2, s4
    j op_done
op_sub:
    sub s2, s2, s4
    j op_done
op_mul:
    mul s2, s2, s4
    j op_done
op_div:
    div s2, s2, s4
    
op_done:
    # Converte resultado para string decimal
    jal number_to_string
    jal write_string
    j exit

# ========================================
# FUNÇÕES AUXILIARES
# ========================================

# Lê um byte da serial port
# Retorna em a0
read_byte:
    li t0, READ_TRIGGER
    li t1, 1
    sb t1, 0(t0)        # Trigger read
    
wait_read:
    lb t1, 0(t0)
    bnez t1, wait_read  # Espera até ficar 0
    
    li t0, READ_DATA
    lb a0, 0(t0)        # Lê o byte
    ret

# Escreve um byte na serial port
# Byte em a0
write_byte:
    li t0, WRITE_DATA
    sb a0, 0(t0)        # Coloca byte no data
    
    li t0, WRITE_TRIGGER
    li t1, 1
    sb t1, 0(t0)        # Trigger write
    
wait_write:
    lb t1, 0(t0)
    bnez t1, wait_write # Espera até ficar 0
    ret

# Lê uma string até '\n' e empilha (incluindo '\n')
# Retorna tamanho em s1
read_string:
    li s1, 0            # contador
read_str_loop:
    jal read_byte
    addi sp, sp, -1
    sb a0, 0(sp)
    addi s1, s1, 1
    
    li t0, '\n'
    bne a0, t0, read_str_loop
    ret

# Escreve string da pilha (tamanho em s1)
write_string:
    mv t0, s1
write_str_loop:
    beqz t0, write_str_done
    lb a0, 0(sp)
    addi sp, sp, 1
    jal write_byte
    addi t0, t0, -1
    j write_str_loop
write_str_done:
    ret

# Lê um número decimal (até espaço ou '\n')
# Retorna número em a0
read_number:
    li s5, 0            # acumulador
read_num_loop:
    jal read_byte
    
    # Verifica se é espaço ou '\n'
    li t0, ' '
    beq a0, t0, read_num_done
    li t0, '\n'
    beq a0, t0, read_num_done
    
    # Converte char para dígito
    addi a0, a0, -'0'
    
    # s5 = s5 * 10 + dígito
    li t0, 10
    mul s5, s5, t0
    add s5, s5, a0
    j read_num_loop
    
read_num_done:
    mv a0, s5
    ret

# Converte número em s2 para string decimal e empilha
# Retorna tamanho em s1
number_to_string:
    li s1, 0
    mv t0, s2
    
    beqz t0, num_zero
    
num_convert_loop:
    beqz t0, num_convert_done
    
    li t1, 10
    remu t2, t0, t1     # t2 = t0 % 10
    divu t0, t0, t1     # t0 = t0 / 10
    
    addi t2, t2, '0'    # Converte para char
    addi sp, sp, -1
    sb t2, 0(sp)
    addi s1, s1, 1
    j num_convert_loop

num_zero:
    li t2, '0'
    addi sp, sp, -1
    sb t2, 0(sp)
    li s1, 1

num_convert_done:
    # Adiciona '\n'
    li t2, '\n'
    addi sp, sp, -1
    sb t2, 0(sp)
    addi s1, s1, 1
    ret

# Sai do programa
exit:
    li a7, 93           # syscall exit
    li a0, 0
    ecall