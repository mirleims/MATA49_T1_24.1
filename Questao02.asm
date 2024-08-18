; Equipe 02
; Michael Kelvin Souza Almeida, Thiago Oliveira Franca, Otávio Novais de Oliveira

section .data
    fmt_int db "%d", 0      
    fmt_out db "%d", 10, 0

section .bss
    n resd 1     
    soma resd 1   

section .text
    extern scanf, printf
    global main

main:
    push rbp
    mov rbp, rsp            

    mov rdi, fmt_int
    lea rsi, [n]
    xor rax, rax              
    call scanf

    mov rax, [n]
    call fatorial

    mov rdi, fmt_out
    mov rsi, [soma]
    xor rax, rax             
    call printf

    mov rax, 60
    xor rdi, rdi
    syscall

factorial:
    push rbp
    mov rbp, rsp            
    mov rbx, 1     
    
.loop:
    cmp rax, 1
    jle .end                  

    imul rbx, rax            
    dec rax                   
    jmp .loop                 

.end:
    mov [soma], rbx    
    
    pop rbp
    ret
