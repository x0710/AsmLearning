assume cs:code,ss:stack
stack segment
  dw 8 dup (0)
stack ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov ax,cs
	mov ds,ax
  mov ax,0
	mov es,ax
	mov si,offset do0
	mov di,200h
	mov cx,offset show_strend-offset do0
	cld
	rep movsb
	mov es:[0],word ptr 200h
	mov es:[2],word ptr 0
	
	mov ax,0ffffh
	mov bl,1
	div bl
  mov ax,4c00h
  int 21h
	
do0:
	jmp realDo
	string:db 'divide error!',0
realDo:	
	mov ax,cs
	mov ds,ax
	mov si,203h
  mov dh,12
  mov dl,32
  mov cl,00001100b
show_str:
	push bx
	push ax
	push si
  push dx
  push es
	mov ax,0
  mov al,0AH
  mul dh
  add ax,0B800H
  mov es,ax
  mov dh,0
  
	mov ax,0	;记录正在显示第几个字符
  s0:
		mov bx,dx
		add bx,ax
    push cx
		mov cx,0
		push bx
		mov bx,ax
    mov cl,[bx][si]
		pop bx
    jcxz ok
		add bx,bx
    mov es:0[bx],cl
    pop cx
    mov es:1[bx],cl
    inc ax
    jmp near ptr s0
  ok:
		pop cx	;jcxz 前有push cx
    pop es
    pop dx
		pop si
		pop ax
		pop bx
	mov ax,4c00h
	int 21h
show_strend:nop
code ends
end start
