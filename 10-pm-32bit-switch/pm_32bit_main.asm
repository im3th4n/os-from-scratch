[org 0x7c00]

mov bp, 0x800 ; points to new stack (bp * 10H + 0x0 = 0x8000)
mov sp, bp

mov bx, MSG_REAL_MODE
call print ; prints after BIOS msg

call switch_to_pm ; start switching

%include "print_16bit.asm"
%include "pm_32bit_gdt.asm"
%include "pm_32bit_print.asm"
%include "pm_32bit_switch.asm"

[bits 32]
BEGIN_PM: ; after the switch we will get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Note that this will be written at the top left corner
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; bootsector
times 510 - ($ - $$) db 0
dw 0xaa55
