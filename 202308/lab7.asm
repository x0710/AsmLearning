assume cs:code,ss:stack,ds:data

stack segment
	dw 10h dup (0);
stack ends

data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
  ;

  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
  ;

  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
  ;
data ends

table segment
  db 21 dup ('year summ ne ?? ')
table ends

code segment
start:mov ax,stack
	mov ss,ax
	mov sp,32
	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	sub bx,bx
	mov cx,21;存在21条数据
s1:	;用来遍历一条数据
	push bx
	
    push ax
    mov ax,bx
    mov bl,4
	mul bl
    mov bx,ax
    pop ax

	mov ax,ds:[bx]
	mov dx,ds:[bx+2]
	pop bx

	push bx
    push ax
    mov ax,bx
    mov bl,10h
	mul bl
    mov bx,ax
    pop ax

	mov es:[bx],ax
	mov es:[bx+2],dx
	pop bx
	;年份
	push bx
	
    push ax
    mov ax,bx
    mov bl,4
	mul bl
    mov bx,ax
    pop ax

	mov ax,ds:[bx+83];低位
	mov dx,ds:[bx+85];高位
	pop bx
	push bx
	
    push ax
    mov ax,bx
    mov bl,10h
	mul bl
    mov bx,ax
    pop ax

	mov es:[bx+5],ax
    mov es:[bx+7],dx
	pop bx
	;收入
	push cx
    push bx
    
    push ax
    mov ax,bx
    mov bl,2
	mul bl
    mov bx,ax
    pop ax

    mov cx,ds:[bx+167]
    pop bx
    push bx
    
    push ax
    mov ax,bx
    mov bl,10h
	mul bl
    mov bx,ax
    pop ax

    mov es:[bx+0ah],cx
    ;人数
    div cx
    mov es:[bx+0dh],ax
    pop bx
    pop cx
    ;平均工资
	
	inc bx
	loop s1

    mov ax,4c00h
    int 21h
code ends
end start