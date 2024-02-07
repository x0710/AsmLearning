assume cs:code,ds:data,ss:stack
data segment
	db '--/--/-- --:--:--'
	db 9,8,7,4,2,0
data ends
stack segment
	dw 8 dup (0)
stack ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,data
	mov ds,ax
	mov ax,0B800H
	mov es,ax
	
	mov bx,0
	mov cx,6
	mov si,0
	s:mov al,17[si]
		out 70h,al
		in al,71h
		mov ah,al
		push cx
		mov cl,4
		shr ah,cl
		pop cx
		and al,00001111b
		
		add al,30h
		add ah,30h
		
		mov [bx],ah
		inc bx
		mov [bx],al
		add bx,2
		inc si
		loop s
	
	mov bx,0
	mov cx,17
	l:push bx
		mov al,[bx]
		add bx,bx
		mov es:[0A0H*12+2*32][bx],al
		mov byte ptr es:[0A0H*12+32*2+1][bx],01111000b
		pop bx
		inc bx
		loop l
		
	mov ax,4c00h
	int 21h
code ends
end start