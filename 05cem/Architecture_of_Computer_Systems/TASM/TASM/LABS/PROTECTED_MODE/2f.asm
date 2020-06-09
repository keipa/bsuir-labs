.386p
RM_seg segment para public "CODE" use16
    assume cs:RM_seg,ds:PM_seg,ss:stack_seg
start: 
; подготовить сегментные регистры
    push       PM_seg
    pop    ds
; проверить, не находимся ли мы уже в РМ
    mov    eax,cr0
    test       al,1
    jz     no_V86
; сообщить и выйти
    mov    dx,offset v86_msg
err_exit:
    push       cs
    pop    ds
    mov    ah,9
    int    21h
    mov    ah,4Ch
    int    21h
 
; убедиться, что мы не под Windows
no_V86:
    mov    ax,1600h
    int    2Fh
    test       al,al
    jz     no_windows
; сообщить и выйти
    mov    dx,offset win_msg
    jmp    short err_exit
 
; сообщения об ошибках при старте
v86_msg db    "Error! Processor in V86 mode!!!$"
win_msg db    "Error! Program running in Windows!$"
 
 
; итак, мы точно находимся в реальном режиме
no_windows:
; очистить экран
    mov    ax,3
    int    10h
; вычислить базы для всех дескрипторов сегментов данных
; вычисляем для 16-битного сегмента кода
    xor     ecx, ecx
    mov     eax, RM_seg
    lea     ebx, GDT_16bitCS
    call        maked
 
; вычисляем для 32-битного сегмента кода
    mov    eax,PM_seg
    lea    ebx, GDT_32bitCS
    call       maked
 
; вычисляем для 32-битного сегмента стека
    mov    eax, PM_seg
    lea    ebx, GDT_32bitSS
    call       maked
 
; вычислить линейный адрес GDT
    xor    eax,eax
    mov    ax,PM_seg
    shl    eax,4
    push       eax
    add    eax,offset GDT
    mov    dword ptr gdtr+2,eax
; загрузить GDT
    lgdt       fword ptr gdtr
; вычислить линейные адреса сегментов TSS наших двух задач
; вычисляем для TSS 0
    pop    eax
    push       eax
    mov ecx, 00000001b       ; устанавливаем метку для подпрограммы maked
    add    eax,offset TSS_0
    lea ebx, GDT_TSS0
    call maked
    
    pop    eax
 
; вычисляем для TSS 1
 
    add    eax,offset TSS_1
    lea ebx, GDT_TSS1
    call maked
 
; открыть А20
    mov    al,2
    out    92h,al
; запретить прерывания
    cli
; запретить NMI
    in     al,70h
    or     al,80h
    out    70h,al
; переключиться в РМ
    mov    eax,cr0
    or     al,1
    mov    cr0,eax
; загрузить CS
    db     66h
    db     0EAh
    dd     offset PM_entry
    dw     SEL_32bitCS
 
RM_return:
; переключиться в реальный режим RM
    mov    eax,cr0
    and    al,0FEh
    mov    cr0,eax
; сбросить очередь предвыборки и загрузить CS
    db     0EAh
    dw     $+4
    dw     RM_seg
; настроить сегментные регистры для реального режима
    mov    ax,PM_seg
    mov    ds,ax
    mov    es,ax
    mov    ax,stack_seg
    mov    bx,stack_l
    mov    ss,ax
    mov    sp,bx
; разрешить NMI
    in     al,70h
    and    al,07FH
    out    70h,al
; разрешить прерывания
    sti
; завершить программу
    mov    ah,4Ch
    int    21h
 
maked proc
; в ebx - ссылка на дескриптор
; в eax ссылка на сегмент/селектор
    cmp ecx, 00000001b
    je  if_tss
    shl    eax,4
if_tss: mov    word ptr [ebx+2],ax
    shr    eax,16
    mov    byte ptr [ebx+4],al
    ret
maked endp
 
RM_seg  ends
 
 
 
 
 
 
 
 
PM_seg segment para public "CODE" use32
    assume cs:PM_seg, ds:PM_seg, es:PM_seg
 
     x  dd  2.0; Переменная для вычисления выражения в fpu
    ; Сообщения для вывода
    first_task_load db "First task loaded!",0
    second_task_load db "Second task loaded!",0
    fpu_start db "FPU start!",0
    real_mode db "We are in real mode!$",0
; таблица глобальных дескрипторов
GDT   label    byte
           db    8 dup(0)
