global ContarVotosAsm
section .text

ContarVotosAsm:
	xorpd xmm0,xmm0	;para el valor del vector v[i]
	xorpd xmm1,xmm1	;para el valor del vector con la cuenta
	xorpd xmm2,xmm2	;para aumentar los contadores
	xorpd xmm3,xmm3 ;para el indice del vector que cuenta

	mov r9,1			
	cvtsi2ss xmm2,r9	;transformo 1 a float para poder operar luego

	mov r8,0
	cmp rcx,0
	je done

lazo1:
	mov r9,rdi
	cmp r8,rcx
	je done
	cvtsi2ss xmm3,r8
lazo2:
	movss xmm0,[rsi]
	cmpeqss xmm0,xmm3
	jne avanzar

	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
avanzar:
	add rsi,4
	sub r9,1
	jnz lazo2
	add r8,1
	mov r9,rdi
regresar:
	sub rsi,4
	sub r9,1
	jnz regresar
	add rdx,4
	jmp lazo1
done:
	ret