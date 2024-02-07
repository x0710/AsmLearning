assume cs:code
code segment
  dw 0abch,153h,509h,16h,003fh
  mov bx,0
  mov cx,5
      s:add bx,2
        add ax,[bx]
        loop s
        mov ax,4c00h
        int 21h
code ends
end
