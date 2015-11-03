.model small
.stack 100H
.data
	STRLEN dw 1000													;THAT string LENGTH
	String 	db 1000 dup (0)											;full sentence
	LongestWord db 	1000 dup (0)									;THAT string

	MSG_SOF db 10, 13, "Reached string LIMIT. Enter is stopped", '$';STRING OVERFLOW...
	MSG_ENT	db "ENTER :", 10, 13, '$'
	MSG_LEN db 10,13,"Max LENGTH is: ", 10, 13, '$'
	MSG_WRD db 10,13,"Max WORDS are:", 10, 13, '$'
	MSG_EMP db "String is EMPTY. Enter is stopped", 10, 13, '$'
	MSG_YED db "You entered: ", 10, 13, '$'
	
	CC_S db "RRSOURSE BIgs STRING" , '$'
	RESERVE  	 1000 dup (" ")
.code





WHITESPACE PROC
		DEC SI
IW_CYLE:
	INC SI
	CMP byte ptr [SI], ' '											;if whitespace is exist then counter increment
		
	JE IW_CYLE														;in a cycle


	RET
ENDP WHITESPACE



GETLENGTH PROC

		PUSH SI									;save registers
		PUSH BX									
		PUSH AX									
		PUSH DX									
		PUSH DI									




		CALL WHITESPACE							;ignore whitespaces
		MOV DI, SI 								;save word
		MOV BX, SI								;save word
		XOR CX, CX  							;clear CX

SCAN_STR:
		MOV AL, [SI]							;go to the position SI is a index
		CMP AL, ' '							


		JNE SCAN_CONTINUE						;go to check of the last symbol
		
		MOV DX, SI 				; save the index
		SUB DX, BX
		
		CMP CX, DX				;compare lenght of the previus word and current word
								; if current word bigger than previus then save maxlength to the bx register
		JNC SCAN_MAXW
		MOV CX, DX

SCAN_MAXW:
		CALL WHITESPACE

		MOV BX, SI
		DEC	SI

SCAN_CONTINUE:
		INC SI
		CMP AL, '$'
		JNE SCAN_STR

		POP DI									;return registers
		POP DX									
		POP	BX									
		POP AX									
		POP SI									;return registers
		RET
ENDP GETLENGTH




WLONGPRINT PROC
		PUSH SI									;save registers
		PUSH AX									
		PUSH BX									
		PUSH CX									
		PUSH DX									;save registers

		CALL WHITESPACE
		MOV DI, SI
		MOV BX, SI
PRINTING_WORDS_CYCLE:
		MOV AL, [SI]
		CMP AL, ' '
		JNE PRINT_CONTINUE
		
		MOV DX, SI

		SUB DX, BX
		CMP CX, DX
		
		JNE PRINT_NOMW
		CALL WPRINT		

PRINT_NOMW:
		
		CALL WHITESPACE
		MOV BX, SI
		
		DEC	SI

PRINT_CONTINUE:
		INC SI
		
		CMP AL, '$'
		JNE PRINTING_WORDS_CYCLE


		POP DX


		POP	BX									
		POP AX									
		POP SI									;return registers
		POP CX									;return registers
		RET
ENDP WLONGPRINT






WPRINT PROC
		PUSH AX									;save registers
		PUSH DX									
		PUSH SI									;save registers

		MOV SI, BX
		ADD SI, CX
		MOV byte ptr [SI], '$'
		MOV AH, 09H
		MOV DX, BX



		INT 21H
		MOV byte ptr [SI], ' '

		MOV AH, 02H
		MOV DL, 10
		INT 21H
		MOV DL, 13
		INT 21H

		POP SI 									;return registers
		POP DX									
		POP AX									
		RET
ENDP WPRINT








EnterString PROC
		PUSH AX									
		PUSH DX									
		PUSH BX								
		PUSH SI									;save registers

		MOV BX, SI
