assume cs:code
code segment
mov ax,0ffffh
mov ds,ax
mov cx,0ch
mov ax,0
mov es,ax
mov bx,0
s:mov ax,ds:[bx]
mov es:[bx+200h],ax
inc bx
inc bx
loop s

mov ax,4c00h
int 21h
code ends
end