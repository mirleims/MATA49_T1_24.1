bits 64

global main
extern printf, scanf 


section .bss
n    resb    1

section .data

msg_solicita_numero db "Digite um numero para calcular a sequencia de collatz",10,0
impri db "novo n: %d"
seq db 10,"Sequencia de collatz",10,0

fmt db "%d",0
fmtSaida db "%d->",0




section .text

  main:
  push rbp
  mov rbp, rsp

  mov rdi, msg_solicita_numero
  call printf

  mov rdi, fmt
  mov rsi, n
  call scanf

  ;imprimindo mensagem frequencia
  mov rdi, seq
  mov rax, 0
  call printf

  collatz:

  ;verifica se n eh 1
  mov eax, [n]
  cmp eax, 1
  je fim

  ;verifica se n eh 0
  mov eax, [n]
  cmp eax, 0
  je fim0

  ;printar atual 
  mov rdi, fmtSaida
  mov rsi, [n]
  mov rax, 0
  call printf

  mov eax, [n]

  ;verificar se eh par
  test eax, 1 
  jz casoPar

 ;jmp fim

  casoImpar:
  ; multiplica por 3 e soma 1
  mov rax, [n]
  imul rax, 3
  add rax, 1
  mov [n], rax
  
  jmp collatz

  casoPar:

  ; div por 2
  mov eax,[n]
  shr eax, 1 ; 
  mov [n], eax

  jmp collatz

  fim:

  mov rdi, fmt
  mov rsi, [n]
  mov rax, 0
  call printf

  fim0:
  pop rbp
  ret

; nasm -f elf64 -o questao5.o questao5.asm && gcc -o questao5 questao5.o -no-pie -lc
; ./questao5
