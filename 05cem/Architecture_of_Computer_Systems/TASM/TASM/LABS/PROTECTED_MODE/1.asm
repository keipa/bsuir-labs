.386p
ABC_Lab_1 segment use16
    assume  cs:ABC_Lab_1, ds:ABC_Lab_1, es:ABC_Lab_1
    org 100h
start:
	Code_selector   =      0000000000001000b
	Stack_selector  =      0000000000010000b
	Data_selector   =      0000000000011000b
	Screen_selector =	   0000000000100000b
	R_Mode_Code_selector = 0000000000101000b
	R_Mode_Data_selector = 0000000000110000b
	
    mov R_Mode_SS,ss
    mov R_Mode_DS,ds
    mov R_Mode_ES,es
	
    mov R_Mode_segment,cs
    lea ax,R_Mode_entry
    mov R_Mode_offset,ax
	
; подготовка дескрипторов:
    mov bx,offset GDT + 8
    xor eax,eax
    mov edx,eax
	
    push cs
    pop ax
    shl eax,4
    mov dx,1024
	;      P DPL S Type A
    ;      1 00  1 100  0b
	mov cl,10011000b																																																																																																																																																																																								;LUL
    call    create_descriptor      ; Code
	
    lea dx, Stack_seg_start
    add eax,edx
    mov dx,1024
    mov cl,10010110b
    call    create_descriptor      ; Stack
	
    xor eax,eax
    mov ax,ds
    shl eax,4
    mov dx,0ffffh
    mov cl,10010010b
    call    create_descriptor      ; Data
	
    mov eax,0b8000h
    mov edx,4000
    mov cl,10010010b
    call    create_descriptor      ; Screen
	
    xor eax,eax
    push cs
    pop ax
    shl eax,4
    mov edx,0ffffh
    mov cl,10011010b        
    call    create_descriptor      ; R_Mode_Code 
    mov cl,10010010b
    call    create_descriptor      ; R_Mode_Data
	
	; Сегмент TSS_area для описания TSS
	mov	bx,offset GDT + TSS_area
	mov	eax,cr3
	add	eax,3 * 4096	;    EAX - базовый адрес сегмента, ему
				; будет выделена не используемая до сих
				; пор страница памяти, 3-я после страницы
				; для каталога страниц.
	mov	ebp,eax		; Временно сохраняем этот адрес.
	mov	edx,4096	; Предел сегмента
	mov	cx,92h		; CL - байт прав доступа,
				; CH - биты GDXU и старшие 4 бита предела.
	call	create_descriptor		; TSS_area

	mov	bx,offset GDT + Main_TSS
	mov	eax,ebp
	mov	edx,67h
	mov	cx,10001001b
	call	create_descriptor		; Main_TSS

	add	eax,104
	call	create_descriptor		; TSS_2

	add	eax,104
	call	create_descriptor		; TSS_3
	
	add	eax,104
	call	create_descriptor		; TSS_4

	add	eax,104
	call	create_descriptor		; TSS_5

	
    xor eax,eax
    mov edx,eax
    mov ax,ds
    shl eax,4
    lea dx,GDT
    add eax,edx
    mov GDT_adress,eax
    mov dx,55
    mov GDT_limit,dx
    cli
    lgdt GDTR
    mov R_Mode_SP,sp
	
; переход в защищённый режим:
    mov eax,cr0
    or  al,1
    mov cr0,eax
	
    db  0eah
    dw  P_Mode_entry
    dw  Code_selector
	
