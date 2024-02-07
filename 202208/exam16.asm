assume cs:code,ss:stack
stack segment stack
	dw 16 dup (0)
stack ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,32
	
	call install
	
	mov ax,4c00h
	int 21h
dostart:
	push ax
	push bx
	push ds
	push cx
	
	mov bx,0B800H
	mov ds,bx
	
	mov cx,80*24
	mov bx,0
	
	cmp ah,0
	je cls
	cmp ah,1
	je set_foreground
	cmp ah,2
	je set_background
	cmp ah,3
	je rollline
	
	jmp ok
	
	rollline:
		push es
		push di
		push si
		
		mov di,bx
		mov ax,bx
		add ax,0a0H
		mov si,ax
		
		mov bx,ds
		mov es,bx
		
		rep movsw
		
		pop si
		pop di
		pop es
		jmp ok
		
	set_foreground:
		s3:mov ah,1[bx]
			and ah,11110000b
			or ah,al
			mov 1[bx],ah
			add bx,2
			loop s3
		jmp ok
	set_background:
		push cx
		mov cl,4
		shl al,cl
		pop cx
		s2:mov ah,1[bx]
			and ah,00001111b
			or ah,al
			mov 1[bx],ah
			add bx,2
			loop s2
		jmp ok
	cls:
		s1:mov byte ptr [bx],' '
			add bx,2
			loop s1
ok:
		pop cx
		pop ds
		pop bx
		pop ax
		iret
doend:nop
install:
	push cx
	push es
	push ds
	push di
	push si

	mov cx,0
	mov es,cx
	mov cx,cs
	mov ds,cx
	mov si,offset dostart
	mov di,200h
	cld
	mov cx,offset doend-offset dostart
	rep movsb
	
	mov cx,0
	mov ds,cx
	push bx
	mov bx,7cH*4
	mov word ptr [bx],200h
	add bx,2
	mov word ptr [bx],0h
	pop bx
	
	pop si
	pop di
	pop ds
	pop es
	pop cx
	ret
	
code ends
end start