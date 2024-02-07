assume cs:code
code segment
mov ax,0ffffh
mov ds,ax
mov cx,0ch
sub dx,dx
sub bx,bx
sub ah,ah
s:mov al,[bx]
add dx,ax
inc bx
loop s

mov ax,4c00h
int 21h
code ends
end