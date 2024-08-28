;Laura Ferreira, Letícia Lemos, Nalanda Pita
bits 64 

section .data
    comando db "(1) Soma (2) Subtração (3) Multiplicação (4) Divisão: ", 10, 0
    fmt_op db "%d", 0              
    fmt_num dq "%lf", 0
    resultado_fmt db "O resultado é: %.2f", 10, 0
    num1_msg db "Digite o primeiro numero: ", 0
    num2_msg db "Digite o segundo numero: ", 0
    erro_msg db "OPERAÇÃO NÃO RECONHECIDA!", 10, 0
    erro2_msg db "DIVISÃO POR ZERO!", 10, 0

section .bss
    num1 resq 1
    num2 resq 1
    op resb 1
    resultado resq 1

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    mov rdi, comando
    call printf

    mov rdi, fmt_op
    mov rsi, op
    call scanf

    mov rdi, num1_msg
    call printf

    mov rdi, fmt_num
    mov rsi, num1
    call scanf

    mov rdi, num2_msg
    call printf

    mov rdi, fmt_num
    mov rsi, num2
    call scanf

    movq xmm0, [num1]
    movq xmm1, [num2]

    mov rax, [op]
    cmp rax, 1      
    je soma
    cmp rax, 2      
    je sub
    cmp rax, 3      
    je mul
    cmp rax, 4      
    je div

    jmp erro1

soma:
    addsd xmm0, xmm1
    jmp res

sub:
    subsd xmm0, xmm1
    jmp res

mul:
    mulsd xmm0, xmm1
    jmp res

div:
    mov rax, [num2]
    cmp rax, 0
    je erro2
    divsd xmm0, xmm1
    jmp res

res:
    movq [resultado],xmm0
    mov rdi, resultado_fmt
    mov rsi, [resultado]
    call printf
    jmp end

erro1:
    mov rdi, erro_msg
    call printf
    jmp end

erro2:
    mov rdi, erro2_msg
    call printf

end:
    leave
    ret
