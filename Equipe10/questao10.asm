bits 64

;Equipe:
;223115209, Amanda Vilas Boas Oliveira
;223115841, Elis Oliveira Vasconcelos
;223115850, Lucas Jùlio de Souza

;nasm -f elf64 Q10.asm -o Q10.o && gcc -o Q10 Q10.o -lm -no-pie && ./Q10

;10- Escreva um programa em Assembly que converta
;expressões matemáticas da notação infixa (ex: "a + b")
;para a notação pós-fixa (ex: "a b +").

;A+B*C+D // SAIDA: A B C * + D +
;(A+B)*(C+D) // SAIDA: A B + C D + *
;A*B+C*D // SAIDA: A B * C D * +
;A+B+C+D // SAIDA: A B + C + D +

section .note.GNU-stack

section   .data
  entrada_msg db "Digite uma expressao matematica em notacao infixa: ", 10, 0
  saida_msg db "A expressao matematica convertida em notacao pos-fixa: ", 10, 0
  postfix_expr db 4096 dup(0)         
  stack db 4096 dup(0)       
  fmt db "%s", 0

section .bss
  expr resb 4096
  stack_ptr resq 1
  
  ;fmt db "%d",  10

section .text
  global  main
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
      mov rdi, expr                       ; Define o ponteiro de origem (expressão de entrada)
      mov rsi, postfix_expr               ; Define o ponteiro de destino (expressão pós-fixa)
      mov qword [stack_ptr], stack        ; Inicializa o ponteiro da pilha

      ; Processa a expressão de entrada
  read:
      cmp byte [rdi + rcx], 0             ; Verifica se chegou ao final da entrada (terminador nulo)
      je end_conversion
      
      cmp byte [rdi + rcx], '+'           ; Verifica se é o operador de adição
      je handle_operator
      cmp byte [rdi + rcx], '-'           ; Verifica se é o operador de subtração
      je handle_operator
      cmp byte [rdi + rcx], '*'           ; Verifica se é o operador de multiplicação
      je handle_operator
      cmp byte [rdi + rcx], '/'           ; Verifica se é o operador de divisão
      je handle_operator
      cmp byte [rdi + rcx], '('           ; Verifica se é o parêntese de abertura
      je handle_parenthesis
      cmp byte [rdi + rcx], ')'           ; Verifica se é o parêntese de fechamento
      je handle_closing_parenthesis

      ; Se for um operando (número/letra), adiciona diretamente à expressão pós-fixa
      mov al, [rdi + rcx]
      mov [rsi + rdx], al
      inc rdx
      jmp next_char

  handle_operator:
      ; Lida com a precedência dos operadores e operações na pilha
      mov al, [rdi + rcx]                 ; Operador atual
      mov rbx, [stack_ptr]                ; Ponteiro da pilha
      mov [rbx], al
      add rbx, 1
      mov [stack_ptr], rbx
      jmp next_char

  check_precedence:
      cmp rbx, stack                      ; Verifica se a pilha está vazia
      je push_operator                    ; Se vazia, empurra o operador atual
      dec rbx                             ; Move para o topo da pilha
      mov bl, [rbx]                       ; Obtém o topo da pilha

      ; Se o topo da pilha for '(', empurra o operador atual
      cmp bl, '('
      je push_operator

      ; Lida com a precedência
      ; '*' e '/' têm maior precedência do que '+' e '-'
      cmp al, '*'                         
      je higher_precedence
      cmp al, '/'                         
      je higher_precedence
      cmp bl, '*'                         
      je pop_operator
      cmp bl, '/'                         
      je pop_operator
      cmp al, '+'                         
      je lower_precedence
      cmp al, '-'                         
      je lower_precedence
      jmp push_operator

  higher_precedence:
      ; Remove operadores com precedência menor ou igual
      cmp bl, '+'                         
      je pop_operator
      cmp bl, '-'                         
      je pop_operator
      jmp push_operator

  lower_precedence:
      ; Remove operadores com precedência menor ou igual
      mov al, [rbx]
      mov [rsi + rdx], al
      inc rdx
      jmp check_precedence

  push_operator:
      ; Empurra o operador atual para a pilha
      mov rbx, [stack_ptr]
      mov [rbx], al
      add rbx, 1
      mov [stack_ptr], rbx
      jmp next_char

  pop_operator:
      ; Remove um operador da pilha
      mov al, [rbx]
      mov [rsi + rdx], al
      inc rdx
      dec rbx
      mov [stack_ptr], rbx
      jmp check_precedence

  handle_parenthesis:
      ; Empurra '(' para a pilha
      mov al, [rdi + rcx]
      mov rbx, [stack_ptr]
      mov [rbx], al
      add rbx, 1
      mov [stack_ptr], rbx
      jmp next_char

  handle_closing_parenthesis:
      ; Remove operadores até encontrar '('
      mov rbx, [stack_ptr]
  pop_loop:
      dec rbx
      mov al, [rbx]
      cmp al, '('
      je found_opening_parenthesis
      mov [rsi + rdx], al
      inc rdx
      jmp pop_loop
  found_opening_parenthesis:
      mov [stack_ptr], rbx
      jmp next_char

  next_char:
      inc rcx
      jmp read

  end_conversion:
      ; Remove os operadores restantes da pilha para a expressão pós-fixa
      mov rbx, [stack_ptr]                ; Carrega o ponteiro da pilha
  pop_remaining:
      cmp rbx, stack                      ; Verifica se a pilha está vazia
      je done                             ; Se abaixo do início, termina o loop
      dec rbx                             ; Move para o próximo elemento na pilha
      mov al, [rbx]                       ; Carrega o operador
      mov [rsi + rdx], al                 ; Armazena na expressão pós-fixa
      inc rdx                             ; Move para a próxima posição na expressão pós-fixa
      jmp pop_remaining                   ; Repete até a pilha estar vazia
  done:
      ; Finaliza a expressão pós-fixa com um terminador nulo
      mov byte [rsi + rdx], 0             ; Finaliza a string pós-fixa com nulo

      ; Imprime a expressão pós-fixa
      mov rax, 1                          ; Número da syscall para sys_write
      mov rdi, 1                          ; Descritor de arquivo (stdout)
      mov rdx, rdx                        ; Comprimento da string para imprimir
      syscall

      ; Sai do programa
      mov rax, 60                         ; Número da syscall para sys_exit
      xor rdi, rdi                        ; Código de saída 0
      syscall

      leave  
      ret