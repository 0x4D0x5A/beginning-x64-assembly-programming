; printb.asm
BITS 64:
extern printf
section .data				
    number1	dq	-72
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
    strLen      dq  63
    str1        db "1",0
    str0        db "0",0
    fmtstr      db "%s"
section .bss
section .text
    push    rbp
    mov     rbp,rsp
    mov     r12, 0

Initialloop:
    ; check if end of string
    cmp     r12, [strLen]
    je      exit
    ; check if eighth bit, if yes, print space 
    cmp     r12d, 0     ; Avoid dividing with 0 
    je      Printloop      
    
    xor     rax,rax     ; clear rax (used in IDIV)
    xor     rdx, rdx    ; clear edx (used in IDIV, stores the remainder) 
    mov     eax, r12d   ; r12 is the counter
    mov     ebx, 8      ; TODO: It prints a space after every 7 bit it should be after every 8
    idiv    ebx         ; divide the contents of EDX:EAX by the contents of EBX. 
    cmp     edx, 0x0    ; remainder is stored in edx
    jne     Printloop   ; print 1 or 0
    ; else print space
    push    rdi
    push    0x0         ; for stack alignment
    mov	    rdi, strspace
    mov     rsi, fmtstr
    mov	    rax,0       ; no floating point
    call    printf  
    add     rsp,8       ; skip the 0x0 that was pushed for alignment
    pop     rdi
    inc     r12
    jmp     Initialloop

Printloop:
    ; check if bit equals 1, then print 1 else print 0
    ; test ah, 1<<1
    shr     rdi, 1  
    jnc     write1      ; jump no carry (means the bit is zero)
    push    rdi
    push    0x0
    mov	    rdi, fmtstr
    mov     rsi, str1   
    mov	    rax, 0		
    call    printf
    add     rsp,8
    pop     rdi
    inc     r12
    jmp     Initialloop

write1:
    push    rdi
    push    0x0
    mov	    rdi, fmtstr
    mov     rsi, str0
    mov	    rax, 0		
    call    printf
    add     rsp,8
    pop     rdi
    inc     r12
    jmp     Initialloop

exit:
    mov 	rsp,rbp
    pop 	rbp
    ret