; Alunos:
; Pedro Henrique Matias de Almeida Ramos
; David França Simões dos Santos

; Questão 1) Escreva um programa em Assembly que calcule a área do círculo, 
; permitindo ao usuário escolher se a entrada é o raio ou o diâmetro.
; Utilizar ponto flutuante.


section .data
    ; Mensagens para interação com o usuário
    msgEscolha db "Escolha a entrada: 1 para raio, 2 para diametro: ", 0  
    lerEsc db "%ld", 0                  
    msgEntrada db "Insira o valor: ", 0  
    lerEnt db "%lf", 0                  
    msgResultado db "A area do circulo e: %lf", 10, 0  
    pi dq 3.14                           
    dois dq 2.0                          

section .bss
    escolha resq 1                       
    entrada resq 1                       

section .text
    global main
    extern printf                        
    extern scanf                        

main:
    push rbp                            
    mov rbp, rsp                        

    ; Solicita ao usuário que escolha o tipo de entrada (raio ou diâmetro)
    mov rdi, msgEscolha                 
    call printf                         
    mov rdi, lerEsc                     
    lea rsi, [escolha]                  
    call scanf                          

    ; Verifica a escolha do usuário
    mov rax, [escolha]                  ; Carrega a escolha do usuário em rax
    cmp rax, 1                          ; Compara a escolha com 1 (raio)
    je ler_entrada1                      ; Se for 1, pula para solicitar o valor de entrada
    cmp rax, 2                          ; Compara a escolha com 2 (diâmetro)
    je ler_entrada2                      ; Se for 2, pula para solicitar o valor de entrada

    ; Se a escolha não for 1 ou 2, finalizar o programa
    jmp finalizar                       ; Pular para o final do programa

ler_entrada1:
    ; Solicita ao usuário que insira o valor
    mov rdi, msgEntrada                 
    call printf                         
    mov rdi, lerEnt                     
    lea rsi, [entrada]                  
    call scanf                          
    jmp calcular_area_com_raio       

ler_entrada2:
    ; Solicita ao usuário que insira o valor
    mov rdi, msgEntrada                     
    call printf                         
    mov rdi, lerEnt                     
    lea rsi, [entrada]                  
    call scanf          
    jmp calcular_area_com_diametro       

calcular_area_com_raio:
    ; Calcula a área do círculo usando o raio
    movsd xmm0, [entrada]              ; Carrega o valor da entrada em xmm0 (raio)
    mulsd xmm0, xmm0                   ; xmm0 = raio * raio
    movsd xmm1, [pi]                   ; Carrega o valor de pi em xmm1
    mulsd xmm0, xmm1                   ; xmm0 = raio * raio * pi
    jmp imprimir_resultado             ; Pular para imprimir o resultado

calcular_area_com_diametro:
    ; Converte diâmetro para o raio e calcula a área
    movsd xmm0, [entrada]              ; Carrega o valor da entrada em xmm0 (diâmetro)
    movsd xmm1, [dois]                 ; Carrega o valor 2.0 em xmm1
    divsd xmm0, xmm1                   ; xmm0 = diâmetro / 2 (raio)
    ; Calcula a área usando o raio
    mulsd xmm0, xmm0                   ; xmm0 = raio * raio
    movsd xmm1, [pi]                   ; Carrega o valor de pi em xmm1
    mulsd xmm0, xmm1                   ; xmm0 = raio * raio * pi

imprimir_resultado:
    mov rdi, msgResultado              
    mov rax, 1                         
    call printf                        

finalizar:
    ; Finaliza o programa
    pop rbp                            
    ret                                
