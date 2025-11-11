# lib.s
#
# Seção de dados não inicializados (BSS)
# Aqui alocamos espaço para as pilhas.
.section .bss
.align 4

# Pilha principal para o programa (ex: 4KB)
main_stack:
.skip 4096
main_stack_end: # O topo da pilha (início, pois cresce para baixo)

# Pilha dedicada para a Rotina de Tratamento de Interrupção (ISR) (ex: 1KB)
.align 4
isr_stack:
.skip 1024
isr_stack_end: # O topo da pilha da ISR

# -----------------------------------------------------------------
# Seção de dados inicializados (.data)
# Aqui guardamos a variável global _system_time.
.section .data
.align 4

.globl _system_time # <-- CORREÇÃO: Exporta o símbolo para o linker
_system_time:
    .word 0 # Inicializa o contador de tempo global com 0

# -----------------------------------------------------------------
# Seção de código (.text)
.section .text
.align 2
.globl _start      # Exporta _start para o linker (ponto de entrada)
.globl play_note   # Exporta play_note para ser chamada pelo C

# =================================================================
# _start: Ponto de entrada e rotina de inicialização
# =================================================================
_start:
    # 1. Configura a pilha principal (para o 'main')
    la sp, main_stack_end

    # [cite_start]2. Configura mscratch com o topo da pilha da ISR [cite: 1612-1615]
    la t0, isr_stack_end
    csrw mscratch, t0

    # 3. Registrar a ISR (apontar mtvec para main_isr)
    la t0, main_isr
    csrw mtvec, t0

    # 4. Configurar o Timer (GPT) para gerar interrupção a cada 100ms
    #    Endereço base do GPT: 0xFFFF0500
    #    Registrador de interrupção (base+0x08): 0xFFFF0508
    li t0, 0xFFFF0108     # Endereço do registrador do GPT
    li t1, 100            # Valor (100 ms)
    sw t1, 0(t0)          # Programa o timer

    # [cite_start]5. Habilitar Interrupções (em dois níveis) [cite: 1630-1653]
    
    # 5a. Habilita Interrupções Externas (MEIE, bit 11 do 'mie')
    li t0, 0x800          # Máscara para o bit 11 (1 << 11)
    csrs mie, t0          # csrs = "CSR Set" (liga o bit 11)

    # 5b. Habilita Interrupções Globais (MIE, bit 3 do 'mstatus')
    li t0, 0x8            # Máscara para o bit 3 (1 << 3)
    csrs mstatus, t0      # Liga o bit 3 global

    # 6. Chama a função principal 'main' (que está no arquivo C)
    jal main

    # Caso 'main' retorne (o que não deve acontecer), fica em loop.
_stop:
    j _stop

# =================================================================
# main_isr: Rotina de Tratamento de Interrupção (ISR)
# =================================================================
main_isr:
    # 1. Salvar o contexto (salva registradores que a ISR usa)
    csrrw sp, mscratch, sp # Troca sp (main_stack) pelo mscratch (isr_stack)
    addi sp, sp, -20       # Aloca espaço (5 registradores * 4 bytes)
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw a0, 12(sp) # Salva a0 (mesmo que não use, por segurança)
    sw a1, 16(sp) # Salva a1 (mesmo que não use, por segurança)

    # 2. Trata a interrupção
    
    # Incrementa _system_time
    la t0, _system_time     # Carrega endereço de _system_time
    lw t1, 0(t0)            # Carrega o valor atual
    addi t1, t1, 1          # Incrementa
    sw t1, 0(t0)            # Salva o novo valor

    # Rearma o Timer (GPT)
    li t2, 0xFFFF0108       # Endereço do registrador do GPT
    li t1, 100              # Valor (100 ms)
    sw t1, 0(t2)            # Escreve 100 para rearmar

    # 3. Recupera o contexto
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw a0, 12(sp)
    lw a1, 16(sp)
    addi sp, sp, 20        # Desaloca espaço da pilha da ISR

    # 4. Retorna da interrupção
    csrrw sp, mscratch, sp # Troca sp (isr_stack) de volta pelo mscratch (main_stack)
    mret                   # Retorna e reabilita interrupções globalmente

# =================================================================
# play_note: Função para tocar uma nota no Sintetizador MIDI
# =================================================================
# void play_note(int ch, int inst, int note, int vel, int dur);
# a0: ch, a1: inst, a2: note, a3: vel, a4: dur
#
play_note:
    li t0, 0xFFFF0300     # Carrega o endereço base do MIDI
    
    sb a0, 0(t0)          # Store byte (ch) em base+0
    sh a1, 2(t0)          # Store half (inst) em base+2
    sb a2, 4(t0)          # Store byte (note) em base+4
    sb a3, 5(t0)          # Store byte (vel) em base+5
    sh a4, 6(t0)          # Store half (dur) em base+6
    
    ret # Retorna para quem chamou (o código 'main' em C)