; Equipe 6
; Arthur Batista dos Santos Borges, João Paulo Cardoso da Paixão e Gabriel Baptista de Abreu
; Questão 6: Escreva um programa em Assembly que leia N
; nomes e ordene-os pelo tamanho. No final, o algoritmo
; deve mostrar todos os nomes ordenados.


section .data

    msg_numero_nomes db "Digite o número de nomes: ", 0
    tam_msg_numero_nomes equ $-msg_numero_nomes
    msg_input db "Digite um nome: ", 0
    tam_msg_input equ $-msg_input
    msg_sorted db "Nome com maior comprimento: ", 0
    tam_msg_sorted equ $-msg_sorted
    msg_sorted2 db "Nome com 2º maior comprimento: ", 0
    tam_msg_sorted2 equ $-msg_sorted2
    msg_sorted3 db "Nome com menor comprimento: ", 0
    tam_msg_sorted3 equ $-msg_sorted3
    novalinha db 10

section .bss

    numero_nomes resb 1
    nome1 resb 10
    nome2 resb 10
    nome3 resb 10
    nome1len resb 1
    nome2len resb 1
    nome3len resb 1
    maior_len resb 1
    meio_len resb 1
    menor_len resb 1

section .text
global _start

%macro inout 4
    mov rax, %1                      
    mov rdi, %2                     
    mov rsi, %3                      ; Endereço da string 
    mov rdx, %4                      ; Tamanho da string 
    syscall                          
%endmacro

%macro qualMaior3 3

    cmp %1, %2
    jg %%maior1
    jl %%menor1

    %%maior1:

        cmp %1, %3
        jl %%maior3
        jmp %%maior_final

    %%menor1:

        cmp %2, %3
        jl %%maior3
        jmp %%maior2

    %%maior_final:
    
        ; %1 é o maior
        qualMaior2 %2, %3
        mov rcx, rbx
        mov rbx, rax
        mov rax, %1
        jmp %%done

    %%maior2:
        ; %2 é o maior
        qualMaior2 %1, %3
        mov rcx, rbx
        mov rbx, rax
        mov rax, %2
        jmp %%done
        
    %%maior3:
        ; %3 é o maior
        qualMaior2 %1, %2
        mov rcx, rbx
        mov rbx, rax
        mov rax, %3

    %%done:
%endmacro

%macro qualMaior2 2

    cmp %1, %2
    jg %%maior1
    jl %%maior2

    %%maior1:
        ; %1 é maior
        mov rax, %1
        mov rbx, %2
        jmp %%done

    %%maior2:
        ; %2 é maior
        mov rax, %2
        mov rbx, %1

    %%done:
%endmacro

strlen:
    mov rax, 0
.scan:
    cmp byte [rdi+rax], 0
    je .done
    inc rax
    jmp .scan
.done:
    ret

%macro qualImprimir3 5-7

    ; contém o comprimento que vai ser impresso
    movzx r9, byte [%1]
    ; Determina qual nome mostrar
    movzx r8, byte [%3]
    cmp r8, r9
    je %%print_nome1

    movzx r8, byte [%5]
    cmp r8, r9
    je %%print_nome2

    %if %0 > 6
        movzx r8, byte [%7]
        cmp r8, r9
        je %%print_nome3
    %endif

    %%print_nome1:

        inout 1, 1, %2, 10
        jmp %%fim

    %%print_nome2:

        inout 1, 1, %4, 10
        jmp %%fim
        
    %if %0 > 6
    
        %%print_nome3:
            inout 1, 1, %6, 10
            
    %endif
    
    %%fim:
%endmacro

_start:

    ; Ler N (o número de nomes a ser lidos)
    inout 1, 1, msg_numero_nomes, tam_msg_numero_nomes
    inout 0, 0, numero_nomes, 4
    movzx r9, byte [numero_nomes]
    sub r9, '0'

        
    ; Lendo nome 1 e armazenando seu tamanho
    inout 1, 1, msg_input, tam_msg_input 
    inout 0, 0, nome1, 10
    mov rdi, nome1
    call strlen
    mov [nome1len], rax
    cmp r9, 1
    je .print_nome1
    

    ; Lendo nome 2 e armazenando seu tamanho
    inout 1, 1, msg_input, tam_msg_input 
    inout 0, 0, nome2, 10
    mov rdi, nome2
    call strlen
    mov [nome2len], rax
    cmp r9, 2
    je .compara2

    ; Lendo nome 3 e armazenando seu tamanho
    inout 1, 1, msg_input, tam_msg_input 
    inout 0, 0, nome3, 10
    mov rdi, nome3
    call strlen
    mov [nome3len], rax
    cmp r9, 3
    je .compara3

    ; Comparando os tamanhos e determinando o nome correspondente
    .compara2:
    
        movzx r8, byte [nome1len]
        movzx r9, byte [nome2len]
        lea r11, [nome1]
        lea r12, [nome2]
        qualMaior2 r8, r9
        mov [maior_len], rax
        mov [menor_len], rbx
        jmp .print_nomes2
    
    .compara3:
        movzx r8, byte [nome1len]
        movzx r9, byte [nome2len]
        movzx r10, byte [nome3len]
        lea r11, [nome1]
        lea r12, [nome2]
        lea r13, [nome3]
        qualMaior3 r8, r9, r10
        mov [maior_len], rax
        mov [meio_len], rbx
        mov [menor_len], rcx

    .print_nomes3:

        inout 1, 1, msg_sorted, tam_msg_sorted
        qualImprimir3 maior_len, nome1, nome1len, nome2, nome2len, nome3, nome3len
        inout 1, 1, msg_sorted2, tam_msg_sorted2
        qualImprimir3 meio_len, nome1, nome1len, nome2, nome2len, nome3, nome3len
        inout 1, 1, msg_sorted3, tam_msg_sorted3
        qualImprimir3 menor_len, nome1, nome1len, nome2, nome2len, nome3, nome3len
        jmp .fim

    .print_nomes2:

        inout 1, 1, msg_sorted, tam_msg_sorted
        qualImprimir3 maior_len, nome1, nome1len, nome2, nome2len
        inout 1, 1, msg_sorted3, tam_msg_sorted3
        qualImprimir3 menor_len, nome1, nome1len, nome2, nome2len
        jmp .fim

    .print_nome1:
        inout 1, 1, msg_sorted, tam_msg_sorted
        inout 1, 1, nome1, 10
.fim:
    mov rax, 60 
    xor rdi, rdi                  
    syscall
