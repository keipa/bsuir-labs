; tasm /m %1.s
; tlink /x /3 %1.obj
model small
.386p
.stack 400h
.data

data1 db 40h
data2 db 3Ch
data3 dw 0
real_mode_ss dw ?

GDT label
    dq 0
    dq ? ; code descriptor
    dq ? ; stack descriptor
    dq ? ; data descriptor
    dq ? ; screen buffer descriptor

    GDT_TSS0 db 067h, 0, 0, 0, 0, 10001001b, 0, 0
    GDT_TSS1 db 067h, 0, 0, 0, 0, 10001001b, 0, 0
    GDT_TSS2 db 067h, 0, 0, 0, 0, 10001001b, 0, 0
    GDT_TSS3 db 067h, 0, 0, 0, 0, 10001001b, 0, 0
    GDT_TSS4 db 067h, 0, 0, 0, 0, 10001001b, 0, 0


GDTR label fword
GDT_lim dw $ - GDT - 1
GDT_adr dd ?


; local stacks
stack_1 db 100h dup(?)
stack_1_end = $
stack_2 db 100h dup(?)
stack_2_end = $
stack_3 db 100h dup(?)
stack_3_end = $
stack_4 db 100h dup(?)
stack_4_end = $

TSS_0 db 68h dup(0)
TSS_1 dd 0, 0, 0, 0, 0, 0, 0, 0
dd offset task_1 ; EIP
dd 0, 130h, 0, 0, 0, stack_1, 0, 0, 0140h ; (EAX, ESP, EDI)
dd SCREEN_SELECTOR, CODE_SELECTOR, DATA_SELECTOR, DATA_SELECTOR, 0, 0
dd 0
dd 0
; TSS_2 dd 0, 0, 0, 0, 0, 0, 0, 0
; dd offset task_2 ; EIP
; dd 0, 230h, 0, 0, 0, stack_2, 0, 0, 0280h ; (EAX, ESP, EDI)
; dd SCREEN_SELECTOR, CODE_SELECTOR, DATA_SELECTOR, DATA_SELECTOR, 0, 0
; dd 0
; dd 0
TSS_3 dd 0, 0, 0, 0, 0, 0, 0, 0
dd offset task_3 ; EIP
dd 0, 330h, 0, 0, 0, stack_3, 0, 0, 03c0h ; (EAX, ESP, EDI)
dd SCREEN_SELECTOR, CODE_SELECTOR, DATA_SELECTOR, DATA_SELECTOR, 0, 0
dd 0
dd 0
TSS_4 dd 0, 0, 0, 0, 0, 0, 0, 0
dd offset task_4 ; EIP
dd 0, 430h, 0, 0, 0, stack_4, 0, 0, 0500h ; (EAX, ESP, EDI)
dd SCREEN_SELECTOR, CODE_SELECTOR, DATA_SELECTOR, DATA_SELECTOR, 0, 0
dd 0
dd 0

TSS0_SELECTOR equ 28h
TSS1_SELECTOR equ 30h
; TSS2_SELECTOR equ 38h
TSS3_SELECTOR equ 40h
TSS4_SELECTOR equ 48h


; TI = 0
; RPL = 00B
CODE_SELECTOR equ 8h
STACK_SELECTOR equ 10h
DATA_SELECTOR equ 18h
SCREEN_SELECTOR equ 20h

ROW_SIZE equ 160
COLUMN_SIZE equ 2
PRINT_POSITION equ (10 * ROW_SIZE) + (16 * COLUMN_SIZE)
SCREEN_BUFFER equ 0b800h

data_segment_size label

.code

init_TSS_descriptor macro descriptor, tss
    pop eax
    push eax
    xor ebx, ebx
    mov bx, offset tss
    add eax, ebx
    mov word ptr descriptor + 2, ax
    shr eax, 16
    mov byte ptr descriptor + 4, al
endm





task_body macro TSS_to_switch ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
local switch_task, skip_char_inc, ODD, NODD, recon
; clear previous char
push ax
mov al, 0
stosw
; print new char
pop ax
mov word ptr es:[edi], ax

inc bx
cmp bx, 4fh
jl switch_task
call switch_direction_and_char
xor bx, bx
switch_task:

db 0eah
dw 0
dw TSS_to_switch
endm


