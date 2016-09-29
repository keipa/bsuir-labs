
;tasm /m beeptest.ass
;tlink /x /3 beeptest
;beeptest

OutStr macro str ;макрос вывода строки
push dx
mov ah,09h
lea dx,str
int 21h
pop dx
endm
;----------------------------------------
OutChar macro char ;макрос вывода символа
push ax
push dx
mov ah,06h
mov dl,char
add dl,30h
int 21h
pop dx
pop ax
endm
;----------------------------------------------------------------------------------------------------
Decomposition macro time ;макрос разложения двузначного числа (16-ного) на цифры и вывода их на экран
push bx
mov bh,time ;используется bx
mov bl,time
and bh,11110000b
shr bh,4h
and bl,00001111b
OutChar bh
OutChar bl
pop bx
endm
;-------------------------------------
Delay macro time ;макрос задежки в мкс
local ext,iter
push cx
mov cx,time
ext:
push cx
mov cx,5000
iter:
loop iter
pop cx
loop ext
pop cx
endm
;-----------------------------------------------------------
GotoXY macro x,y ;макрос установки позиции курсора в т.(x,y)
push ax
push bx
push dx
mov ah,02 ;Запрос на установку курсора
mov bh,0 ;Экран 0
mov dh,11 ;Строка 0
mov dl,25 ;Столбец 0
int 10h ;Передача управления в BIOS
pop dx
pop bx
pop ax
endm
;-----------------------------------------------

.model small
.stack 100h
.data
M1 DB ':$'
M2 DB 'Surname Letter!!! $'
M3 DB '',10,13,'$'

MR DB 'R',10,13,'$'
MO DB 'O',10,13,'$'
MV DB 'V',10,13,'$'
MD DB 'D',10,13,'$'

.code
start:
mov ax,@DATA ;инициализация
mov ds,ax

mov ah,0
mov al,2
int 10h

l1:
mov ah,0 ;clear screen
mov al,2
int 10h

mov ah, 01h
int 16h
jnz surnamepassed

pewend:
;pewpewpewpewpewpewpewpewpew
mov al, 10110110b
out 43h, al
mov al, 2ah
out 42h, al
mov al, 4h
out  42h, al
in al, 61h
or  al, 00000011b
out 61h, al
mov bx,2
xor ah, ah
int 1ah
add  dx, bx
mov bx, dx
_m1:
int 1ah
cmp dx, bx
jb _m1
in al, 61h
and al, 11111100b
out 61h, al
Delay 100
jmp l1

surnamepassed:
mov ah, 00H        ;key is ready, get
int 16H  ;now process the key
cmp al, 52h
jz processing
cmp al, 4Fh
jz processing
cmp al, 56h
jz processing
cmp al, 44h
jz processing
jmp pewend
processing:
GotoXY 11,25
OutStr M2
push ax
push bx
push cx
;;;;;;;;;;;;;;;;;;;;;;PEEEEEEEEEEEEEEEEEEEEW blaster
MOV     DX,2000          ; Number of times to repeat whole routine.
MOV     BX,1             ; Frequency value.
MOV     AL, 10110110B    ; The Magic Number (use this binary number only)
OUT     43H, AL          ; Send it to the initializing port 43H Timer 2.
NEXT_FREQUENCY:          ; This is were we will jump back to 2000 times.
MOV     AX, BX           ; Move our Frequency value into AX.
OUT     42H, AL          ; Send LSB to port 42H.
MOV     AL, AH           ; Move MSB into AL
OUT     42H, AL          ; Send MSB to port 42H.
IN      AL, 61H          ; Get current value of port 61H.
OR      AL, 00000011B    ; OR AL to this value, forcing first two bits high.
OUT     61H, AL          ; Copy it to port 61H of the PPI Chip
                         ; to turn ON the speaker.
MOV     CX, 100          ; Repeat loop 100 times
DELAY_LOOP:              ; Here is where we loop back too.
LOOP    DELAY_LOOP       ; Jump repeatedly to DELAY_LOOP until CX = 0
INC     BX               ; Incrementing the value of BX lowers
                         ; the frequency each time we repeat the
                         ; whole routine
DEC     DX               ; Decrement repeat routine count
CMP     DX, 0            ; Is DX (repeat count) = to 0
JNZ     NEXT_FREQUENCY   ; If not jump to NEXT_FREQUENCY
                         ; and do whole routine again.
                         ; Else DX = 0 time to turn speaker OFF
IN      AL,61H           ; Get current value of port 61H.
AND     AL,11111100B     ; AND AL to this value, forcing first two bits low.
OUT     61H,AL           ; Copy it to port 61H of the PPI Chip
                         ; to turn OFF the speaker.
;;;;;;;;;;;;;;;;;;;;BEEEEEEEEEEEEEEEEP
Delay 100
pop cx
pop bx
pop ax

jmp pewend

exit:
mov ax,4C00h
int 21h
END start


proc BEEEEEEP

ret
end
