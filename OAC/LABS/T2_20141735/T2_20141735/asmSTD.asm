global asmSTD
section .text

asmSTD:
	xorpd xmm0,xmm0		;para el elemento del vector
	xorpd xmm1,xmm1		;para la media
	xorpd xmm2,xmm2		;para la desviacion estandar
	xorpd xmm3,xmm3
	cmp rdx,0
	je done

	cvtsi2ss xmm3,rsi	;N en float
	mov rcx,rsi			;N en entero
	mov r8,rsi			;N en entero


media:
	movss xmm0, [rdi]
	addss xmm1,xmm0
	add rdi,4
	sub rsi,1
	jnz media

	;tengo la suma de los numeros en xmm1
	divss xmm1,xmm3

;regresa el puntero al inicio del vector para volverlo a recorrer
regresar:
	sub rdi,4
	sub rcx,1
	jnz regresar


varianza:
	xorpd xmm0,xmm0
	movss xmm0,[rdi]
	subss xmm0,xmm1
	mulss xmm0,xmm0
	addss xmm2,xmm0
	add rdi,4
	sub r8,1
	jnz varianza

	divss xmm2,xmm3

done:
	sqrtss xmm2,xmm2
	movss [rdx],xmm2
	ret
