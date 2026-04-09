section .data
  newline_char: db 10
  codes: db '0123456789abcdf'

  demo1: dq 0x112234455667788
  demo2: db 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88

section .text
global _start

_start:
  mov   rdi, [demo1]
  call  print_hex
  call  print_newline

  mov   rdi, [demo2]
  call  print_hex
  call  print_newline

  mov   rax, 60
  xor   rdi, rdi
  syscall

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