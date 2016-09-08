;Ассемблировать в TASM с параметрами /x /3

;Линковать в TLINK с параметром /m

;Запускать в dosbox или в dos без драйверов памяти


.386p
INCLUDE STRUCT.ASM
;Флаги уровней доступа сегментов
CODE_RM segment para use16                      ;Сегмент кода реального режима       
CODE_RM_BEGIN   = $
    assume cs:CODE_RM,DS:DATA,ES:DATA           ;Инициализация регистров для ассемблирования
START:
    mov ax,DATA                                 ;Инициализиция сегментных регистров
    mov ds,ax                                   
    mov es,ax                          
    lea dx,MSG_ENTER
    mov ah,9h
    int 21h
    call INPUT                                  ;Ввод времени
    mov ds:[TIME], al
    lea dx,MSG_HELLO
    mov ah,9h
    int 21h
    mov ah,7h
    int 21h                                     ;Ожидание подтверждения
PREPARE_RTC:                                    ;Подготовка часов RTC 
    mov al,0Bh
    out 70h,al                                  ;Выбрать регистр состояния 0Bh
    in  al,71h                                  ;Получить значение регистра 0Bh
    or  al,00000100b                            ;Установить бит DM в 1 - формат представления время в двоичном виде
    out 71h,al                                  ;Записать измененное значение
ENABLE_A20:                                     ;Открыть линию A20
    in  al,92h                                                                              
    or  al,2                                    ;Установить бит 1 в 1                                                   
    out 92h,al                                                                                                                     
    ;Или так для старых компьютеров                                                                                                     
    ;mov    al, 0D1h
    ;out    64h, al
    ;mov    al, 0DFh
    ;out    60h, al
SAVE_MASK:                                      ;Сохранить маски прерываний     
    in      al,21h
    mov     INT_MASK_M,al                  
    in      al,0A1h
    mov     INT_MASK_S,al                 
DISABLE_INTERRUPTS:                             ;Запрет маскируемых и немаскируемых прерываний        
    cli                                         ;Запрет маскирумых прерываний
    in  al,70h	
	or	al,10000000b                            ;Установить 7 бит в 1 для запрета немаскируемых прерываний
	out	70h,al
	nop	
LOAD_GDT:                                       ;Заполнить глобальную таблицу дескрипторов            
    mov ax,DATA
    mov dl,ah
    xor dh,dh
    shl ax,4
    shr dx,4
    mov si,ax
    mov di,dx
WRITE_GDT:                                      ;Заполнить дескриптор GDT
    lea bx,GDT_GDT
    mov ax,si
    mov dx,di
    add ax,offset GDT
    adc dx,0
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
WRITE_CODE_RM:                                  ;Заполнить дескриптор сегмента кода реального режима
    lea bx,GDT_CODE_RM
    mov ax,cs
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
WRITE_DATA:                                     ;Записать дескриптор сегмента данных
    lea bx,GDT_DATA
    mov ax,si
    mov dx,di
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
WRITE_STACK:                                    ;Записать дескриптор сегмента стека
    lea bx, GDT_STACK
    mov ax,ss
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
WRITE_CODE_PM:                                  ;Записать дескриптор кода защищенного режима
    lea bx,GDT_CODE_PM
    mov ax,CODE_PM
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh        
    or  [bx][S_DESC.ATTRIBS],40h
WRITE_IDT:                                      ;Записать дескриптор IDT
    lea bx,GDT_IDT
    mov ax,si
    mov dx,di
    add ax,offset IDT
    adc dx,0
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh        
    mov IDTR.IDT_L,ax
    mov IDTR.IDT_H,dx
WRITE_TASK_CODE:                                ;Записать дескриптор кода второй и третей задачи
    lea bx,GDT_CS_2
    mov ax,CODE_2
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
    or  [bx][S_DESC.ATTRIBS],40H                ;32-битный сегмент
    lea bx, GDT_CS_3
    mov ax, CODE_3
    xor dh,dh
    mov dl,ah
    shl ax, 4
    shr dx, 4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
    or  [bx][S_DESC.ATTRIBS],40H           
