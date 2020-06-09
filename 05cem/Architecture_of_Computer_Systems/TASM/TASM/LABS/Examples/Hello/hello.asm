DOSSEG
	.MODEL SMALL
	.STACK 100h
	.DATA
Message DB 'HELLO!',13,10,'$'
	.CODE
	mov ax, @Data
	mov dx,ax
	mov ah,9
	mov dx,OFFSET Message
	int 21h
	mov ah,4ch
	int 21h
END