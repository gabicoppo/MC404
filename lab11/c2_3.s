.data

.globl fill_array_int
.globl for_loop_int
.globl end_for_int
.globl fill_array_short
.globl for_loop_short
.globl end_for_short
.globl fill_array_char
.globl for_loop_char
.globl end_for_char


fill_array_int:
    addi sp, sp, -416     # (400 bytes) + ra (8 bytes) e arredonda pra 416 pq eh mehlor pra pilha 
    sw ra, 408(sp)      

    li t0, 0            # i = 0
    li t1, 100          

for_loop_int:
    bge t0, t1, end_for_int 

    slli t2, t0, 2        # t2 = i * 4

    add t3, sp, t2       # t3 = &array[i]

    sw t0, 0(t3)        # array[i] = i

    addi t0, t0, 1        
    j for_loop_int 

end_for_int:
    mv a0, sp           
    jal mystery_function_int 

    lw ra, 408(sp)    
    addi sp, sp, 416    
    ret           

fill_array_short:
    addi sp, sp, -208
    sw   ra, 200(sp)  
    li   t0, 0         
    li   t1, 100       

for_loop_short:
    bge  t0, t1, end_for_short # if (i >= 100) exit loop

    slli t2, t0, 1        # i * 2

    add  t3, sp, t2       # &array[i]

    sh   t0, 0(t3)        # array[i] = i

    addi t0, t0, 1       
    j    for_loop_short

end_for_short:
    mv   a0, sp      
    jal  mystery_function_short

    lw   ra, 200(sp)      
    addi sp, sp, 208      
    ret


fill_array_char:
    addi sp, sp, -112
    sw   ra, 104(sp)   

    li   t0, 0       
    li   t1, 100      

for_loop_char:
    bge  t0, t1, end_for_char 

    add  t2, sp, t0    

    sb   t0, 0(t2)     

    addi t0, t0, 1  
    j    for_loop_char

end_for_char:
    mv   a0, sp     
    jal  mystery_function_char

    lw   ra, 104(sp)   
    addi sp, sp, 112  
    ret
