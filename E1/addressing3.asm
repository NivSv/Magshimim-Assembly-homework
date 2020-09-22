org  100h

jmp start

start:  

; We first push a "magic" number to the stack
; so we can check it's ok at the end

        mov     ax,23232
        push    ax


; Use 'call' and 'pop' to find the address of my_pos without using
; 'offset'. No need to actually write a function. 
; Write your code here:

        call my_pos
        my_pos:        
; Write your code also here:        
           
        pop ax        
        call    print_num
        PRINTN
        
; Compare your value to this value
        PRINTN  "THE CORRECT VALUE SHOULD BE:"
        mov     ax,offset my_pos
        call    print_num
        PRINTN
; We now check the stack - this MUST print out our
; "magic" number 23232               

        pop     ax
        call    print_num
        PRINTN
        
        
        mov     ah, 0 
        int     16h 
        

ret
include magshimim.inc 