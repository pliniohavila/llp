MAKEFLAGS += -r # remove regras implícitas do make
AS			= nasm
LINKER 	= ld
AFLAGS 	= -f elf64
LDFLAGS = -o $@

.SECONDARY: %.elf

# Regra de padrão: qualquer alvo sem extensão vem de um .asm de mesmo nome
# $@ = nome do alvo (ex: hello)
# $< = primeira dependência (ex: hello.asm)
%.elf: %.o
	$(LINKER) $< $(LDFLAGS)

# Regra intermediária: .asm → .o
%.o: %.asm
	$(AS) $(AFLAGS) $< -o $@

clean:
	rm -f *.o *.elf