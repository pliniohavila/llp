set disassembly-flavor intel

layout asm
layout regs


Bit: 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
     ┌──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┬──┐
     │  │  │  │  │OF│DF│IF│TF│SF│ZF│  │AF│  │PF│  │CF│
     └──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┴──┘

## Instruções que afetam flags
    cmp rax, rbx        ; ZF=1 se igual, CF=1 se unsigned menor
    test rax, rax       ; ZF=1 se zero
    add rax, 5          ; OF, CF, ZF, SF mudam

## Instruções que usam flags
    jz  label           ; jump if ZF=1
    jnz label           ; jump if ZF=0
    jc  label           ; jump if CF=1 (carry)
    jnc label           ; jump if CF=0

## Manipular flags diretamente
    clc                 ; clear carry (CF=0)
    stc                 ; set carry (CF=1)
    cld                 ; clear direction (DF=0)
    std                 ; set direction (DF=1)

## Salvar/restaurar flags
    pushf               ; salva todas flags
    popf                ; restaura flags


# Disassembly
set disassembly-flavor intel    ; formato Intel
disassemble main                ; descompila main
x/10i $rip                      ; 10 instruções no RIP

# Registradores
info registers                  ; todos registradores
info registers rax rbx          ; específicos
print $rax                      ; valor de RAX
set $rax = 42                   ; modifica RAX

# Memória
x/s 0x401000                    ; string
x/10x $rsp                      ; 10 palavras hex no topo
x/4gx $rbp-16                   ; 4 giant words (8 bytes)
x/10i função                    ; descompila 10 instruções

# Pilha e frames
backtrace (bt)                  ; mostra stack frames
frame 1                         ; muda para frame 1
info frame                      ; info do frame atual

# Breakpoints
break *0x401865                 ; break em endereço
break main                      ; break em função
watch *0x401000                 ; watchpoint


Resumo dos bits úteis do EFLAGS:
Flag Bit Comando GDB
CF  0 p ($eflags >> 0) & 1
PF  2 p ($eflags >> 2) & 1
ZF  6 p ($eflags >> 6) & 1
SF  7 p ($eflags >> 7) & 1
OF  11 p ($eflags >> 11) & 1

## Alterar registrador:
 set $al = 0x42
## Alterar memória:
 set {char}0x402000 = 0x41

 Use x/s $rdi ao entrar em strlen — o que aparece?
 Coloque um breakpoint em .loop e use x/1xb $rdi+$rax a cada iteração — anote os bytes que aparecem

 Execute p ($eflags >> 6) & 1 antes e depois do je na iteração final

 Use x/9xb no endereço da string e identifique o \0 na saída