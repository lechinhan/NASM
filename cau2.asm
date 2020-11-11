section .text
   global _start
_start:
   mov edx, 9
   mov ecx, s2
   mov ebx, 1
   mov eax, 4
   int 0x80

   mov eax, 1
   int 0x80

section .data
   s2 times 9 db '#'