WRITE_TASK_STACK:                               ;Записать дескрипторы сегментов стека дополнительных задач
    lea bx,GDT_SS_2
    mov ax,STCK_2
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
    lea bx,GDT_SS_3
    mov ax,STCK_3
    xor dh,dh
    mov dl,ah
    shl ax,4
    shr dx,4
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
WRITE_TSS:                                      ;Записать TSS задач                  ;
    LEA bx,GDT_TSS_MAIN
    MOV ax,si
    MOV dx,di
    ADD ax,offset TSS_MAIN
    ADC dx,0
    MOV [bx][S_DESC.BASE_L],ax
    MOV [bx][S_DESC.BASE_M],dl
    MOV [bx][S_DESC.BASE_H],dh
    lea BX, GDT_TSS_2
    mov AX, SI
    mov DX, DI
    add AX, offset TSS_2
    adc DX, 0
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh        
    lea bx,GDT_TSS_3
    mov ax,si
    mov dx,di
    add ax,offset TSS_3
    adc dx,0
    mov [bx][S_DESC.BASE_L],ax
    mov [bx][S_DESC.BASE_M],dl
    mov [bx][S_DESC.BASE_H],dh
FILL_IDT:                                       ;Заполнить таблицу дескрипторов шлюзов прерываний
    irpc    N, 0123456789ABCDEF                 ;Заполнить шлюзы 00-0F исключениями
        lea eax, EXC_0&N
        mov IDT_0&N.OFFS_L,ax
        shr eax, 16
        mov IDT_0&N.OFFS_H,ax
    endm
    irpc    N, 0123456789ABCDEF                 ;Заполнить шлюзы 10-1F исключениями
        lea eax, EXC_1&N
        mov IDT_1&N.OFFS_L,ax
        shr eax, 16
        mov IDT_1&N.OFFS_H,ax
    endm
    lea eax, TIMER_HANDLER                      ;Поместить обработчик прерывания таймера на 20 шлюз
    mov IDT_TIMER.OFFS_L,ax
    shr eax, 16
    mov IDT_TIMER.OFFS_H,ax
    lea eax, KEYBOARD_HANDLER                   ;Поместить обработчик прерывания клавиатуры на 21 шлюз
    mov IDT_KEYBOARD.OFFS_L,ax
    shr eax, 16
    mov IDT_KEYBOARD.OFFS_H,ax
    irpc    N, 234567                           ;Заполнить вектора 22-27 заглушками
        lea eax,DUMMY_IRQ_MASTER
        mov IDT_2&N.OFFS_L, AX
        shr eax,16
        mov IDT_2&N.OFFS_H, AX
    endm
    irpc    N, 89ABCDEF                         ;Заполнить вектора 28-2F заглушками
        lea eax,DUMMY_IRQ_SLAVE
        mov IDT_2&N.OFFS_L,ax
        shr eax,16
        mov IDT_2&N.OFFS_H,ax
    endm
    lgdt fword ptr GDT_GDT                      ;Загрузить регистр GDTR
    lidt fword ptr IDTR                         ;Загрузить регистр IDTR
    mov eax,cr0                                 ;Получить управляющий регистр cr0
    or  al,00000001b                            ;Установить бит PE в 1
    mov cr0,eax                                 ;Записать измененный cr0 и тем самым включить защищенный режим
OVERLOAD_CS:                                    ;Перезагрузить сегмент кода на его дескриптор
    db  0EAH
    dw  $+4
    dw  CODE_RM_DESC        
OVERLOAD_SEGMENT_REGISTERS:                     ;Переинициализировать остальные сегментные регистры на дескрипторы
    mov ax,DATA_DESC
    mov ds,ax                         
    mov es,ax                         
    mov ax,STACK_DESC
    mov ss,ax                         
    xor ax,ax
    mov fs,ax                                   ;Обнулить регистр fs
    mov gs,ax                                   ;Обнулить регистр gs
    lldt ax                                     ;Обнулить регистр LDTR - не использовать таблицы локальных дескрипторов
