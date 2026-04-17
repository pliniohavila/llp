
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

  ; Bytes Diferentes
  mov   rdi, df   ; endereço da da string 'different'
  mov   rax, 0

  ; Bytes Iguais
  mov   rcx, eq   ; endereço da da string 'equal'
  mov   rdx, 1

  ; O operador ele define o valor de rdi de acordo com o a flag ZF
  ; Se a flag ZF = 1, então rdi recebe o valor de rcx, caso contrário mantém o seu valor 
  cmove rdi, rcx    ; escolhe string - se ZF=1, rax = 1  if (ZF == 1) destino = fonte
  cmove rax, rdx    ; escolhe retorno

  push  rax         ; salva o valor do retorno, pois a chamda de strlen vai alterar o valor em rax
  mov   rsi, rdi    ; salva em rsi o endereço da string
  call  strlen      ; retorna  o tamanho da string em rax
  mov   rdx, rax    ; salva em rdx o tamanho da string
  call  .print      ; imprimo a string
  
  pop   rax
  pop   rbx       ; ← restaura antes de ret
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
  add   rax, 1    ; incrementa o valor em rax
  jmp  .loop      ; continua o loop

.end:
  ret             ; retorna a execução para quem chamou

print_newline:
  mov rax, 1
  mov rdi, 1
  mov rsi, newline
  mov rdx, 1
  syscall ; rax = 1 write
          ; rdi = 1 - stdout
          ; rsi = char address
          ; rdx = byte count
  
  ret