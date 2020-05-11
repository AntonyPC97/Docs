global asmTaylor
section .text:

asmTaylor:
    xor rax, rax
    xor rbx, rbx
    xor r8, r8
    xorpd xmm1, xmm1
    xorpd xmm2, xmm2
    xorpd xmm3, xmm3
    xorpd xmm4, xmm4

    mov r8 ,1

reinicia:
    mov rbx, 0

lazo:
    movss xmm2, [rcx]
    movss xmm1, [rdx]
    call potencia
    mulss xmm1, xmm0
    addss xmm1, xmm2
    movss [rcx], xmm1
    inc rbx
    cmp rbx, rsi
    jl lazo

    add rcx, 4
    add rdx, 4
    dec rdi
    jnz reinicia

done:
    ret
potencia:
    xor rax, rax
    xorpd xmm3, xmm3
    mov rax, rbx

    or rax, rax
    jnz sigue
    cvtsi2ss xmm1, r8
    jmp fin_potencia
sigue:
    cvtsi2ss xmm3,r8
while:
    or rax, rax
    jz fin_while
    mulss xmm3, xmm1
    dec rax
    jmp while
fin_while:
    movss xmm1, xmm3
fin_potencia:
    ret
