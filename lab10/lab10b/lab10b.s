.data

newline_char: .asciz "\n"

.text

.globl gets
.globl puts
.globl atoi
.globl exit
.globl itoa
.globl recursive_tree_search

gets:
    addi sp, sp, -4
    sw s0, 0(sp)

    mv s0, a0             # s0 guarda o ponteiro inicial
    mv t1, a0             # t1 vai caminhar no buffer
    li t2, 10             # '\n'

loop_gets:
    # lê 1 byte de stdin
    li a0, 0              # stdin
    mv a1, t1             # buffer de destino (1 byte)
    li a2, 1              # lê exatamente 1 byte
    li a7, 63             # syscall read
    ecall

    blez a0, end_gets     

    lb t3, 0(t1)          # lê o byte que acabou de entrar
    beq t3, t2, found_newline

    addi t1, t1, 1        # vai pro próximo byte
    j loop_gets

found_newline:
    sb zero, 0(t1)        # troca '\n' por '\0'
    j end_gets

end_gets:
    sb zero, 0(t1)        # \0 final
    mv a0, s0             # retorna ponteiro original

    lw s0, 0(sp)
    addi sp, sp, 4
    ret


puts:
    addi sp, sp, -4
    sw s0, 0(sp)

    mv s0, a0
    mv t0, a0
    li t1, 0

loop_puts:
    lb t2, 0(t0)
    beqz t2, write_buffer

    addi t0, t0, 1
    addi t1, t1, 1

    j loop_puts

write_buffer:
    li a0, 1
    mv a1, s0
    mv a2, t1
    li a7, 64
    ecall

    li a0, 1
    la a1, newline_char
    li a2, 1
    li a7, 64
    ecall

    lw s0, 0(sp)
    addi sp, sp, 4

fim_puts:
    ret

atoi:
    addi sp, sp, -12
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)

    mv s0, a0         # ponteiro para string
    li s1, 1          # sinal
    li s2, 0          # resultado acumulado

check_whitespace_tab:
    lb t0, 0(s0)
    li t1, 32         # ' '
    beq t0, t1, skip_whitespace_tab
    li t1, 9          # '\t'
    beq t0, t1, skip_whitespace_tab

    j check_signal

skip_whitespace_tab:
    addi s0, s0, 1
    j check_whitespace_tab

check_signal:
    lb t0, 0(s0)
    li t1, 45         # '-'
    bne t0, t1, check_plus_sign

    li s1, -1
    addi s0, s0, 1

check_plus_sign:
    lb t0, 0(s0)
    li t1, 43         # '+'

    bne t0, t1, loop_atoi

    addi s0, s0, 1

loop_atoi:
    lb t0, 0(s0)
    li t1, 48         # '0'
    blt t0, t1, end_loop_atoi
    li t1, 58         # '9' + 1
    bge t0, t1, end_loop_atoi

    addi t0, t0, -48  # converte char para número

    li t1, 10
    mul s2, s2, t1
    add s2, s2, t0

    addi s0, s0, 1

    j loop_atoi

end_loop_atoi:
    mul s2, s2, s1    # aplica o sinal

    mv a0, s2

    lw s2, 0(sp)
    lw s1, 4(sp)
    lw s0, 8(sp)
    addi sp, sp, 12

end_atoi:
    ret

itoa:
    addi sp, sp, -24
    sw ra, 20(sp)
    sw s0, 16(sp)
    sw s1, 12(sp)
    sw s2, 8(sp)
    sw s3, 4(sp)
    sw s4, 0(sp)

    mv s0, a1          # ponteiro atual no buffer
    mv s3, a1          # guarda ponteiro original (sempre)
    mv s1, a0          # valor a converter
    mv s2, a2          # base (10 ou 16)
    li s4, 0           # contador de dígitos

    # trata zero
    bnez s1, check_negative
    
    li t0, 48          # '0'
    sb t0, 0(s0)
    sb zero, 1(s0)
    j fim_itoa

check_negative:
    # se base 16, unsigned
    li t0, 16
    beq s2, t0, loop_extracao
    
    # base 10: se negativo, adiciona '-' e usan val absoluto
    bgez s1, loop_extracao
    
    li t0, 45          # '-'
    sb t0, 0(s0)
    addi s0, s0, 1     # avança ponteiro para próxima posição
    
    sub s1, zero, s1    # val absoluto

loop_extracao:
    beqz s1, write_digits_start
    
    remu t1, s1, s2    # resto
    divu s1, s1, s2    # quociente

    li t2, 10
    blt t1, t2, is_digit
    
    # 'A' = 65
    addi t1, t1, 55
    j push_digit

is_digit:
    addi t1, t1, 48    # '0'

push_digit:
    addi sp, sp, -4
    sw t1, 0(sp)
    addi s4, s4, 1

    j loop_extracao

write_digits_start:
    # n sei se precisa
    
write_digits_loop:
    beqz s4, finish_string
    
    lw t0, 0(sp)
    addi sp, sp, 4
    
    sb t0, 0(s0)
    addi s0, s0, 1
    addi s4, s4, -1
    
    j write_digits_loop

finish_string:
    sb zero, 0(s0)     # null terminator

fim_itoa:
    mv a0, s3          # retorna ponteiro original do buffer

    lw s4, 0(sp)
    lw s3, 4(sp)
    lw s2, 8(sp)
    lw s1, 12(sp)
    lw s0, 16(sp)
    lw ra, 20(sp)
    addi sp, sp, 24

end_itoa:
    ret

recursive_tree_search:
    beqz a0, not_found # se ponteiro eh null, nao achamos
    
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)
    
    mv s0, a0         # nó atual
    mv s1, a1         # val
    
    lw t0, 0(s0)      # val
    
    beq t0, s1, found_here
    
    # prucura na esquerda
    lw a0, 4(s0)      # left
    mv a1, s1         # val
    jal recursive_tree_search
    
    bnez a0, found_in_child
    
    # não achamos na esuqerda, procura na direita
    lw a0, 8(s0)      # right
    mv a1, s1         # val a procurar
    jal recursive_tree_search
    
    bnez a0, found_in_child
    
    # achamos em nenhuma
    li a0, 0
    j finaliza_search
    
found_here:
    li a0, 1
    j finaliza_search
    
found_in_child:
    addi a0, a0, 1 # achamos valor no filho, incrementamos depth
    
finaliza_search:
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    ret

not_found:
    li a0, 0
    ret

exit:
    li a7, 93
    ecall