; exercicio1.asm — Compara dois valores com JE/JNE
section .text
global _start

_start:
  mov  rax, 10         ; primeiro valor
  mov  rbx, 20         ; segundo valor — TROQUE para 20 e observe o resultado!
  cmp  rax, rbx        ; subtrai internamente: rax - rbx, atualiza flags (The CF, OF, SF, ZF, AF, and PF flags are set according to the result.)
  je   sao_iguais       ; ZF=1? salta
; --- caso diferentes ---
  mov  rax, 1          ; syscall exit
  mov  rbx, 2          ; exit code 2 = diferentes
  int  0x80

sao_iguais:
  mov  rax, 1
  mov  rbx, 1          ; exit code 1 = iguais
  int  0x80