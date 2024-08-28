;Equipe:
;223115209, Amanda Vilas Boas Oliveira
;223115841, Elis Oliveira Vasconcelos
;223115850, Lucas Jùlio de Souza

;10- Escreva um programa em Assembly que converta
;expressões matemáticas da notação infixa (ex: "a + b")
;para a notação pós-fixa (ex: "a b +").

;nasm -f elf64 questao10.asm -o questao10.o && gcc -o questao10 questao10.o -lm -no-pie && ./questao10

bits 64

section .note.GNU-stack

section .data
  entrada_msg db "Digite uma expressao matematica em notacao infixa: ", 10, 0
  saida_msg db "A expressao matematica convertida em notacao pos-fixa: ", 10, 0
  posfixa db 4096 dup(0)    
  pilha db 4096 dup(0)             
  fmt db "%s", 0                   

section .bss
  expr resb 4096         
  pilha_pnt resq 1         

section .text
  global main
  extern printf, scanf

main:
  push rbp                      
  mov rbp, rsp

  mov rdi, entrada_msg               
  call printf                      

  mov rdi, fmt                       
  mov rsi, expr                      
  call scanf                       

  mov rdi, saida_msg               
  call printf   

  xor rax, rax       
  xor rcx, rcx         
  xor rdx, rdx  
  
  mov rdi, expr
  mov rsi, posfixa
  mov qword [pilha_pnt], pilha

exp_posfixa:
  cmp byte [rdi + rcx], 0 
  je esvaziar_pilha

  cmp byte [rdi + rcx], '('
  je parentese_abrindo

  cmp byte [rdi + rcx], ')'
  je parentese_fechando

  cmp byte [rdi + rcx], '+'
  je operadores
  cmp byte [rdi + rcx], '-'
  je operadores
  cmp byte [rdi + rcx], '*'
  je operadores
  cmp byte [rdi + rcx], '/'
  je operadores

  mov al, [rdi + rcx]
  mov [rsi + rdx], al
  inc rdx

proxima_letra:
  inc rcx
  jmp exp_posfixa

parentese_abrindo:
  mov al, [rdi + rcx]
  mov rbx, [pilha_pnt]
  mov [rbx], al
  inc rbx
  mov [pilha_pnt], rbx
  jmp proxima_letra

parentese_fechando:
  mov rbx, [pilha_pnt]
loop:
  dec rbx
  mov al, [rbx]
  cmp al, '('
  je acabou
  cmp rbx, pilha
  je acabou
  mov [rsi + rdx], al
  inc rdx
  jmp loop  

acabou:
  mov [pilha_pnt], rbx
  jmp proxima_letra

operadores:
  mov rbx, [pilha_pnt]
  cmp rbx, pilha
  je adicione

  
loop2:
  dec rbx
  mov al, [rbx]

  cmp al, '*'
  je imediato
  cmp al, '/'
  je imediato

  cmp al, '+'
  je analise
  cmp al, '-'
  je analise

  jmp adicione

imediato:
  mov [rsi + rdx], al
  inc rdx 
  mov rbx, [pilha_pnt]
  dec rbx
  mov [pilha_pnt], rbx
  cmp rbx, pilha
  je adicione
  jmp loop2
  
adicione:
  mov al, [rdi + rcx]
  mov rbx, [pilha_pnt]
  mov [rbx], al
  inc rbx
  mov [pilha_pnt], rbx
  jmp proxima_letra

analise: 
  cmp byte [rdi + rcx], '+'
  je imediato
  cmp byte [rdi + rcx], '-'
  je imediato
  cmp byte [rdi + rcx], '('
  je imediato

  jmp adicione  
  

esvaziar_pilha:
  mov rbx, [pilha_pnt]
loop1:
  cmp rbx, pilha
  je final
  dec rbx
  mov al, [rbx]
  mov [rsi + rdx], al
  inc rdx
  jmp loop1  
  
final:
  mov rdi, posfixa
  call printf
 
  leave  
  ret

;EXEMPLOS_SAIDA:
;A+B*C+D // SAIDA: ABC*+D+
;(A+B)*(C+D) // SAIDA: AB+CD+*
;A*B+C*D // SAIDA: AB*CD*+
;A+B+C+D // SAIDA: AB+C+D+

;nasm -f elf64 questao10.asm -o questao10.o && gcc -o questao10 questao10.o -lm -no-pie && ./questao10