section .data
    codes db '0123456789ABCDEF'
    newline db 10

section .text
global _start

_start:
    mov     rax, 0x1234; valor de teste

    ; NIBBLE ALTO
    mov     rbx, rax;
    shr     rbx, 4 ; desloca 4 bits (pega nibble alto)
    and     rbx, 0xf ;  O valor 0xf em binário é 0000 1111 — uma máscara com apenas os 4 bits mais baixos ligados.

    lea rsi, [codes + rbx]
    mov rdx, 1
    mov rdi, 1
    mov rax, 1
    syscall

    ; restaura o valor original
    ; pop rax

    ; NIBBLE BAIXO
    ; mov rbx, rax         ; (ops: rax foi alterado, então recarrega)
    ; mov rbx, 0x1234
    ; and rbx, 0xf         ; pega nibble baixo

    ; lea rsi, [codes + rbx]
    ; mov rdx, 1
    ; mov rdi, 1
    ; mov rax, 1
    ; syscall              ; print

    ; newline
    mov rsi, newline
    mov rdx, 1
    mov rax, 1
    mov rdi, 1
    syscall
    
    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
