M = 0                           
IRPC N, 0123456789ABCDEF
EXC_0&N label word                              ;Обработчики исключений
    cli 
    jmp EXC_HANDLER
endm
M = 010H
IRPC N, 0123456789ABCDEF                        ;Обработчики исключений
EXC_1&N label word                          
    cli
    jmp EXC_HANDLER
endm
EXC_HANDLER proc near                           ;Процедура вывода обработки исключений
    call CLRSCR                                 ;Очистка экрана
    lea  esi, MSG_EXC
    mov  edi, 40*2
    call BUFFER_OUTPUT                          ;Вывод предупреждения
    pop eax                                     ;Снять со стека старый EIP
    pop eax                                     ;CS  
    pop eax                                     ;И EFLAGS
    sti                                         ;Обязательно, без этого обработка аппаратных прерываний отключена
    db 66H
    retf                                        ;Переход в 16-битный сегмент кода    
EXC_HANDLER     ENDP
DUMMY_IRQ_MASTER proc near                      ;Заглушка для аппаратных прерываний ведущего контроллера
    push eax
    mov  al,20h
    out  20h,al
    pop  eax
    iretd
DUMMY_IRQ_MASTER endp
DUMMY_IRQ_SLAVE  proc near                      ;Заглушка для аппаратных прерываний ведомого контроллера
    push eax
    mov  al,20h
    out  20h,al
    out  0A0h,al
    pop  eax
    iretd
DUMMY_IRQ_SLAVE  endp
TIMER_HANDLER proc near                         ;Обработчик прерываний системного таймера
    push ds
    push es
    pushad                                      ;Занести в стек расширенные регистры общего назначения 
    mov  ax,DATA_DESC                           ;Переинициализировать сегментные регистры
    mov  ds,ax
    inc  ds:[COUNT]                             ;Увеличить значение счетчика
    lea  edi,ds:[BUFFER_COUNT]
    mov  ax,ds:[COUNT]
    call WORD_TO_DEC                            ;Преобразовать счётчик в строку
    mov  edi,378
    lea  esi,BUFFER_COUNT
    call BUFFER_OUTPUT                          ;Вывести значение счетчика
SHOW_TIMER:
    mov  al,ds:[TIME]                           ;Получить значение оставшегося время
    cmp  ds:[TIME],0                            ;Если время подошло к концу
    jbe   DISABLE_PM                             ;То на выход из защищенного режима
    mov  al,0h                                  ;Выбрать регистр секунд cmos
    out  70h,al
    in   al,71h                                 ;Прочитать значение секунд
    cmp  al,ds:[SECOND]                         ;Если секунда та же самая
    je   SKIP_SECOND                            ;То пропустить вывод
    mov  ds:[SECOND],al                         ;Иначе записать значение новой секунды
    mov  al,ds:[TIME]                           ;Получить значение оставшегося время
    xor  ah,ah
    lea  edi,ds:[BUFFER_TIME]                   
    call WORD_TO_DEC                            ;Преобразовать его в строку
    mov  edi,432
    lea  esi,BUFFER_TIME                        
    call BUFFER_OUTPUT                          ;Вывести значение оставшегося время
    dec  ds:[TIME]                              ;Уменьшить значение оставшегося времени
    lea  esi,BUFFER_TIME
    call BUFFER_CLEAR                           ;Очистка буфера
    jmp  SKIP_SECOND                            ;На выход из обработки время
DISABLE_PM:                                     ;Выход из защищенного режима
    mov	bx,offset ds:[TSS_MAIN_DESC]
    mov al,byte ptr [ bx + 5 ]
    test al,00000010b
    jnz GO
    db 0eah
    dd 0
    dw TSS_MAIN_DESC
GO:
    db 0eah                                     ;Дальний jmp
    dd OFFSET EXIT_FROM_INTERRUPT               ;На метку
    dw CODE_PM_DESC                             ;В сегменте
SKIP_SECOND:                                    ;Секунда та же, не надо производить никаких действий    
    mov     al,20h
    out     20h,al
    mov	    bx,offset TSS_MAIN_DESC
	and	    byte ptr [bx+5],11111101b           ;Обнулить флаг занятости главной задачи
	mov	    bx,offset TSS_2_DESC
	and	    byte ptr [bx+5],11111101b           ;Обнулить флаг занятости 0 задачи
	mov	    bx,offset TSS_3_DESC
	and	    byte ptr [bx+5],11111101b           ;Обнулить флаг занятости 1 задачи
	movzx   eax,ds:[TASK_INDEX]                 ;Получить номер текущей задачи
    add     ds:[TASK_INDEX],2
    movzx   eax,ds:[TASK_LIST+eax]              ;Получить дескриптор следующей задачи
    or      eax,eax                        
    jnz     TIMER_NEXT_TASK                     ;Перейти к следующей задаче
    movzx   eax,ds:[TASK_LIST]
    mov     ds:[TASK_INDEX],0                   ;Перейти к первой задаче
TIMER_NEXT_TASK:
    mov     word  ptr ds:[TASK_ADDR+4],ax       ;Записать в поле дескриптор задачи
    jmp     fword ptr ds:[TASK_ADDR]            ;Переключиться на новую задачу
    mov  al,20h
    out  20h,al  
    popad
    pop es
    pop ds
    iretd
TIMER_HANDLER endp
KEYBOARD_HANDLER proc near                      ;Обработчик прерывания клавиатуры
    push ds
    push es
    pushad                                      ;Сохранить расширенные регистры общего назначения
    mov  ax,DATA_DESC
    mov  ds,ax
    in   al,60h                                 ;Считать скан код последней нажатой клавиши                                ;
    cmp  al,1                                   ;Если был нажат 'ESC'
    je   KEYBOARD_EXIT                          ;Тогда на выход из защищенного режима   
    cmp  al,81
    je   KEYBOARD_EXIT
    cmp  al,11                                  ;Если клавишу отпустили
    jae   KEY_UP
    mov  ds:[KEY_PRESSED],al
KEY_UP:
    mov  ds:[KEY_SCAN_CODE],al                  ;Записать его в память
    lea  edi,ds:[BUFFER_SCAN_CODE]
    mov  al,ds:[KEY_SCAN_CODE]
    xor  ah,ah
    call BYTE_TO_HEX                            ;Преобразовать скан-код в строку
    mov  edi,200
    lea  esi,BUFFER_SCAN_CODE                   
    call BUFFER_OUTPUT                          ;Вывести строку со скан-кодом
    jmp  KEYBOARD_RETURN  
KEYBOARD_EXIT:
    mov ds:[TIME],0                             ;Установить оставшееся время в 0 - выход будет по прерыванию таймера  
KEYBOARD_RETURN:
    mov  al,20h
    out  20h,al                                 ;Отпарвка сигнала контроллеру прерываний
    popad                                       ;Восстановить значения регистров
    pop es
    pop ds
    iretd                                       ;Выход из прерывания
KEYBOARD_HANDLER endp