segment .data
	SYS_EXIT equ 1
	SYS_READ equ 3
	SYS_WRITE equ 4
	STDIN	equ 0
	STDOUT	equ 1

	n dd 3
	result dd 0
	
	message db "El factorial es: "
	len equ $-message
	
	newline db 10
	len2 equ $-newline

segment .bss
segment .text
	global _start
	
_start:
	push ebp
	mov ebp, esp	
	
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	mov ebx, 1
	mov ecx, [n]
	mov eax, ebx

bucle:
	inc ebx
	cmp ebx, ecx
	jg end
	imul ebx
	jmp bucle

end:
	add eax, 48
	mov [result], eax

	mov edx, len
	mov ecx, message	
	mov ebx, STDOUT
	mov eax, SYS_WRITE
	int 0x80

	mov edx, 4
	mov ecx, result
	mov ebx, STDOUT
	mov eax, SYS_WRITE	
	int 0x80

	mov edx, len2
	mov ecx, newline
	mov ebx, STDOUT
	mov eax, SYS_WRITE	
	int 0x80

exit:
	mov esp, ebp
	pop ebp

	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
