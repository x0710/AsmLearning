assume cs:code,ds:data
data segment
	db 'Welcome to masm!'
	db 16 dup (0)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov di,16
	mov es,ax
	mov si,0
	mov cx,10h
	rep movsb
	
	mov ax,4c00h
	int 21h
code ends
end start