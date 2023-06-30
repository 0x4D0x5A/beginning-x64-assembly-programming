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
    strspace    db "",32
    strLen      db  63
    str1        db "1"
    str0        db "0"
    fmtstr      db "%s"
section .bss
section .text
    push    rbp
    mov     rbp,rsp
    
    mov     rcx, strLen
    mov     r12, 0

Initialloop:
    ; check if eighth bit, if yes, print space
    xor     rax,rax      ; clear rax (used in IDIV)
    xor     edx, edx     ; clear edx (used in IDIV, stores the remainder)  
    mov     ax, 8
    mov     ebx, r12d
    inc     ebx         
    idiv    ebx         ; divide the contents of EDX:EAX by the contents of EBX. 
                        ; TODO:  Doesnt work. Remainder will also be zero when deviding by 2 and 4 
    cmp     edx, 0x0    ; remainder is stored in edx
    jne     Printloop
    push    rdi
    push    0x0         ; for stack alignment
    mov	    rdi, fmtstr
    mov     rsi, strspace
    mov	    rax,0       ; no floating point
    call    printf
    add     rsp,8       ; skip the 0x0 that was pushed to the stack prior to function call
    pop     rdi
    cmp     r12, strLen
    jz      exit
    inc     r12
    jmp     Initialloop

Printloop:
    ; check if bit equals 1, then print 1 else print 0
    ; test ah, 1<<1
    shr     rdi, 1  ; does this work?
    jnc     write1  ; jump no carry (means the bit is zero)
    push    rdi
    push    0x0
    mov	    rdi, fmtstr
    mov     rsi, str1   ; TODO; prints 10?
    mov	    rax, 0		
    call    printf
    add     rsp,8
    pop     rdi
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

