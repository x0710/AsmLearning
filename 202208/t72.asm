assume cs:code,ds:data
data segment
	db 'welcome to masm!'
	db '................'
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov bx,0
	mov cx,16
s:	mov si,[bx]
	mov 16[bx],si
	add bx,1
	loop s
	
	mov ax,4c00h
	int 21h
code ends
end start