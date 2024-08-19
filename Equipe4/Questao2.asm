; Equipe 04

;Felipe de Sant'Anna Paixão
;Laís Abib Gonzalez 
;Malu Pinto de Brito

section .bss
  N resq 1
  resposta resq 1

section .data
  PEDIR_INPUT db "Insira um valor para que seja calculado seu fatorial: ", 0
  RES_FATORIAL db "O fatorial do número inserido é %d",10, 0
  fmt db "%d", 0

section .text
  global main
  extern printf, scanf

fatorial:
    mov rbx, 1
    mov rax, 1 
    inc rsi
  .loop:
      cmp rax, rsi
      je .end
      imul rbx, rax
      inc rax
      
      jmp .loop
  .end:
      mov [resposta], rbx
      ret

main:
  push rbp
  mov rbp, rsp

  mov rdi, PEDIR_INPUT
  mov rax, 0
  call printf

  mov rdi, fmt
  mov rsi, N
  mov rax, 0
  call scanf

  mov rsi, [N]
  call fatorial 
  
  mov rdi, RES_FATORIAL
  mov rsi, [resposta]
  mov rax, 0
  call printf

  pop rbp
  mov rax, 0
  ret
