.model tiny
.code
.186

org 2Ch
envseg dw ?

org 80h
cmd_len db ?
cmd_line db ?

org 100h

main:

	jmp start

	; the resident part:

	int21h_handler proc far

		jmp begin

		;variables
		old_int21h_handler dd ?
		isinstalled dw ?
		inputstr db ?
		outputstr db 256 dup('$')
		upperreg db "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		lowerreg db "abcdefghijklmnopqrstuvwxyz"

		begin:

			pushf
			pusha
			cli

			cmp ah, 09h
			jnz old_handler

			xor ax, ax ;test on installation
			mov ax, cs:isinstalled
			cmp ax, 1
			jnz old_handler

			;mov inputstr, offset dx
			cld
			mov si, offset inputstr
			mov di, offset upperreg

			;mov cx, sizeof(inputstr) ;!!

			cycle:

				lodsb
				repne scasb


			old_handler:

				popa
				popf
				;sti ; maybe
				jmp dword ptr cs:old_int21h_handler
				iret



	int21h_handler endp

	already_installed db "Handler is already installed!$"
	incorrectparam db "Incorrect parameter! Use -d to deactivate handler.$"
	installed db "Handler is successfully installed!$"
	uninstalled db "Handler is successfully removed!$"
	not_installed_msg db "Handler is not installed!$"

; the installation part:

start:

	mov ax, 3521h ; getting old handler
	int 21h

	mov word ptr old_int21h_handler, bx  ; saving old handler
	mov word ptr old_int21h_handler + 2, es

	mov ah, cmd_len	; checking the input parameter
    	cmp ah, 0
    	jnz withparam

	mov ax, es:isinstalled
	cmp ax, 1
	jz alreadyInst	; if handler is already installed

	mov dx, offset installed
	mov ah, 09h
	int 21h

	mov ax, 1
	mov isinstalled, ax

	mov ax, 2521h ; restoring the old handler
	mov dx, offset int21h_handler
	int 21h

	mov dx, offset start ; leaving active the resident part
	int 27h

	ret

	withparam:

		mov di, offset cmd_line
		mov al, [di + 1]
		cmp al, '-'
		jnz parameter_err

		mov al, [di + 2]
		cmp al, 'd'
		jnz parameter_err	; if parameter is not '-d'

		mov ax, es:isinstalled
		cmp ax, 1
		jnz not_installed ; if handler is not installed

		mov ax, 0 ; uninstallation
		mov es:isinstalled, ax

		mov dx, offset uninstalled
		mov ah, 09h
		int 21h

		ret

	not_installed:

		mov dx, offset not_installed_msg
		mov ah, 09h
		int 21h

		ret

	parameter_err:

		mov dx, offset incorrectparam
		xor bx, bx
		mov ax, es:isinstalled
		cmp ax, 1
		jnz not_activated
		mov bx, 1

		mov ax, 0
		mov es:isinstalled, ax

		not_activated:

			mov ah, 09h
			int 21h

			cmp bx, 1
			jnz wasntactivated

			mov ax, 1
			mov es:isinstalled, ax

		wasntactivated:

			ret

	alreadyInst:

		mov dx, offset already_installed

		mov ax, 0
		mov es:isinstalled, ax

		mov ah, 09h
		int 21h

		mov ax, 1
		mov es:isinstalled, ax

		ret

end main
