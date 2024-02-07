assume cs:code,ss:stack,ds:data
stack segment
	dw 10 dup (0)
stack ends
data segment
	db '1) reset pc    $'
	db '2) start system$'
	db '3) clock       $'
	db '4) set clock   $'
	start_address dw 0000, 0ffffh
	screen_address dw 0000,0B800h
	db '--/--/-- --:--:--'
	db 9,8,7,4,2,0
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov dx,0
	mov cx,4
	s0:
		mov ah,9
		int 21h
		mov ah,2
		push dx
		mov dl,10
		int 21h
		pop dx
		add dx,10H
		loop s0

	input:
	mov ah,0
	int 16h
	
	cmp al,30h+1
	je reset
	cmp al,30h+2
	je startSystem
	cmp al,30h+3
	je clock
	cmp al,30h+4
	je setClock
	jmp input
	
	reset:
	jmp start_address
	startSystem:
	clock:
	
	setClock:

end_program:
	mov ax,4c00h
	int 21h
code ends
end start
