so	equ	small offset
	.386p
RM_seg segment para public 'CODE' use16
	assume cs:RM_seg,ds:PM_seg,ss:stack_seg
start:

old_mask1 db 0	
old_mask2 db 0	
	

	push	PM_seg
	pop	ds
;проверить не находимся ли уже в PM
	mov	eax,cr0
	test	al,1
	jz	no_V86
;если да, то сообщить и выйти
	mov	dx,offset v86_msg
err_exit:
	push	cs
	pop	ds
	mov	ah,9
	int	21h
	mov	ah,4Ch
	int	21h
;убедиться, что мы не под Windows
no_V86:
	mov	ax,1600h
	int	2Fh
	test	al,al
	jz	no_windows
;если да, то сообщить и выйти
	mov	dx,offset win_msg
	jmp short err_exit
;сообщения об ошибках при старте
v86_msg	db	"Процесоор в режиме V86 - нельзя переключиться в PM$"
win_msg db	"Программа под виндовс - нет доступа к нулевому кольцу$"

;итак, мы точно в реальном режиме
no_windows:

	cli
;считаем базы для дескрипторов сегментов
	xor	eax,eax
	mov	ax,RM_seg
	shl	eax,4
	mov	word ptr GDT_16bitCS+2,ax
	shr	eax,16
	mov	byte ptr GDT_16bitCS+4,al
	mov	ax,PM_seg
	shl	eax,4
	mov	word ptr GDT_32bitCS+2,ax
	shr	eax,16
	mov	byte ptr GDT_32bitCS+4,al
	mov	ax,stack_seg
	shl	eax,4
	mov	word ptr GDT_32bitSS+2,ax
	shr eax,16
	mov	byte ptr GDT_32bitSS+4,al
	
;считаем линейный адрес GDT
	xor	eax,eax
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset GDT
	mov	dword ptr gdtr+2,eax
;загружаем GDT
	lgdt	fword ptr gdtr

;cчитаем линейный адрес IDT
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset IDT
	mov	dword ptr idtr+2,eax
;загружаем IDT
	lidt	fword ptr idtr	
	
;считаем линейные адреса сегментов TSS
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset TSS_start
	mov	word ptr GDT_TSSs+2,ax
	shr	eax,16
	mov	byte ptr GDT_TSSs+4,al
	
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset TSS_i
	mov	word ptr GDT_TSSi+2,ax
	shr	eax,16
	mov	byte ptr GDT_TSSi+4,al
	
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset TSS_1
	mov	word ptr GDT_TSS1+2,ax
	shr	eax,16
	mov	byte ptr GDT_TSS1+4,al
	
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset TSS_2
	mov	word ptr GDT_TSS2+2,ax
	shr	eax,16
	mov	byte ptr GDT_TSS2+4,al
	
	mov	ax,PM_seg
	shl	eax,4
	add	eax,offset TSS_3
	mov	word ptr GDT_TSS3+2,ax
	shr	eax,16
	mov	byte ptr GDT_TSS3+4,al
	
;открываем линию А20 http://ru.osdev.wikia.com/wiki/%D0%92%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D0%B5_%D0%BB%D0%B8%D0%BD%D0%B8%D0%B8_A20
	mov	al,2
	out	92h,al

	cli
;запрет NMI
	in	al,70h
	or	al,80h
	out	70h,al
	
; Сохранение регистров маски контроллеров
	in      al, 021h
	mov     cs:old_mask1, al	; запоминаем старые обработчики с ведущего
	in      al, 0A1h
	mov     cs:old_mask2, al	; и с ведомого
	
; Инициализация контроллеров прерываний
	mov		bl,	20h	 ; номер обработчика для IRQ0
	mov		bh,	28h	 ; номер обработчика для IRQ8	
	call	init_pic	
	
	mov     al, 11111100b ; Разрешаем прерывания IRQ0 (таймер)    
	out     021h, al
	mov     al, 11111111b ; На SLAVE запрещаем все прерывания      
	out     0A1h, al
	
; переключиться в PM
	mov	eax,cr0
	or	al,1
	mov	cr0,eax
; загрузить CS
	db	66h
	db	0EAh
	dd	offset PM_entry
	dw	SEL_32bitCS