P_Mode_entry:
    mov ax,Screen_selector
    mov es,ax
    mov ax,Data_selector
    mov ds,ax
    mov ax,Stack_selector
    mov ss,ax
    mov sp,0
	
	xor	di,di		; Это будет первая задача (Main_TSS).
	call create_descriptor_TSS	;    Для задачи Main можно вообще не
				; определять TSS. Почему - см. далее.



	add	di,104		; Это будет вторая задача (TSS_2).
	lea	ebx,second_task_entry_point	; EIP задачи.
	mov	edx,esp				; ESP 2-й задачи.
	sub	edx,256

	call	create_descriptor_TSS



	add	di,104		; Это будет третья задача (TSS_3).
	lea	ebx,third_task_entry_point	; EIP задачи.
	mov	edx,esp				; ESP 3-й задачи.
	sub	edx,512

	call	create_descriptor_TSS
	
	add	di,104		; Это будет 4-ая задача (TSS_4).
	lea	ebx,second_task_entry_point	; EIP задачи.
	mov	edx,esp				; ESP 4-й задачи.
	sub	edx,768

	call	create_descriptor_TSS



	add	di,104		; Это будет пятая задача (TSS_5).
	lea	ebx,third_task_entry_point	; EIP задачи.
	mov	edx,esp				; ESP 5-й задачи.
	sub	edx,1024

	call	create_descriptor_TSS

; Запускаем первую задачу:

	mov	ax,Main_TSS
	ltr	ax		;    Загружаем в регистр TR селектор
				; дескриптора TSS задачи Main. Теперь текущая
				; задача - это Main_TSS.

; Чистим Busy flag Main_TSS - он установился после загрузки селектора в TR

	mov	bx,offset GDT + Main_TSS
	and	byte ptr [ bx + 5 ],11111101b

; Переход на Main_TSS

	db	0eah	; Этот код эквивалентен команде FAR JMP Main_TSS:00
	dw	00
	dw	Main_TSS

;    Вот здесь процессор сохранил контекст текущей задачи, т.е. заполнил
; поля TSS текущими значениями.

	
	
	
    lea bx, P_Mode_ZS
	mov di,3680
    call    p_print_str 
	
; возвращение в реальный режим:
    db  0eah
    dw  Pre_R_Mode_entry
    dw  R_Mode_Code_selector

	
Main_TSS:

;    А теперь процессор загрузил те же самые значения из TSS в регистры.
; Вот почему можно не определять TSS для первой задачи - процессор всё
; равно перезапишет в него текущие значения, однако тогда нужно быть
; уверенным, что поля для SSi:ESPi будут содержать нули.

;    Установка Busy flag Main_TSS - она нужна, потому что был переход с
; Main_TSS на Main_TSS командой JMP - эта команда сбрасывает флаг занятости
; старой задачи, т.е. Main_TSS.

	mov	bx,offset GDT + Main_TSS
	or	byte ptr [ bx + 5 ],10b

; Вывод строки первой задачи.

	mov	text_color,1fh
	lea	bx,TASK_1_ZS
	mov	dx,0600h
	call	p_print_str

mtss_1:
	db	9ah		; far call TSS_1:00
	dw	00
	dw	TSS_2

	db	9ah		; far call TSS_1:00
	dw	00
	dw	TSS_3

	jmp	mtss_1



second_task_entry_point:

	mov	text_color,1ah
	lea	bx,snd_task_msg
	mov	dx,0700h
	call	p_print_str 

	xor	eax,eax

step_1:
	mov	text_color,1ah
	call	put_dd_num
	inc	eax
	sub	dl,8

	iret

	jmp	step_1


third_task_entry_point:

	mov	text_color,1eh
	lea	bx,trd_task_msg
	mov	dx,0800h
	call	put_zs

	xor	eax,eax

ttep_1:
	mov	text_color,1eh
	call	put_dd_num
	dec	eax
	sub	dl,8

	iret

	jmp	ttep_1

	
Pre_R_Mode_entry:
    mov ax,R_Mode_Data_selector
    mov ss,ax
    mov ds,ax
    mov es,ax
	
    mov eax,cr0
    and al,11111110b
    mov cr0,eax
	
    db  0eah
	R_Mode_offset   dw  ?
	R_Mode_segment  dw  ?
	
