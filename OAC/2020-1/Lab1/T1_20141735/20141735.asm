;Antony Palacios 20141735

segment	.data
    SYS_EXIT		equ 1
    SYS_READ		equ 3
    SYS_WRITE		equ 4
    STDIN			equ 0
    STDOUT  		equ 1
	;num			dw 1			;invalido
	;num			dw 10000		;invalido
	;num			dw 88			;capicua de 2 cifras
	;num			dw 86			;no capicua de 2 cifras
	;num			dw 232			;capicua de 3 cifras
	;num			dw 965			;no capicua de 3 cifras
	num			dw 2112				;capicua de 4 cifras
	;num			dw 8652			;no capicua de 4 cifras

	invalido	db "El numero es invalido",10,0
	escapi		db "El numero es capicua",10,0
	nocapi		db "El numero no es capicua",10,0

	cifra4	dw 0		;declaro espacios de memoria consecutivas
	cifra3	dw 0
	cifra2	dw 0
	cifra1  dw 0

segment	.bss

segment	.text
	global main
	extern printf

main:
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

;comparo si esta dentro del rango
	mov ax, [num]
	cmp ax, 9999
	jg inva
	cmp ax, 10
	jl inva

	mov edi,cifra4		;lo relaciono como si fuera un arreglo de numeros
						;asigno la direccion de memoria de cifra4 a edi

;separa las cifras del numero
separar:
    cmp cx, 4
    je fin_separar
    mov ebx, 10
    div bx
    mov [edi], dx
    add edi, 2		;avanzo 16 bits, ose, avanzo al siguiente espacio de memoria
    mov dx, 0		;limpio dx luego de cada div
    inc cx
    jmp separar

;ya que tengo los valores en cifra4..cifra1, los muevo a los registros de 16 bits

fin_separar:
	mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

	mov ax,[cifra1]
	mov bx,[cifra2]
	mov cx,[cifra3]
	mov dx,[cifra4]

	cmp ax,0
	jnz cuatro
	cmp bx,0
	jnz tres
	jmp dos

dos:
	cmp cx,dx
	je capi
	jmp noescapi

tres:
	cmp bx,dx
	je capi
	jmp noescapi

cuatro:
	cmp ax,dx
	jne noescapi
	cmp bx,cx
	jne noescapi
	jmp capi

noescapi:
	push nocapi
	call printf
	jmp exit

inva:
	push invalido
	call printf
	jmp exit

capi:
	push escapi
	call printf
	jmp exit

exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80