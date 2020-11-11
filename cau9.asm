section .text
	global _start
_start:
	mov eax, 8
	mov ebx, file_name
	mov ecx, 0777
	int 0x80

	mov [fd_out], eax

	mov edx, len
	mov ecx, msg
	mov ebx, [fd_out]
	mov eax, 4
	int 0x80

	mov eax, 6
	mov ebx, [fd_out]
	int 0x80

	mov edx, len_a
	mov ecx, announce
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov eax, 1
	int 0x80

section .data
	announce db 'file da duoc ghi', 0xa
	len_a equ $ - announce
	msg db 'Hom nay toi hoc lap trinh assembly'
	len equ $ - msg
	file_name db 'demo.txt'
section .bss
	fd_out resb 1
