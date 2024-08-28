;Brenno Andrade
;Fernanda Diniz
;Theo Farias 

section .data
    PERGUNTAR_NUM1 db "Informe o primeiro número: ",0
    PERGUNTAR_NUM2 db "Informe o segundo número: ",0
    PERGUNTAR_OPERACAO db "Escolha a operação (1: +, 2: -, 3: *, 4: /): ",0
    LER_NUM db "%d",0
    RESULTADO db "O resultado é: %d",10,0
    ERRO_DIV_ZERO db "Erro: divisão por zero!", 10, 0

section .bss
    num1 resq 1     
    num2 resq 1
    operacao resq 1 
    res_resultado resq 1 

section .text
    extern scanf
    extern printf
    global main

main:
    
    push rbp
    mov rbp, rsp

    ; Perguntar o primeiro número
    mov rdi, PERGUNTAR_NUM1
    call printf
    mov rdi, LER_NUM
    mov rsi, num1
    call scanf

    ; Perguntar o segundo número
    mov rdi, PERGUNTAR_NUM2
    call printf
    mov rdi, LER_NUM
    mov rsi, num2
    call scanf

    ; Perguntar a operação
    mov rdi, PERGUNTAR_OPERACAO
    call printf
    mov rdi, LER_NUM
    mov rsi, operacao
    call scanf

    ; Executar a operação escolhida
    mov rax, [num1]        ; Carrega o primeiro número
    mov rbx, [num2]        ; Carrega o segundo número

    mov rcx, [operacao]    ; Carrega a operação
    cmp rcx, 1             ; Compara com 1 (soma)
    je do_soma
    cmp rcx, 2             ; Compara com 2 (subtração)
    je do_subtracao
    cmp rcx, 3             ; Compara com 3 (multiplicação)
    je do_multiplicacao
    cmp rcx, 4             ; Compara com 4 (divisão)
    je do_divisao

    ; Se nenhuma operação corresponde, terminar
    jmp fim

do_soma:
    add rax, rbx             ; Soma `num1` e `num2`
    jmp mostrar_resultado

do_subtracao:
    sub rax, rbx             ; Subtrai `num2` de `num1`
    jmp mostrar_resultado

do_multiplicacao:
    imul rax, rbx            ; Multiplica `num1` por `num2`
    jmp mostrar_resultado

do_divisao:
    cmp rbx, 0               ; Verificar se o divisor é 0
    je erro_divisao_zero
    ; Divisão precisa de rdx:rax como o dividendo
    xor rdx, rdx             ; Limpa rdx
    div rbx                  ; Divide rax por rbx
    jmp mostrar_resultado

erro_divisao_zero:
    mov rdi, ERRO_DIV_ZERO ; Coloca a mensagem de erro na pilha
    call printf
    jmp fim

mostrar_resultado:
    mov [res_resultado], rax ; Armazena o resultado em res_resultado
    mov rdi, RESULTADO       ; Passa a string de resultado para `rdi`
    mov rsi, [res_resultado] ; o valor em res_r passa para rsi 
    call printf              ; Exibe o resultado

fim:
    pop rbp  
    mov rax, 0  ; Indica que a execução foi bem-sucedida
    ret         ; Retorna ao sistema operacional