segment .data
	SYS_EXIT equ 1
	STDIN	equ 0
	STDOUT	equ 1
	num1 dd 9
    num2 dd 75
    num3 dd 84
    aux dd 0
    msgInvalido db "Hay un dato invalido", 10, 0
    msgresp db "La mcm es: %d", 10, 0
segment .text
	global main
	extern printf
main:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    mov edi, [num1]
    cmp edi, 1290
    jg inva
    cmp edi, 1
    jl inva
    mov ebx, [num2]
    cmp ebx, 1290
    jg inva
    cmp ebx, 1
    jl inva
    mov ecx, [num3]
    cmp ecx, 1290
    jg inva
    cmp ecx, 1
    jl inva
    cmp edi, ebx	;primero se quiere sacar el mayor de los 3 numeros
    jg mayor
    jle menor1
next:    
    cmp esi, ecx
    jle menor2
incio:    
    mov [aux], esi
    mov eax, [aux]
bucle:                  ;una vez que se tiene el mayor, se va a dividir entre los otros numero para 
    mov edx, 0          ;ver si sale exacto, caso contrario, se incrementa
    div edi
    cmp edx, 0
    jne incrementar
    mov edx, 0
    mov eax, [aux]
    div ebx
    cmp edx, 0
    jne incrementar
    mov edx, 0
    mov eax, [aux]
    div ecx
    cmp edx, 0
    jne incrementar
    jmp fin
incrementar:    
    mov eax, [aux]
    inc eax
    mov [aux], eax
    jmp bucle
mayor:    
    mov esi, edi
    jmp next
menor1:    
    mov esi, ebx
    jmp next
menor2:    
    mov esi, ecx
    jmp incio
inva:    
	push msgInvalido
    call printf
fin:    mov eax, [aux]
    push eax
    push msgresp
	call printf
exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 0x80               ;si se quitan los cambio de linea al incio de la etiquetas, da menos de 80 lineas pero se veria desordenado