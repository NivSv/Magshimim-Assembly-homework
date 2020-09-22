org  100h

jmp start

max_num   dw 0;
min_num   dw 0;

start:  
              
        push    5
        push    4
        lea bx , [max_num]      
        push    bx
        call    max
		add 	sp, 3
		
		push    5
        push    4
        lea bx , [min_num]      
        push    bx
        call    min
		add 	sp, 3
        
        
        mov     ah, 0 
        int     16h 
ret

max proc
    cmp [sp+6] , [sp+8]
    je par1
    jmp par2
       

ret
   
min proc
    cmp [sp+6] , [sp+8]
    je par2
    jmp par1
       

ret

par1:
 mov [sp-4],[sp+6]
 ret
 
par2:
 mov [sp-4],[sp+8]
 ret


foo endp
    
include magshimim.inc 