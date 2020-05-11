global ContarVotosAsm
section .text

ContarVotosAsm:
	xorpd xmm0,xmm0	;para el valor del vector v[i]
	xorpd xmm1,xmm1	;para el valor del vector con la cuenta
	xorpd xmm2,xmm2	;para aumentar los contadores

	mov rcx,1			
	cvtsi2ss xmm2,rcx	;transformo 1 a float para poder operar luego

	mov r8,0
	cmp rdx,0
	je done

contar:
	movss xmm0,[rsi]
	cvtss2si r8,xmm0	;el valor en r8 int
	cmp r8,0
	je valor0
	cmp r8,1
	je valor1
	cmp r8,2
	je valor2
	cmp r8,3
	je valor3
	jmp valor4

back:			;luego de comprobar el primer numero, avanzo a la siguiente posicion
	add rsi,4	;y reduzco el contador 
	sub rdi,1
	jnz contar
	jmp done

valor0:					;si vale 0, imprimo en la primera posicion del arreglo que cuenta
	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
	jmp back
valor1:					;si vale 1 o mas, me muevo a la posicion (4*v[i]) del arreglo que cuenta
	add rdx,4			;obtengo el valor, le sumo 1 y reescribo. Luego regreso a la posicion incial del arreglo
	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
	sub rdx,4
	jmp back
valor2:
	add rdx,8
	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
	sub rdx,8
	jmp back
valor3:
	add rdx,12
	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
	sub rdx,12
	jmp back
valor4:
	add rdx,16
	movss xmm1,[rdx]
	addss xmm1,xmm2
	movss [rdx],xmm1
	sub rdx,16
	jmp back

done:
	ret