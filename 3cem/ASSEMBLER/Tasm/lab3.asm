.model   small
.stack   200h
.data         
    a1 dw 0
    a2 dw 0
    error db "incorrect number$"
    buff db 7,7 Dup(?)
.code 
main:
    mov ax,@data    
    mov ds,ax
    mov dx,0
    call InputInt
    mov a1,ax
    call InputInt
    mov bx,ax
    mov ax,a1
    div bx
    call OutInt

    mov ax,4c00h    
    int 21h



    OutInt proc
        push cx
        push dx
        push bx
        push ax

        mov bx, 10
        xor cx, cx
        oi1:

            xor dx,dx
            div bx
            push dx
            inc cx ; счётчик цикла
            cmp ax, ax
            jnz oi1

        mov ah, 02h
        oi2:
            pop dx
            add dl, '0'
            int 21h
            loop oi2

        pop ax
        pop bx
        pop dx
        pop cx
    ret
    OutInt endp 

    InputInt proc 
        push cx
        push dx
        push bx

        mov ah,0ah
        xor di,di
        mov dx,offset buff ;
        int 21h 
        mov dl,0ah
        mov ah,02
        int 21h 
        


   
        mov si,offset buff+2 
    ii1:
        xor ax,ax
        mov bx,10  
    ii2:

        mov cl,[si] ; берем символ из буфера
        cmp cl,0dh  
        jz ii3
        
    
        cmp cl,'0'  
        jl er
        cmp cl,'9'  
        ja er
     
        sub cl,'0' ;
        mul bx     
        jc er
        add ax,cx  
        jc er
        inc si     
        jmp ii2    
     
    er:   

        mov dx, offset error
        mov ah,09h
        int 21h
        mov ax,4c00h    
        int 21h
        
     

    ii3:
        
        pop bx
        pop dx
        pop cx
        ret
     
 
    
    InputInt endp


end     main

;0ah - ввод строки с клавиатуры.

           ; На входе ds:dx  = адрес буфера с форматом:

           ; 1 байт - размер буфера для ввода (формирует пользователь)

           ; 2 байт - число фактически введенных символов (заполняет система по окончанию ввода - нажатию Enter (0dh), этот символ не считает)

           ; 3 байт и далее - введенная строка с символом 0dh на конце

           ; На выходе - введенная строка в буфере

;02h - вывод символа.

;На входе в DL - ACSII-код символа