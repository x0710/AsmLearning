assume cs:code
code segment
mov cx,40h
sub bx,bx
mov ax,20h
mov ds,ax
s:mov [bx],bl
inc bl
loop s
mov ax,4c00h
int 21h
code ends
end