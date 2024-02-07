assume cs:code
stack segment
	dw 5 dup (0)
data segment
	db 'welcome to masm!'	;first line: B864:40
	db 00000010b,00100100b,01110001b
	dw 0B864H,0B86eH,0b878H
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,12
	
	mov bx,0
	mov cx,3
	
s:push cx
	
	push bx
	add bx,bx
	mov ax,19[bx]
	mov es,ax
	pop bx
	
	mov ah,16[bx]
	
	mov cx,16
	push bx
	mov bx,0
	s0:
		mov al,0[bx]
		push bx
		add bx,bx
		mov es:64[bx],ax
		pop bx
		inc bx
		loop s0
	pop bx
	inc bx
	
	pop cx
	loop s
	
	mov ax,4c00h
	int 21h
code ends
end start