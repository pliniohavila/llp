global _start
section .data
  str: db  "Reverse", 0

section .text

_start:
  mov   rdi, str  ; carrega o endereço da string str no registrador rdi
  call strlen     ; chama a função strlen

  mov   rdi, rax  ; para para rdi o valor retornado armazenado em rax
  
  mov   rax, 60   ; define o valor referente a syscal exit
  syscall         ; execerra a execução

strlen:
  xor   rax, rax
  
.loop:
  cmp   byte[rdi + rax], 0  ; compara com a operação 0 - [<<endereço da string>> + <<rax>>] se for igual, define o valor 1 para a flag ZF
  je    .end      ; se a flag ZF conter o valor 1, faz jump para .end
  add   rax, 1    ; incrimenta o valor de rax
  jmp  .loop      ; continua o loop

.end:
  ret             ; retorna a execução para quem chamou