GDT_flatDS     db    0FFh,0FFh,0,0,0,10010010b,11001111b,0
GDT_16bitCS    db    0FFh,0FFh,0,0,0,10011010b,0,0
GDT_32bitCS    db    0FFh,0FFh,0,0,0,10011010b,11001111b,0
GDT_32bitSS    db    0FFh,0FFh,0,0,0,10010010b,11001111b,0
; сегмент TSS задачи 0 (32-битный свободный TSS)
GDT_TSS0       db    067h,0,0,0,0,10001001b,01000000b,0
; сегмент TSS задачи 1 (32-битный свободный TSS)
GDT_TSS1       db    067h,0,0,0,0,10001001b,01000000b,0
gdt_size = $ - GDT
gdtr           dw    gdt_size-1    ; размер GDT
           dd    ?         ; адрес GDT
 
 
; используемые селекторы
SEL_flatDS     equ   001000b
SEL_16bitCS    equ   010000b
SEL_32bitCS    equ   011000b
SEL_32bitSS    equ   100000b
SEL_TSS0       equ   101000b
SEL_TSS1       equ   110000b
 
; сегмент TSS_0 будет инициализирован, как только мы выполним переключение
; из нашей основной задачи. Конечно, если бы мы собирались использовать
; несколько уровней привилегий, то нужно было бы инициализировать стеки
TSS_0          db    68h dup(0)
; сегмент TSS_1. В него будет выполняться переключение, так что надо
; инициализировать все, что может потребоваться:
TSS_1          dd    0,0,0,0,0,0,0,0        ; связь, стеки, CR3
           dd    offset task_1          ; EIP
; регистры общего назначения
           dd    0,0,0,0,0,stack_l2,0,0,0B8140h ; (ESP и EDI)
; сегментные регистры
           dd    SEL_flatDS,SEL_32bitCS,SEL_32bitSS,SEL_flatDS,0,0
           dd    0              ; LDTR
           dd    0              ; адрес таблицы ввода-вывода
 
 
 
; точка входа в 32-битный защищенный режим
PM_entry:
; подготовить регистры
    xor    eax, eax
    mov    ax,SEL_flatDS
    mov    ds,ax
    mov    es,ax
    mov    ax,SEL_32bitSS
    mov    ebx,stack_l
    mov    ss,ax
    mov    esp,ebx
; загрузить TSS задачи 0 в регистр TR
    mov    ax,SEL_TSS0
    ltr    ax
; только теперь наша программа выполнила все требования к переходу
; в защищенный режим
    xor    eax, eax
    mov    edi,0B8000h      ; DS:EDI - адрес начала экрана
task_0:
; дальний переход на TSS задачи 1
 
 
    lea     bx, first_task_load; выводим первую строку
        call prints
 
    db     0EAh
    dd     0
    dw     SEL_TSS1
 
; задача 1
task_1:
    CLTS; сбрасываем бит переключения задачи
 
    finit
    fld x
    fld x
    fmul
    fld  st(0)
    fld1
    fadd
    fsqrt
    fpatan
    fild x
    fmul
 
    lea     bx, second_task_load; выводим вторую строку
        call prints
 
; дальний переход на процедуру выхода в реальный режим
    db     0EAh
    dd     offset RM_return
    dw     SEL_16bitCS
 
 
 
 
prints   proc    near
; DS:BX  строка с нулём на конце
; ES:DI = видеопамять
        push    ax
        push    bx
        push    edi
        mov ah,1Bh ;В AH  светло-циановые символы на синем фоне.
print_1: mov al,[bx]   ; Читаем байт из ZS-строки.
        inc     bx              ; Переводим указатель на следующий байт.
        cmp     al,0            ; Если байт равен 0,
        je      print_end       ; то переходим в конец процедуры.
        mov ds:[ edi ],ax    ; Иначе - записываем символ вместе с
                                ;  атрибутом в видеопамять по заданному
                                ;  смещению - цветной символ появится на
                                ;  экране.
        add     edi,2            ; Переводим указатель в видеопамяти на
                                ;  позицию следующего символа.
        jmp print_1; Повторяем процедуру для следующего байта из ZS-строки.
print_end: 
        pop edi
        pop bx
        pop ax
        ret
prints endp
PM_seg  ends
 
 
stack_seg segment para stack "STACK"
stack_start    db    100h dup(?)    ; стек задачи 0
stack_l = $ - stack_start
stack_task2    db    100h dup(?)    ; стек задачи 1
stack_l2 = $ - stack_start
stack_seg ends
    end    start