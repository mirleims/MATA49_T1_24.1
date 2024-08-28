;Laura Ferreira, Leticia Lemos, Nalanda Pita
bits 64

section .data
    msg_n db "Digite a quantidade de valores: ",10, 0
    msg_valores db "Digite o valor: ",0
    msg_soma db "A soma dos dois maiores valores é: %u",10,0 
    fmt db "%d",0
    max1 dq -2147483648
    max2 dq -2147483648



section .bss
    n resd 1
    valores resd 100
    soma resd 1
    valor resd 1

section .text
	global main
	extern printf, scanf
	
	main:
	 push rbp
	 mov rbp, rsp

     ;imprime mensagem perguntando qual a qtd de valores(n)
     mov rdi, msg_n
     call printf

      
     ;leitura qtd valores
     mov rdi, fmt
     mov rsi, n
     call scanf
     mov  rax, [n]
     cmp rax, 1
     je print1
      
     ;leitura em loop de n valores
     xor rbx, rbx
     leitura:
        cmp     rbx, [n]
        jge     fim_leitura
        ;incrementa o contador
        inc rbx
        
        ;lê os valores
        mov     rdi, msg_valores
        call    printf
        mov     rdi, fmt
        mov     rsi, valor
        call    scanf

        ;verifica se o valor lido é maior que max1
        mov     r8, [valor]
        cmp     r8, [max1]
        jle verifica_max2
        
        ;atualiza max2 para ser o antigo max1 e max1 para o novo maior valor
        mov     r9,[max1]
        mov     [max2], r9
        mov     [max1], r8
        jmp     leitura

      verifica_max2:
        cmp     r8, [max2]
        jle     leitura
        mov     [max2], r8
        jmp     leitura

      fim_leitura:
          mov     rax, [max1]
          add     rax, [max2]
          mov     [soma],rax
          
      print:
          mov     rdi, msg_soma
          mov     rsi, [soma]
          call    printf

          mov     rax, 60
          xor     rdi, rdi
          syscall
          

      print1:
        mov     rdi, msg_valores
        call    printf
        mov     rdi, fmt
        mov     rsi, valor
        call    scanf
        mov     rdi, msg_soma
        mov     rsi, [valor]
        call    printf

            mov     rax, 60
            xor     rdi, rdi
            syscall
