.model small
.stack 100h
.data

 a dw 5
 b dw 6

.code
start:
 mov ax, @data
 mov ds, ax

 mov ax, a
 mov bx, b
 add ax, bx

 mov ah, 4ch
 int 21h
end start