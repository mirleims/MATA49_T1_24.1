section .data
msg_0 db "Digite 3 lados:",10, 0
fmt_res4 dq "O triângulo formado é equilátero e, portanto, tambem é isósceles",10,0
fmt_res2 dq "O triângulo formado é isósceles ",10,0
fmt_res3 dq "O triângulo formado é escaleno",10,0
fmt_res1 dq "Os lados fornecidos não são capazes de gerar triângulo. Sempre um lado qualquer deve ser menor que a soma dos dois outros", 10,0

fmt dq "%lf",10,0
lado1 dq 0.0
lado2 dq 0.0
lado3 dq 0.0
const dq 0.0


section .bss
n resq 10


section .text
global main
extern printf,scanf

main:
push rbp
mov rbp, rsp

;Printar comando
 mov rdi, msg_0
 mov rax, 0
 call printf


;Scan lado1
 mov rdi, fmt
 mov rsi, lado1
 call scanf

;Scan lado2
 mov rdi, fmt
 mov rsi, lado2
 call scanf

 ;Scan lado3
 mov rdi, fmt
 mov rsi, lado3
 call scanf

;Move-se as variaveis para os respectivos registradores
 movsd xmm1, [lado1]
 movsd xmm2, [lado2]
 movsd xmm3, [lado3]
 
comparacao_base:
    ;somar lado 1 , lado 2 e verificar se é maior que 3
    
    movsd xmm0,[const]
    
    addsd xmm0,xmm1
    addsd xmm0,xmm2
    
    ucomisd xmm0,xmm3
    jbe erro
    
    
    ;somar lado 1, lado 3 e verificar se é maior que 2
    
    movsd xmm0,[const]

    addsd xmm0,xmm1
    addsd xmm0,xmm3
    
    ucomisd xmm0,xmm2
    jbe erro
    
    ;somar lado 2 , lado 3 e verificar se é maior que 1
    
    movsd xmm0,[const]

    addsd xmm0,xmm2
    addsd xmm0,xmm3
    
    ucomisd xmm0,xmm1
    jbe erro

    jmp triangulo_valido



triangulo_valido:
    ;zerando o registrador rbx
    xor rbx,rbx

;utilizamos rbx para determinar quantos lados iguais
    
    comparacao_1:
        ; Comparar lado1 , lado2
        ucomisd xmm1, xmm2
        jne comparacao_2
        inc rbx
    
    comparacao_2:
        ; Comparar lado1 , lado3
        ucomisd xmm1, xmm3
        jne comparacao_3
        inc rbx
    
    comparacao_3:
        ; Comparar lado2 , lado3
        ucomisd xmm2, xmm3
        jne result
        inc rbx


result:
 cmp rbx,0
 je print_escaleno
 cmp rbx,1
 je print_isoceles
 jmp print_equilatero


 
 ;Caso não seja um triangulo
erro:
    mov rdi, fmt_res1
    mov rax, 0
    call printf
    jmp end

   
print_equilatero:
    mov rdi, fmt_res4
    mov rax, 0
    call printf
    jmp end

print_isoceles:
    mov rdi, fmt_res2
    mov rax, 0
    call printf
    jmp end

print_escaleno:
    mov rdi, fmt_res3
    mov rax, 0
    call printf

end:
 leave 
 ret