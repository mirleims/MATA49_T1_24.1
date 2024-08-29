;Brenno Andrade
;Fernanda Diniz
;Theo Farias 

section .data
    msg db "Escolha a entrada: (1) Raio, (2) Diâmetro: ", 0
    msg_val db "Informe o valor: ", 0
    area_msg db "A área do círculo é: %f", 10, 0
    erro_msg db "Opção inválida. O programa encerrado.", 10, 0
    pi dq 3.1415926  ; Valor de pi
    divisor dq 2.0           ; Divisor para converter diâmetro em raio
    ler_num dq "%lf",0
    ler_op db "%d",0

section .bss
    entrada resd 1           ; Espaço para armazenar a escolha (1 ou 2)
    valor resq 1             ; Espaço para armazenar o valor inserido

section .text
    global main
    extern printf
    extern scanf

main:
    ; Configura a stack frame
    push rbp
    mov rbp, rsp

    ; Perguntar ao usuário o tipo de entrada (raio ou diâmetro)
    mov rdi, msg
    call printf

    mov rdi, ler_op         ; Lê um operação
    mov rsi, entrada
    call scanf

    ; Perguntar o valor (raio ou diâmetro)
    mov rdi, msg_val
    call printf

    mov rdi, ler_num          ; Lê um valor flutuante
    mov rsi, valor
    call scanf

    ; Verificar se o usuário escolheu raio (1) ou diâmetro (2)
    mov rax, [entrada]
    cmp rax, 1
    je calcular_raio
    cmp rax, 2
    je calcular_diametro

    ; Se nenhuma opção não for válida, exibir mensagem de erro e sair
    mov rdi, erro_msg
    call printf
    jmp fim

calcular_raio:
    ; Calcular a área usando o raio diretamente
    movq xmm0, [valor]        ; Carrega o valor em xmm0
    mulsd xmm0, xmm0          ; xmm0 = valor * valor
    movq xmm1, [pi]           ; Carrega o valor de pi
    mulsd xmm0, xmm1          ; xmm0 = pi * valor * valor
    jmp mostrar_resultado

calcular_diametro:
    ; Calcular a área usando o diâmetro
    movq xmm0, [valor]        ; Carrega o valor em xmm0
    movq xmm1, [divisor]      ; Carrega o divisor (2.0)
    divsd xmm0, xmm1          ; xmm0 = valor / 2.0 (raio)
    mulsd xmm0, xmm0          ; xmm0 = (valor / 2.0) * (valor / 2.0)
    movq xmm1, [pi]           ; Carrega o valor de pi
    mulsd xmm0, xmm1          ; xmm0 = pi * (valor / 2.0) * (valor / 2.0)

mostrar_resultado:
    ; Imprimir o resultado
    mov rdi, area_msg
    mov rax, 1               ; Número de argumentos flutuantes
    call printf

fim:
    pop rbp  
    mov rax, 0  ; Indica que a execução foi bem-sucedida
    ret         ; Retorna ao sistema operacional