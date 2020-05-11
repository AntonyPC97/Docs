global asmMayorNumero
section .text

asmMayorNumero:
	xor rcx,rcx
	xor r8,r8

	cmp rdi,0
	je done

	mov rdx,0
bucle:
	mov r8,[rsi]
	cmp r8,rdx
	jl avanza
	mov rdx,r8
avanza:
	add rsi,4
	sub rdi,1
	jnz bucle

done:
	ret