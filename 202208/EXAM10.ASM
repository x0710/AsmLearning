assume cs:code,ss:stack
stack segment
  dw 8 dup (0)
stack ends
data segment
  db 'Welcome to masm!',0
data ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
  mov dh,12
  mov dl,32
  mov cl,2
  mov ax,data
  mov ds,ax
  mov si,0
  call show_str

  mov ax,4c00h
  int 21h
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
		ret
  
code ends
end start
