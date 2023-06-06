; hello2.asm
BITS 64;
section .data					
    msg	db      "hello, world",0
    NL  db      0xa ;ascii code for newline			
section .bss							
section .text							
    global main					
main:
						 
	mov     rax, 1		; 1 = write	
    mov     rdi, 1		; 1 = to stdout		
    mov     rsi, msg	; string to display in rsi
    mov     rdx, 12		; length of the string, without 0
    syscall				; display the string
    mov     rax, 1      ; 1 = write
    mov     rdi, 1      ; 1 = stdout
    mov     rsi, NL     ; Display newline
    mov     rdx, 1      ; length of the string
    syscall             ; Display the string
    mov     rax, 60		; 60 = exit	
    mov     rdi, 0		; 0 = success exit code	
    syscall				; quit
