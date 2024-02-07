ASSUME cs:code,ss:stack,ds:data
stack SEGMENT
	DW 16 DUP (0)
stack ENDS
data SEGMENT
	isPrimeMsg DB 'It is a prime.$'
	notPrimeMsg DB 'It is not a prime.$'
data ENDS
code SEGMENT
start:
	MOV ax,stack
	MOV ss,ax
	MOV sp,32
	
	MOV ax,data
	MOV ds,ax
	
	;PROGRAMING START PART
	MOV ax,23
	PUSH ax
	MOV dx,0
	CALL judge
	MOV bx,ax
	POP ax
	CMP ax,bx
	JE printIsMsg
	MOV ah,9
	
	
	
	JMP stop
	printIsMsg:
	MOV ax,0
	MOV dx,ax
	MOV ah,9
	int 21h
	
	stop:
	MOV ax,4c00H
	int 21h
	
;need a number in ax
judge:
	PUSH cx
	PUSH bx
	MOV bx,ax
	MOV cx,ax
	DEC cx
	
	s:
		CMP cx,1
		JE over
		
		PUSH dx
		DIV cx
		CMP dx,0
		JE notPrime
		POP dx
		MOV ax,bx
		LOOP s
	MOV ax,0
	JMP over
	notPrime:
		POP DX
		mov ax,cx
	over:
		POP bx
		POP cx
	ret
	
printRegistor:
	PUSH cx
	MOV cx,31
	sl1:
		PUSH ax
		SHR ax,cx
		AND ax,1
		

	ret
	
code ENDS
END start
	