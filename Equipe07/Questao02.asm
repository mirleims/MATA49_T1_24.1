;Equipe 07
;Bruno Henrique dos Santos Luz Santos, Vitor Renato Santos dos Santos
;Escreva um programa em Assembly que leia um valor N e calcule o valor fatorial.

;COMO EXECUTAR
;nasm -f elf64 Questao02.asm
;gcc -o Questao02 Questao02.o -no-pie
;./Questao02

global main
extern scanf
extern printf

section .data
    DIGITE_N db "Digite um número N e descubra seu valor fatorial: ", 0
    LER_N db "%llu", 0
    ESCREVER_FATORIAL db "O valor fatorial do número digitado é: %llu", 10, 0

    ;utilizamos %llu pois ele suporta 20 dígitos, logo funciona até 20!, depois disso não exibe o resultado correto
    ;enquanto o %d suporta 10 dígitos

section .bss
  n resq 1

section .text

main:
  push rbp
  mov rbp, rsp

leitura:
  mov rdi, DIGITE_N
  mov rax, 0
  call printf

  mov rdi, LER_N
  mov rsi, n
  call scanf

  mov rax, 1
  mov rcx, [n]

calcula_fatorial: 
  cmp rcx, 1
  jbe exibe_fatorial

  mul rcx
  dec rcx
  jmp calcula_fatorial
  
exibe_fatorial:
  mov rdi, ESCREVER_FATORIAL
  mov rsi, rax
  mov rax, 1
  call printf

end:
  pop rbp
  mov rax, 0
  ret