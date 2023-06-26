; printb.asm
BITS 64:
extern printf
section .data				
    number1	dq	-72
section .bss													
section .text									
	global main						
main:
    mov rbp, rsp    ; for correct debugging
    push rbp
    mov rbp,rsp
    mov rdi, [number1]
    call printb
    leave
    ret

printb:
section .data
    strspace    db " ",10,0
    strLen      db  63
    str1        db "1"
    str0        db "0"
    fmtstr      db "%s",10,0
section .bss
    shiftAmount dq 0
section .text
    push    rbp
  	mov     rbp,rsp
    
    mov     rbx, rdi
    mov     rcx, strLen
    mov     r12, 0

Initialloop:
    ; check if eighth bit, if yes, print space
    xor     rax,rax           ; clear rax (especially higher bits)
    mov     ax, 8
    div     r12
    cmp     ah, 0x0 ; remainder in ah
    jne     Printloop
    mov	    rdi, fmtstr
    mov     rsi, strspace
	mov	    rax,0		; no floating point
	call    printf
    cmp     r12, strLen
    jz      exit
    inc     r12
    jmp     Initialloop

Printloop:
    ; check if bit equals 1, then print 1 else print 0
    ; test ah, 1<<1
    mov     [shiftAmount], r12
    shr     rdi, shiftAmount
    test    al, 1
    jz      write1
    mov		rdi, fmtstr
    mov    	rsi, str0
    mov		rax, 0		
    call  	printf
    inc     r12
    jmp     Initialloop

write1:
    mov		rdi, fmtstr
    mov    	rsi, str1
    mov		rax, 0		
    call  	printf
    inc     r12
    jmp     Initialloop

exit:
    mov 	rsp,rbp
    pop 	rbp
    ret