start:
    mov ax, @data
    mov ds, ax
    mov ax, SCREEN_BUFFER
    mov es, ax

    ; clear screen
    mov ax, 3h
    int 10h

    ; save segment registers
    mov real_mode_ss, ss
    push es fs gs

    mov ax, ds
    mov es, ax

    call init_GDT
    call set_GDTR
    call switch_A20
    call switch_interrupts

    mov eax, cr0
    btc eax, 0
    mov cr0, eax
    ; jump far
    db  0eah
    dw  offset protected_mode
    dw  CODE_SELECTOR

  protected_mode:
    mov ax, SCREEN_SELECTOR
    mov es, ax
    mov ax, DATA_SELECTOR
    mov ds, ax
    mov ax, STACK_SELECTOR
    mov ss, ax


    mov ax, TSS0_SELECTOR
    ltr ax

    xor eax, eax
    xor ebx, ebx
    xor edi, edi ; ES:EDI - SCREEN
    mov ecx, 20 * 79
    mov ax, 0f30h
    main_cycle:                     ; TSS0 is main task
        task_body TSS4_SELECTOR

        ; test ecx, 1
        ; jnz $ + 7
        ; db 0eah
        ; dw 0
        ; dw TSS2_SELECTOR

        test ecx, 3
        jnz $ + 7
        db 0eah
        dw 0
        dw TSS3_SELECTOR

        test ecx, 7
        jnz $ + 7
        db 0eah
        dw 0
        dw TSS1_SELECTOR

        call make_pause
    loop main_cycle

    jmp RM_return

    task_1:
        task_body TSS0_SELECTOR
    jmp task_1
    ;
    ; task_2:
    ;     task_body TSS1_SELECTOR
    ; jmp task_2

    task_3:
        task_body TSS0_SELECTOR
    jmp task_3

    task_4:
        task_body TSS3_SELECTOR
    jmp task_4

RM_return:

    mov eax, cr0
    btc eax, 0
    mov cr0, eax
    ; jump far
    db  0eah
    dw  offset real_mode
    dw  @code

  real_mode:
    ;restore segment registers
    mov ax, @data
    mov ds, ax
    mov ss, real_mode_ss
    pop gs fs es

    call switch_A20
    call switch_interrupts

    mov ax, 3h
    int 10h
    mov ax, 4c00h
    int 21h



make_pause proc
    push ecx

    mov ecx, 64h
    pause_loop:
        push ecx
        mov ecx, 0ffffffffh
        loop $
        pop ecx
    loop pause_loop

    pop ecx
    ret
make_pause endp



switch_direction_and_char proc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push dx

pushf
pop dx
bt dx, 10
jnc skip_char_inc
inc al
skip_char_inc:
btc dx, 10
push dx
popf

pop dx
ret
switch_direction_and_char endp









create_descriptor  proc

    push eax ebx edx

    mov ax, dx
    stosw
    mov ax, bx
    stosw

    shr ebx, 16
    mov al, bl
    mov ah, cl
    stosw
    mov ah, bh
    shr edx, 16
    mov al, dl
    and al, 00001111b
    stosw

    pop edx ebx eax
    ret
create_descriptor  endp

init_GDT proc
    push ebx ecx edx edi

    mov di, offset GDT + 8
    xor ebx, ebx
    mov bx, cs
    shl ebx, 4
    mov edx, offset code_segment_size - 1
    mov cl, 10011000b
    call create_descriptor      ; code segment

    xor ebx, ebx
    mov bx, ss
    shl eax, 4
    mov edx, 400h - 1
    mov cl, 10010110b
    call create_descriptor      ; stack segment

    xor ebx, ebx
    mov bx, ds
    shl ebx, 4
    mov edx, offset data_segment_size - 1
    mov cl, 10010010b
    call create_descriptor      ; data segment

    mov ebx, SCREEN_BUFFER shl 4
    mov edx, 4000
    mov cl, 10010010b
    call create_descriptor      ; screen segment


    mov ax, ds
    shl eax, 4
    push eax

    init_TSS_descriptor GDT_TSS0, TSS_0
    init_TSS_descriptor GDT_TSS1, TSS_1
    ; init_TSS_descriptor GDT_TSS2, TSS_2
    init_TSS_descriptor GDT_TSS3, TSS_3
    init_TSS_descriptor GDT_TSS4, TSS_4

    pop eax


    pop edi edx ecx ebx
    ret
init_GDT endp

set_GDTR proc
    push eax ebx

    xor eax, eax
    xor ebx, ebx
    mov ax, ds
    shl eax, 4
    lea bx, GDT
    add eax, ebx
    mov GDT_adr, eax
    lgdt GDTR

    pop ebx eax
    ret
set_GDTR endp

switch_interrupts proc
    push ax

    cli
    in al, 70h
    btc ax, 7
    out 70h, al

    pop ax
    ret
switch_interrupts endp

switch_A20 proc
    push ax

    in al, 92h
    btc ax, 1
    out 92h,al

    pop ax
    ret
switch_A20 endp

code_segment_size:
end start
