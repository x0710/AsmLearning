ASSUME CS:code

code SEGMENT
	MOV AX,2
	ADD AX,AX
	ADD AX,AX
	
	MOV AX,4c00H
	INT 21H
code ENDS
END