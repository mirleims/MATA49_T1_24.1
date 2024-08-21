; Equipe 6
; Arthur Batista dos Santos Borges, João Paulo Cardoso da Paixão e Gabriel Baptista de Abreu
; Questão 11:  Escreva um programa em Assembly que receba os
; três lados do triângulo, por exemplo, l1, l2 e l3. E
; verifique se o triângulo é equilátero, isósceles, ou
; escaleno.


section .bss
    l1 resq 1
    l2 resq 1
    l3 resq 1

section .data
    msg_eq db "O triângulo é equilátero", 10, 0
    msg_is db "O triângulo é isósceles", 10, 0
    msg_es db "O triângulo é escaleno", 10, 0


    msg_prompt_l1 db "Escreva o lado 1: ", 0
    msg_prompt_l2 db "Escreva o lado 2: ", 0
    msg_prompt_l3 db "Escreva o lado 3: ", 0
    fmt db "%ld", 0   ; Formato para scanf

section .text
    global main
    extern printf, scanf

    main:
        ; Salvar o ponteiro base do frame
        push rbp
        mov rbp, rsp

        ; Solicitar e ler o lado 1
        mov rdi, msg_prompt_l1  ; Mensagem para printf
        call printf
        mov rdi, fmt            ; Formato para scanf
        lea rsi, [l1]           ; Endereço de l1
        call scanf

        ; Solicitar e ler o lado 2
        mov rdi, msg_prompt_l2  ; Mensagem para printf
        call printf
        mov rdi, fmt            ; Formato para scanf
        lea rsi, [l2]           ; Endereço de l2
        call scanf

        ; Solicitar e ler o lado 3
        mov rdi, msg_prompt_l3  ; Mensagem para printf
        call printf
        mov rdi, fmt            ; Formato para scanf
        lea rsi, [l3]           ; Endereço de l3
        call scanf

        ; Carregar lados em registradores
        mov rax, [l1]
        mov rbx, [l2]
        mov rcx, [l3]

        ; Verificar equilátero
        cmp rax, rbx
        jne check_isosceles
        cmp rbx, rcx
        jne check_isosceles
        ; Triângulo equilátero
        mov rdi, msg_eq
        call printf
        jmp done

        ; Verificar isósceles
    check_isosceles:
        cmp rax, rbx
        je check_isosceles_l2
        cmp rax, rcx
        je check_isosceles_l3
        cmp rbx, rcx
        je check_isosceles_l2
        ; Triângulo escaleno
        mov rdi, msg_es
        call printf
        jmp done

        ; Triângulo isósceles
    check_isosceles_l2:
        mov rdi, msg_is
        call printf
        jmp done

    check_isosceles_l3:
        mov rdi, msg_is
        call printf
        jmp done

    done:
        ; Restaurar o ponteiro base do frame e retornar
        pop rbp
        mov rax, 0
        ret
