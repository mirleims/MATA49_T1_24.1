# Alessandro Oliveira
# Daniel Alves
# Tainã Costa

section .data
    mensagem_entrada db "Digite um valor para N: ", 0
    mensagem_saida db "O fatorial de %d é: %ld", 10, 0
    formato_entrada db "%d", 0
    formato_saida db "%ld", 0

section .bss
    n resd 1
    resultado resq 1

section .text
    extern printf, scanf
    global _start

_start:
    ; Ler o valor
    mov rdi, mensagem_entrada
    call printf
    mov rdi, formato_entrada
    mov rsi, n
    call scanf

    ; Inicializar resultado 1
    mov rax, 1
    mov [resultado], rax

    ; Calcular o fatorial
    mov ecx, [n]
    cmp ecx, 1
    jbe fim_fatorial

loop_fatorial:
    imul rax, rcx
    loop loop_fatorial
    mov [resultado], rax

fim_fatorial:
    ; Imprimir o resultado
    mov eax, [n]
    mov rdi, mensagem_saida
    mov esi, eax
    mov rdx, [resultado]
    call printf

    mov eax, 60
    xor edi, edi
    syscall
