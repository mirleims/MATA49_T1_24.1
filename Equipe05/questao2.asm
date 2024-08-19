; Equipe 05
; Guilherme Rocha Ribeiro, Jean Anderson Hugo Jesus Santos, Vilomar Gomes de Cerqueira Neto
section .data
    msg_solicitar_input db "Digite o valor de N para calcular n!: ", 0
    fmt_in db "%d", 0       
    fmt_outN db "%d!", 0
    fmt_out db "= %d", 10,  0
    msg_overflow db "O valor de n! maximo em um registrador de 32bits = 12!", 10, 0

section .bss
    num resd 1                 
    result resd 1              

section .text
    extern printf, scanf       
    global main                

main:
    push rbp
    mov rbp, rsp

    ; Printa msg_solicitar_input
    mov rdi, msg_solicitar_input
    call printf

    ; Recebe o input
    mov rdi, fmt_in
    mov rsi, num
    call scanf

    mov eax, [num]
    cmp eax, 12
    jg overflow
    
    mov dword [result], 1      ; Para usar N*1 na primeira interacao

    cmp eax, 1
    jle done                   ; Se num = 0, 0! = 1
    jg fatorial_loop

fatorial_loop:
    mov ecx, [result]          ; carrega 1 para ecx
    imul ecx, eax    
    
    mov [result], ecx          
    dec eax                    ; Decrementa eax
    
    cmp eax, 1                 ; Compara eax com 1
    jg fatorial_loop           ; eax > 1, continua o loop  

done:
    ; Print the result
    mov rdi, fmt_outN
    mov rsi, [num]
    call printf
    
    mov rdi, fmt_out
    mov rsi, [result]
    call printf
    jmp fim

overflow:
    mov rdi, msg_overflow
    call printf

fim:
    pop rbp
    ret

; nasm -f elf64 -o questao2.o questao2.asm && gcc -o questao2 questao2.o -no-pie -lc
; ./questao2
