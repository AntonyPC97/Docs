segment .data
	SYS_EXIT equ 1
	SYS_READ equ 3
	SYS_WRITE equ 4
	STDIN	equ 0
	STDOUT	equ 1

	n dd 2
	result dd 0
	message db "El factorial es: %d", 10, 0

segment .bss
segment .text
	global main
	extern printf
main:
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
	;add eax, 48
	mov [result], eax

	push eax
	push message
	call printf

exit:
	mov esp, ebp
	pop ebp
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