RM_return:
	cli
	
	mov		bl,	08h  ; номер обработчика для IRQ0
	mov		bh,	70h  ; номер обработчика для IRQ8
	call	init_pic ; инициализация обоих контроллеров
	
	mov     al, cs:old_mask1 ; восстановление сохранённых регистров масок
	out     021h, al
	mov     al, cs:old_mask2 
	out     0A1h, al

; переключиться в реальный режим RM
	mov	eax,cr0
	and	al,0FEh
	mov	cr0,eax
; сбросить очередь предвыборки и загрузить CS
	db	0EAh
	dw	$+4
	dw	RM_seg
; настроить сегментные регистры для реального режима
	mov	ax,PM_seg
	mov	ds,ax
	mov	es,ax
	mov	ax,stack_seg
	mov	bx,stack_l1
	mov	ss,ax
	mov	sp,bx
	
; загрузить IDTR для реального режима
	mov	ax,PM_seg
	mov	ds,ax
	lidt	fword ptr idtr_real
	
; разрешить NMI
	in	al,70h
	and	al,07FH
	out	70h,al
; разрешить прерывания
	sti
; завершить программу
	mov	ah,4Ch
	int	21h
	
	; Инициализация обоих контроллеров прерываний
init_pic proc		
	push eax
	mov al, 11h	 ; ICW1
	out 20h, al	 ; в MASTER
	out 0A0h, al ; в SLAVE
	
	mov al, bl   ; ICW2 - номер обработчика для IRQ0
	out 21h, al	 ; в MASTER	
	mov al, bh   ; ICW2 - номер обработчика для IRQ8    			
	out 0A1h, al ; в SLAVE
	
	mov al, 04h  ; ICW3 - выход 2, к которому подключен SLAVE PIC
	out 21h, al  ; в MASTER	
	mov al, 02h  ; ICW3 - номер выхода ведущего контроллера (2) 
	out 0A1h, al ; в SLAVE
	
	mov al, 01h  ; ICW4 для первого и второго контроллера
	out 021h, al
	out 0A1h, al
	pop eax
	ret
init_pic endp	
	
RM_seg ends

PM_seg segment para public 'CODE' use32
	assume	cs:PM_seg

; таблица глобальных дескрипторов
GDT	label	byte
			db	8 dup(0)
GDT_flatDS	db	0FFh,0FFh,0,0,0,10010010b,11001111b,0
GDT_16bitCS	db	0FFh,0FFh,0,0,0,10011010b,0,0
GDT_32bitCS	db	0FFh,0FFh,0,0,0,10011010b,11001111b,0
GDT_32bitSS	db	0FFh,0FFh,0,0,0,10010010b,11001111b,0

GDT_TSSs	db	067h,0,0,0,0,10001001b,01000000b,0 ; сегмент TSS стартовой задачи (32-битный свободный TSS)
GDT_TSS1	db	067h,0,0,0,0,10001001b,01000000b,0 ; сегмент TSS задачи 1 (32-битный свободный TSS)
GDT_TSS2	db	067h,0,0,0,0,10001001b,01000000b,0 ; сегмент TSS задачи 2 (32-битный свободный TSS)
GDT_TSS3	db	067h,0,0,0,0,10001001b,01000000b,0 ; сегмент TSS задачи 3 (32-битный свободный TSS)
GDT_TSSi	db	067h,0,0,0,0,10001001b,01000000b,0 ; сегмент TSS задачи-диспетчера (32-битный свободный TSS)

gdt_size = $-GDT
gdtr	dw	gdt_size-1	; размер GDT
	dd	?		; адрес GDT
; используемые селекторы
SEL_flatDS equ	 0001000b
SEL_16bitCS equ	 0010000b
SEL_32bitCS equ	 0011000b
SEL_32bitSS equ	 0100000b
SEL_TSSs equ	 0101000b
SEL_TSS1 equ	 0110000b
SEL_TSS2 equ	 0111000b
SEL_TSS3 equ	 1000000b
SEL_TSSi equ	 1001000b

; таблица дескрипторов прерываний IDT
IDT	label	byte

; INT 00 - 1F
	dw    13 dup( small offset int_handler,SEL_32bitCS,8E00h,0)
	dw    small offset int13_handler,SEL_32bitCS,8E00h,0 ;обработчик ошибки защиты памяти (возвращает ошибку в стеке)
	dw    18 dup( small offset int_handler,SEL_32bitCS,8E00h,0)

