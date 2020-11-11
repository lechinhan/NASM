section .text
	global _start
_start:
	
	;open the file for reading
	 mov eax, 5
	   mov ebx, file_name
	   mov ecx, 0             ;for read only access
	   mov edx, 0777          ;read, write and execute by all
	   int  0x80
		
	   mov  [fd_in], eax
	    
	   ;read from file
	   mov eax, 3
	   mov ebx, [fd_in]
	   mov ecx, info
	   mov edx, 26
	   int 0x80
	    
	   ; close the file
	   mov eax, 6
	   mov ebx, [fd_in]
	   int  0x80    
		
	   ; print the info 
	   mov eax, 4
	   mov ebx, 1
	   mov ecx, info
	   mov edx, 26
	   int 0x80
	       
	   mov	eax,1             ;system call number (sys_exit)
	   int	0x80              ;call kernel

section .data
	file_name db 'demo.txt'
section .bss
	fd_in  resb 1
	info resb  26

