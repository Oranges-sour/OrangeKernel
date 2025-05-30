#########################
# Makefile for Orange'S #
#########################

# Entry point of Orange'S
# It must have the same value with 'KernelEntryPointPhyAddr' in load.inc!
ENTRYPOINT	= 0x30400

# Offset of entry point in kernel file
# It depends on ENTRYPOINT
ENTRYOFFSET	=   0x400

# Programs, flags, etc.
ASM		= nasm
DASM		= objdump
CC		= gcc
LD		= ld
ASMBFLAGS	= -I boot/include/
ASMKFLAGS	= -I include/ -f elf
CFLAGS		= -m32 -g -I include/ -c -fno-builtin -fno-stack-protector
LDFLAGS		= -m elf_i386 -Ttext $(ENTRYPOINT)
DASMFLAGS	= -d -M intel

# This Program
ORANGESBOOT	= boot/boot.bin boot/loader.bin
ORANGESKERNEL	= kernel.bin
OBJS		= kernel/kernel.o kernel/syscall.o kernel/console.o kernel/keyboard.o kernel/tty.o kernel/proc.o kernel/start.o kernel/main.o kernel/clock.o kernel/i8259.o kernel/global.o kernel/protect.o lib/kliba.o lib/stringa.o lib/stringc.o lib/klibc.o
DASMOUTPUT	= kernel.bin.asm

# All Phony Targets
.PHONY : everything final image clean realclean disasm all buildimg

# Default starting position
everything : $(ORANGESBOOT) $(ORANGESKERNEL)

all : realclean everything

final : all clean

image : final buildimg

clean :
	rm -f $(OBJS)

realclean :
	rm -f $(OBJS) $(ORANGESBOOT) $(ORANGESKERNEL) $(DASMOUTPUT)

disasm :
	$(DASM) $(DASMFLAGS) $(ORANGESKERNEL) > $(DASMOUTPUT)

# We assume that "a.img" exists in current folder
buildimg :
	dd if=boot/boot.bin of=a.img bs=512 count=1 conv=notrunc
	sudo mount -o loop a.img /mnt/floppy/
	sudo cp -fv boot/loader.bin /mnt/floppy/
	sudo cp -fv kernel.bin /mnt/floppy
	sudo umount /mnt/floppy

boot/boot.bin : boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

boot/loader.bin : boot/loader.asm boot/include/load.inc \
			boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

$(ORANGESKERNEL) : $(OBJS)
	$(LD) $(LDFLAGS) -o $(ORANGESKERNEL) $(OBJS)

kernel/kernel.o : kernel/kernel.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

kernel/syscall.o : kernel/syscall.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

kernel/start.o: kernel/start.c include/const.h \
 include/klibc.h include/type.h include/protect.h include/type.h \
 include/proto.h include/const.h include/string.h include/global.h \
 include/protect.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/keyboard.o: kernel/keyboard.c include/const.h \
 include/klibc.h include/type.h include/protect.h include/type.h \
 include/proto.h include/const.h include/string.h include/global.h \
 include/protect.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/tty.o: kernel/tty.c include/const.h \
 include/klibc.h include/type.h include/protect.h include/type.h \
 include/proto.h include/const.h include/string.h include/global.h \
 include/protect.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/console.o: kernel/console.c include/const.h \
 include/klibc.h include/type.h include/protect.h include/type.h \
 include/proto.h include/const.h include/string.h include/global.h \
 include/protect.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/i8259.o: kernel/i8259.c include/const.h \
 include/proto.h include/const.h include/type.h include/type.h include/protect.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/clock.o: kernel/clock.c /usr/include/stdc-predef.h include/global.h \
 include/const.h include/proc.h include/protect.h include/type.h \
 include/klibc.h include/proto.h include/string.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/global.o: kernel/global.c /usr/include/stdc-predef.h include/const.h \
 include/protect.h include/type.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/protect.o: kernel/protect.c /usr/include/stdc-predef.h include/protect.h \
 include/type.h include/global.h include/const.h include/protect.h \
 include/type.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/main.o: kernel/main.c /usr/include/stdc-predef.h include/const.h \
 include/klibc.h include/type.h include/proto.h include/const.h \
 include/string.h include/type.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/proc.o: kernel/proc.c /usr/include/stdc-predef.h include/global.h \
 include/const.h include/proc.h include/protect.h include/type.h \
 include/klibc.h include/proto.h include/string.h
	$(CC) $(CFLAGS) -o $@ $<

lib/klibc.o: lib/klibc.c /usr/include/stdc-predef.h include/klibc.h \
 include/type.h include/const.h include/type.h
	$(CC) $(CFLAGS) -o $@ $<

lib/stringc.o: lib/stringc.c /usr/include/stdc-predef.h include/string.h \
 include/const.h include/type.h
	$(CC) $(CFLAGS) -o $@ $<

lib/kliba.o : lib/kliba.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

lib/stringa.o : lib/stringa.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<
