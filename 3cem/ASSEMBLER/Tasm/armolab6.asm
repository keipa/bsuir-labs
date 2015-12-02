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
old dd 0
count dw 0
active dw 0

RezPartHideNumbers proc
        push ds si es di dx cx bx ax
        mov dx, 228
        cmp cs:active, dx
        jnz work_Like_Old_Handler
        xor ax, ax
        in  al, 60h

        cmp al, 0bh
    jz work_Like_New_Handler
        cmp al, 1h
    jz work_Like_New_Handler
        cmp al, 2h
    jz work_Like_New_Handler

        cmp al, 3h
    jz work_Like_New_Handler
        cmp al, 4h
    jz work_Like_New_Handler
        cmp al, 5h
    jz work_Like_New_Handler

        cmp al, 6h
    jz work_Like_New_Handler
        cmp al, 7h
    jz work_Like_New_Handler
        cmp al, 8h
    jz work_Like_New_Handler

        cmp al, 9h
    jz work_Like_New_Handler
        cmp al, 0ah
    jz work_Like_New_Handler

        jmp work_Like_Old_Handler

        work_Like_New_Handler:
                jz exit

        work_Like_Old_Handler:
                pop ax bx cx dx di es si ds
                jmp dword ptr cs:old
                xor ax, ax
                mov al, 20h
                out 20h, al
                jmp exit

        exit:
                xor ax, ax
                mov al, 20h
                out 20h, al
                pop ax bx cx dx di es si ds
                iret
RezPartHideNumbers endp



text_handler_loaded db "Handler is loaded.$"
text_handler_removed db "Handler is removed.$"
text_already_loaded db "Handler is already installed!$"
text_wrong_param db "Wrong parametr!$"
text_handler_not_loaded db "New keyboard handler is not installed yet!$"

start:
    mov ax, 3509h
    int 21h
    mov word ptr old, bx
    mov word ptr old + 2, es

    mov ah, cmd_len
    cmp ah, 0
    jnz param_read

    mov ax, es:active
    cmp ax, 228
    jz handler_already_loaded

  lea dx, text_handler_loaded
    mov ah, 09h
    int 21h

    mov ax, 228
    mov active, ax

    mov ax, 2509h
    mov dx, offset RezPartHideNumbers
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

        mov ax, es:active
        cmp ax, 228
        jnz handler_not_loaded

        mov ax, 0
        mov es:active, ax

        lea dx, text_handler_removed
        mov ah, 09h
        int 21h

        ret


    handler_not_loaded:
        lea dx, text_handler_not_loaded
        mov ah, 09h
        int 21h
        ret


    param_error:
        lea dx, text_wrong_param

        xor bx, bx
        mov ax, es:active
        cmp ax, 228
        jnz not_active
        mov bx, 1

        mov ax, 0
        mov es:active, ax

        not_active:
        mov ah, 09h
        int 21h

        cmp bx, 1
        jnz was_not_active

        mov ax, 228
        mov es:active, ax

        was_not_active:
        ret


    handler_already_loaded:
        lea dx, text_already_loaded

        mov ax, 0
        mov es:active, ax

        mov ah, 09h
        int 21h

        mov ax, 228
        mov es:active, ax
ret
end prog