PREPARE_TO_RETURN:
    push cs                                     ;Сегмент кода
    push offset BACK_TO_RM                      ;Смещение точки возврата
    lea  edi,ENTER_PM                           ;Получить точку входа в защищенный режим
    mov  eax,CODE_PM_DESC                       ;Получить дескриптор кода защищенного режима
    push eax                                    ;Занести их в стек
    push edi  
PREPARE_TSS:                                    ;Подготавливаю TSS для дополнительных задач
    or  TSS_2.R_EFLAGS, 3200H                   ;Установить 3 уровень привелегий и разрешить аппаратные прерывания           
    mov TSS_2.R_CS,CS_2_DESC                    ;Установить регистр сегмента кода
    mov TSS_2.R_EIP,offset TASK_2               ;Установить регистр команд на точку входа в задачу
    mov TSS_2.R_SS, SS_2_DESC                   ;Установить сегмент стека задачи
    mov TSS_2.R_ESP,0                           ;Установить указатель стека на начало стека
    mov ax, 0                                   ;Обнулить сегментные регистры
    mov TSS_2.R_DS, AX
    mov TSS_2.R_ES, AX
    mov TSS_2.R_FS, AX
    mov TSS_2.R_GS, AX
    mov TSS_2.SS0, STACK_DESC                   ;Установить сегмент стека 0 уровня доступа
    mov TSS_2.ESP0, 500h                        ;И указатель в стеке
    or  TSS_3.R_EFLAGS,3200H                    ;Установить 3 уровень привелегий и разрешить аппаратные прерывания 
    mov TSS_3.R_CS,CS_3_DESC
    mov TSS_3.R_EIP,offset TASK_3
    mov TSS_3.R_SS, SS_3_DESC
    mov TSS_3.R_ESP,0
    mov ax, 0
    mov TSS_3.R_DS, AX
    mov TSS_3.R_ES, AX
    mov TSS_3.R_FS, AX
    mov TSS_3.R_GS, AX
    mov TSS_3.SS0, STACK_DESC
    mov TSS_3.ESP0, 600h
REINITIALIAZE_CONTROLLER_FOR_PM:                ;Переинициализировать контроллер прерываний на вектора 20h, 28h
    mov al,00010001b                            ;ICW1 - переинициализация контроллера прерываний
    out 20h,al                                  ;Переинициализируем ведущий контроллер
    out 0A0h,al                                 ;Переинициализируем ведомый контроллер
    mov al,20h                                  ;ICW2 - номер базового вектора прерываний
    out 21h,al                                  ;ведущего контроллера
    mov al,28h                                  ;ICW2 - номер базового вектора прерываний
    out 0A1h,al                                 ;ведомого контроллера
    mov al,04h                                  ;ICW3 - ведущий контроллер подключен к 3 линии
    out 21h,al       
    mov al,02h                                  ;ICW3 - ведомый контроллер подключен к 3 линии
    out 0A1h,al      
    mov al,11h                                  ;ICW4 - режим специальной полной вложенности для ведущего контроллера
    out 21h,al        
    mov al,01h                                  ;ICW4 - режим обычной полной вложенности для ведомого контроллера
    out 0A1h,al       
    mov al, 0                                   ;Размаскировать прерывания
    out 21h,al                                  ;Ведущего контроллера
    out 0A1h,al                                 ;Ведомого контроллера
ENABLE_INTERRUPTS_0:                            ;Разрешить маскируемые и немаскируемые прерывания
    in  al,70h	
	and	al,01111111b                            ;Установить 7 бит в 0 для запрета немаскируемых прерываний
	out	70h,al
	nop
    sti                                         ;Разрешить маскируемые прерывания
GO_TO_CODE_PM:                                  ;Переход к сегменту кода защищенного режима
    db 66h                                      
    retf