; INT 20 (irq0)
	dw 0, SEL_TSSi
	db 0
	db 10000101b
	dw 0  ; шлюз задачи 
; INT 21 (irq1)
	dw	so irq1_handler,SEL_32bitCS,8E00h,0
; INT 22h - 27h (IRQ2 - IRQ8)
	dw	6 dup(so irq0_7_handler,SEL_32bitCS,8E00h,0)
; INT 28h - 2Fh (IRQ8 - IRQ15)
	dw	8 dup(so irq8_15_handler,SEL_32bitCS,8E00h,0)
; INT 30h - FFh;
	dw	0D0h dup(so int_handler,SEL_32bitCS,8E00h,0)

idt_size = $-IDT			; размер IDT
idtr	dw	idt_size-1		; лимит IDT
	dd	?			; линейный адрес начала IDT
; содержимое регистра IDTR в реальном режиме
idtr_real dw	3FFh,0,0

;--------------------------------------------------------------------------
;управление задачами
;--------------------------------------------------------------------------
; сегмент TSS_0 инициализировать смысла нет, в него мы не вернёмся никогда
TSS_start	db	68h dup(0)
; сегмент TSS_1
TSS_1	dd	0,0,0,0,0,0,0,0			; связь, стеки, CR3
	dd	offset task_1			; EIP
; регистры общего назначения
	dd	0,0,0,0,0,stack_l1,0,0,0B8140h	; (ESP и EDI) 
; сегментные регистры 
	dd	SEL_flatDS,SEL_32bitCS,SEL_32bitSS,SEL_flatDS,0,0
	dd	0		; LDTR
	dd	0		; адрес таблицы ввода-вывода
	
TSS_2	dd	0,0,0,0,0,0,0,0			; связь, стеки, CR3
	dd	offset task_2			; EIP
; регистры общего назначения
	dd	0,0,0,0,0,stack_l2,0,0,0B8140h	; (ESP и EDI) 
; сегментные регистры 
	dd	SEL_flatDS,SEL_32bitCS,SEL_32bitSS,SEL_flatDS,0,0
	dd	0		; LDTR
	dd	0		; адрес таблицы ввода-вывода
	
TSS_3	dd	0,0,0,0,0,0,0,0			; связь, стеки, CR3
	dd	offset task_3			; EIP
; регистры общего назначения
	dd	0,0,0,0,0,stack_l3,0,0,0B8140h	; (ESP и EDI) 
; сегментные регистры 
	dd	SEL_flatDS,SEL_32bitCS,SEL_32bitSS,SEL_flatDS,0,0
	dd	0		; LDTR
	dd	0		; адрес таблицы ввода-вывода

TSS_i	dd	0,0,0,0,0,0,0,0			; связь, стеки, CR3
	dd	offset switch_task			; EIP
; регистры общего назначения
	dd	0,0,0,0,0,stack_l4,0,0,0B8140h	; (ESP и EDI) 
; сегментные регистры 
	dd	SEL_flatDS,SEL_32bitCS,SEL_32bitSS,SEL_flatDS,0,0
	dd	0		; LDTR
	dd	0		; адрес таблицы ввода-вывода	
	
; точка входа в 32-битный защищенный режим
PM_entry:

; подготовить регистры
	mov ecx, 20000h
	loop $
	xor	eax,eax
	mov	ax,SEL_flatDS
	mov	ds,ax
	mov	es,ax
	mov	ax,SEL_32bitSS
	mov	ebx,stack_l1
	mov	ss,ax
	mov	esp,ebx
	
	
; загрузить TSS стартовой задачи в регистр TR
	mov	ax,SEL_TSSs
	ltr	ax

	xor	eax,eax


task_start:
;принудительно ставим BUSY в TSS стартовой задачи
	mov	ebx,offset GDT + SEL_TSSs
	or	byte ptr [ ebx + 5 ],10b
;разлочиваем таймер
	in	al,21h
	and	al,11111110b
	out	21h,al
;для отладки, что дошли до этого места	
	mov	edi,0B8000h	; DS:EDI - адрес начала экрана
	mov fword [edi], "AAAA"
	mov ecx, 1000000h
	loop $
	sti
