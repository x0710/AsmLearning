assume cs:code,ss:stack,ds:data
    data segment
     db'Welcome to masm!'
         db 0CAH,0CAH,0CAH
    data ends
    
    stack segment
     db 0,0,0,0,0,0,0,0
    stack ends
         
        code segment
          start: mov ax,data
                 mov ds,ax
                          
                         mov ax,stack
                         mov ss,ax
                         mov sp,0010H          
                         
                         mov ax,0B800H
                         mov es,ax
                          
                         mov bx,0
                         mov di,0
                          
                         mov cx,3
                S0:  mov si,0
                 mov bp,0
                          push cx
                         mov cx,16
                         S: mov al,ds:[0000+bp]
                                    mov es:[0680H+si+bx],al
                                        mov al,ds:[0010H+di]
                                        mov es:[0681H+si+bx],al
                                        add si,2
                                        add bp,1
                                 Loop S
                         add bx,00A0h
                     add di,1
                         pop cx
                Loop S0        
                mov ax,4c00H
                int 21H
        code ends
end start