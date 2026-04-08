section .data
  newline db 10

section .text
global _start

_start:
  mov   rax, 0
  cmp   rax, 42
  jl    yes
  mov   rbx, 0
  jmp   ex

yes:
  mov   rbx, 1
  jmp   exit

ex: 
  jmp   exit


exit: ; newline
  mov rsi, newline
  mov rdx, 1
  mov rax, 1
  mov rdi, 1
  syscall
  
  ; exit
  mov rax, 60
  xor rdi, rdi
  syscall