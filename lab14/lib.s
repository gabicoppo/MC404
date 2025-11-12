.section .bss
.align 4
main_stack: .skip 4096
main_stack_end:


isr_stack: .skip 1024 # Aloca 1024 bytes para a pilha
isr_stack_end: 

.section .data
.align 4

.globl _system_time
_system_time: .word 0

.text

.globl _start
_start:
    la sp, main_stack_end

    # Configura mscratch com o topo da pilha das ISRs.
    la t0, isr_stack_end            # t0 <= base da pilha
    csrw mscratch, t0            # mscratch <= t0

    # Registrar a ISR direct mode
    la t0, isr_trata_gpt            # Grava o endereço da ISR principal
    csrw mtvec, t0                  # no registrador mtvec

    # Habilita Interrupções Externas
    csrr t1, mie                    # Seta o bit 11 (MEIE) 
    li t2, 0x800                    # do registrador mie
    or t1, t1, t2 
    csrw mie, t1

    # Habilita Interrupções Global
    csrr t1, mstatus                # Seta o bit 3 (MIE) 
    ori t1, t1, 0x8                 # do registrador mstatus
    csrw mstatus, t1

    li t0, 0xFFFF0100               # Endereço do registrador do GPT
    li t1, 100                      # Valor (100 ms)
    sw t1, 8(t0)                    # Programa o timer


    jal main


.globl isr_trata_gpt
isr_trata_gpt:
    # Salvar o contexto
    csrrw sp, mscratch, sp # Troca sp com mscratch
    addi sp, sp, -12 # Aloca espaço na pilha da ISR
    sw t0, 0(sp) # Salva t0
    sw t1, 4(sp) # Salva t1
    sw t2, 8(sp)

    la t0, _system_time    
    lw t1, 0(t0)           
    addi t1, t1, 100              # incrementa
    sw t1, 0(t0)          

    li t0, 0xFFFF0100    
    li t1, 100            # valor 100 ms
    sw t1, 8(t0)        

    lw t2, 8(sp)
    lw t1, 4(sp) # Recupera t1
    lw t0, 0(sp) # Recupera t0
    addi sp, sp, 12 # Desaloca espaço da pilha da ISR

    csrrw sp, mscratch, sp # Troca sp com mscratch novamente
    mret # Retorna da interrupção


.globl play_note
play_note:
    li t0, 0xFFFF0300     # Carrega o endereço base do MIDI

    sb a0, 0(t0)          
    sh a1, 2(t0)          
    sb a2, 4(t0)          
    sb a3, 5(t0)          
    sh a4, 6(t0)          
    
    ret 