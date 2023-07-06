; printb.asm
; program that takes an argument (in rdi) and prints every bit (64 bit)
BITS 64:
extern printf
section .data				
    number1	dq	-72 ; The number which binary representation, will be printed.
section .bss													
section .text									
	global main						
main:
    push    rbp
    mov     rbp,rsp
    mov     rdi, [number1]
    call    printb
    leave
    ret

printb:
section .data
    strspace    db " ",0
    strLen      dq  64
    str1        db "1",0
    str0        db "0",0
    fmtstr      db "%s",0
    strNl       db 10,0     ; prints new line
section .bss
section .text
    push    rbp
    mov     rbp,rsp
    mov     r12, 0    

printLoop:
    ; check if end of string
    cmp     r12, [strLen]
    je      exit        ; TODO: Jump greater
    ; check if bit equals 1, then print 1 else print 0
    ; test ah, 1<<1
    shl     rdi, 1  
    jnc     write0      ; jump no carry (means the bit is zero)
    push    rdi
    push    0x0
    mov	    rdi, fmtstr
    mov     rsi, str1   
    mov	    rax, 0		
    call    printf
    add     rsp,8
    pop     rdi
    jmp     writeSpace

write0:
    push    rdi
    push    0x0
    mov	    rdi, fmtstr
    mov     rsi, str0
    mov	    rax, 0		
    call    printf
    add     rsp,8
    pop     rdi
    
writeSpace:
    ; check for 8th bit
    xor     rax,rax     ; clear rax (used in IDIV)
    xor     rdx, rdx    ; clear edx (used in IDIV, stores the remainder) 
    mov     eax, r12d   ; r12 is the counter
    inc     r12         ; increment counter
    inc     eax         ; increment because every 9th place shoudl be a space
    mov     ebx, 8
    idiv    ebx         ; divide the contents of EDX:EAX by the contents of EBX. 
    cmp     edx, 0x0    ; remainder is stored in edx
    jne     printLoop   ; print 1 or 0
    ; print space
    push    rdi
    push    0x0         ; for stack alignment
    mov	    rdi, strspace
    mov     rsi, fmtstr
    mov	    rax,0       ; no floating point
    call    printf  
    add     rsp,8       ; skip the 0x0 that was pushed for alignment
    pop     rdi         ; pops the number back into rdi
    jmp     printLoop
    

exit:
    mov	    rdi, fmtstr
    mov     rsi, strNl  ; prints a newline
    mov	    rax, 0		
    call    printf
    mov 	rsp,rbp
    pop 	rbp
    ret