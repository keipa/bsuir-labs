SIZE_TSS        EQU 7Eh
ACS_PRESENT     EQU 10000000B                   ;PXXXXXXX - бит присутствия, сегмент присутствует в оперативной памяти
ACS_CSEG        EQU 00011000B                   ;XXXXIXXX - тип сегмента, для данных = 0, для кода 1
ACS_DSEG        EQU 00010000B                   ;XXXSXXXX - бит сегмента, данный объект сегмент(системные объекты могут быть не сегменты)
ACS_READ        EQU 00000010B                   ;XXXXXXRX - бит чтения, возможность чтения из другого сегмента
ACS_WRITE       EQU 00000010B                   ;XXXXXXWX - бит записи, для сегмента данных разершает запись
ACS_CODE        =   ACS_PRESENT or ACS_CSEG     ;AR сегмента кода
ACS_DATA =  ACS_PRESENT or ACS_DSEG or ACS_WRITE;AR сегмента данных
ACS_STACK=  ACS_PRESENT or ACS_DSEG or ACS_WRITE;AR сегмента стека
ACS_INT_GATE    EQU 00001110B
ACS_TRAP_GATE   EQU 00001111B                   ;XXXXSICR - сегмент, подчиненный сегмент кода, доступен для чтения
ACS_IDT         EQU ACS_DATA                    ;AR таблицы IDT    
ACS_INT         EQU ACS_PRESENT or ACS_INT_GATE
ACS_TRAP        EQU ACS_PRESENT or ACS_TRAP_GATE
ACS_TSS         EQU ACS_PRESENT OR 00001001B
ACS_DPL_3       EQU 01100000B  

;Структуры данных
S_DESC  struc                         ;Структура сегментного дескриптора
    LIMIT       dw 0                  ;Лимит сегмента (15:00)    
    BASE_L      dw 0                  ;Адрес базы, младшая часть (15:0)
    BASE_M      db 0                  ;Адрес базы, средняя часть (23:16)
    ACCESS      db 0                  ;Байт доступа
    ATTRIBS     db 0                  ;Лимит сегмента (19:16) и атрибуты
    BASE_H      db 0                  ;Адрес базы, старшая часть
S_DESC  ends        
I_DESC  struc                         ;Структура дескриптора таблицы прерываний
    OFFS_L      dw 0                  ;Адрес обработчика (0:15)
    SEL         dw 0                  ;Селектор кода, содержащего код обработчика
    PARAM_CNT   db 0                  ;Параметры
    ACCESS      db 0                  ;Уровень доступа
    OFFS_H      dw 0                  ;Адрес обработчика (31:16)
I_DESC  ends        
R_IDTR  struc                         ;Структура IDTR
    LIMIT       dw 0                  
    IDT_L       dw 0                  ;Смещение биты (0-15)
    IDT_H       dw 0                  ;Смещение биты (31-16)
R_IDTR  ends
S_TSS   STRUC
    LINK        dw      0, 0          ;Дескриптор предыдущей задачи
    ESP0        dd      0             ;Указатели на стек различных уровней превилегий
    SS0         dw      0, 0          ;Необходимы для разделения стека на разные уровни доступа
    ESP1        dd      0             ;НЕЛЬЗЯ ИЗМЕНИТЬ(!)
    SS1         dw      0, 0          ;
    ESP2        dd      0             ;
    SS2         dw      0, 0          ;
    R_CR3       dd      0             ;Регистр CR3 - параметры страницы задачи
    R_EIP       dd      0             ; 
    R_EFLAGS    dd      0             ; 
    R_EAX       dd      0             ;Регистры общего назначения
    R_ECX       dd      0             ;
    R_EDX       dd      0             ;
    R_EBX       dd      0             ;
    R_ESP       dd      0             ;
    R_EBP       dd      0             ;
    R_ESI       dd      0             ;
    R_EDI       dd      0             ;
    R_ES        dw      0, 0          ;Сегментные регистры
    R_CS        dw      0, 0          ;
    R_SS        dw      0, 0          ;
    R_DS        dw      0, 0          ;
    R_FS        dw      0, 0          ;
    R_GS        dw      0, 0          ;
    R_LDTR      dw      0, 0          ;Дескриптор LDT
    TRACE       dw      0             ;Флаг трассировки сброшен - не надо генерировать прерывание 1
    IO_MAP_ADDR dw      68h           ;Адрес карты ввода/вывода - доступ к портам
    IO_MAP      db      14h dup (0)   ;Все биты сброшены - доступны все порты
S_TSS   ENDS
