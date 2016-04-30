	.model   small
	.stack   1000h

	.data
	text_please db "Please, enter the number: $"
	text_result db "Result of the division: $"
	text_integer_part db " is integer part, $"
	text_remainder db " is remainder.$"
	text_endline db 13, 10, "$"			;Line end in DOS
	text_negative db "-$"
	text_zero db "You can't devide by zero!$"

	.code
	main:
	mov ax, @data
	mov ds, ax

	lea dx, text_please
	call Output_Text
	call Input_Text
	call Output_Text_Endline
	mov cx, ax

	lea dx, text_please
	call Output_Text
	call Input_Text
	call Output_Text_Endline
	mov bx, ax

	test bx, bx
	jz Devide_By_Zero
	jmp Normal_Division
	Devide_By_Zero:
		lea dx, text_zero
		call Output_Text
	jmp Exit

	Normal_Division:
		lea dx, text_result				;Output result
		call Output_Text
		xor dx, dx
		mov ax, cx
		cwd
		idiv bx

		call Output_Sign				;Integer part or result
		mov bx, dx						;Save remainder
		lea dx, text_integer_part
		call Output_Text
		xor dx, dx

		mov ax, bx						;Remainder of result
		call Output_Sign
		lea dx, text_remainder
		call Output_Text
		call Output_Text_Endline
	Exit:								;Exit
		mov ax, 4c00h
		int 21h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Functions;;;;;;;;;;;;;;;;;;;;;;

	Input_Remove_Symbol PROC
			push ax
			push bx
			push cx
	        push dx

			xor dx, dx					;Get cursor position
			mov ah, 03h
			int 10h

			mov ah, 02h					;Move cursor back by one position
			dec dl
			int 10h

			push dx						;Remove last symbol
			mov ah, 02h
			mov dl, ' '
			int 21h
			pop dx
			mov ah, 02h
			int 10h

			pop dx
			pop cx
			pop bx
			pop ax
			ret
	Input_Remove_Symbol ENDP

	Input_Text PROC
		push bx
		push cx							;Cx is count of symbols
		push dx
		push di							;Di store number
		push si							;Si in this function show is number negative
										;Final number will in Ax
		xor di, di
		xor cx, cx
		Get:
			xor ax, ax
			mov ah, 08h
			int 21h

			cmp al, 13					;Enter
			jz DOS_Enter
			cmp al, 8					;Backspace
			jz DOS_Backspace
			cmp al, 27					;Esc
			jz DOS_Esc
			cmp al, 45					;Minus
			jz Minus

			cmp al, '9'
			ja Get
			cmp al, '0'
			jb Get
			jmp Do_It

			DOS_Esc:
				test cx, cx
				jz Get
				Cycle:
					call Input_Remove_Symbol
					loop Cycle

				xor di, di
				xor si, si
			jmp Get

			DOS_Backspace:
				push dx
	 			push ax
				push bx

				test cx, cx
				jz Deleted

				cmp cx, 1				;Remove minus
				jnz Remove_Symbol
				test si, si
				jz Remove_Symbol
				xor si, si
				xor di, di
				dec cx
				call Input_Remove_Symbol
				jmp Deleted

				Remove_Symbol:
					call Input_Remove_Symbol
					dec cx
					test di, di
					jz Deleted

				Reduce_Number:
					xor ax, ax
					xor dx, dx
					xor bx, bx

					mov ax, di
					mov bx, 10
					cwd
					idiv bx
					mov di, ax

				Deleted:
					pop bx
					pop ax
					pop dx
			jmp Get

			DOS_Enter:
				xor ax, ax
				mov ax, di
			jmp End_Input

			Minus:
				test cx, cx
				jnz Get
				xor si, si
				xor di, di
				mov si, 1
			jmp Show

			Do_It:
				push ax
				push cx
				push di

				xor cx, cx					;Convert symbol
				sub al, '0'
				mov cl, al
				test si, si
				jz Increase
				neg cx

				Increase:
					xor dx, dx
					xor ax, ax
					mov ax, di
					xor bx, bx
					mov bx, 10

					cmp cx, 1
					jz Check_Algebraic_Sign
					jmp Sign_Determined
				Check_Algebraic_Sign:
					test si, si
					jnz Negative
					jmp Sign_Determined
				Negative:
					xor bx, bx
					mov bx, -10
				Sign_Determined:
					imul bx
					jo Overflow				;Check overflow of sign number

					add ax, cx
					jo Overflow				;Check overflow of sign number
					mov di, ax
					jmp Not_Overflow

				Overflow:
					pop di
					pop cx
					pop ax
					jmp Get

				Not_Overflow:
					pop cx					;Erase old Di
					xor cx, cx
					pop cx
					pop ax
			Show:
				inc cx
				xor dx, dx
				mov dl, al
				mov ah, 02h
				int 21h
			jmp Get

		End_Input:
			pop si
			pop di
			pop dx
			pop cx
			pop bx
			ret
	Input_Text ENDP

	Output_Text PROC 					;Output text
		push ax
		mov ah, 09h
		int 21h
		pop ax
		ret
	Output_Text ENDP

	Output_Text_Endline PROC 			;End of line
		push dx
		lea dx, text_endline
		call Output_Text
		pop dx
		ret
	Output_Text_Endline ENDP

	Output_Unsign PROC					;Unsign to string
		push ax							;Save registers
		push bx
		push cx
		push dx
		xor cx, cx						;Zeroing the char count
		mov bx, 10

		Output_Unsign_Split:
			xor dx, dx					;Zeroing the rest
			div bx
			add dl, '0'
			push dx
			inc cx						;Increase the char count
			test ax, ax
		jnz Output_Unsign_Split

		mov ah, 02h
		Output_Unsign_Merge:
			pop dx
			int 21h
		loop Output_Unsign_Merge		;Counter is CX

		pop dx
		pop cx
		pop bx
		pop ax
		ret
	Output_Unsign ENDP

	Output_Sign PROC
		push ax
		push dx
		test ax, ax						;If ax >= 0, print as unsign
		jns More_Zero
		lea dx, text_negative
		call Output_Text
		neg ax
		More_Zero:
		call Output_Unsign
		pop dx
		pop ax
		ret
	Output_Sign ENDP

	end     main
