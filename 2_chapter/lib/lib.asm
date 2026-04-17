global  _start
section .data
  test_string: db "abcedf", 0
  newline: db 0xA
  char: db "A"

section .text
; rax, rdi, rcx, rdx;
; registradores que podem aceitar argumentos: rdi, rsi, rdx, rcs, r8 e r9
; rsp aponta para o último elemento da stack
_start:
    mov     rax, 1          ; rax = 1 write
    mov     rdi, 1          ; rdi = 1 stdout
    push    0x34
    push    0x32
    ; mov     al, [rsp+8]
    mov     rsi, [rsp+8]         ; rdi = char address
    mov     rdx, 1          ; rdx = byte count
    syscall
    
    ; mov     rdi, char
    ; call    print_char

    call    print_newline   ; chama print_newline
    call exit

exit:
    mov     rax, 60
    xor     rdi, rdi
    syscall

string_length:
    xor     rax, rax

.loop:
    cmp     byte[rdi + rax], 0
    je      .end
    inc     rax
    jmp     .loop

.end:
    ret

print_string: ; rdi = ponteiro para string
    call    string_length   ; obtem o tamanho da string
    mov     rdx, rax        ; salva o tamanho da string em rdx
    mov     rax, 1          ; valor da syscall write
    mov     rdi, 1          ; valor de stdout
    syscall
    ret

print_char: ; rdi = ponteiro para string
    call    string_length
    mov     rsi, rdi        ; ponterio para o char (byte)
    mov     rdx, rax
    mov     rax, 1
    mov     rdi, 1
    syscall
    ret

print_newline:
    mov     rax, 1          ; rax = 1 write
    mov     rdi, 1          ; rdi = 1 stdout
    mov     rsi, newline    ; rdi = char address
    mov     rdx, 1          ; rdx = byte count
    syscall
    ret

print_uint:
    xor rax, rax
    ret


print_int:
    xor rax, rax
    ret

string_equals:
    xor rax, rax
    ret


read_char:
    xor rax, rax
    ret 

read_word:
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    xor rax, rax
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    xor rax, rax
    ret 


string_copy:
    ret