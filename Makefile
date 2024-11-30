HEADERS = $(wildcard *.h)
SOURCES = $(wildcard *.c)

CC = i686-linux-gnu-gcc
CFLAGS = -std=gnu17 -ffreestanding -Wall -Wextra -Werror -nostdinc -nostdlib -fno-exceptions -fno-pie

LD = i686-linux-gnu-ld
LDFLAGS = -T linker.ld -o kernel.bin --oformat binary --allow-multiple-definition

OBJECT_KERNEL = kernel.o
OBJECTS = $(SOURCES:.c=.o)

OUTPUT_BOOT = boot.bin
OUTPUT_KERNEL = kernel.bin
OUTPUT_OS93 = os93.bin

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

all: $(OBJECTS)
	nasm -f bin boot.asm -o boot.bin
	nasm -f elf kernel.asm -o $(OBJECT_KERNEL)
	$(LD) $(LDFLAGS) $(OBJECT_KERNEL) $(OBJECTS)
	dd if=/dev/zero of=$(OUTPUT_OS93) bs=512 count=2880
	cat $(OUTPUT_BOOT) $(OUTPUT_KERNEL) > $(OUTPUT_OS93)

run: all
	qemu-system-i386 -hda os93.bin -vga std

clean:
	rm -f *.bin *.o
