.model small
.stack 100h
.data
.code

iinput PROC CPP
USES	bx,cx,dx,si,di,bp
	XOR     di,di		
	XOR     si,si
	XOR     cx,cx		
	mov	bp,10		
input_get_char:
	mov	ah,08h		
	int	21h
	cmp     al,'-'
	jz      sign		
	cmp	al,'0'		
	jb	input_spec_ch
	cmp	al,'9'		
	ja	input_get_char
	mov	bl,al		
	mov	ax,di
	imul	bp		
        jno     input_not_overflow1
	jmp	input_get_char
input_not_overflow1:
	mov	dl,bl
	sub	dl,'0'		
	mov	dh,0		
	add	dx,ax
	test    cx,cx
	jz      check_overflow
	cmp     dx,32768
	ja	input_get_char
	jmp     check_overflow_next
check_overflow:
	cmp     dx,32767
	ja      input_get_char
check_overflow_next:
	inc	si
	mov	di,dx			
	mov	dl,bl
	mov	ah,02h
	int	21h
	jmp	input_get_char
sign:
	test    cx,cx
	jnz     input_get_char
	test    si,si
	jnz     input_get_char
	inc     cx
	inc     si
	mov     dl,al
	mov	ah,02h
	int	21h
	jmp     input_get_char
input_spec_ch:
	cmp	si,0
	je	input_get_char
	cmp	al,13
	je	input_enter		
	cmp	al,8		
	jne	input_get_char
input_backspace:
	dec	si
	test    cx,cx
	jnz     need_do_sign
no_del_sign:
	mov	ax,di
	mov	dx,0
	div	bp
	mov	di,ax
input_sign_back:
	mov	dl,8
	mov	ah,2
	int	21h
	mov	dl,32
	int	21h
	mov	dl,8
	int	21h
	jmp	input_get_char
need_do_sign:
	test    si,si
	jnz     no_del_sign
	xor     cx,cx
	jmp     input_sign_back
input_enter:	
	mov     ax,di
	test    cx,cx
	jz     	positive
	neg     ax
positive:
RET
iinput ENDP

ioutput PROC CPP
USES ax,bx,cx,dx,bp
	mov     bp,10
	push	-1
	push    ax
	shl     ax,1
	jnc     output_check
	mov	ah,2h
	mov     dl,'-'
	int     21h
	pop     ax
	neg     ax
	jmp     output_to_stek
output_check:
	pop     ax			
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
ioutput ENDP

start:
	push    cs
	pop     ds
	xor     ax,ax
	mov	ah,09h		
	mov	dx,offset str1
	int	21h
        CALL    iinput
	push    ax
	mov	dl,10
	mov	ah,02h
	int	21h
	mov	ah,09h		
	mov	dx,offset str2
	int	21h
	CALL    iinput
	mov     bx,ax
	mov	dl,10
	xor     ax,ax
	mov	ah,02h
	int	21h
	mov	dx,offset str3
	mov	ah,09h
	int	21h
	pop     ax
	cwd
	test    bx,bx
	jz      divide_by_zero
	idiv    bx
	push    dx
	CALL    ioutput
	mov	dl,'('
	mov	ah,02h
	int	21h
	pop     dx
	mov     ax,dx
abs_ax1:
	neg     ax
	js      abs_ax1
	CALL    ioutput
	mov	dl,')'
	mov	ah,02h
	int	21h
error_end:
	mov	ah,02h	
	mov	dl,10
	int	21h
	mov	ax,4c00h
	int	21h
	jmp     end_prog
divide_by_zero:
	mov     dx,offset str4
	mov     ah,09h
	int     21h
	jmp     error_end
end_prog:
str1    db      'Enter number: $'
str2	db      'Enter second number: $'
str3    db      'Answer: $'
str4    db      'Divide by zero $'

end	start