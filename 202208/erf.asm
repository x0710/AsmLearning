ASSUME cs:code,ds:data,ss:stack
stack SEGMENT
	DW 16 DUP (0)
stack ENDS
data SEGMENT
	first DW 256 DUP(0)
data ENDS
code SEGMENT
start:
	MOV ax,stack
	MOV ss,ax
	MOV sp,32
	
	MOV ax,data
	MOV ds,ax
	
	mov cx,0ffffH
	t:
		mov ax,0
		out 61h,ax
		mov ax,1111
		out 61h,ax
		JMP t
	lp:
		MOV ah,1h
		INT 21h
		CMP al,10
		JE endCode
		CMP al,8
		JNE lp
		MOV dl,' '
		MOV ah,2
		INT 21h
		MOV dl,8
		MOV ah,2
		INT 21h
		
		JMP lp
	;GET NUMBER a
	
endCode:
	MOV ax,4c00h;
	INT 21h

install:
	ret

hexToDec:


hexToDecEnd:nop

code ENDS


END start