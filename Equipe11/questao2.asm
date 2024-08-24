%macro fatorial 1
;passo base 
mov rax,1
;armazenando variavel da função
mov rbx,%1
;compara para o caso especial
cmp rbx,0
je fim
;loop para os passos subsequentes
.while:
  mul rbx
  dec rbx
  jnz .while
fim:
 mov r10,rax
%endmacro


section .data
msg_0 db "Digite o número:",10,0
msg_error db "Número não aceitável, escolha um numero n < 21)",10,0
fmt dq "%d",10,0
fmt_res dq "O resultado é: %llu",10,0
numero db 0
limite db 21

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


;Scan numero
 mov rdi, fmt
 mov rax,0
 mov rsi, numero
 call scanf


 ;Identifica se há um numero não aceitavel
 cmp qword[numero],21
 jge print_error
 jmp print_fatorial

 ;error_message
 print_error:
  mov rdi, msg_error
  mov rax, 0
  call printf
  jmp end

 print_fatorial:
   ;chama a macro do fatorial
    mov rbx, [numero]
    fatorial rbx
   ;move o resultado do fatorial para ser impresso
    mov rax, r10
    mov rdi, fmt_res
    mov rsi, rax
    xor rax, rax  
    call printf


 end:
  leave 
  ret
