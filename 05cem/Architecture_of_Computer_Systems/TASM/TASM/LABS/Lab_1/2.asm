.model small
.stack 100h
.data

 a dw 1111110100100000b

.code
start:
 mov ax, @data
 mov ds, ax
 mov ax,a
 mov bx,0h

loop_main:
 shr ax,1
 adc bx,0
 test ax, ax
 jne loop_main
 
 cmp bx,8
 ja one_more
 jb zero_more
 mov ax,64
 jmp end_cmp

one_more:
 mov ax,1
 jmp end_cmp

zero_more:
 mov ax,128
 jmp end_cmp

end_cmp:
 mov ah, 4ch
 int 21h
end start