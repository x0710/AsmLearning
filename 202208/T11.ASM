assume cs:code,ds:data,ss:stack
stack segment
  dw 8 dup (0)
stack ends
data segment
  db 'Hello, this',39,'s a sentense. Please change the words. ',0
data ends
code segment
start:
  mov ax,data
  mov ds,ax
  mov si,0
	mov ax,stack
	mov ss,ax
	mov sp,16
  call letterc
  mov ax,4c00h
  int 21h
letterc:
  push ax
  push si
  push es
  cld
	mov ax,ds
  mov es,ax
	mov cx,0

  s:mov al,[si]
		mov cl,al
    cmp al,'a'
    jb break
    cmp al,'z'
    ja break
    and al,11011111b
    mov [si],al

    next:jcxz over
				 inc si
				 jmp s
    break:mov [si],al
          jmp next
  over:
    pop es
    pop si
    pop ax
		ret

code ends
end start











