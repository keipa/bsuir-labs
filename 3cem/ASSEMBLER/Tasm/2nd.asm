model small
.stack 100h
.data
a dw 1
b dw 2
c dw 3
d dw 4
min dw 0
max dw 0
abmul dw 0
bcmul dw 0
cdmul dw 0
damul dw 0
ans dw 0
.code
start:
mov ax, @data
mov ds, ax

mov ax, a
mov bx, b
mul bx
mov abmul,ax

mov ax, b
mov bx, c
mul bx
mov bcmul,ax

mov ax, c
mov bx, d
mul bx
mov cdmul,ax

mov ax, d
mov bx, a
mul bx
mov damul,ax

mov ax,abmul
mov max, ax
mov ax, bcmul
mov min, ax
mov ax, abmul
mov bx, bcmul
cmp ax,bx
jnc label1
mov max, bx 
mov min, ax
label1:

mov ax, max
mov bx, cdmul
cmp ax, bx
jnc label2
mov max, bx
label2:
mov ax, cdmul
mov bx, min
cmp ax, bx
jnc label3
mov min, ax
label3:


mov ax, max
mov bx, damul
cmp ax, bx
jnc label4
mov max, bx
label4:
mov ax, damul
mov bx, min
cmp ax, bx
jnc label5
mov min, ax
label5:

mov ax, max
mov bx, min
sub ax, bx
mov ans,ax

mov ah, 4ch
int 21h
end start