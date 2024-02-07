;菜单显示
DISPLAY  MACRO B     ;定义一个宏指令，即把需要重复执行的一段代码，或者是一组指令缩写成一个宏
		 LEA DX,B
		 MOV AH,9    ;调用9号中断，将菜单显示在屏幕上
		 INT 21H
		 ENDM
		 
DATA SEGMENT

MENU     DB 0DH,0AH,'1: <<liang zhi lao hu>>'  ;歌曲1：两只老虎
		 DB 0DH,0AH,'2: <<xin nian hao>>'     ;歌曲2：新年好
		 DB 0DH,0AH,'3: <<fen shua jiang>>'   ;歌曲3: 粉刷匠
		 DB 0DH,0AH,'q: EXIT'                ;退出演奏乐曲
		 DB 0AH,0AH,'$'
		 
music1_fre DW 263,294,330,263  ;音乐1的频率
		   DW 263,294,330,263
		   DW 330,349,392
		   DW 330,349,392
		   DW 392,440,392,349,330,263
		   DW 392,440,392,349,330,263
		   DW 263,196,263
		   DW 263,196,263,0
music1_time DW 10 dup(20), 40    ;音乐1的节拍
			DW 2 dup(20), 40
			DW 4 dup(10), 20, 20
			DW 4 dup(10), 20, 20
			DW 2 dup(20), 40
			DW 2 dup(20), 40
			
music2_fre dw 262,262,262,196
           dw 330,330,330,262
           dw 262,330,392,392
           dw 349,330,294
           dw 294,330,349,349
           dw 330,294,330,262
           dw 262,330,294,196
           dw 247,294,262,0

music2_time dw 3 dup(12,12,25,25),12,12,50
            dw 3 dup(12,12,25,25),12,12,50

music3_fre	dw 392,330,392,330
		    dw 392,330,262
		    dw 294,349,330,294
		    dw 392
		    dw 392,330,392,330
		    dw 392,330,262
		    dw 294,349,330,294
		    dw 262
		    dw 294,294,349,349
		    dw 330,262,392
		    dw 294,349,330,294
		    dw 392
		    dw 392,330,392,330
		    dw 392,330,262
		    dw 294,349,330,294
		    dw 262
		    dw 0	
music3_time dw 3 dup(10h,10h,10h,10h,10h,10h,20h,10h,10h,10h,10h,40h)
		    dw 10h,10h,10h,10h,10h,10h,20h,10h,10h,10h,10h,20h
			
DATA ENDS

STACK SEGMENT

STACK ENDS			
			
CODE  SEGMENT                                                
    ASSUME DS:DATA,CS:CODE 
	
	
START:
      MOV AX,DATA
	  MOV DS,AX
	  
	  MOV AH,0
	  MOV AL,0
	  
INPUT:    ;控制音乐播放的主程序
      DISPLAY MENU   ;显示菜单
	  
	  MOV AH,1
	  INT 21H    ;调用1号中断，输入播放哪首音乐或者退出播放
	  
stop_music:
      CMP AL,'q'   ;若输入的字符为q，则中断，停止播放音乐
	  JZ end_music
	  
	  
music1:      
      CMP AL,'1'
      JNZ music2  ;若输入的数字不为1，跳转到音乐2的子程序接着判断
      lea SI,music1_fre  ;将音乐1频率的偏移地址赋值给SI
      lea BP,music1_time  ;将音乐1节拍的偏移地址赋值给BP
      CALL play_music   ;调用播放音乐子程序
      JMP INPUT        ;循环继续输入，直至按下‘4’，即退出播放

music2:      
      CMP AL,'2'
      JNZ music3  ;若输入的数字不为2，跳转到音乐3的子程序接着判断
      lea SI,music2_fre  ;将音乐2频率的偏移地址赋值给SI
      lea BP,music2_time  ;将音乐2节拍的偏移地址赋值给BP
      CALL play_music   ;调用播放音乐子程序
      JMP INPUT        ;循环继续输入，直至按下‘4’，即退出播放

music3:      
      CMP AL,'3'
      JNZ INPUT  ;若输入的数字不为3，跳转继续输入
      lea SI,music3_fre  ;将音乐2频率的偏移地址赋值给SI
      lea BP,music3_time  ;将音乐2节拍的偏移地址赋值给BP
      CALL play_music   ;调用播放音乐子程序
      JMP INPUT        ;循环继续输入，直至按下‘4’，即退出播放

end_music:                                                             
      MOV AH,4CH
      INT 21H

;*******************************************************************
sound proc near
        PUSH AX 
        PUSH BX 
        PUSH CX 
        PUSH DX 
        PUSH DI 
		;8253 芯片的设置
        MOV AL,0B6H  ;8253初始化
        OUT 43H,AL    ;43H是8253芯片控制口的端口地址
        MOV DX,12H    ;高16位
        MOV AX,34dch   ;低16位                                        
        DIV DI    ;计算分频值,赋给ax。DI中存放声音的频率值。
        OUT 42H,AL   ;先送低8位到计数器，42h是8253芯片通道2的端口地址
        MOV AL,AH 
        OUT 42H,AL   ;后送高8位计数器
		
		;设置8255芯片, 控制扬声器的开/关
        IN AL,61H    ;读取8255 B端口原值
        MOV AH,AL     ;保存原值
        OR AL,3        ;使低两位置1，打开开关
        OUT 61H,AL   ;开扬声器, 发声
		
WAIT1:    
        MOV CX,28000                                          
         
DELAY1:   
		nop
		loop DELAY1
        DEC BX 
        JNZ WAIT1 
        MOV AL,AH   ;恢复扬声器端口原值
        OUT 61H,AL 
        POP DI 
        POP DX 
        POP CX 
        POP BX                                                 
        POP AX 
        RET 


sound ENDP
;*************************************************************
play_music 	PROC NEAR   ;播放音乐子程序
       PUSH DS
	   SUB AX,AX
       PUSH AX

play_start:
		MOV AH,1
		INT 16H    ;这里是可以切换音乐的关键
		JNZ jpC
     MOV DI,[SI]  ;音符
	   CMP DI,0  ;判断音符是否为0，为0则结束播放音乐子程序
	   JE end_paly
	   MOV BX,[BP]   ;节拍
	   CALL sound
	   
	   ADD SI,2
	   ADD BP,2
	   JMP play_start  ;继续执行音乐播放子程序，直至一首音乐结束
	   
end_paly:
       RET
       
	jpC:JMP INPUT
	   
play_music endp
;*******************************************************************

CODE  ENDS 
END START   
