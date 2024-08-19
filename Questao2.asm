;Equipe 1
;Alunos:
;Pedro Henrique Matias de Almeida Ramos
;David França Simões dos Santos

;Questão 2) Escreva um programa em Assembly que leia um valor N e calcule o valor fatorial.


section .data
    msgEntrada db "Insira o valor para calcular o fatorial: ", 0
    lerEnt db "%ld", 0
    msgResultado db "O fatorial de %ld e: %ld", 10, 0
    
section .bss
    entrada resq 1
    resultado resq 1

section .text
    global main
    extern printf
    extern scanf

main:
    push rbp
    mov rbp, rsp

    ; Ler valor de entrada
    mov rdi, msgEntrada
    call printf
    mov rdi, lerEnt
    lea rsi, [entrada]
    call scanf

    ; Calcular o fatorial
    mov rdi, [entrada]  ; Carrega o número de entrada para rdi
    call calcular_fatorial
    mov [resultado], rax  ; Armazena o resultado do fatorial

    ; Imprimir resultado
    mov rdi, msgResultado
    mov rsi, [entrada]   ; Número original
    mov rdx, [resultado] ; Resultado do fatorial
    call printf

    ; Finalizar o programa
    pop rbp
    ret

; Função para calcular o fatorial
; Entrada:
;   rdi - num (int) - Número cuja fatorial será calculada
; Saída:
;   rax - Resultado do fatorial
calcular_fatorial:
    mov rax, rdi            ; Coloca o valor de num em rax
    cmp rax, 0              ; Verifica se o número é menor que 0
    jl  fatorial_zero       ; Se for negativo, retorna 1 (fatorial não definido)

    mov rcx, 1              ; Inicializa o acumulador do fatorial com 1
    test rax, rax           ; Verifica se o valor de num é zero
    jz fatorial_zero        ; Se num é zero, pula para o tratamento de fatorial zero

    mov rbx, rax            ; Copia o valor de num para rbx (contador do loop)

fatorial_loop:
    imul rcx, rbx           ; Multiplica rcx (acumulador do fatorial) por rbx
    dec rbx                 ; Decrementa rbx
    test rbx, rbx           ; Verifica se rbx é zero
    jnz fatorial_loop       ; Se rbx não for zero, continua o loop

    mov rax, rcx            ; Armazena o resultado em rax (retorno)
    ret

fatorial_zero:
    mov rax, 1              ; Se num é zero ou negativo, o fatorial é 1
    ret
