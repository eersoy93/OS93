all: boot.asm kernel.asm kmain.c linker.ld
	nasm -f bin boot.asm -o boot.bin
	nasm -f elf kernel.asm -o kernel.o
	i686-linux-gnu-gcc -std=gnu17 -ffreestanding -Wall -Wextra -Werror -nostdinc -nostdlib -fno-exceptions -fno-pie -c ports.c -o ports.o
	i686-linux-gnu-gcc -std=gnu17 -ffreestanding -Wall -Wextra -Werror -nostdinc -nostdlib -fno-exceptions -fno-pie -c kmain.c -o kmain.o
	i686-linux-gnu-ld -T linker.ld -o kernel.bin --oformat binary kernel.o kmain.o ports.o
	cat boot.bin kernel.bin > os93.bin

run: all
	qemu-system-i386 -hda os93.bin -vga std

clean:
	rm -f *.bin *.o
