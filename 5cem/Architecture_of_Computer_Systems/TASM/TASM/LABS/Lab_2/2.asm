.model small
.stack 100h
.data
.code

input PROC CPP
USES	bx,cx,dx,si,di,bp
	XOR     di,di		
	XOR     si,si		
	mov	bp,10		
input_get_char:
	mov	ah,08h		
	int	21h		
	cmp	al,'0'		
	jb	input_spec_ch
	cmp	al,'9'		
	ja	input_get_char
	mov	bl,al		
	mov	ax,di
	mul	bp		
	cmp	dx,0
        je      input_not_overflow1
	jmp	error_overflow
input_not_overflow1:
	mov	dl,bl
	sub	dl,'0'		
	mov	dh,0		
	add	dx,ax
	jnc     input_not_overflow2
	jmp	error_overflow
input_not_overflow2:
	inc	si
	mov	di,dx			
	mov	dl,bl
	mov	ah,02h
	int	21h
	jmp	input_get_char
input_spec_ch:
	cmp	si,0
	je	input_get_char
	cmp	al,13
	je	input_enter		
	cmp	al,8		
	jne	input_get_char
input_backspace:
	dec	si
	mov	ax,di
	mov	dx,0
	div	bp
	mov	di,ax
	mov	dl,8
	mov	ah,2
	int	21h
	mov	dl,32
	int	21h
	mov	dl,8
	int	21h
	jmp	input_get_char
input_enter:
	mov     ax,di
RET
input ENDP

output PROC CPP
USES ax,bx,cx,dx,bp
	mov     bp,10
	push	-1	
output_to_stek:
	xor     dx,dx	
	div	bp	
	push	dx	
	cmp	ax,0
	jne	output_to_stek
	mov	ah,2h
output_display:
	pop	dx	
	cmp	dx,-1	
	je	output_exit
	add	dl,'0'	
	int	21h	
	jmp	output_display	
output_exit:
RET
output ENDP

start:
	push    cs
	pop     ds
	xor     ax,ax
	mov	ah,09h		
	mov	dx,offset str1
	int	21h
        CALL    input
	push    ax
	mov	dl,' '
	mov	ah,02h
	int	21h
	mov	ah,09h		
	mov	dx,offset str2
	int	21h
	CALL    input
	mov     bx,ax
	mov	dl,' '
	xor     ax,ax
	mov	ah,02h
	int	21h
	mov	dx,offset str3
	mov	ah,09h
	int	21h
	mov     dx,0
	pop     ax
	div     bx
	push    dx
	CALL    output
	mov	dl,' '
	mov	ah,02h
	int	21h
	pop     dx
	mov     ax,dx
	CALL    output
error_overflow:
	mov	ah,02h
	mov	dl,10
	int	21h
	mov	ax,4c00h
	int	21h

str1    db      'Enter number: $'
str2	db      'Enter second number: $'
str3    db      'Answer: $'

end	start