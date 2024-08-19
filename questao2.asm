; Guilherme Barbosa e Rafael Lins Queiroz dos Santos
; CALCULAR FATORIAL

bits 64

section .text
    global  main
    extern printf,scanf
    main:     
        push rbp
        ; input
        mov rdi, fmt_d
        mov rsi, inp
        call scanf

        xor rdx,rdx
        mov rax,1
        mov rbx,[inp]
        ; se 0 ou 1 retornar 1
        cmp rbx,1
        jle fim
        mov rax,rbx
        dec rbx
        loop:
            mul rbx
            dec rbx
            cmp rbx,0
            jg loop
        fim:
            mov rdi, fmt_d
            mov rsi, rax
            call printf
            pop rbp
            ret

section   .data
    fmt_d:    db    "%d", 0

section .bss
    inp:   resb    4
