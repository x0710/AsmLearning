assume cs:code
code segment
start:
	mov ax,0b814h
	mov ds,ax
	mov cl,4
	mov al,4
	out 70h,al
	in al,71h
	
	shr al,cl
	add al,30h
	
	mov bx,0
	mov [bx],al
	
	mov cl,4
	in al,71h
	shl al,cl
	shr al,cl
	
	add al,30h
	mov 2[bx],al
	
	mov ax,4c00h
	int 21h
code ends
end start