.text
.globl my_function


my_function:
    # a0 = a, a1 = b, a2 = c

    addi sp, sp, -20
    sw ra, 16(sp)       
    sw a0, 12(sp)       
    sw a1, 8(sp)        
    sw a2, 4(sp)        
        
    add t0, a0, a1      # sum 1
    
    mv a1, a0          
    mv a0, t0          

    
    jal ra, mystery_function
    # retorno em a0
    
    lw t1, 12(sp)       # t1 = a
    lw t2, 8(sp)        # t2 = b
    lw t3, 4(sp)        # t3 = c

    sub t4, t2, a0      # diff 1
    
    add t5, t4, t3      # sum 2
    
    mv a0, t5         
    mv a1, t2        
    
    sw t5, 0(sp)        # salva aux
    
    jal ra, mystery_function
    # retono em a0
    
    lw t5, 0(sp)       
    lw t3, 4(sp)        
    
    sub t6, t3, a0      # diff 2
    
    add a0, t6, t5      # sum 3
    
    lw ra, 16(sp)
    addi sp, sp, 20
    
    ret

