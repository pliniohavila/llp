
; Questões:
; Coloque breakpoint em compare, use p $rbx antes e depois da função — o valor foi preservado?
; Houve alterações, antes era 0x0 e depois ficou com 0x65
; Use set *(char*)&byte2 = 'B' e confirme com x/1xb &byte2 que mudou
; Mudou
;  Execute p ($eflags >> 6) & 1 após o cmp nos dois casos
;  Antes: 0
;  Depois: 1

global _start
section .data
  byte1: db "A"
  byte2: db "A"
  eq: db  "equal", 0
  df: db  "different", 0
  newline: db 10

section .text

_start:
  mov   rdi, byte1
  mov   rsi, byte2
  call compare

  push  rax

  call  print_newline

  pop   rax

  mov   rdi, rax  ; para rdi o valor retornado armazenado em rax
  mov   rax, 60   ; define o valor referente a syscal exit
  syscall         ; encerra a execução

compare:
  push  rbx       ; ← salva rbx
  
  mov   al, byte [rdi]
  mov   bl, byte [rsi]
  cmp   al, bl
  
  pop   rbx       ; ← restaura antes de ret
  
  je    .equal
  jmp   .different

.equal:
  mov   rdi, eq
  call  strlen
  mov   rdx, rax
  mov   rsi, eq
  call  .print
  mov   rax, 1
  ret

.different:
  mov   rdi, df
  call  strlen
  mov   rdx, rax  ; rax = tamanho
  mov   rsi, df   ; rdx = tamanho
  call  .print    ; rsi = endereço (explícito, não depende de rdi)
  mov   rax, 0
  ret

.print:
  mov   rax, 1
  mov   rdi, 1
  syscall
  ret

strlen:
  xor   rax, rax
  
.loop:
  cmp   byte[rdi + rax], 0  ; compara com a operação 0 - [<<endereço da string>> + <<rax>>] se for igual, define o valor 1 para a flag ZF
  je    .end      ; se a flag ZF conter o valor 1, faz jump para .end
  add   rax, 1    ; incrimenta o valor de rax
  jmp  .loop      ; continua o loop

.end:
  ret             ; retorna a execução para quem chamou

print_newline:
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall ; rax = 1 write
          ; rdi = 1 - stadout
          ; rsi = char address
          ; byte count
  
  ret