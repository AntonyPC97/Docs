global asmOrdenar
section .text

asmOrdenar:
	xor rcx,rcx
	xor r8,r8
	xor r9,r9

	cmp rdi,0
	je done
	mov rcx,rdi
	mov r8,rdi
	mov r9,0	;r9 = aux

bucle:
	cmp rdi,0
	je done
	mov r9,0
	
lazo1:
	cmp [rsi],r9
	jl avanza1
	mov r9,[rsi]
avanza1:
	add rsi,4
	sub rcx,1
	jnz lazo1

	mov rcx,r8
regresa1:
	sub rsi,4
	sub rcx,1
	jnz regresa1

	mov rcx,r8
lazo2:
	cmp [rsi],r9
	jne avanza2
	mov dword [rsi],0
avanza2:
	add rsi,4
	sub rcx,1
	jnz lazo2

	mov rcx,r8
regresa2:
	sub rsi,4
	sub rcx,1
	jnz regresa2

ordenar:
	mov [rdx],r9
	mov rcx,r8

avanza_out:
	add rdx,4
	sub rdi,1
	jmp bucle
done:
	ret