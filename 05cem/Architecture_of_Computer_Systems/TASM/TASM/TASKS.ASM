CODE_2  segment para use32          ;Сегмент кода второй задачи - выводит красно-белую полосу слева-направо
        assume  cs:CODE_2
CS_2_BEGIN  = $
TASK_2  proc
    mov ax,DATA_DESC
    mov ds,ax
    mov ax,TEXT_DESC
    mov es,ax
TASK_2_START:    
    mov edi,640
    mov ecx,37
TASK_2_LOOP_FILL:                   ;Цикл по выводу красной полосы
    mov al,0DBh
    mov es:[di],al
    inc di
    mov al,74h
    mov es:[di],al
    inc di
    mov bx,cx
    mov cx,60000
    TASK_2_SLEEP_0:
        rept    90
            nop
        endm
    loop TASK_2_SLEEP_0
    mov cx,bx
loop TASK_2_LOOP_FILL
    mov edi,640
    mov ecx,37
TASK_2_LOOP_CLEAN:                  ;Цикл по выводу белой полосы
    mov al,' '
    mov es:[di],al
    inc di
    mov al,74h
    mov es:[di],al
    inc di
    mov bx,cx
    mov cx,60000
    TASK_2_SLEEP_1:
        rept    90
            nop
        endm
    loop TASK_2_SLEEP_1
    mov cx,bx
loop TASK_2_LOOP_CLEAN  
TASK_2_END:
    jmp TASK_2_START          
TASK_2  endp
SIZE_CS_2   = ($ - CS_2_BEGIN)
CODE_2  ends
CODE_3  segment para use32          ;Сегмент кода 3 задачи - выводит зелено-желтую полосу справа-налево
        assume cs:CODE_3
CS_3_BEGIN  = $
TASK_3  proc near
    mov ax,DATA_DESC
    mov ds,ax
    mov ax,TEXT_DESC
    mov es,ax
TASK_3_START:    
    mov edi,872
    mov ecx,37  
TASK_3_LOOP_FILL:                   ;Цикл по выводу зеленой полосы
    mov al,0DBh
    mov es:[di],al
    inc di
    mov al,46
    mov es:[di],al
    sub di,3
    mov bx,cx
    mov cx,60000
    TASK_3_SLEEP_0:
        rept    90
            nop
        endm
    loop TASK_3_SLEEP_0
    mov cx,bx
loop TASK_3_LOOP_FILL
    mov edi,872
    mov ecx,37
TASK_3_LOOP_CLEAN:                  ;Цикл по выводу желтой полосы
    mov al,' '
    mov es:[di],al
    inc di
    mov al,46
    mov es:[di],al
    sub di,3
    mov bx,cx
    mov cx,60000
    TASK_3_SLEEP_1:
        rept    90
            nop
        endm
    loop TASK_3_SLEEP_1
    mov cx,bx
loop TASK_3_LOOP_CLEAN  
TASK_3_END:
    jmp TASK_3_START          
TASK_3  endp
SIZE_CS_3   = ($ - CS_3_BEGIN)
CODE_3  ends
STCK_2  segment para
        db      1000h DUP (?)
STCK_2  ends
STCK_3  segment para
        db      1000h DUP (?)
STCK_3  ends
