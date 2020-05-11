;Generar archivo de sistemas: 		nasm -f bin boot_real.asm -o boot_real.bin 
;Bootear desde una MV en x86:		qemu-system-i386 -fda boot_real.bin
;Es posible bootear desde x86_64:	qemu-system-x86_64 -fda boot_real.bin
org 0x7c00
mov ah,0x0E

mov al,'H'
int 0x10
mov al,'o'
int 0x10
mov al, 'l'
int 0x10
mov al,'a'
int 0x10
mov al,'a'
int 0x10
jmp $

times 510-($-$$) db 0
dw 0xaa55
