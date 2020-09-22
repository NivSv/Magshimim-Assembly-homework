include emu8086.inc

jmp __AFTER_MACROS__
                        
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS     

print_al_chr	proc
		pusha
		_PRINT_AL_CHR
		popa
		ret
print_al_chr  	endp


print_ax_str	proc
		pusha
		_PRINT_AX_STR
		popa
		ret
print_ax_str  	endp


_PRINT_AL_CHR    MACRO
        mov     ah,0Eh
        int     10h
        mov     al,0Dh  
        int     10h
        mov     al,0Ah
        int     10h  
ENDM        
        
        
_PRINT_AX_STR    MACRO     
        mov     dx, ax
        mov     ah, 09h   
        xor     al,al
        int     21h   
ENDM    

__AFTER_MACROS__: nop
