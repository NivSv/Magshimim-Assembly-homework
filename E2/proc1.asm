org  100h

jmp start

start:  

; We first push a "magic" number to the stack
; so we can check it's ok at the end

        mov     ax,23232
        push    ax

; The value of BX,BP,SI,DI at the beginning
        PRINTN  "BX,BP,SI,DI before:"
        mov     bx,1
        mov     ax,bx       
        call    print_num
        PRINTN      
        mov     bp,2
        mov     ax,bp       
        call    print_num
        PRINTN      
        mov     si,3
        mov     ax,si       
        call    print_num
        PRINTN
        mov     di,4
        mov     ax,di       
        call    print_num
        PRINTN
              
; Push two parameters
              
        push    5   ;param2
        push    4   ;param1
        call    foo
		add 	sp, 4 ;restore stack

        
; The value of BX,BP,SI,DI at the end
        PRINTN  "BX,BP,SI,DI after (should be 1,2,3,4):"
        mov     ax,bx       
        call    print_num
        PRINTN
        mov     ax,bp       
        call    print_num
        PRINTN
        mov     ax,si       
        call    print_num
        PRINTN
        mov     ax,di       
        call    print_num
        PRINTN        
                
; We now check the stack - this MUST print out our
; "magic" number 23232               
        PRINTN  "Check stack cookie (should be 23232):"
        pop     ax
        call    print_num
        PRINTN
        
        
        mov     ah, 0 
        int     16h 
ret

foo proc
; Define EQU's for the offsets of the parameters
; and local variables RELATIVE TO BP
; Example: 
    localvar1  equ -2
    
; Fill in:    
    param1     equ +12
    param2     equ +14
    
    localvar2  equ -4
    localvar3  equ -6    
     
    
; First save the old BP     

    push bp     

; Now save more registers that we mess up
; during the function and must preserve:
    push bx
    push bp
    push si
    push di
                        
                 
; Now establish new BP     
    mov bp,sp   

; Make room for 3 local variables, each of size 2 bytes
    sub sp,6   

    
; Now let's test it:
    mov     ax,[bp+param1]
    mov     [bp+localvar1],ax
    
    mov     bx,[bp+param2]
    mov     [bp+localvar2],bx

    sub     bx,ax
    mov     [bp+localvar3],bx
    
; Now let's check the stack

    pop     di
    cmp     di,1
    jne     fail
    
    pop     si
    cmp     si,5
    jne     fail
    
    
    pop     bx
    cmp     bx,4
    jne     fail
    
    PRINTN "VERY GOOD!"
    
    jmp     epilogue

fail:   PRINTN "YOU HAVE AN ERROR. TRY AGAIN!"

epilogue:   
  
mov sp,bp

pop di
pop si
pop bp
pop bx


pop bp   

ret
 

foo endp
    
include magshimim.inc 