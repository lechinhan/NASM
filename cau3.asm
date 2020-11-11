section	.text
	global _start
_start:
	mov	eax, 4
	mov ebx, 1
	mov ecx, stars
	mov edx, len
	int	0x80 
	
	mov	eax, 1
	int	0x80

section	.data

stars db '*',0xa, '**',0xa,'***',0xa,'****',0xa,'*****',0xa,
len	equ	$ - stars