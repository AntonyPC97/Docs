segment .data
	SYS_EXIT equ 1
	SYS_READ equ 3
	SYS_WRITE equ 4
	STDIN equ 0
	STDOUT equ 1
	num1 dd 5
	num2 dd 5
	num3 dd 5
	message db "La media es: %d", 10, 0
	primo db "El numero %d es primo",10,0
	noprimo db "El numero %d no es primo",10,0
	resultado dd 0
segment .bss
segment .text
	global main
	extern printf
main:
;SIEMPRE LIMPIAR
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0
	;-------------------------------------
	mov eax, [num1]
	mov ebx, [num2]
	add eax, ebx
	mov ebx, [num3]
	add eax, ebx
	mov ebx, 3
	idiv ebx
	mov [resultado],eax
	push eax
	push message
	call printf

	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx

	mov eax,[resultado]
	mov ebx, eax	
	mov ecx, eax	
	
	cmp eax,2		;si el numero es 2, de frente es primo
	je fin

	funcionprimo:
		cmp ebx,2	;el limite inferior es 2 porque si baja a 1 y divide, no se activa la bandera zero y entra a no primo
		jbe fin
		dec ebx
		mov eax,ecx
		div ebx
		cmp edx,0
		jnz funcionprimo
		mov eax,[resultado]
		push eax
		push noprimo
		call printf
		jmp end

	fin:
	mov eax,[resultado]
	push eax
	push primo
	call printf

	end:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80