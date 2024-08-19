; Alunos: Arthur Batzakas, Clóvis Carmo e Rafael Melo
; Matrículas: 223115829, 223115825 e 223115826


section .data
  ; Preparando as mensagens que serão impressas
  mensagem0 db "Digite uma string:", 10, 0
  mensagem1 db "É Palíndromo", 10, 0
  mensagem2 db "Não é Palíndromo", 10, 0
  fmt db "%s", 0

section .bss
  palavra resb 100

section .text
  global  main
  extern scanf, printf

  ;macro para contar a quantidade de caracteres da string e colocar o valor no rax
  %macro tamstring 1
    mov rax, 0
    mov rcx, %1
    inicio:
    mov rdx, [rcx]
    cmp byte dl, 0
    je fim
    inc rax
    inc rcx
    jmp inicio
  fim:
  %endmacro




main:
  ; Ajeita a pilha para as chamadas de em funções C
  push rbp
  mov rbp, rsp

  ; Imprime a mensagem para digitar a String
  mov rdi, mensagem0
  call printf

  ; Recebe a String
  mov rdi, fmt
  mov rsi, palavra
  call scanf


  ; Move a String para rsi e chama o MACRO tamstring
  mov rsi, palavra
  tamstring rsi

  ; Move o endereço do primeiro caractere da palavra para o rcx e o do ultimo para o rdx
  lea rcx, palavra
  lea rdx, palavra
  add rdx, rax
  dec rdx

  loop:
  ; Nesse loop, começamos comparando os caracteres final e inicial da palavra 
  ; para verificar se são iguais
  ; Se não forem, sabemos que a palavra não é palíndromo
  ; fazemos isso para todos os caracteres de lados "opostos" da palavra
  mov r8, [rdx]
  cmp r8b, byte[rcx]
  jne naopalindromo
  dec rdx
  inc rcx
  cmp rcx, rdx
  jge palindromo
  jmp loop


  ; Caso for palíndromo, imprime a mensagem1 e termina o código
  palindromo:
  mov rdi, mensagem1
  call printf
  leave
  ret


  ; Caso não for palíndromo, imprime a mensagem2 e termina o código
  naopalindromo:
  mov rdi, mensagem2
  call printf
  leave
  ret