;с этого момента запущен диспетчер, в эту задачу мы уже не вернёмся
task_start_loop:	
	jmp task_start_loop

;задача 1	
task_1:
	mov edi,0B8000h
tsk_1:
	sti
	mov fword [edi], " s t"
	add edi, 4
	mov fword [edi], " 1 k"
	add edi, 4
	mov ecx, 0200000h
	loop $
	jmp tsk_1

;задача 2
task_2:
mov edi,0B8400h
tsk_2:
	sti
	mov fword [edi], "asat"
	add edi, 4
	mov fword [edi], "a2ak"
	add edi, 4
	mov ecx, 0400000h
	loop $
	jmp tsk_2
	
	

; задача 3
task_3:
	mov edi,0B8800h
tsk_3:
	sti
	mov fword [edi], "bsbt"
	add edi, 4
	mov fword [edi], "b3bk"
	add edi, 4
	mov ecx, 0600000h
	loop $
	jmp tsk_3

	
switch_task:
	cli	
	mov	edi,0B8000h	
	mov fword [edi], "BBBB" ;для отладки, добрались таки
	
	push	eax ;eio
	mov	al,20h
	out	20h,al
	pop	eax
	
	xor ax, ax
	mov al, task_counter
	inc al
	cmp al, 2
	jbe st_1
	mov al, 0
st_1:
	mov task_counter, al

;в AL - номер задачи, на которую надо бы переключиться	

;примитивное ветвление, т.к. косвенного FAR JUMP'а найти не смог	
	cmp al, 0
	jne st_2
	;чистим BUSY задачи, куда перерубаемся
	mov	ebx,offset (GDT + SEL_TSS1)
	and	byte ptr cs:[ ebx + 5 ],11111101b
	db         0EAh
    dd         0
    dw         SEL_TSS1
	;а тут у нас BUSY диспетчера чистится автоматом
	jmp	switch_task

;далее - аналогично
	
st_2:
	cmp al, 1
	jne st_3
	mov	ebx,offset GDT + SEL_TSS2
	and	byte ptr cs:[ ebx + 5 ],11111101b
	db         0EAh
    dd         0
    dw         SEL_TSS2
	jmp	switch_task
	
st_3:
	mov	ebx,offset GDT + SEL_TSS3
	and	byte ptr cs:[ ebx + 5 ],11111101b
	db         0EAh
    dd         0
    dw         SEL_TSS3
	jmp	switch_task

	
	
; обработчик обычного прерывания
int_handler:
	mov	edi,0B8000h	; отладка
	mov fword [edi], "CCCC"
	mov ecx, 02000000h
	loop $
	iretd
; обработчик аппаратного прерывания IRQ0 - IRQ7
irq0_7_handler:
	mov	edi,0B8000h	; отладка
	mov fword [edi], "DDDD"
	mov ecx, 02000000h
	loop $
	push	eax
	mov	al,20h
	out	20h,al
	pop	eax
	iretd
; обработчик аппаратного прерывания IRQ8 - IRQ15
irq8_15_handler:
	mov	edi,0B8000h	; отладка
	mov fword [edi], "EEEE"
	mov ecx, 02000000h
	loop $
	push	eax
	mov	al,20h
	out	0A0h,al
	pop	eax
	iretd
; обработчик IRQ1 - прерывания от клавиатуры
irq1_handler:
	push	   eax
	in         al,60h           
	cmp        al,1             
	jne m1
	mov        al,20h
    out        20h,al
	pop		   eax
    db         0EAh
    dd         offset RM_return
    dw         SEL_16bitCS
m1:
    mov        al,20h
    out        20h,al
	pop		   eax
    iretd
	
int13_handler:
	pop eax
    iretd

	
task_counter db 3	
	
PM_seg ends

stack_seg segment para stack 'STACK'
stack_start	db	100h dup(?)	
stack_l1 = $-stack_start
stack_task2	db	100h dup(?)	
stack_l2 = $-stack_start
stack_task3	db	100h dup(?)	
stack_l3 = $-stack_start
stack_task4	db	100h dup(?)	
stack_l4 = $-stack_start
stack_task5	db	100h dup(?)	
stack_l5 = $-stack_start
stack_seg ends
	end start
