section .text
	global _start
_start:
	mov ecx, 3
	mov eax, '1'
	
l:
	mov [num], eax
	mov eax, 4
	mov ebx, 1
	push ecx
	
	mov ecx, num
	mov edx, 1
	int 0x80
	mov eax, [num]
	sub eax, '0'
	inc eax
	add eax, '0'
	pop ecx
	loop l
	
	mov eax, 4
	mov ebx, 1
	mov ecx, new_line
	mov edx, 1
	int 0x80
	
	mov eax, 1
	int 0x80

section .data
new_line db 0xa

section .bss
num resb 1
