.section .bss
.align 4
main_stack: .skip 4096
main_stack_end:

isr_stack: .skip 1024 # Aloca 1024 bytes para a pilha
isr_stack_end: 

.section .data

.text

.set MEMORY_SLOT, 0xFFFF0100

.align 4


.globl _start
_start:
    la sp, main_stack_end

    # Configura mscratch com o topo da pilha das ISRs.
    la t0, isr_stack_end              # t0 <= base da pilha
    csrw mscratch, t0                 # mscratch <= t0

    la t0, int_handler                # Load the address of the routine that will handle interrupts
    csrw mtvec, t0                    # (and syscalls) on the register MTVEC to set the interrupt array.

    csrr t1, mstatus                  # Update the mstatus.MPP
    li t2, ~0x1800                    # field (bits 11 and 12)
    and t1, t1, t2                    # with value 00 (U-mode)

    csrw mstatus, t1 
    la t0, user_main                  # Loads the user software 
    csrw mepc, t0                     # entry point into mepc 
    
    mret                              # PC <= MEPC; mode <= MPP;

    jal user_main


# Write here the code to change to user mode and call the function
# user_main (defined in another file). Remember to initialize
# the user stack so that your program can use it.

.globl int_handler
int_handler:
    ###### Syscall and Interrupts handler ######

    # Salvar o contexto
    csrrw sp, mscratch, sp       # Troca sp com mscratch
    addi sp, sp, -8              # Aloca espaço na pilha
    sw t0, 0(sp)                 # Salva a0
    sw t1, 4(sp)                 # Salva a1 

    li t1, MEMORY_SLOT

    li t0, 10
    bne a7, t0, not_valid        # se a ecall não for a7=10, vamos p uma f que retorna

    sb a0, 0x21(t1)              # setando engine 1
    sb a1, 0x20(t1)              # setando steering wheel -15
    
    csrr t0, mepc                # load return address (address of the instruction that invoked the syscall)
    addi t0, t0, 4               # adds 4 to the return address (to return after ecall)
    csrw mepc, t0                # stores the return address back on mepc

    lw t1, 4(sp)                 # Recupera a1
    lw t0, 0(sp)                 # Recupera a0
    addi sp, sp, 8               # Desaloca espaço da pilha

    csrrw sp, mscratch, sp       # Troca sp com mscratch novamente
    mret                         # Recupera o restante do contexto

.globl
not_valid:
1: 
    j 1b # Infinite loop


.globl control_logic
control_logic:
    # set engine forward
    li a0, 1
    # set steering wheel
    li a1, -15                       # inclinação necessária p esquerda pra entrar corretamente no test track na tentativa e erro   

    li a7, 10
    ecall                            # syscall_set_engine_and_steering

    ret


