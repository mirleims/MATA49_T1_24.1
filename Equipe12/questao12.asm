# Alessandro Oliveira
# Daniel Alves
# Tainã Costa

section .data
    msg1x db "Digite a coordenada x1 do ponto A: ", 0
    msg1y db "Digite a coordenada y1 do ponto A: ", 0
    msg2x db "Digite a coordenada x2 do ponto B: ", 0
    msg2y db "Digite a coordenada y2 do ponto B: ", 0
    msg3x db "Digite a coordenada x3 do ponto C: ", 0
    msg3y db "Digite a coordenada y3 do ponto C: ", 0
    msg_resultado db "O triângulo é: ", 10, 0
    msg_equilatero db "Equilátero", 0
    msg_isosceles db "Isósceles", 0
    msg_escaleno db "Escaleno", 0
    format_entrada db "%lf", 0
    format_saida db "%s", 0

section .bss
    x1 resq 1
    y1 resq 1
    x2 resq 1
    y2 resq 1
    x3 resq 1
    y3 resq 1
    dist1 resq 1
    dist2 resq 1
    dist3 resq 1

section .text
    extern printf, scanf
    global _start

_start:
    ; Ler ponto A
    mov rdi, msg1x
    call printf
    mov rdi, format_entrada
    mov rsi, x1
    call scanf

    mov rdi, msg1y
    call printf
    mov rdi, format_entrada
    mov rsi, y1
    call scanf

    ; Ler ponto B
    mov rdi, msg2x
    call printf
    mov rdi, format_entrada
    mov rsi, x2
    call scanf

    mov rdi, msg2y
    call printf
    mov rdi, format_entrada
    mov rsi, y2
    call scanf

    ; Ler ponto C
    mov rdi, msg3x
    call printf
    mov rdi, format_entrada
    mov rsi, x3
    call scanf

    mov rdi, msg3y
    call printf
    mov rdi, format_entrada
    mov rsi, y3
    call scanf

    call calcular_distancias

    ; "O triângulo é: "
    mov rdi, msg_resultado
    mov rsi, format_saida
    call printf

    call classificar_triangulo

fim:
    mov rax, 60         
    xor rdi, rdi  
    syscall

calcular_distancias:
    ; A para B
    movsd xmm0, qword [x2]
    subsd xmm0, qword [x1]
    mulsd xmm0, xmm0
    movsd xmm1, qword [y2]
    subsd xmm1, qword [y1]
    mulsd xmm1, xmm1
    addsd xmm0, xmm1
    movsd qword [dist1], xmm0

    ; B para C
    movsd xmm0, qword [x3]
    subsd xmm0, qword [x2]
    mulsd xmm0, xmm0
    movsd xmm1, qword [y3]
    subsd xmm1, qword [y2]
    mulsd xmm1, xmm1
    addsd xmm0, xmm1
    movsd qword [dist2], xmm0

    ;C para A
    movsd xmm0, qword [x1]
    subsd xmm0, qword [x3]
    mulsd xmm0, xmm0
    movsd xmm1, qword [y1]
    subsd xmm1, qword [y3]
    mulsd xmm1, xmm1
    addsd xmm0, xmm1
    movsd qword [dist3], xmm0

    ret

classificar_triangulo:
    movsd xmm0, qword [dist1]
    movsd xmm1, qword [dist2]
    ucomisd xmm0, xmm1
    jne verificar_isosceles
    movsd xmm1, qword [dist3]
    ucomisd xmm0, xmm1
    jne verificar_isosceles

    ; Triângulo equilátero
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_equilatero
    mov rdx, 11
    syscall
    ret

verificar_isosceles:
    movsd xmm0, qword [dist1]
    movsd xmm1, qword [dist2]
    ucomisd xmm0, xmm1
    je isosceles
    movsd xmm1, qword [dist3]
    ucomisd xmm0, xmm1
    je isosceles
    movsd xmm0, qword [dist2]
    ucomisd xmm0, xmm1
    je isosceles

    ; Triângulo escaleno
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_escaleno
    mov rdx, 8
    syscall
    ret

isosceles:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_isosceles
    mov rdx, 10
    syscall
    ret
