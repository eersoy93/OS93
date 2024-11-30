[BITS 16]

start:
    ; Set up the segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7E00

    ; Print the message
    mov si, switch_msg

print_char:
    lodsb
    or al, al
    jz switch_to_32_bit
    mov ah, 0x0E
    int 0x10
    jmp print_char

switch_to_32_bit:
    ; Switch to 32-bit protected mode
    cli                     ; Clear interrupts
    lgdt [gdt_descriptor]   ; Load the GDT
    mov eax, cr0
    or eax, 1
    mov cr0, eax            ; Set the PE bit in CR0 to enter protected mode
    jmp 0x08:protected_mode  ; Far jump to flush the prefetch queue

gdt_start:
    ; Null descriptor
    dq 0

    ; Code segment descriptor
    dw 0xFFFF               ; Limit (low 16 bits)
    dw 0x0000               ; Base (low 16 bits)
    db 0x00                 ; Base (next 8 bits)
    db 10011010b            ; Access byte
    db 11001111b            ; Flags and limit (high 4 bits)
    db 0x00                 ; Base (high 8 bits)
    
    ; Data segment descriptor
    dw 0xFFFF               ; Limit (low 16 bits)
    dw 0x0000               ; Base (low 16 bits)
    db 0x00                 ; Base (next 8 bits)
    db 10010010b            ; Access byte
    db 11001111b            ; Flags and limit (high 4 bits)
    db 0x00                 ; Base (high 8 bits)

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT
    dd gdt_start                ; Address of GDT

switch_msg db "Switching to 32-bit...", 10, 13, 0

[BITS 32]

protected_mode:
    ; Update segment registers for protected mode
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x9FC00            ; Set stack pointer

clear_screen:
    ; Clear the screen
    mov edi, 0xB8000            ; VGA text buffer start
    mov ecx, 80 * 25            ; Number of characters on the screen
    mov al, ' '                 ; Space character
    mov ah, 0x07                ; Attribute byte for white text on black background
    rep stosw                   ; Fill the screen with spaces

    or ecx, ecx
    jnz clear_screen

    ; Continue with 32-bit code
    ; Print "Hello, World!" to 0xB8000 (VGA text buffer)
    mov edi, 0xB8000
    mov esi, hello_msg

print_loop:
    lodsb
    or al, al
    jz _start
    mov [edi], al
    inc edi
    mov byte [edi], 0x07        ; Attribute byte for white text on black background
    inc edi
    jmp print_loop

global _start

_start:
    ; Call kmain() in kmain.c
    extern kmain
    call kmain

    ; Infinite loop to prevent returning
    jmp $

hello_msg db "Hello from protected mode!", 0