BACK_TO_RM:                                     ;Точка возврата в реальный режим
    cli                                         ;Запрет маскируемых прерываний
    in  al,70h	                                ;И не маскируемых прерываний
	or	AL,10000000b                            ;Установить 7 бит в 1 для запрета немаскируемых прерываний
	out	70h,AL
	nop
REINITIALISE_CONTROLLER:                        ;Переиницализация контроллера прерываний               
    mov al,00010001b                            ;ICW1 - переинициализация контроллера прерываний
    out 20h,al                                  ;Переинициализируем ведущий контроллер
    out 0A0h,al                                 ;Переинициализируем ведомый контроллер
    mov al,8h                                   ;ICW2 - номер базового вектора прерываний
    out 21h,al                                  ;ведущего контроллера
    mov al,70h                                  ;ICW2 - номер базового вектора прерываний
    out 0A1h,al                                 ;ведомого контроллера
    mov al,04h                                  ;ICW3 - ведущий контроллер подключен к 3 линии
    out 21h,al       
    mov al,02h                                  ;ICW3 - ведомый контроллер подключен к 3 линии
    out 0A1h,al      
    mov al,11h                                  ;ICW4 - режим специальной полной вложенности для ведущего контроллера
    out 21h,al        
    mov al,01h                                  ;ICW4 - режим обычной полной вложенности для ведомого контроллера
    out 0A1h,al
PREPARE_SEGMENTS:                               ;Подготовка сегментных регистров для возврата в реальный режим          
    mov GDT_CODE_RM.LIMIT,0FFFFh                ;Установка лимита сегмента кода в 64KB
    mov GDT_DATA.LIMIT,0FFFFh                   ;Установка лимита сегмента данных в 64KB
    mov GDT_STACK.LIMIT,0FFFFh                  ;Установка лимита сегмента стека в 64KB
    db  0EAH                                    ;Перезагрузить регистр cs
    dw  $+4
    dw  CODE_RM_DESC                            ;На сегмент кода реального режима
    mov ax,DATA_DESC                            ;Загрузим сегментные регистры дескриптором сегмента данных
    mov ds,ax                                   
    mov es,ax                                   
    mov fs,ax                                   
    mov gs,ax                                   
    mov ax,STACK_DESC
    mov ss,ax                                   ;Загрузим регистр стека дескриптором стека
ENABLE_REAL_MODE:                               ;Включим реальный режим
    mov eax,cr0
    and al,11111110b                            ;Обнулим 0 бит регистра cr0
    mov cr0,eax                        
    db  0EAH
    dw  $+4
    dw  CODE_RM                                 ;Перезагрузим регистр кода
    mov  al,20h  
    out  20h,al
    mov ax,STACK_A
    mov ss,ax                      
    mov ax,DATA
    mov ds,ax                      
    mov es,ax
    xor ax,ax
    mov fs,ax
    mov gs,ax
    mov IDTR.LIMIT, 3FFH                
    mov dword ptr  IDTR+2, 0            
    lidt fword ptr IDTR                 
REPEAIR_MASK:                                   ;Восстановить маски прерываний
    mov  al,20h
    out  20h,al
    mov al,INT_MASK_M
    out 21h,al                                  ;Ведущего контроллера
    mov al,INT_MASK_S
    out 0A1h,al                                 ;Ведомого контроллера
ENABLE_INTERRUPTS:                              ;Разрешить маскируемые и немаскируемые прерывания
    in  al,70h	
	and	al,01111111b                            ;Установить 7 бит в 0 для разрешения немаскируемых прерываний
	out	70h,al
    nop
    sti                                         ;Разрешить маскируемые прерывания
DISABLE_A20:                                    ;Закрыть вентиль A20
    in  al,92h
    and al,11111101b                            ;Обнулить 1 бит - запретить линию A20
    out 92h, al
EXIT:                                           ;Выход из программы
    mov ax,3h
    int 10H                                     ;Очистить видео-режим    
    lea dx,MSG_EXIT
    mov ah,9h
    int 21h                                     ;Вывести сообщение
    mov ax,4C00h
    int 21H                                     ;Выход в dos
