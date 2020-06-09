include	pmode_6.lib
;---------------------------------------------------------------------------
.386p
pmode segment use16
	assume	cs:pmode, ds:pmode, es:pmode

	org	100h

main		proc	far
start:
;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
; Определяем селекторы как константы. У всех у них биты TI = 0 (выборка
; дескрипторов производится из GDT), RPL = 00B - уровень привилегий - нулевой.

IDT_descr_max_n	= 20h	; Число максимально используемых дескрипторов в
			;  системе (при инициализации определены только
			;  первые 6).

IDT_descr_n	= 32h	; Число дескрипторов в IDT (20h - для исключений,
			;  10h - для IRQ и 2 - для программных прерываний)


Code_selector	=  8
Stack_selector	= 16
Data_selector	= 24
Screen_selector = 32
R_Mode_Code	= 40
R_Mode_Data	= 48
;----------------------------------------------------------------------------

	call	store_R_Mode_IRQ_Mask

	call	what_cpu

	mov	R_Mode_SS,ss
	mov	R_Mode_DS,ds
	mov	R_Mode_ES,es
	mov	R_Mode_FS,fs
	mov	R_Mode_GS,gs

	mov	R_Mode_segment,cs
	lea	ax,R_Mode_entry
	mov	R_Mode_offset,ax

	mov	bx,offset GDT + 8
	xor	eax,eax
	mov	edx,eax

	push	cs
	pop	ax

	shl	eax,4
	mov	dx,0FFFFh		; Предел сегмента кода = 64К - 1
	mov	cl,10011000b
	call	set_descriptor		; Code

	lea	dx,Stack_seg_start
	add	eax,edx
	mov	dx,1024
	mov	cl,10010110b
	call	set_descriptor		; Stack

	xor	eax,eax
	mov	ax,ds
	shl	eax,4
	mov	dx,0ffffh
	mov	cl,10010010b
	call	set_descriptor		; Data

	mov	eax,0b8000h
	mov	edx,4000
	mov	cl,10010010b
	call	set_descriptor

; Готовим дополнительные дескрипторы для возврата в R-Mode:

	xor	eax,eax

	push	cs
	pop	ax

	shl	eax,4

	mov	edx,0ffffh
	mov	cl,10011010b
	call	set_descriptor		; R_Mode_Code

	mov	cl,10010010b
	call	set_descriptor		; R_Mode_Data

; Устанавливаем IDTR:

	xor	eax,eax
	mov	edx,eax
	mov	ax,ds
	shl	eax,4		; ЕAX = физический адрес сегмента данных

	lea	dx,IDT
	add	edx,eax
	mov	IDT_adr,edx

	mov	dx,IDT_descr_n * 8 - 1
	mov	IDT_lim,dx

; Устанавливаем GDTR:

	lea	dx,GDT
	add	edx,eax
	mov	GDT_adr,edx

	mov	dx,63		; Предел GDT = 8 * (1 + 7) - 1
	mov	GDT_lim,dx

	cli

	lidt	IDTR
	lgdt	GDTR

	mov	R_Mode_SP,sp

; Переходим в защищённый режим:

	mov	eax,cr0
	or	al,1
	mov	cr0,eax


; Процессор в защищённом режиме

	db	0eah
	dw	P_Mode_entry
	dw	Code_selector

;----------------------------------------------------------------------------
P_Mode_entry:

	mov	ax,Screen_selector
	mov	es,ax

	mov	ax,Data_selector
	mov	ds,ax

	mov	ax,Stack_selector
	mov	ss,ax
	mov	sp,0

; Выводим ZS-строку:

	mov	text_color,1bh

	lea	bx,Start_P_Mode_ZS
	mov	dx,0300h
	call	put_zs

; Работа программы в защищённом режиме (здесь - только вывод строки):

	call	P_Mode_redirect_IRQ

	call	setup_IDT

	lea	bx,P_Mode_ZS
	mov	dx,0400h
	call	put_zs

; Демонстрация работы прерывания по таймеру

	in	al,21h
	and	al,11111100b	; Размаскируем прерывания таймера
				;  и клавиатуры.
	out	21h,al

	mov	al,0
	mov	timer_count,al		; Сбрасываем наши счётчики
	mov	timer_sec,al

	xor	eax,eax		; Число в EAX будет выводится на экран
				;  в бесконечном цикле.

	sti		; Разрешаем аппаратные прерывания. Теперь наш
			;  бесконечный цикл будет "рваться" таймером и
			;  клавиатурой и остаётся только следить за
			;  счётчиками.
