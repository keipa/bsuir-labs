model small
.stack 100h
.data
a dw 6
b dw 5
.code
start:
mov ax, @data
mov ds, ax

mov ax, a
mov bx, b
cmp ax, bx
jnc next
mov ax, bx
next:

mov ah, 4ch
int 21h
end start