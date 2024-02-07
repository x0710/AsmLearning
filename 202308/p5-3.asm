assume cs:code

code segment
	mov ax,0ffffh
	mov ds,ax
	mov ah,0
	mov bx,6
	mov al,[bx]
	mov dx,0
	mov cx,3
	s:add dx,ax
	loop s
	
	mov ax,4c00h
	int 21h
code ends
end