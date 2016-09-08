CLRSCR  proc near                               ;Процедура очистки консоли
    push es
    pushad
    mov  ax,TEXT_DESC                           ;Поместить в ax дескриптор текста
    mov  es,ax
    xor  edi,edi
    mov  ecx,80*25                              ;Количество символов в окне
    mov  ax,700h
    rep  stosw
    popad
    pop  es
    ret
CLRSCR  endp
BUFFER_CLEAR  proc near                         ;Процедура очистки буфера
    mov al,' '
    mov [esi+0],al
    mov [esi+1],al
    mov [esi+2],al
    mov [esi+3],al
    mov [esi+4],al
    mov [esi+5],al
    mov [esi+6],al
    mov [esi+7],al
    ret
BUFFER_CLEAR  endp
BUFFER_OUTPUT proc near                         ;Процедура вывода текстового буфера, оканчивающегося 0
    push es
    PUSHAD
    mov  ax,TEXT_DESC                           ;Поместить в es селектор текста
    mov  es,ax
OUTPUT_LOOP:                                    ;Цикл по выводу буфера
    lodsb                                       
    or   al,al
    jz   OUTPUT_EXIT                            ;Если дошло до 0, то конец выхода
    stosb
    inc  edi
    jmp  OUTPUT_LOOP
OUTPUT_EXIT:                                    ;Выход из процедуры вывода
    popad
    pop  es
    ret
BUFFER_OUTPUT ENDP
WORD_TO_DEC proc near                           ;Процедура перевода слова в строку
    pushad    
    movzx eax,ax
    xor cx,cx              
    mov bx,10              
LOOP1:                                          ;Цикл по извлечению цифры             
    xor dx,dx              
    div bx                 
    add dl,'0'             
    push dx                
    inc cx                 
    test ax,ax             
    jnz LOOP1          
LOOP2:                                          ;Цикл по заполнению буфера                 
    pop dx                 
    mov [di],dl            
    inc di                 
    loop LOOP2         
    popad
    ret
WORD_TO_DEC endp
DIGIT_TO_HEX proc near                          ;Процедура перевода цифры в шеснадцатеричный вид
    add al,'0'            
    cmp al,'9'            
    jle DTH_END           
    add al,7              
DTH_END:
    ret        
DIGIT_TO_HEX endp
BYTE_TO_HEX proc near                           ;Процедура перевода числа в шеснадцатеричный вид
    push ax
    mov ah,al             
    shr al,4              
    call DIGIT_TO_HEX     
    mov [di],al           
    inc di                
    mov al,ah             
    and al,0Fh            
    call DIGIT_TO_HEX     
    mov [di],al           
    inc di                
    pop ax
    ret    
BYTE_TO_HEX endp