ENTERING_CYCLE:
		MOV AH, 08H
		INT 21H

		CMP AL, 8
		JE BACKSPACE_PROCESSING					;return cursor
		CMP AL, 13
		JE ENTER_OUT							;stop Enter
		CMP AL, '$'
		JE ENTERING_CYCLE 						;$ skipping

		MOV byte ptr [SI], AL
		INC SI 

		MOV CX, SI
		SUB CX, BX
		CMP CX, STRLEN
		JNC OVERLIMIT						;if OVERLIMIT then goto OVERLIMIT

		MOV	DL, AL
		MOV AH, 02H
		INT 21H
		JMP ENTERING_CYCLE
	

BACKSPACE_PROCESSING:
		MOV	DL, 8
		MOV AH, 02H								;BACKSPACE processing
		INT 21H
		MOV	DL, 0
		INT 21H
		MOV	DL, 8
		INT 21H
		CMP SI, BX
		JE 	ENTERING_CYCLE
		DEC SI 
		JMP ENTERING_CYCLE

OVERLIMIT:
		LEA DX, MSG_SOF
		MOV AH, 09H
		INT 21H

ENTER_OUT:
		MOV byte ptr [SI], ' '
		INC SI
		MOV byte ptr [SI], '$'					;interruption of the word
		MOV	DL, 10
		MOV AH, 02H
		INT 21H
		MOV	DL, 13
		INT 21H

		POP SI									;return registers
		POP BX									
		POP DX									
		POP AX									;return registers
		RET
ENDP EnterString


GET_DIGIT PROC						
		PUSH AX									;save registers
		PUSH CX									;save registers

		MOV AX, BX
		XOR DX, DX								;put 10 to cx register
		MOV	CX, 10
		CWD
		IDIV CX									;decrese down to 10
		MOV BX, AX
		TEST DX, DX 
		JNS GET_OUT
		NEG 	DX

GET_OUT:
		ADD DX, 48

		POP CX									
		POP AX									;return registers
		RET
ENDP GET_DIGIT





DIGIT_PRINT PROC						
		PUSH AX									;save registers
		PUSH BX									
		PUSH CX									
		PUSH DX									;save registers

		XOR CX, CX
		MOV BX, AX
		TEST BX, BX					
		JNS GETTING_DIGITS_LOOP
		MOV AH, 02H
		MOV DL, '-'
		INT 21H

GETTING_DIGITS_LOOP:					
		CALL GET_DIGIT
		PUSH DX
		INC CX
		CMP BX, 0
		JNE GETTING_DIGITS_LOOP
PRINTING_DIGITS_LOOP:					
		POP DX
		MOV AH, 02H								;out of digits from stack
		INT 21H
		loop PRINTING_DIGITS_LOOP
		MOV AH, 02H								;cursor down
		MOV DL, 10
		INT	21H
		MOV DL, 13
		INT 21H

		POP DX									
		POP CX									;return registers
		POP BX									
		POP AX									
		RET
ENDP DIGIT_PRINT


		assume	DS: @data, ES: @data 	 
MAIN:
		MOV AX, @data
		MOV DS, AX
		MOV ES, AX

		LEA DX, MSG_ENT
		MOV AH, 09H
		INT 21H

		LEA SI, String
		CALL EnterString



		LEA DX, MSG_YED
		MOV AH, 09H
		INT 21H

		PUSH SI
		PUSH DI
		PUSH CX
		PUSH DX

		LEA SI,String
		LEA DI, RESERVE
		MOV CX, 1000
		REP MOVS RESERVE,String
		LEA DX,RESERVE
		MOV AH,09H
		INT 21H

		POP DX
		POP CX
		POP DI
		POP SI
		
		
		

		CALL GETLENGTH								;GET LENGTH of THAT string
		CMP CX, 0


		JE 	MAIN_EMPCH								;if LENGTH is 0 then go to exit

		LEA DX, MSG_LEN								;MSG outout
		MOV AH, 09H
		INT	21H

		MOV AX, CX
		CALL DIGIT_PRINT

		LEA DX, MSG_WRD								;MSG outout
		MOV AH, 09H
		INT 21H
		CALL WLONGPRINT	
	
		

		JMP MAIN_END

MAIN_EMPCH:
		LEA DX, MSG_EMP								;ERR outout
		MOV AH, 09H
		INT 21H
	
MAIN_END:
		MOV AX, 4c00H
		INT	21H
end MAIN