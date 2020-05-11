global asmSTD
section .text

asmSTD:
	xorpd xmm0,xmm0		;para el elemento del vector
	xorpd xmm1,xmm1		;para la media
	xorpd xmm2,xmm2		;para la desviacion estandar
	xorpd xmm3,xmm3
	cmp rdx,0
	je done

	movss xmm3,[rsi]
	
media:
	movss xmm0, [rdi]
	addss xmm1,xmm0
	add rdi,4
	sub rsi,1
	jnz media

	;tengo la suma de los nuemero en xmm1
	div xmm1,xmm3
	; la respuesta estara en xmm1
varianza:

	