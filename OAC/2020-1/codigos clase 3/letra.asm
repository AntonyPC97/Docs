org 0x7c00
mov AH,0x0E
mov AL,[letra1]
int 0x10
mov AL,[0x7c22]
int 0x10
mov AL,[letra2]
int 0x10
mov AL,[0x7c23]
int 0x10
mov AL,[letra3]
int 0x10
mov AL,[0x7c24]
int 0x10
jmp $

letra1: db 'A'
letra2: db 'B'
letra3: db 'C'

numero  db 0x12
numero2 dw 0x3456


times 510 - ($-$$) db 0
dw 0xaa55
