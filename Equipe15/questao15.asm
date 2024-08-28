section .data
    msg1 db "Digite uma string: ", 0
    msg1_len equ $-msg1
    msg2 db "String codificada: ", 0
    msg2_len equ $-msg2

section .bss
    str1 resb 100        ; Buffer para a string de entrada
    str2 resb 200        ; Buffer para a string codificada
    count resb 1         ; Buffer para armazenar o contador de repetições
    encoded_len resb 1   ; Buffer para armazenar o comprimento da string codificada

section .text
    global _start

_start:
    ; Imprime a mensagem para o usuário
    mov rax, 1          ; sys_write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, msg1       ; ponteiro para a mensagem
    mov rdx, msg1_len   ; comprimento da mensagem
    syscall

    ; Lê a string do usuário
    mov rax, 0          ; sys_read
    mov rdi, 0          ; file descriptor 0 (stdin)
    mov rsi, str1       ; ponteiro para o buffer
    mov rdx, 100        ; tamanho do buffer
    syscall

    ; Remove o caractere de nova linha da string de entrada
    call remove_newline

    ; Inicializa os ponteiros e o contador
    mov rsi, str1       ; ponteiro para a string de entrada
    mov rdi, str2       ; ponteiro para a string codificada
    mov byte [count], 1 ; Inicializa o contador de repetições
    mov byte [encoded_len], 0 ; Inicializa o comprimento da string codificada

    ; Loop principal para codificar a string
loop:
    mov al, [rsi]       ; Carrega o caractere atual
    cmp al, 0           ; Verifica se é o fim da string
    je fim              ; Se for o fim, termina o loop

    ; Se o próximo caractere for o mesmo, incrementa o contador
    mov bl, [rsi + 1]
    cmp al, bl
    jne fim_count

    inc byte [count]
    inc rsi
    jmp loop

fim_count:
    ; Armazena o caractere original na string de saída
    mov [rdi], al
    inc rdi

    ; Converte o contador para ASCII e armazena na string de saída
    movzx rax, byte [count]
    add rax, '0'
    mov [rdi], al
    inc rdi

    ; Atualiza o comprimento da string codificada (2 bytes por caractere e contador)
    add byte [encoded_len], 2

    ; Reinicializa o contador
    mov byte [count], 1
    inc rsi
    jmp loop

fim:
    ; Adiciona o caractere nulo ao final da string de saída
    mov byte [rdi], 0

    ; Imprime a mensagem "String codificada:"
    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, msg2_len
    syscall

    ; Imprime a string codificada
    mov rax, 1
    mov rdi, 1
    mov rsi, str2
    ; Corrige o comprimento para toda a string codificada
    movzx rdx, byte [encoded_len]  
    syscall

    ; Encerra o programa
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall

; Função para remover o caractere de nova linha da string de entrada
remove_newline:
    mov rdi, str1
    loop_newline:
        cmp byte [rdi], 0
        je newline_done
        cmp byte [rdi], 10
        jne skip_newline
        mov byte [rdi], 0
        jmp newline_done
    skip_newline:
        inc rdi
        jmp loop_newline
    newline_done:
        ret