R_Mode_entry:
    mov ss,R_Mode_SS
    mov ds,R_Mode_DS
    mov es,R_Mode_ES
    mov sp,R_Mode_SP
	
    sti
    int 20h
	
; переменные и таблица дескрипторов:
P_Mode_ZS 	db  "Hello, Protected Mode!!!",0
TASK_1_ZS 	db  "Task one!",0
TASK_2_ZS 	db  "Task two!",0
TASK_3_ZS 	db  "Task three!",0
TASK_4_ZS 	db  "Task four!!!",0
R_Mode_SP   dw  ?
R_Mode_SS   dw  ?
R_Mode_DS   dw  ?
R_Mode_ES   dw  ?


GDTR    	label fword
GDT_limit     dw  ?
GDT_adress    dd  ?
GDT:
    dd  ?,? ; дескрипторы:
    dd  ?,? ; код
    dd  ?,? ; стек
    dd  ?,? ; данные
    dd  ?,? ; видео
    dd  ?,? ; реальный режим
    dd  ?,? ; данные режима
TSS_area:
	dd  ?,? ; дескрипторы:
    dd  ?,? ; код
    dd  ?,? ; стек
    dd  ?,? ; данные
    dd  ?,? ; видео
    dd  ?,? ; реальный режим
    dd  ?,? ; данные режима
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; !!!!!!!!!!!!!
    db  1024 dup (?)
	
create_descriptor  proc cpp
uses eax, ecx
; DS:BX = дескриптор в GDT, EAX = адрес сегмента, EDX = предел сегмента, CL = права доступа
    push    cx
    mov cx,ax
    shl ecx,16
    mov cx,dx
    mov [bx],ecx
    shr eax,16
    mov cl,ah
    shl ecx,24
    mov cl,al
    pop ax
    mov ch,al
    mov [bx+4],ecx
    add bx,8
    ret 
create_descriptor  endp

create_descriptor_TSS		proc	near
; Создаёт 32-разрядный TSS минимального размера (104 байта - предел 67h).
; DI = указатель на TSS внутри сегмента TSS_area
; Параметры новой задачи:
; EAX = CR3
; EBX = EIP
; ECX = EFLAGS
; EDX = ESP

	push	eax
	push	bx
	push	di
	push	es

	push	eax		; Сохраняем регистры для очистки TSS.
	push	ecx
	push	di

	mov	ax,TSS_area	; ES:DI указывают на начало TSS.
	mov	es,ax

	xor	eax,eax	;    Очищаем 26 двойных слов (т.е. 104 байта)
	mov	cx,26		; в TSS. Это делается для потому, что
	cld			; большинство полей TSS будут содержать нули.
	rep	stosd

	pop	di
	pop	ecx
	pop	eax


	mov	es:[ di + 28 ],eax	; Записали CR3
	mov	es:[ di + 32 ],ebx	; EIP
	mov	es:[ di + 36 ],ecx	; EFLAGS
	mov	es:[ di + 56 ],edx	; ESP

	mov	al,8
	mov	es:[ di + 76 ],al	; CS ( = 8 = Code_selector )

	add	al,8
	mov	es:[ di + 80 ],al	; SS ( = 16 = Stack_selector )

	add	al,8
	mov	es:[ di + 84 ],al	; DS ( = 24 = Data_selector )

	pop	es
	pop	di
	pop	bx
	pop	eax

	ret

endp


p_print_str proc cpp
uses ax,bx,es,di
; DS:BX = нулевая строка, ES:DI = позиция вывода, ES - сегмент видеопамяти, DI - смещение в сегменте
    mov ah, 11100100b
p_print_str_loop:
	mov al,[bx]
    inc bx
    cmp al,0
    jz  p_print_str_end
    mov es:[ di ],ax
    add di,2
    jmp p_print_str_loop
p_print_str_end:
    ret
p_print_str endp

Stack_seg_start:
ABC_Lab_1   ends
end start 