timer_demo_start:

	mov	dx,1400h	; В 20-ю строку, нулевую позицию ...
	call	put_dd_num	; ... будет выводится dd-число.
	inc	eax		; А здесь оно увеличивается.

	cmp	timer_count,18
	jb	timer_demo_start	; Выводим число, пока timer_count < 18

	mov	timer_count,0		; timer_count достиг 18.
					;  Сбрасываем его.

	push	ax
	mov	al,timer_sec
	inc	al
	mov	timer_sec,al
	mov	dx,1410h
	call	put_db_num		; Выводим число секунд.

	pop	ax

	cmp	timer_sec,4
	jbe	timer_demo_start	; Продолжаем цикл, если timer_sec < 4

	jmp	Return_to_R_Mode

;----------------------------------------------------------------------------
Return_to_R_Mode:

	cli

	call	R_Mode_redirect_IRQ

	xor	eax,eax
	mov	IDT_adr,eax
	dec	ax		; AX = -1 = FFFFh
	mov	IDT_lim,ax

; Возвращаемся в режим реальных адресов.

	db	0eah
	dw	Pre_R_Mode_entry
	dw	R_Mode_Code

Pre_R_Mode_entry:
	mov	ax,R_Mode_Data
	mov	ss,ax
	mov	ds,ax
	mov	es,ax
	mov	fs,ax
	mov	gs,ax

	lidt	IDTR

; 4. Сбросить флаг PE в CR0.

	mov	eax,cr0
	and	al,0feh
	mov	cr0,eax

; 5. Выполнить команду far jump на программу режима реальных адресов.

		db	0eah
R_Mode_offset	dw	?
R_Mode_segment	dw	?

R_Mode_entry:
; 6. Загрузить в регистры SS, DS, ES, FS и GS необходимые значения или 0.

	mov	ss,R_Mode_SS
	mov	ds,R_Mode_DS
	mov	es,R_Mode_ES
	mov	fs,R_Mode_FS
	mov	gs,R_Mode_GS

; 7. Разрешить прерывания (STI).

	mov	sp,R_Mode_SP

	sti

; Выводим ZS-строку "Back to real address mode..."

	lea	bx,R_Mode_ZS
	mov	ax,0b800h
	mov	es,ax
	mov	di,800
	call	putzs

	exitcode 0

	int	20h

;----------------------------------------------------------------------------
what_cpu	proc	near
; Определение типа процессора и наличия в нём APIC.

	pushf
	pop	ax

	or	ah,0f0h		; Устанавливаем биты 12..15 в FLAGS

	push	ax
	popf

	pushf
	pop	ax

	mov	al,ah
	shr	al,4
	and	al,1111b	; сбрасываем биты 3..7

	cmp	al,1111b
	je	wcpu_1

	cmp	al,0
	je	wcpu_2

	cmp	al,0111b
	je	wcpu_3


wcpu_1:
; Процессор - 8086
; Программа работать не будет

wcpu_2:
; Процессор - i286
; Программа тоже работать не будет

	int	20h		; Возврат в MS-DOS.

wcpu_3:
; 32-разрядный процессор

	pushfd
	pop	eax
	mov	edx,eax
	mov	ebx,eax		; Копия

	btc	eax,18		; Инвертируем бит 18
	push	eax
	popfd

	pushfd
	pop	eax

	mov	ecx,40000h	; Устанавливаем в ECX 18-й бит
	and	eax,ecx		; Обнуляем в EAX и EDX все биты, кроме 18.
	and	edx,ecx

	cmp	eax,edx
	je	wcpu_3_1

	shl	ecx,3		; В ECX установлен только 21-й бит

	mov	eax,ebx
	btc	eax,21		; Инвертируем бит 21

	push	eax
	popfd

	pushfd
	pop	eax

	and	eax,ecx		; Обнуляем в EAX и EBX все биты, кроме 21.
	and	ebx,ecx

	cmp	eax,ebx
	jne	wcpu_4

; Процессор - раняя версия i486, не поддерживающая команду CPUID

wcpu_3_1:
; Процессор - i386

	mov	al,0
	jmp	wcpu_end

wcpu_4:
; Процессор может выполнить команду CPUID

	xor	ecx,ecx
	mov	cl,1		; ECX = 1 - номер запроса команды CPUID
	db	0fh, 0a2h	; Код команды CPUID

; EDX = Информация о технологиях (Feature Information)

	test	dh,10b		; 9-й бит EDX установлен ?
	jne	wcpu_5

	mov	al,0
	jmp	wcpu_end

wcpu_5:
	mov	al,1

wcpu_end:
	mov	APIC_presence,al

	ret

