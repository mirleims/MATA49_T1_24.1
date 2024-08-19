; Alunos: Arthur Batzakas, Clóvis Carmo e Rafael Melo
; Matrículas: 223115829, 223115825 e 223115826
section   .data
    message    db    "Entre com o numero:",10,0
    message_2 db "o resultado eh %d", 10, 0
    leitura_entrada dq "%d", 0

section .bss
entrada resq 1
result resq 1

section .text
global main
extern printf, scanf

    main:
    push rbp
    mov rbp, rsp

    ;mensagem de entrada
    mov rdi, message
    mov rax, 0
    call printf

    ;leitura numero

    mov rdi, leitura_entrada
    mov rsi, entrada
    mov rax, 0
    call scanf

    mov rbx, [entrada]
    mov rcx, rbx
    dec rcx
    mov rax, rbx

    .loop:
        cmp rcx, 1
        jle .acabou
        mul rcx
        dec rcx

        jmp .loop

    .acabou:
        mov [result], rax


    mov rdi, message_2
    mov rsi, [result]
    mov rax, 0
    call printf


    leave
    ret