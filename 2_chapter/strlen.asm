global _start
section .data
  test_string: db "abcedf", 0

section .text

strlen:
  xor   rax, rax

.loop:
  cmp   byte[rdi+rax], 0 ; left - right result is set in ZF flag
  je    .end ; Jump to .end cmp result is equal, here is result is zero. (ZF=1)
  inc   rax

  jmp .loop

.end 
  ret

_start:
  mov   rdi, test_string
  call  strlen
  mov   rdi, rax

  mov   rax, 60
  syscall