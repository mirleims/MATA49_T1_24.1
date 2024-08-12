; Guilherme Barbosa e Rafael Lins Queiroz dos Santos
; CHECAR SE É PRIMO
bits 64

section .text
    global  main
    extern printf,scanf
    main:     
        push rbp
        
        ; receber o numero
        mov rdi, fmt_d
        mov rsi, inp
        call scanf

        mov rax,[inp]
        
        ; se for 0 ou 1 não é primo
        cmp rax,1
        jle nao

        ; rbx é o divisor a ser testado
        mov rbx,1
        loop:
        
            inc rbx
            mov rax,[inp]
            xor rdx,rdx
            ; checar se ja foram testados todos
            cmp rbx,rax
            jge sim
            xor rdx,rdx
            div rbx
            cmp rdx,0
            jne loop
        nao:
            mov rdi,fmt_str
            mov rsi,output_nao
            call printf
            jmp fim
        sim:
            mov rdi,fmt_str
            mov rsi,output_sim
            call printf
        fim:
        pop rbp
        ret
        
section   .data
    fmt_d:    db    "%d", 0
    fmt_str:    db    "%s", 0
    output_sim: db "Numero primo", 0
    output_nao: db "Numero nao primo", 0
    
section .bss
    inp:   resb    4
    