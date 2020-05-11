segment .data
	SYS_EXIT equ 1
	SYS_READ equ 3
	SYS_WRITE equ 4
	STDIN	equ 0
	STDOUT	equ 1
	num1 dd 4
	num2 dd 4
	num3 dd 4
	resultado dd 0
	message db "La media es: %d", 10, 0
	msg_nesprimo db "Resultado %d no es primo", 10, 0
	msg_esprimo db "Resultado %d es primo", 10, 0
segment .bss
segment .text
	global main
	extern printf
main:
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	mov eax, [num1]
	mov ebx, [num2]
	add eax, ebx
	mov ebx, [num3]
	add eax, ebx
	mov ebx, 3
	idiv ebx
	mov [resultado], eax
	push eax
	push message
	call printf

	;Evaluar si es primo
	mov edx, 0
	mov eax, [resultado]
	mov ebx, eax
valida_primo:
	dec ebx
lazo:
	cmp ebx, 1
	jle es_primo
	div ebx
	or edx, edx
	jz nes_primo
	mov eax, [resultado]
	dec ebx
	jmp lazo
nes_primo:
	mov eax, [resultado]
	push eax
	push msg_nesprimo
	call printf
	jmp exit
es_primo:
	mov eax, [resultado]
	push eax
	push msg_esprimo
	call printf
exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80
