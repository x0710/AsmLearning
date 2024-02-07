assume cs:code,ss:stack
stack segment
	dw 16 dup (0)
stack ends
code segment
start:
	mov ax,1858H
	mov dx,41H
	out dx,ax
	in ax,dx
code ends
end start