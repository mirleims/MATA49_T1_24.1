;Equipe:
;223115209, Amanda Vilas Boas Oliveira
;223115841, Elis Oliveira Vasconcelos
;223115850, Lucas Jùlio de Souza

bits 64

;nasm -f elf64 fatorial.asm -o fatorial.o && gcc -o fatorial fatorial.o -lm -no-pie && ./fatorial

section .note.GNU-stack

section .data
    entrada db "Digite um número N: ", 0     
    fmt db "%d", 0                       
    
    saida db "O fatorial de %d é: %llu", 10, 0     
    
    erro1 db "Número muito grande, insira um valor menor ou igual a 20!", 10, 0
    erro2 db "Número inválido, insira um valor positivo!", 10, 0

section .bss
    N resd 1                                 
    resultado resq 1                                

section .text
    global main
    extern printf, scanf

main:
    push rbp
    mov rbp, rsp

    mov rdi, entrada
    call printf

    mov rdi, fmt
    mov rsi, N                   
    call scanf

    mov eax, [N]

    cmp eax, 0
    jl to_erro2

    cmp eax, 20
    jg to_erro1                  

    mov rax, 1                          
    mov rcx, [N]                         

fatorial:
    cmp rcx, 1                    
    jle fim

    mul rcx                              
    dec rcx                            
    jmp fatorial                    

fim:
    mov [resultado], rax                

    mov rdi, saida
    mov rsi, [N]
    mov rdx, [resultado]                           
    call printf

    jmp end

to_erro1:
    mov rdi, erro1
    call printf
    jmp end

to_erro2:
    mov rdi, erro2
    call printf

end:
    leave
    mov rax, 0
    ret
    