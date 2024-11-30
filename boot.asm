[BITS 16]
[ORG 0x7C00]

start:
    ; Set up the stack
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Print boot message
    mov si, boot_msg

print_char:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print_char

done:
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x1000  ; Address to load the kernel

    mov ah, 0x02    ; BIOS read sector function
    mov al, 3       ; Number of sectors to read (depends on kernel.bin size)
    mov ch, 0       ; Cylinder number
    mov cl, 2       ; Sector number (second sector)
    mov dh, 0       ; Head number
    mov dl, 0x80    ; Drive number (first hard disk)

    int 0x13

    jc load_error

    jmp 0x1000

load_error:
    ; Print error message
    mov si, error_msg
    call print_char

    ; Halt after printing error
    cli
    hlt

.done:
    ret

boot_msg db "Booting OS93...", 10, 13, 0
error_msg db "Error loading kernel from second sector!", 10, 13, 0

times 510-($-$$) db 0
dw 0xAA55
