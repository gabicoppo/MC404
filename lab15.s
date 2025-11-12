.section .bss
.align 4
main_stack: .skip 4096
main_stack_end:


isr_stack: .skip 1024 # Aloca 1024 bytes para a pilha
isr_stack_end: 

.section .data

.text

.set X_TEST_TRACK, 73
.set Y_TEST_TRACK, 1
.set Z_TEST_TRACK, -19

.align 4

int_handler:
    ###### Syscall and Interrupts handler ######

    # <= Implement your syscall handler here

    csrr t0, mepc  # load return address (address of
                    # the instruction that invoked the syscall)
    addi t0, t0, 4 # adds 4 to the return address (to return after ecall)
    csrw mepc, t0  # stores the return address back on mepc
    mret           # Recover remaining context (pc <- mepc)


.globl _start
_start:
    la sp, main_stack_end

    # Configura mscratch com o topo da pilha das ISRs.
    la t0, isr_stack_end # t0 <= base da pilha
    csrw mscratch, t0 # mscratch <= t0

    la t0, int_handler  # Load the address of the routine that will handle interrupts
    csrw mtvec, t0      # (and syscalls) on the register MTVEC to set
                        # the interrupt array.

    csrr t1, mstatus # Update the mstatus.MPP
    li t2, ~0x1800 # field (bits 11 and 12)
    and t1, t1, t2 # with value 00 (U-mode)

    csrw mstatus, t1 
    la t0, user_main # Loads the user software 
    csrw mepc, t0 # entry point into mepc 
    mret # PC <= MEPC; mode <= MPP;

    jal user_main

# Write here the code to change to user mode and call the function
# user_main (defined in another file). Remember to initialize
# the user stack so that your program can use it.

.globl control_logic
control_logic:
    # set engine forward
    li a0, MEMORY_SLOT
    li t0, 0x21
    add a0, a0, t0
    li t0, 1
 
    sb t0, 0(a0)             # colocando 1 na engine

    # set steering wheel
    li a0, MEMORY_SLOT
    li t0, 0x20
    add a0, a0, t0
    li t0, -15       # inclinação necessária p esquerda pra entrar corretamente no test track na tentativa e erro
    sb t0, 0(a0)

  # implement your control logic here, using only the defined syscalls