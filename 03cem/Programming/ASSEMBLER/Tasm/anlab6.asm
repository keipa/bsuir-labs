	.286
	.model tiny
	.code
	org 2Ch
	org 80h
	cmd_len db ?
	cmd_line db ?
	org 100h

	prog:
	jmp start
	old_handler dd 0
	count dw 0
	initialized dw 0

	KeybordHandler proc
	        push ds si es di dx cx bx ax

			mov dx, 123
	        cmp cs:initialized, dx
	        jnz use_old_handler
	       
	        xor ax, ax
	        in  al, 60h

	       ;	mov dl, '1'
	        ;cmp al, 1eh ;a
			;je use_new_handler

			;mov dl, '2'
			;cmp al, 30h ;b
			;je use_new_handler
	       
	       	mov dl, '3'
	        cmp al, 2eh ;c
			je use_new_handler
	       
	       ;	mov dl, '4'
	       ; cmp al, 20h ;d
			;je use_new_handler
	       
	       	mov dl, '5'
	        cmp al, 12h ;e
			je use_new_handler
	       	
	       	jmp use_old_handler       

			use_new_handler:
					mov ah, 05H	
					mov cl, dl
					int 16H
					jmp end_of_handler
		            

	       use_old_handler:
	                pop ax bx cx dx di es si ds
	                jmp dword ptr cs:old_handler
	                jmp end_of_handler

	        end_of_handler:
	                xor ax, ax
	                mov al, 20h
	                out 20h, al
	                pop ax bx cx dx di es si ds
	                iret
	KeybordHandler endp



	text_handler_loaded db "Handler is loaded.$"
	text_handler_removed db "Handler is removed.$"
	handler_already_initialized_msg db "Handler is already initialized!$"
	wrong_param_msg db "Wrong parametr! Uou can use only '-d'!$"
	handler_not_loaded_error_msg db "Handler is not initialized yet!$"

	start:
	    mov ax, 3509h
	    int 21h
	    mov word ptr old_handler, bx
	    mov word ptr old_handler + 2, es

	    mov ah, cmd_len
	    cmp ah, 0
	    jnz param_read

	    mov ax, es:initialized
	    cmp ax, 123
	    jz handler_already_loaded

		lea dx, text_handler_loaded
	    mov ah, 09h
	    int 21h

	    mov ax, 123
	    mov initialized, ax

	    mov ax, 2509h
	    mov dx, offset KeybordHandler
	    int 21h

	    mov dx, offset start
	    int 27h
	    ret

	    param_read:
			lea di, cmd_line
			mov al, [di + 1]
		    cmp al, '-'
	        jnz param_error

	        mov al, [di + 2]
	        cmp al, 'd'
	        jnz param_error

	        mov ax, es:initialized
	        cmp ax, 123
	        jnz handler_not_loaded

	        mov ax, 0
	        mov es:initialized, ax

	        lea dx, text_handler_removed
	        mov ah, 09h
	        int 21h


	        ret


	    handler_not_loaded:
	        lea dx, handler_not_loaded_error_msg
	        mov ah, 09h
	        int 21h
	        ret


	    param_error:
	        lea dx, wrong_param_msg
	        ret


	    handler_already_loaded:
	        lea dx, handler_already_initialized_msg

	        mov ah, 09h
	        int 21h

	ret
	end prog
