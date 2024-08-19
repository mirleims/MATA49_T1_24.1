;Equipe 07
;Bruno Henrique dos Santos Luz Santos, Vitor Renato Santos dos Santos
;Escreva um programa em Assembly que receba dois valores A e B e apresente a sequência de Fibonacci do intervalo [A,B].

;COMO EXECUTAR
;nasm -f elf64 Questao07.asm
;gcc -o Questao07 Questao07.o -no-pie
;./Questao07

;explicacao
    ;a = 0
    ;b = 10
    
    ;rcx = 1 -> 1 -> 1 -> 2 -> 3 -> 5
    ;rbx = 1 -> 1 -> 2 -> 3 -> 5 -> 8
    ;rax = 1 -> 2 -> 3 -> 5 -> 8 ->
    ;contador - rdx = 1 + 1 -> 2 + 1 -> 3 + 1 -> 4 + 1 -> 5 + 1 -> 6
    
    ;SAÍDA
    ;n = 1
    ;n = 2
    ;n = 3
    ;n = 5
    ;n = 8
    ;END

global main
extern scanf
extern printf

section .data
    DIGITE_AeB db "Digite dois números A e B, e veja a sequência de Fibonacci do intervalo [A,B]: ", 0
    LER_AeB db "%d %d", 0
    ESCREVER_SEQUENCIA db "A sequência de Fibonacci do intervalo [%d,%d] é:", 10, 0
    Numero db "n = %d", 10, 0

section .bss
  a resq 1 ; usamos resq pois para comparação com rax, tem que ter numero equivalente de bits
  b resq 1
  fibonacci resq 1

section .text

main:
  push rbp
  mov rbp, rsp

leitura:
  mov rdi, DIGITE_AeB
  mov rax, 0
  call printf

  mov rdi, LER_AeB
  mov rsi, a
  mov rdx, b
  call scanf

exibe_sequencia:
  mov rdi, ESCREVER_SEQUENCIA
  mov rsi, [a]
  mov rdx, [b]
  mov rax, 0
  call printf

caso_base:
  mov rax, 1     ;Fibonacci n
  xor rbx, rbx   ;Fibonacci n-1
  xor rcx, rcx   ;Fibonacci n-2
  mov rdx, 1     ;contador começa em 1
  
verificar_limites:
    cmp rax, [a]
    jb atualiza_valores_n ; Se rax < a, vou somar o próximo
    
    cmp rax, [b]
    ja end ; Se rax > b, encerra ;O B.O. É AQUI

imprimir_n:
    mov [fibonacci], rax

    mov rdi, Numero
    mov rsi, rax
    call printf
    
    mov rax, [fibonacci] ;isso foi útil, pois rax estava mudando após printf

atualiza_valores_n:    
    mov rcx, rbx ;Fibonacci n-2    
    mov rbx, rax ;Fibonacci n-1

soma:
    add rax, rcx ;Fibonacci n
    inc rdx
    jmp verificar_limites

end:
    pop rbp
    mov rax, 0
    ret