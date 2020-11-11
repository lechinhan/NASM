section .data

	in_msg db "Enter n: ", 0xa
	in_len equ $ - in_msg
	out_msg db "Factorial: "
	out_len equ $ - out_msg

section .bss
	n_str resb 4
	factorial_str resb 7
section .text
	global _start
	
print: 
	push ebx
	push eax
	mov eax, 4
	mov ebx, 1
	int 0x80
	pop eax
	pop ebx
	ret
scan:
	push ebx
	push eax
	mov eax, 3
	mov ebx, 0
	int 0x80
	pop eax
	pop ebx
	ret
	
xTen:
	push ebx
	mov ebx, eax
	shl eax, 2
	add eax, ebx
	shl eax, 1
	pop ebx
	ret
	
byTen:
	push edx
	push ecx
	mov edx, 0
	mov ecx, 10
	div ecx
	mov ebx, edx
	pop ecx
	pop edx
	ret
	
toInt:
	push ebx
	mov eax, 0
	mov ebx, 0
	.loopStr:
		call xTen
		push edx
		mov edx, 0
		mov dl, byte[ecx + ebx]
		sub dl, 0x30
		add eax, edx
		pop edx
		inc ebx
		cmp byte[ecx + ebx], 0xa
		jle .return
		cmp ebx, edx
		jge .return
		jmp .loopStr
	.return:
		pop ebx
		ret

toStr:
	push ebx
	push eax
	mov ebx, 0
	push 0
	.loopDiv:
		call byTen
		add ebx, 0x30
		push ebx
		cmp eax, 0
		jg .loopDiv
		mov ebx, 0
	.loopStr:
		pop eax
		cmp eax, 0
		je .loopFill
		cmp ebx, edx
		je .loopStr
		mov byte[ecx+ebx], al
		inc ebx
		jmp .loopStr
	.loopFill:
		cmp ebx, edx
		je .return
		mov byte[ecx + ebx], 0
		inc ebx
		jmp .loopFill
	.return:
		pop eax
		pop ebx
		ret
		
factorialN:
	mov eax, 1
	push ebx
	.loopN:
		mul ebx
		dec ebx
		jnz .loopN
		pop ebx
		ret
		
_start:
	mov ecx, in_msg
	mov edx, in_len
	call print
	
	mov ecx, n_str
	mov edx, 4
	call scan
	
	call toInt
	
	mov ebx, eax
	call factorialN
	
	mov ecx, out_msg
	mov edx, out_len
	call print
	
	mov ecx, factorial_str
	mov edx, 7
	call toStr
	
	call print
	mov eax, 1
	int 0x80
