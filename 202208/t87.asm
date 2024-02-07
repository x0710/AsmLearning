assume cs:code
 
code segment
	mov ax,537
	mov dx,0
	div dl
	mov bx,0
	mov cx,bx
	mov bl,al
	mov cl,ah
	
	mov ax,4c00h
	int 21h
code ends
end