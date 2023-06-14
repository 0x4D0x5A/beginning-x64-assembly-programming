;alive.asm
BITS 64;
section .data
    msg1    db      "Hello, World!",10,0 ;string with NL and 0 
    msg1Len equ     $-msg1-1    ; measure the length, minus the 0. means take memory address of "$" and subtract address of msg1 and subtract 1
    msg2    db      "Alive and Kicking!",10,0 ;string with NL and 0
    msg2Len equ     $-msg2-1    ; measure the length, minus the 0
    radius  dq      357         ; no string, not displayable?
    pi      dq      3.14        ; no string, not displayable?

section .bss
section .text

    global main
main:
    push    rbp         ; function prologue
    mov     rbp,rsp     ; function prologue
    mov     rax, 1      ; 1 = write
    mov     rdi, 1      ; 1 = to stdout
    mov     rsi, msg1   ; string to display
    mov     rdx, msg1Len; length of string
    syscall             ; display the string
    mov     rax, 1      ; 1 = write 
    mov     rdi, 1      ; 1 = stdout
    mov     rsi, msg2   ; string to display
    mov     rdx, msg2Len; length of the string
    syscall             ; display the string
    mov     rsp,rbp     ; function epilogue
    pop     rbp         ; function epilogue
    mov     rax, 60     ; 60 = exit
    mov     rdi, 0      ; exit code
    syscall
