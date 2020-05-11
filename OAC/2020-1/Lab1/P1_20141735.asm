;Antony Palacios 20141735

segment	.data
    SYS_EXIT		equ 1
    SYS_READ		equ 3
    SYS_WRITE		equ 4
    STDIN			equ 0
    STDOUT  		equ 1
	num			dw 15			
	array	times 26 dw 0
	invalido	db "No valido",10,0
	fibmsg			db "El fib del numero es %d",10,0
	fib0	dw 0
	fib1	dw 1

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
	cmp ax, 23
	jg inva
	cmp ax, 0
	jl inva

	mov ax,[num]
	cmp ax,0	;si es 0 o 1, que imprima
	je base
	cmp ax,1
	je base

	mov ax,[fib0]
	mov edi,array
	mov word [edi],ax	;pongo 0 en array[0] = fib(0)

	add edi,2			;avanzo 16 bits
	mov ax,[fib1]
	mov word [edi],ax	;pongo 1 en array[1] = fib(0)

	mov edi,array	;regreso el puntero de edi al incio del arreglo y lo avanzo 2 posiciones ya que la posicion
	add edi,4		;lo avanzo 2 posiciones ya que la posicion 0 y 1 ya esta con valores
	mov cx,2 		
	mov dx,[num]
	add dx,1	

fib:
	sub edi,4
	mov ax,[edi]		;obtengo f(0) = 0 (array[0])
	add edi,2
	mov bx,[edi]		;obtengo f(1) = 1 (array[1])
	add edi,2
	add ax,bx
	mov [edi],ax		;como se movio a la siguiente posicion, solo copio el valor en el arreglo y avanzo 16 bits
	add edi,2
	inc cx
	cmp cx,dx			; se saldra del bucle cuando cx = num+1
	jne fib
	sub edi,2			;una vez fuera regreso 16 bits el puntero se encuentra delante del numero que se quiere
	mov eax,0
	mov ax,[edi]		;leo e imprimo
	push eax
	push fibmsg
	call printf
	jmp exit

inva:
	push invalido
	call printf
	jmp exit
	
base:
	push eax
	push fibmsg
	call printf

exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80

;Respuestas

;d) Ya que se esta trabajando con registros de 16 bits, el numero máximo que acepta es 2^16 que es 65536, por lo tanto el numero máximo que aceptaría el programa es 24 ya que su fibbonachi no sobrepasa 2^16.
;e) Creo que en lugar de definir los espacios de memoria con dw, se puede con dd lo cual aceptaria valores hasta 2^32. Asi se puede aprovechar el bit de acarreo para usar dos registros de 16 bits simulando un registro de 32