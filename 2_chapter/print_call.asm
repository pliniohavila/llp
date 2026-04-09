section .data
  newline_char: db 10
  codes: db '0123456789abcdf'

section .text
global _start

print_newline:
  mov   rax, 1 ; syscal write
  mov   rdi, 1 ; stdout
  mov   rsi, newline_char 
  mov   rdx, 1 ; quantidade bytes a serem escritos
  syscall
  ret

print_hex:
  mov   rax, rdi
  mov   rdi, 1 ; set the writing location: stdout
  mov   rdx, 1 ; how many bytes will be written
  mov   rcx, 64 ; ate que ponto estamos deslocando em rax?

interate:
  push  rax ; save the initial value of rax
  sub   rcx, 4
  sar   rax, cl ; desloca para 60, 56, 52, ..., 4, 0

  and   rax, 0xf ; limpa todos os bits, exceto os quatro mais significativos
  lea   rsi, [codes + rax] 

  mov   rax, 1

  push  rcx
  syscall ; rax = 1 (31) - writing identifier 
          ; rdi = 1 - stadout
          ; rsi = char address
  
  pop   rcx
  pop   rax

  test  rcx, rcx
  jnz interate

  ret

_start:
  mov   rdi, 0x1122334455667788
  call  print_hex
  call  print_newline

  mov   rax, 60
  xor   rdi, rdi
  syscall