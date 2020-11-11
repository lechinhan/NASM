section .bss
	n_str resb 4
section .text
	global _start

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

_start:
	mov edx, in_len
	mov ecx, in_msg
	mov ebx, 1
	mov eax, 4
	int 0x80
	
	mov ecx, n_str
	mov edx, 4
	call scan

	call toInt

	and eax, 1

	jz evnn

	mov eax, 4
	mov ebx, 1
	mov ecx, odd_msg
	mov edx, len2
	int 0x80
	jmp outprog

	evnn:
	mov ah, 09h
	mov eax, 4
	mov ebx, 1
	mov ecx, even_msg
	mov edx, len1
	int 0x80

	outprog:
	mov eax, 1
	int 0x80

section .data
	in_msg db "Enter n: ", 0xa
	in_len equ $ - in_msg
	even_msg db 'Even Number!'
	len1 equ $ - even_msg
	odd_msg db 'Odd Number!'
	len2 equ $ - odd_msg