endp
;----------------------------------------------------------------------------
stopper:
; AL = номер исключения
; CF = 1/0 - код ошибки есть / нет

	mov	text_color,1ah
	mov	cl,al		; Сохраняем в CL номер исключения

	mov	al,0		; AL = признак наличия кода ошибки
				;  (1/0 - есть / нет).
	jnc	stop_1

	mov	al,1

stop_1:
	xor	ebx,ebx
	mov	bx,ss		; EBX = BX = селектор стека
	lar	edx,ebx		; EDX = старшая половина дескриптора
				;  сегмента стека.
	shr	edx,22
	test	dl,1		; Проверяем бит D (размерность сегмента
				;  16 или 32 бит).
	jnz	stop_3

 ; стек - 16-разрядный

	cmp	al,1		; Код ошибки есть?
	jne	stop_2

	pop	ax		; Error code
	mov	dx,0747h
	call	put_dw_num

stop_2:
	pop	ax		; IP
	mov	dx,0647h
	call	put_dw_num

	pop	ax		; CS
	mov	dx,0547h
	call	put_dw_num

	pop	ax		; FLAGS
	mov	dx,0447h
	call	put_dw_num

	jmp	stop_5

stop_3:
 ; стек - 32-разрядный

	cmp	al,1		; Код ошибки есть?
	jne	stop_4

	pop	eax		; Error Code
	mov	dx,0747h
	call	put_dd_num

stop_4:
	pop	eax		; EIP
	mov	dx,0647h
	call	put_dd_num

	pop	eax		; CS
	mov	dx,0547h
	call	put_dd_num

	pop	eax		; EFLAGS
	mov	dx,0447h
	call	put_dd_num

stop_5:
	mov	text_color,1fh

	mov	dx,0347h
	mov	al,cl
	call	put_db_num	; Выводим номер исключения, переданный в
				;  процедуру в регистре AL.

	mov	text_color,1bh

	lea	bx,exept_mess_1
	mov	dx,033bh
	call	put_zs		; "Exeption:"

	mov	dx,043bh
	call	put_zs		; "EFLAGS:"

	mov	dx,053bh
	call	put_zs		; "CS:"

	mov	dx,063bh
	call	put_zs		; "EIP:"

	mov	dx,073bh
	call	put_zs		; "Error Code:"

	jmp	Return_to_R_Mode	; Выход в R-mode

;----------------------------------------------------------------------------
put_db_num	proc	near
; Вывод в шестнадцатиричном виде db-числа с атрибутом text_color в позицию X,Y.
; AL = число
; DX = позиция вывода: DL = X, DH = Y
; Возврат: DL += 2

	push	eax
	push	cx
	push	dx
	push	di
	push	es

	call	get_adr		; Преобразование координат вывода (DX) в адрес
				;  видеопамяти (ES:DI).

	mov	dl,al		; Временно сохраняем выводимое число

	and	al,0fh		; AL = младший hex-разряд числа.
	cmp	al,9		; Если число меньше 0Ah, то добавляем к
				;  нему 30h, иначе - 37h.
	jbe	pdbn_1

	add	al,7

pdbn_1:
	add	al,30h
	mov	ah,text_color

	shl	eax,16		; Смещаем готовый атрибут и символ в старшую
				;  часть EAX для того, чтобы потом одной
				;  командой вывести оба символа.

	mov	al,dl
	shr	al,4		; AL = старший hex-разряд выводимого числа.

	cmp	al,9		; Если число меньше 0Ah, то добавляем к
				;  нему 30h, иначе - 37h.
	jbe	pdbn_2

	add	al,7

pdbn_2:
	add	al,30h
	mov	ah,text_color

	mov	es:[ di ],eax	; Выводим оба символа на экран.

	pop	es
	pop	di
	pop	dx
	pop	cx
	pop	eax

	add	dl,2		; Увеличиваем координату вывода X на 2, для
				;  обеспечения "автоматического" перевода
				;  текущей позиции вывода.
	ret

endp
;----------------------------------------------------------------------------
put_dw_num	proc	near
; Вывод в шестнадцатиричном виде dw-числа с атрибутом text_color в позицию X,Y.
; AX = число
; DX = позиция вывода: DL = X, DH = Y
; Возврат: DL += 4

	ror	ax,8		; Поменяли местами AL и AH.
	call	put_db_num	; Выводим содержимое AL - это будут два
				;  старших разряда 4-разрядного dw hex-числа.
	ror	ax,8		; Поменяли обратно местами AL и AH.
	call	put_db_num	; Выводим два младших разряда заданного числа

	ret

