assume cs:code,ss:stack
stack segment
	dw 5 dup (0)
stack ends
data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1980','1990','1991','1992'
	db '1993','1994','1995'
	;84
	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
	;84
	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
	;42
data ends

table segment
	db 21 dup('year summ ne ?? ')
table ends
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,10
	
	mov ax,table
	mov es,ax
	mov ax,data
	mov ds,ax
	
	
	mov bx,0
	mov cx,21
	mov bp,0
s0:
	push cx
	
	push bx
	add bx,bx
	add bx,bx
	mov cx,4
	push bp
	yearLoop:
		mov dl,ds:0[bx]
		mov byte ptr es:0[bp],dl
		inc bx
		inc bp
		loop yearLoop
	pop bp
	pop bx
	
	push bx
	add bx,bx
	add bx,bx
	mov dx,ds:84[bx]
	mov word ptr es:5[bp],dx
	mov dx,ds:86[bx]
	mov word ptr es:7[bp],dx
	mov dx,es:7[bp]
	mov ax,es:5[bp]
	pop bx
	
	push bx
	add bx,bx
	push dx
	mov dx,ds:168[bx]
	mov word ptr es:10[bp],dx
	pop dx
	div word ptr es:10[bp]
	pop bx
	
	mov es:13[bp],ax
	
	pop cx
	mov ax,es
	inc ax
	mov es,ax
	inc bx
	loop s0
	
	mov ax,4c00h
	int 21h
code ends
end start