INPUT proc near                                 ;Процедура ввода время-нахождения в защищенном режиме 
    mov ah,0ah
    xor di,di
    mov dx,offset ds:[INPUT_TIME]
    int 21h
    mov dl,0ah
    mov ah,02
    int 21h 
    mov si,offset INPUT_TIME+2 
    cmp byte ptr [si],"-" 
    jnz ii1
    mov di,1 
    inc si   
II1:
    xor ax,ax
    mov bx,10  
II2:
    mov cl,[si]
    cmp cl,0dh 
    jz ii3
    cmp cl,'0' 
    jl er
    cmp cl,'9' 
    ja er 
    sub cl,'0' 
    mul bx     
    add ax,cx  
    inc si     
    jmp ii2    
ER:   
    mov dx, offset MSG_ERROR
    mov ah,09
    int 21h
    int 20h
II3:
    ret
INPUT endp
SIZE_CODE_RM    = ($ - CODE_RM_BEGIN)           ;Лимит сегмента кода
CODE_RM ends
;Сегмент кода реального режима
CODE_PM  segment para use32
CODE_PM_BEGIN   = $
    assume cs:CODE_PM,ds:DATA,es:DATA           ;Указание сегментов для компиляции
ENTER_PM:                                       ;Точка входа в защищенный режим
    call CLRSCR                                 ;Процедура очистки экрана
    MOV  ax,TSS_MAIN_DESC
    ltr  ax                                     ;Загрузить регистр tr и заполнить TSS для главной задачи
    xor  edi,edi                                ;В edi смещение на экране
    lea  esi,MSG_HELLO_PM                       ;В esi адрес буфера
    call BUFFER_OUTPUT                          ;Вывести строку-приветствие в защищенном режиме
    add  edi,160                                ;Перевести курсор на следующую строку
    lea  esi,MSG_KEYBOARD
    call BUFFER_OUTPUT                          ;Вывести поле для вывода скан-кода клавиатуры
    mov edi,320
    lea esi,MSG_TIME
    call BUFFER_OUTPUT                          ;Вывести поле для вывода время
    mov edi,480
    mov DS:[COUNT],0
    mov edi,480
    lea esi,MSG_TASK_1                          ;Подготовить место для задач
    call BUFFER_OUTPUT
    mov edi,640
    lea esi,MSG_TASK_2
    call Buffer_OUTPUT
    mov edi,800  
    lea esi,MSG_TASK_3
    call BUFFER_OUTPUT
    mov edi,480
    mov ax,TEXT_DESC
    mov es,ax
WAITING_ESC:                                    ;Ожидание нажатия кнопки выхода из защищенного режима    
    mov al,10
    cmp ds:[KEY_PRESSED],0
    je NO_KEY
    mov al,ds:[KEY_PRESSED]
    dec al
    add al,'0'
    mov es:[di],al
    mov ds:[KEY_PRESSED],0
    add di,2
    cmp di,554
    jne NO_KEY
    mov cx,37
    mov di,480
FFLUSH:
    mov al,' '
    mov es:[di],al
    add di,2
    loop FFLUSH
    mov di,480
    mov al,ds:[KEY_PRESSED]
    dec al
    add al,'0'
    mov es:[di],al
    mov ds:[KEY_PRESSED],0
    add di,2

NO_KEY:    
    
    jmp  WAITING_ESC                            ;Если был нажат не ESC
EXIT_PM:                                        ;Точка выхода из 32-битного сегмента кода    
    db 66H
    retf                                        ;Переход в 16-битный сегмент кода
EXIT_FROM_INTERRUPT:                            ;Точка выхода для выхода напрямую из обработчика прерываний
    popad
    pop es
    pop ds
    pop eax                                     ;Снять со стека старый EIP
    pop eax                                     ;CS  
    pop eax                                     ;И EFLAGS
    sti                                         ;Обязательно, без этого обработка аппаратных прерываний отключена
    db 66H
    retf                                        ;Переход в 16-битный сегмент кода    
