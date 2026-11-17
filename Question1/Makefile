# xv6 (x86) with counting semaphores.
# Layout: kernel/ (kernel sources), user/ (user programs + libs), mkfs/ (image builder).
# Build and run:  make qemu      (then type: synctest)

K = kernel
U = user

OBJS = \
	$K/bio.o\
	$K/console.o\
	$K/exec.o\
	$K/file.o\
	$K/fs.o\
	$K/ide.o\
	$K/ioapic.o\
	$K/kalloc.o\
	$K/kbd.o\
	$K/lapic.o\
	$K/log.o\
	$K/main.o\
	$K/mp.o\
	$K/picirq.o\
	$K/pipe.o\
	$K/proc.o\
	$K/sem.o\
	$K/sleeplock.o\
	$K/spinlock.o\
	$K/string.o\
	$K/swtch.o\
	$K/syscall.o\
	$K/sysfile.o\
	$K/sysproc.o\
	$K/trapasm.o\
	$K/trap.o\
	$K/uart.o\
	$K/vectors.o\
	$K/vm.o\

# Cross-compiling (e.g., on Mac OS X): i686-elf- or i386-jos-elf-
ifndef TOOLPREFIX
TOOLPREFIX := $(shell if i686-elf-objdump -i 2>&1 | grep '^elf32-i386$$' >/dev/null 2>&1; \
	then echo 'i686-elf-'; \
	elif i386-jos-elf-objdump -i 2>&1 | grep '^elf32-i386$$' >/dev/null 2>&1; \
	then echo 'i386-jos-elf-'; \
	elif objdump -i 2>&1 | grep 'elf32-i386' >/dev/null 2>&1; \
	then echo ''; \
	else echo "*** Error: no i386 ELF GCC/binutils found (set TOOLPREFIX)." 1>&2; exit 1; fi)
endif

ifndef QEMU
QEMU = $(shell if which qemu-system-i386 > /dev/null 2>&1; then echo qemu-system-i386; \
	elif which qemu > /dev/null 2>&1; then echo qemu; \
	else echo qemu-system-x86_64; fi)
endif

CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gas
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
CFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Wno-array-bounds -fno-omit-frame-pointer -I$K -I$U
CFLAGS += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
ASFLAGS = -m32 -gdwarf-2 -Wa,-divide -I$K -I$U
LDFLAGS += -m $(shell $(LD) -V | grep elf_i386 2>/dev/null | head -n 1)

ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]no-pie'),)
CFLAGS += -fno-pie -no-pie
endif
ifneq ($(shell $(CC) -dumpspecs 2>/dev/null | grep -e '[^f]nopie'),)
CFLAGS += -fno-pie -nopie
endif

xv6.img: $K/bootblock $K/kernel
	dd if=/dev/zero of=xv6.img count=10000
	dd if=$K/bootblock of=xv6.img conv=notrunc
	dd if=$K/kernel of=xv6.img seek=1 conv=notrunc

$K/bootblock: $K/bootasm.S $K/bootmain.c
	$(CC) $(CFLAGS) -fno-pic -O -nostdinc -c $K/bootmain.c -o $K/bootmain.o
	$(CC) $(CFLAGS) -fno-pic -nostdinc -c $K/bootasm.S -o $K/bootasm.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 -o $K/bootblock.o $K/bootasm.o $K/bootmain.o
	$(OBJDUMP) -S $K/bootblock.o > $K/bootblock.asm
	$(OBJCOPY) -S -O binary -j .text $K/bootblock.o $K/bootblock
	$K/sign.pl $K/bootblock

$K/entryother: $K/entryother.S
	$(CC) $(CFLAGS) -fno-pic -nostdinc -c $K/entryother.S -o $K/entryother.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0x7000 -o $K/bootblockother.o $K/entryother.o
	$(OBJCOPY) -S -O binary -j .text $K/bootblockother.o $K/entryother
	$(OBJDUMP) -S $K/bootblockother.o > $K/entryother.asm

$K/initcode: $K/initcode.S
	$(CC) $(CFLAGS) -nostdinc -c $K/initcode.S -o $K/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o $K/initcode.out $K/initcode.o
	$(OBJCOPY) -S -O binary $K/initcode.out $K/initcode
	$(OBJDUMP) -S $K/initcode.o > $K/initcode.asm

# initcode and entryother are linked in as binary blobs; run the ld from $K so
# the symbol names stay _binary_initcode_start etc.
$K/kernel: $(OBJS) $K/entry.o $K/entryother $K/initcode $K/kernel.ld
	cd $K && $(LD) $(LDFLAGS) -T kernel.ld -o kernel entry.o $(patsubst $K/%,%,$(OBJS)) -b binary initcode entryother
	$(OBJDUMP) -S $K/kernel > $K/kernel.asm
	$(OBJDUMP) -t $K/kernel | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $K/kernel.sym

$K/vectors.S: $K/vectors.pl
	$K/vectors.pl > $K/vectors.S

ULIB = $U/ulib.o $U/usys.o $U/printf.o $U/umalloc.o

$U/_%: $U/%.o $(ULIB)
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $@ $^
	$(OBJDUMP) -S $@ > $U/$*.asm
	$(OBJDUMP) -t $@ | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $U/$*.sym

# forktest links less library code so it stays small enough to fill the proc table.
$U/_forktest: $U/forktest.o $U/ulib.o $U/usys.o
	$(LD) $(LDFLAGS) -N -e main -Ttext 0 -o $U/_forktest $U/forktest.o $U/ulib.o $U/usys.o
	$(OBJDUMP) -S $U/_forktest > $U/forktest.asm

mkfs/mkfs: mkfs/mkfs.c $K/fs.h
	gcc -Werror -Wall -iquote $K -o mkfs/mkfs mkfs/mkfs.c

.PRECIOUS: %.o

UPROGS=\
	$U/_cat\
	$U/_echo\
	$U/_forktest\
	$U/_grep\
	$U/_init\
	$U/_kill\
	$U/_ln\
	$U/_ls\
	$U/_mkdir\
	$U/_rm\
	$U/_sh\
	$U/_stressfs\
	$U/_synctest\
	$U/_usertests\
	$U/_wc\
	$U/_zombie\

fs.img: mkfs/mkfs README $(UPROGS)
	mkfs/mkfs fs.img README $(UPROGS)

-include $K/*.d $U/*.d

clean:
	rm -f $K/*.o $K/*.d $K/*.asm $K/*.sym $K/vectors.S $K/bootblock $K/entryother \
	$K/initcode $K/initcode.out $K/kernel $U/*.o $U/*.d $U/*.asm $U/*.sym \
	$(UPROGS) xv6.img fs.img mkfs/mkfs

# try to generate a unique GDB port
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
ifndef CPUS
CPUS := 2
endif
QEMUOPTS = -drive file=fs.img,index=1,media=disk,format=raw -drive file=xv6.img,index=0,media=disk,format=raw -smp $(CPUS) -m 512 $(QEMUEXTRA)

qemu: fs.img xv6.img
	$(QEMU) -serial mon:stdio $(QEMUOPTS)

qemu-nox: fs.img xv6.img
	$(QEMU) -nographic $(QEMUOPTS)

qemu-gdb: fs.img xv6.img
	$(QEMU) -serial mon:stdio $(QEMUOPTS) -S -gdb tcp::$(GDBPORT)
