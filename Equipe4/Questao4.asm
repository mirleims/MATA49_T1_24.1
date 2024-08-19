; Equipe 04

;Felipe de Sant'Anna Paixão
;Laís Abib Gonzalez 
;Malu Pinto de Brito

section .bss
    N resq 1
    elemento resq 1
    vt resq 25

section .data
    PEDIR_TAMANHO db "Insira a quantidade de elementos do vetor:", 0
    PEDIR_ELEMENTOS db "Insira os elementos do vetor:", 0
    VETOR db "O vetor inserido é: ", 0
    VETOR_INVERTIDO db "Ao inverter esse vetor, temos: ", 0
    PULAR_LINHA db " ", 10, 0
    fmt_s db "%d", 0
    fmt_p db "%d ", 0

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    mov rdi, PEDIR_TAMANHO
    mov rax, 0
    call printf

    mov rdi, fmt_s
    mov rsi, N
    mov rax, 0
    call scanf
    
    mov rdi, PEDIR_ELEMENTOS
    mov rax, 0
    call printf

    mov rbx, 0

leitura:
    mov rdi, fmt_s
    mov rsi, elemento
    call scanf

    mov rax, [elemento]
    mov [vt + rbx*8], rax

    inc rbx
    cmp rbx, [N]
    jl leitura 

    mov rdi, VETOR
    mov rax, 0
    call printf

    mov rbx, 0  

imprimir_vetor:
    mov rdi, fmt_p
    mov rsi, [vt + rbx*8]
    mov rax, 0
    call printf

    inc rbx
    cmp rbx, [N]
    jl imprimir_vetor  

    mov rbx, 0 
    mov rcx, [N]
    dec rcx            

inverter:
    cmp rbx, rcx      
    jge fim_inversao   

    mov rdx, [vt + rbx*8]
    mov rdi, [vt + rcx*8]
    mov [vt + rbx*8], rdi
    mov [vt + rcx*8], rdx

    inc rbx           
    dec rcx           
    jmp inverter      

fim_inversao:
    mov rdi, PULAR_LINHA
    mov rax, 0
    call printf

    mov rdi, VETOR_INVERTIDO
    mov rax, 0
    call printf

    mov rbx, 0  

imprimir_vetor_2:
    mov rdi, fmt_p
    mov rsi, [vt + rbx*8]
    mov rax, 0
    call printf

    inc rbx
    cmp rbx, [N]
    jl imprimir_vetor_2 
    
    pop rbp
    mov rax, 0
    ret

