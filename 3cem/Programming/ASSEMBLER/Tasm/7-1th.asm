
;by intercepting interrupt produced duplication vowels
; tasm as a default
;tlink /t 7-1th
;7-1th
.286
.model tiny  ;code and date contains together
.code


org 2Ch   ; starting offset addressing
org 80h


cmd_len db ?  ; command length
cmd_line db ? ; command begining

org 100h 		;standart offset DANGER DO NOT TOUCH

prog:
jmp start
old_handler dd 0
count dw 0
initialized dw 0

dublicateKeyHandler proc
				push ds si es di dx cx bx ax		;we must save the registers
;vowels - гласные буквы - "A","E","Y","U","I","O"
		mov dx, 123
				cmp cs:initialized, dx  ;if handler is initialized
				jnz use_old_handler			;then use old handler
				xor ax, ax						;clear the ax
				in  al, 60h						;load to al keyboard processing

				mov dl, 'a'	;when "A" will pressed
				cmp al, 1eh ;set scan code for "A"
		je custom_keyboard_handler
				mov dl, 'e'	;when "e" will pressed
				cmp al, 12h;set scan code for "e"
		je custom_keyboard_handler

				mov dl, 'y';when "y" will pressed
				cmp al, 15h ;set scan code for "y"
		je custom_keyboard_handler

				mov dl, 'u';when "u" will pressed
				cmp al, 16h;set scan code for "u"
		je custom_keyboard_handler

				mov dl, 'i';when "i" will pressed
				cmp al, 17h;set scan code for "i"
		je custom_keyboard_handler

			mov dl, 'o';when "o" will pressed
			cmp al, 18h;set scan code for "o"
		je custom_keyboard_handler


	  jmp use_old_handler

		custom_keyboard_handler:;main logic of the progma
				mov ah, 05H				;some miracle
				mov cl, dl				;dl contains scan code for keyboard which we send upper
				int 16H						;INTERRUPION!!!11 and output to the screen

				mov ah, 05H			;repeat to duplicate
				mov cl, dl			;
				int 16H

				jmp end_of_handler


			 use_old_handler:;old handler if we bored
								pop ax bx cx dx di es si ds			;restore registers
								jmp dword ptr cs:old_handler	;and restore default handler
								jmp end_of_handler

				end_of_handler:
								xor ax, ax			;some MAGIC
								mov al, 20h
								out 20h, al
								pop ax bx cx dx di es si ds			;and restore registers
								iret
dublicateKeyHandler endp


err_msg db "pls use '-d'!$"
start:
		mov ax, 3509h 				;MAGIC
		int 21h
		mov word ptr old_handler, bx			;preserving the old interrupt handler
		mov word ptr old_handler + 2, es
		mov ah, cmd_len							; if comand lenght not equal zero
		cmp ah, 0										;than
		jnz param_read							;read the parametr
		mov ax, es:initialized			;MAGIC(i suppose this line save standart interrupt)
		cmp ax, 123
		mov ax, 123
		mov initialized, ax
		mov ax, 2509h												;DANGER ZONE ENTERANCE TO THE custom_handler
		mov dx, offset dublicateKeyHandler  ;offset to custom_handler
		int 21h															;and useing
		mov dx, offset start								;go to start(maybe org use this too)
		int 27h
		ret

		param_read:							;flag processing
		lea di, cmd_line				;load comand line
		mov al, [di + 1]				;space skip
			cmp al, '-'						;if flag not begin with "-"
				jnz error						;send  error
														;else
				mov al, [di + 2]		;offset to next symbol
				cmp al, 'd'					;if it not "d"
				jnz error						;send error msg
														;else
				mov ax, es:initialized;return standart handler
				cmp ax, 123						;MAGIC
				mov ax, 0							;MAGIC
				mov es:initialized, ax;MAGIC
				ret										;and return
		error:
				lea dx, err_msg ;msg with error
				ret											;and return



ret
end prog
