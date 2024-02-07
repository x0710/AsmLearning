assume cs:code,ds:data,ss:stack
stack segment
	dw 0,0,0,0,0,0,0,0
stack ends
data segment
	db '1.display       '
	db '2.brows         '
	db '3.replace       '
	db '4.modify        '
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	
	mov bx,0
	mov cx,4
s0:	push cx
	mov cx,4
	mov si,0
	s1:	mov dl,2[bx][si]
		and dl,11011111b
		mov 2[bx][si],dl
		inc si
		loop s1
	add bx,16
	pop cx
	loop s0
	
	mov ax,4c00h
	int 21h
code ends
end start