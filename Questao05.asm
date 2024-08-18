; Equipe 02
; Michael Kelvin Souza Almeida, Thiago Oliveira Franca, Otávio Novais de Oliveira

section .data
    fmt_input db "%d", 0   
    fmt_out db "%d, ", 0
    fmt_out_last db "%d", 10, 0

section .bss
    n resd 1              

section .text
    extern scanf, printf
    global main

main:
    push rbp
    mov rbp, rsp

    mov rdi, fmt_input        
    lea rsi, [n]              
    xor rax, rax              
    call scanf

    mov rbx, [n]              
    call collatz 
    
    mov rax, 60               
    xor rdi, rdi              
    syscall                   

collatz:
    push rbp
    mov rbp, rsp

    .loop:
        cmp rbx, 1            
        je .print_last        

        mov rdi, fmt_out
        mov rsi, rbx          
        mov rax, 0          
        call printf

        test rbx, 1           
        jz .even              

        imul rbx, rbx, 3      
        add rbx, 1            
        jmp .loop             

    .even:
        shr rbx, 1            
        jmp .loop             

    .print_last:
        mov rdi, fmt_out_last 
        mov rsi, rbx          
        xor rax, rax          
        call printf

        pop rbp
        ret  