endp
;----------------------------------------------------------------------------
put_dd_num	proc	near
; Вывод в шестнадцатиричном виде dd-числа с атрибутом text_color в позицию X,Y.
; EAX = число
; DX = позиция вывода: DL = X, DH = Y
; Возврат: DL += 8

	ror	eax,16		; Готовим для вывода старшую часть dd-числа
	call	put_dw_num	; ... и выводим её.
	ror	eax,16		; Готовим для вывода младшую часть dd-числа
	call	put_dw_num	; ... выводим и её.

	ret

endp
;----------------------------------------------------------------------------
get_adr		proc	near
; Преобразование координат вывода в адрес
; DX = позиция вывода: DL = X, DH = Y
; Возврат: ES:DI = адрес вывода в видеопамяти текстового режима

	push	dx

	mov	di,Screen_selector
	mov	es,di

	movzx	di,dl		; DI = DL
	add	di,di		; DI = DI*2 = DL*2
	movzx	dx,dh		; DX = DH
	shl	dx,5
	add	di,dx
	shl	dx,2
	add	di,dx		; DI += DX * 2^5 + DX * 2^7
				;  или DI += DX * 160.
	pop	dx

	ret

endp
;----------------------------------------------------------------------------
put_zs	proc	near
; Вывод ZS-строки (ZS = Zero-String - строка, оканчивающаяся нулём)
; Переменная text_color содержит атрибут цвета для вывода.
; DS:BX = строка
; Возврат: DL += длина строки
;	   DS:BX указывает на следующий после 0 байт.

	push	ax

	mov	ah,text_color
	call	get_adr		; Преобразование координат вывода в адрес
				;  видеопамяти.
pzs_start:
	mov	al,[ bx ]
	inc	bx
	cmp	al,0		; Символ для вывода = 0?
	je	pzs_end		; Если да, то выход...

	stosw			; ... иначе - вывод на экран.
	jmp	pzs_start

pzs_end:
	pop	ax

	ret

endp
;----------------------------------------------------------------------------
store_R_Mode_IRQ_Mask	proc	near
; Сохраняет значение маски IRQ в переменную R_Mode_IRQ_Mask для корректного
;  восстановления IRQ при возврате в R-Mode.

	in	al,0a1h
	mov	ah,al
	in	al,21h
	mov	R_Mode_IRQ_Mask,ax

	ret

endp
;----------------------------------------------------------------------------
init_set_descriptor
init_putzs

init_P_Mode_redirect_IRQ
init_R_Mode_redirect_IRQ
init_redirect_IRQ

init_set_IDT_descriptor
init_set_int_IDT_descriptor
init_set_trap_IDT_descriptor

init_handlers
init_setup_IDT

init_disable_APIC
init_enable_APIC
;----------------------------------------------------------------------------

; ZS-строка для вывода при входе в P-Mode:
Start_P_Mode_ZS:	db	"Entering to protected mode...",0

; ZS-строка для вывода при работе в P-Mode:
P_Mode_ZS:	db	"Working in P-mode...",0

; ZS-строка для вывода в R-Mode:
R_Mode_ZS:	db	"Back to real address mode...",0

;----------------------------------------------------------------------------
; Сообщения заглушек исключений
exept_mess_1	db	'Exeption:',0
exept_mess_2	db	'EFLAGS:',0
exept_mess_3	db	'CS:',0
exept_mess_4	db	'EIP:',0
exept_mess_5	db	'Error Code:',0
;exept_mess_	db	'',0
;exept_mess_	db	'',0
;----------------------------------------------------------------------------
text_color	db	?
;----------------------------------------------------------------------------
APIC_presence	db	?	; 1/0 - APIC есть / нет
R_Mode_IRQ_Mask	dw	?
;----------------------------------------------------------------------------
timer_count	db	?
timer_sec	db	?
;----------------------------------------------------------------------------
R_Mode_SP	dw	?
R_Mode_SS	dw	?
R_Mode_DS	dw	?
R_Mode_ES	dw	?
R_Mode_FS	dw	?
R_Mode_GS	dw	?
;----------------------------------------------------------------------------
; Образ регистра IDTR:
IDTR	label	fword
IDT_lim		dw	?
IDT_adr		dd	?

; Образ регистра GDTR:

GDTR	label	fword
GDT_lim		dw	?
GDT_adr		dd	?
;----------------------------------------------------------------------------
IDT:
	dq	IDT_descr_n dup (?)
;----------------------------------------------------------------------------
GDT:
	dq	IDT_descr_max_n dup (?)
;----------------------------------------------------------------------------
	db	1024 dup (?)	; Зарезервировано для стека.
Stack_seg_start:	; Последняя метка программы - отсюда будет расти стек.
;----------------------------------------------------------------------------
main		endp
	pmode	ends
	end	start
