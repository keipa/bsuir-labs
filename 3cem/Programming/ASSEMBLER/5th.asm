.model small
.stack 100h
.data
	MaxStringLength 	dw 	1000
	String 				db 	1000 dup (0)
	LongestWord 		db 	1000 dup (0)

	OutOfLengthError 	db 	10, 13, "Out of max string length. Entering is terminated:C", '$'
	EnterStringMessage	db 	"Enter string: ", 10, 13, '$'
	WordLenghtMessage 	db 	"The longest word length is: ", 10, 13, '$'
	LongestWordMessage 	db 	"The longest words is:", 10, 13, '$'
	EmptyStringMessage 	db 	"You enter a empty string. Program is terminated:C", 10, 13, '$'
.code

IgnoreWhitespaces proc
		dec 	SI
IW_CYLE:
		inc 	SI
		cmp 	byte ptr [SI], ' '
		je 		IW_CYLE

		ret
endp IgnoreWhitespaces

GetWordLength proc
		push 	SI
		push 	AX
		push 	BX
		push  	DX
		push 	DI

		call 	IgnoreWhitespaces
		mov 	DI, SI
		mov 	BX, SI
		xor 	CX, CX
SCANNING_WORDS_CYCLE:
		mov 	AL, [SI]
		cmp 	AL, ' '
		jne 	SCANNING_WORDS_CYCLE_CONT
		
		mov 	DX, SI
		sub 	DX, BX
		cmp 	CX, DX
		jnc 	SCANNING_WORDS_CYCLE_NO_MAX 
		mov 	CX, DX

SCANNING_WORDS_CYCLE_NO_MAX:
		call 	IgnoreWhitespaces
		mov 	BX, SI
		dec		SI

SCANNING_WORDS_CYCLE_CONT:
		inc 	SI
		cmp 	AL, '$'
		jne 	SCANNING_WORDS_CYCLE

		pop 	DI
		pop 	DX
		pop		BX
		pop 	AX
		pop 	SI
		ret
endp GetWordLength

PrintLongestsWord proc
		push 	SI
		push 	AX
		push 	BX
		push 	CX
		push  	DX

		call 	IgnoreWhitespaces
		mov 	DI, SI
		mov 	BX, SI
PRINTING_WORDS_CYCLE:
		mov 	AL, [SI]
		cmp 	AL, ' '
		jne 	PRINTING_WORDS_CYCLE_CONT
		
		mov 	DX, SI
		sub 	DX, BX
		cmp 	CX, DX
		jne  	PRINTING_WORDS_CYCLE_NO_MAX
		call 	PrintWord		

PRINTING_WORDS_CYCLE_NO_MAX:
		call 	IgnoreWhitespaces
		mov 	BX, SI
		dec		SI

PRINTING_WORDS_CYCLE_CONT:
		inc 	SI
		cmp 	AL, '$'
		jne 	PRINTING_WORDS_CYCLE

		pop 	DX
		pop		BX
		pop 	AX
		pop 	SI
		pop 	CX
		ret
endp PrintLongestsWord

PrintWord proc
		push 	AX
		push 	DX
		push 	SI

		mov 	SI, BX
		add 	SI, CX
		mov 	byte ptr [SI], '$'
		mov 	AH, 09h
		mov 	DX, BX
		int 	21h
		mov 	byte ptr [SI], ' '

		mov 	AH, 02h
		mov 	DL, 10
		int 	21h
		mov 	DL, 13
		int 	21h

		pop 	SI
		pop 	DX
		pop 	AX
		ret
endp PrintWord

EnterString proc
		push 	AX
		push 	DX
		push 	BX
		push 	SI

		mov 	BX, SI
ENTERING_CYCLE:
		mov 	AH, 08h
		int 	21h

		cmp 	AL, 8
		je 		BACKSPACE_HANDLING
		cmp 	AL, 13
		je 		ENTERING_CYCLE_OUT
		cmp 	AL, '$'
		je 		ENTERING_CYCLE

		mov 	byte ptr [SI], AL
		inc 	SI

		mov 	CX, SI
		sub 	CX, BX
		cmp 	CX, MaxStringLength
		jnc 	OUT_OF_STRING_LENGTH

		mov		DL, AL
		mov 	AH, 02h
		int 	21h
		jmp 	ENTERING_CYCLE
	

BACKSPACE_HANDLING:
		mov		DL, 8
		mov 	AH, 02h
		int 	21h
		mov		DL, 0
		int 	21h
		mov		DL, 8
		int 	21h

		cmp 	SI, BX
		je 		ENTERING_CYCLE
		dec 	SI 
		jmp 	ENTERING_CYCLE

OUT_OF_STRING_LENGTH:
		lea 	DX, OutOfLengthError
		mov 	AH, 09h
		int 	21h

ENTERING_CYCLE_OUT:
		mov 	byte ptr [SI], ' '
		inc 	SI
		mov 	byte ptr [SI], '$'

		mov		DL, 10
		mov 	AH, 02h
		int 	21h
		mov		DL, 13
		int 	21h

		pop 	SI
		pop 	BX
		pop 	DX
		pop 	AX
		ret
endp EnterString


GetDigitFromNumber proc						
		push 	AX
		push 	CX

		mov 	AX, BX
		xor 	DX, DX
		mov		CX, 10
		cwd
		idiv	CX
		mov 	BX, AX

		test 	DX, DX 						
		jns 	GETTING_DIGIT_OUT
		neg 	DX

GETTING_DIGIT_OUT:
		Add 	DX, 48

		pop 	CX
		pop 	AX
		ret
endp GetDigitFromNumber


PrintNumber proc						
		push 	AX
		push 	BX
		push	CX
		push 	DX
		xor 	CX, CX

		mov 	BX, AX
		test 	BX, BX					
		jns 	GETTING_DIGITS_LOOP
		mov 	AH, 02h
		mov 	DL, '-'
		int 	21h

GETTING_DIGITS_LOOP:					
		call 	GetDigitFromNumber
		push 	DX
		inc  	CX
		cmp 	BX, 0
		jne  	GETTING_DIGITS_LOOP

PRINTING_DIGITS_LOOP:					
		pop 	DX
		mov 	AH, 02h
		int 	21h
		loop 	PRINTING_DIGITS_LOOP

		mov 	AH, 02h
		mov 	DL, 10
		int		21h
		mov 	DL, 13
		int 	21h

		pop 	DX
		pop 	CX
		pop 	BX
		pop 	AX
		ret
endp PrintNumber


		assume	DS: @data, ES: @data 	 
MAIN:
		mov 	AX, @data
		mov 	DS, AX
		mov 	ES, AX

		lea 	DX, EnterStringMessage
		mov 	AH, 09h
		int 	21h

		lea 	SI, String
		call 	EnterString
		call 	GetWordLength	
		cmp 	CX, 0
		je 		EMPTY_STRING_HANDLING

		lea 	DX, WordLenghtMessage
		mov 	AH, 09h
		int		21h

		mov 	AX, CX
		call 	PrintNumber

		lea 	DX, LongestWordMessage
		mov 	AH, 09h
		int 	21h
		call 	PrintLongestsWord
		jmp 	MAIN_END

EMPTY_STRING_HANDLING:
		lea 	DX, EmptyStringMessage
		mov 	AH, 09h
		int 	21h
	
MAIN_END:
		mov 	AX, 4c00h
		int		21h
end MAIN