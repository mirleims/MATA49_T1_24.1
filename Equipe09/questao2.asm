; Alunos: Arthur Batzakas, Clóvis Carmo e Rafael Melo
; Matrículas: 223115829, 223115825 e 223115826

section   .data
    message    db    "Entre com o numero entre 0 e 20:", 10, 0
    message_2  db    "O resultado é %ld", 10, 0
    leitura_entrada db "%d", 0

section .bss
    entrada resq 1
    result resq 1

section .text
global main
extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    ; Mensagem de entrada
    mov rdi, message
    mov rax, 0
    call printf

    ; Leitura do número
    mov rdi, leitura_entrada
    mov rsi, entrada
    mov rax, 0
    call scanf

    ;Calculo do fatorial
    mov rbx, [entrada]
    mov rcx, rbx
    dec rcx
    mov rax, rbx
    cmp rbx, 0
    je .zero

    .loop:
        cmp rcx, 1
        jle .fim_loop
        mul rcx
        dec rcx
        jmp .loop
    
    .zero:
        mov rax, 1
    
    .fim_loop:
        mov [result], rax    
    
        ; Exibe o resultado
        mov rdi, message_2
        mov rsi, [result]
        mov rax, 0
        call printf
    
        leave
        ret