INCLUDE IRQ.ASM                                 ;Файл с обработчиками аппаратных прерываний
INCLUDE PROC.ASM                                ;Файл с процедурами главной задачи защищенного режима
SIZE_CODE_PM     =       ($ - CODE_PM_BEGIN)
CODE_PM  ENDS
;Сегмент данных реального/защищенного режима
DATA    segment para use16                      ;Сегмент данных реального/защищенного режима
DATA_BEGIN      = $
    ;GDT - глобальная таблица дескрипторов
    GDT_BEGIN   = $
    GDT label       word                        ;Метка начала GDT (GDT: не работает)
    GDT_0           S_DESC <0,0,0,0,0,0>                              
    GDT_GDT         S_DESC <GDT_SIZE-1,,,ACS_DATA,0,>                 
    GDT_CODE_RM     S_DESC <SIZE_CODE_RM-1,,,ACS_CODE,0,>             
    GDT_DATA        S_DESC <SIZE_DATA-1,,,ACS_DATA+ACS_DPL_3,0,>   
    GDT_STACK       S_DESC <1000h-1,,,ACS_DATA,0,>                    
    GDT_TEXT        S_DESC <2000h-1,8000h,0Bh,ACS_DATA+ACS_DPL_3,0,0> 
    GDT_CODE_PM     S_DESC <SIZE_CODE_PM-1,,,ACS_CODE+ACS_READ,0,>    
    GDT_IDT         S_DESC <SIZE_IDT-1,,,ACS_IDT,0,>                  
    GDT_CS_2        S_DESC <SIZE_CS_2-1,,,ACS_CODE+ACS_DPL_3,0,>                    ; 58
    GDT_CS_3        S_DESC <SIZE_CS_3-1,,,ACS_CODE+ACS_DPL_3,0,>                    ; 60
    GDT_SS_2        S_DESC <1000h-1,,,ACS_DATA+ACS_DPL_3,0,>                   ; 68
    GDT_SS_3        S_DESC <1000h-1,,,ACS_DATA+ACS_DPL_3,0,>                   ; 70
    GDT_TSS_MAIN    S_DESC <SIZE_TSS-1,,,ACS_TSS,0,>                                ; 78
    GDT_TSS_2       S_DESC <SIZE_TSS-1,,,ACS_TSS,0,>                                ; 80
    GDT_TSS_3       S_DESC <SIZE_TSS-1,,,ACS_TSS,0,>                                ; 88
    GDT_SIZE        = ($ - GDT_BEGIN)               ;Размер GDT
    ;Селлекторы сегментов
    CODE_RM_DESC    = (GDT_CODE_RM - GDT_0)
    DATA_DESC       = (GDT_DATA - GDT_0)+ 3  
    STACK_DESC      = (GDT_STACK - GDT_0)       
    TEXT_DESC       = (GDT_TEXT - GDT_0)+ 3
    CODE_PM_DESC    = (GDT_CODE_PM - GDT_0)     
    IDT_DESC        = (GDT_IDT - GDT_0)         
    CS_2_DESC       = (GDT_CS_2 - GDT_0)+ 3
    CS_3_DESC       = (GDT_CS_3 - GDT_0)+ 3
    SS_2_DESC       = (GDT_SS_2 - GDT_0)+ 3
    SS_3_DESC       = (GDT_SS_3 - GDT_0) + 3
    TSS_MAIN_DESC   = (GDT_TSS_MAIN - GDT_0)
    TSS_2_DESC      = (GDT_TSS_2 - GDT_0)
    TSS_3_DESC      = (GDT_TSS_3 - GDT_0)
    ;Дескрипторы задач
    TSS_MAIN        S_TSS   <>
    TSS_2           S_TSS   <>
    TSS_3           S_TSS   <>
    ;Список задач
    TASK_LIST  dw   TSS_MAIN_DESC, TSS_2_DESC, TSS_3_DESC, 0
    TASK_INDEX dw   2                               ;Номер включаемой задачи
    TASK_ADDR  df   1 dup(0)                        ;6-байтный адрес для jmp far на задачу   
    ;IDT - таблица дескрипторов прерываний
    IDTR    R_IDTR  <SIZE_IDT,0,0>                  ;Формат регистра ITDR   
    IDT label   word                                ;Метка начала IDT
    IDT_BEGIN   = $
    IRPC    N, 0123456789ABCDEF
        IDT_0&N I_DESC <0, CODE_PM_DESC,0,ACS_TRAP,0>            ; 00...0F
    ENDM
    IRPC    N, 0123456789ABCDEF
        IDT_1&N I_DESC <0, CODE_PM_DESC, 0, ACS_TRAP, 0>         ; 10...1F
    ENDM
    IDT_TIMER    I_DESC <0,CODE_PM_DESC,0,ACS_INT,0>             ;IRQ 0 - прерывание системного таймера
    IDT_KEYBOARD I_DESC <0,CODE_PM_DESC,0,ACS_INT,0>             ;IRQ 1 - прерывание клавиатуры
    IRPC    N, 23456789ABCDEF
        IDT_2&N         I_DESC <0, CODE_PM_DESC, 0, ACS_INT, 0>  ; 22...2F
    ENDM
    SIZE_IDT        =       ($ - IDT_BEGIN)
    MSG_HELLO           db "press any key to go to the protected mode",13,10,"$"
    MSG_HELLO_PM        db "wellcome in protected mode           |",0
    MSG_EXIT            db "wellcome back to real mode",13,10,"$"
    MSG_KEYBOARD        db "keyboard scan code:                  | press 'ESC' to come back to the real mode",0
    MSG_TIME            db "quantity of interrupt calls:         | go back to RM in  XXXXXXX seconds",0
    MSG_TASK_1          db "                                     | here is line for task 1",0
    MSG_TASK_2          db "                                     | here is line for task 2",0
    MSG_TASK_3          db "                                     | here is line for task 3",0
    MSG_OUTPUT_TASK_1   db 0DBh,0
    MSG_OUTPUT_TASK_2   db "  ",0
    MSG_EXC             db "exception: XX",0
    MSG_ENTER           db "enter time in protected mode: $"
    MSG_ERROR           db "incorrect error$"
    HEX_TAB             db "0123456789ABCDEF"   ;Таблица номеров исключений
    ESP32               dd  1 dup(?)            ;Указатель на вершину стека
    INT_MASK_M          db  1 dup(?)            ;Значение регистра масок ведущего контроллера
    INT_MASK_S          db  1 dup(?)            ;Значение регистра масок ведомого контроллера
    KEY_SCAN_CODE       db  1 dup(?)            ;Ска-код последней нажатой клавиши
    KEY_PRESSED         db  1 dup(0)            ;Последняя нажатая клавиша
    SECOND              db  1 dup(?)            ;Текущее значение секунд
    TIME                db  1 dup(10)           ;Время нахождения в зазищенном режиме
    COUNT               dw  1 dup(0)            ;Количество вызовов прерывания (диапазон от 0 до 65535)
    INTERVAL            db  1 dup(0)            ;Интервал между переключениями
    BUFFER_COUNT        db  8 dup(' ')          ;Буфер для вывода количества вызовов прерываинй
                        db  1 dup(0)
    BUFFER_SCAN_CODE    db  8 dup(' ')          ;Буфер для вывода скан-кода клавиатуры
                        db  1 dup(0)                
    BUFFER_TIME         db  8 dup(' ')          ;Буфер для вывода оставшегося время в защищенном режиме
                        db  1 dup(0)
    INPUT_TIME          db  6,7 dup(?)          ;Буфер для ввода время        
SIZE_DATA   = ($ - DATA_BEGIN)                  ;Размер сегмента данных
DATA    ends
;Сегмент стека реального/защищенного режима
STACK_A segment para stack
    db  1000h dup(?)
STACK_A  ends
INCLUDE TASKS.ASM                               ;Файл с двумя дополнительными задачами
end START
