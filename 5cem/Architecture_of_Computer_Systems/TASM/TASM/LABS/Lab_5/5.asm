.model small
.stack 200h

.data

filename  db     'matrix.txt',0
matrix	  dw	 0,0,100 dup ('*'),'$',0
buffer    label  byte
handle    dw     0,0

.code

fileread proc pascal
uses	ax,bx,cx,dx,si,di,bp
local   x:word,y:word,z:word	

	mov	bp,10
	mov 	ah,3dh
	mov 	al,0
	mov 	dx,offset filename
	mov 	si,offset matrix
	mov     z,si
	int 	21h
	mov     x,ax
	
	
	
	
	
	
	000
	001
	010
	011
	
	
	
	
	
	
	
	
	jnc 	begin_word	
	jmp 	error
begin_word:
	mov     y,0
	xor     di,di
next_char:
	mov 	bx,x
	mov 	ah,3fh
	mov 	dx,offset buffer
	mov 	cx,1		
	int	21h
	jnc     no_error_read
	jmp     error
no_error_read:
	cmp     ax,0
	jz      end_read
	mov     al,byte ptr buffer
	cmp     al,'-'
	jz      sign		
	cmp     al,' '
	jz      end_word
	cmp     al,0dh
	jz      end_word
	cmp     al,0ah
	jz      begin_word

	mov	bl,al		
	mov	ax,di
	imul	bp		
	mov	dl,bl
	sub	dl,'0'		
	mov	dh,0		
	add	dx,ax
	mov	di,dx			
	jmp	next_char
sign:
	mov     y,1
	jmp     next_char		
end_word:	
	mov     ax,di
	cmp     y,0
	jz     	positive
	neg     ax
positive:
	mov     word ptr[si],ax
	add     si,2
	jmp     begin_word
end_read:
	mov     ax,di
	cmp     y,0
	jz     	positive_end
	neg     ax
positive_end:
	mov     word ptr[si],ax
	
ret
fileread endp
		
sort proc pascal
uses	ax,bx,cx,dx,di,si
local   i:word,j:word,j0:word,sum:word,maxsum:word,jmax:word,jcurr:word
	mov     j0,0
	mov 	si,offset matrix
	mov     ax,word ptr[si]
	mov     i,ax
	add     si,2
	mov     ax,word ptr[si]
	mov     j,ax
	add     si,2

	mov     cx,j
col_loop:
	push    cx
	dec     cx
	mov     maxsum,-32768
	mov     jcurr,cx
	mov     jmax,cx
	inc     cx

	find_min:
		push    cx
		dec     cx
		mov     j0,cx
		mov     cx,i
		mov     sum,0

		sum_loop:
			mov     ax, cx
			dec     ax
			mul     j
			add     ax, j0
			mov     bx, 2
			mul     bx
			mov     bx,ax
			mov	ax,word ptr[bx+si]
			add     sum,ax
		loop	sum_loop

		mov     ax, sum
		cmp 	maxsum,ax
		jge     no_new_max
		mov     bx,j0
		mov     jmax,bx
		mov     maxsum,ax
		no_new_max:		
		pop     cx
	loop    find_min

	mov     ax,jmax
	cmp     ax,jcurr
	je     no_swap
	mov     cx,i
	swap_loop:
			push    cx
			mov     ax, cx
			dec     ax
			mul     j
			add     ax, jcurr
			mov     bx, 2
			mul     bx
			mov     bx,ax
			mov	di,word ptr[bx+si]
			push    bx
			mov     ax, cx
			dec     ax
			mul     j
			add     ax, jmax
			mov     bx, 2
			mul     bx
			mov     bx,ax
			mov     cx,word ptr[bx+si]
			pop     bx
			mov     word ptr[bx+si],cx
			mov     bx,ax
			mov     word ptr[bx+si],di
			pop     cx
	loop	swap_loop
no_swap:
	pop     cx
loop    next_col_loop
	jmp	end_sort

next_col_loop:
	jmp  col_loop

end_sort:	
ret
sort endp

matrixout proc pascal
uses  ax,bx,cx,dx,si
local a:word,b:word,c:word,d:word
	mov     c,0
	mov     d,0
	mov 	si,offset matrix
	lodsw
	mov     a,ax
	lodsw
	mov     b,ax
print_loop:
	lodsw
	call	word_out
	inc     d
	mov     bx,d
	cmp	b,bx
	je      new_string
	mov	ah,2h
	mov     dl,' '
	int     21h
	jmp     print_loop
new_string:
	inc     c
	mov     ax,c
	cmp     a,ax
	je      end_print_matrix
	mov	ah,2h
	mov     dl,13
	int     21h
	mov     dl,10
	int     21h
	mov     d,0
	jmp     print_loop
end_print_matrix:
	mov	ah,2h
	mov     dl,13
	int     21h
	mov     dl,10
	int     21h
ret
matrixout endp

word_out proc pascal
uses ax,bx,cx,dx,bp
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
ret
word_out endp

start:
	mov 	ax,@data
	mov 	ds,ax
	mov     es,ax

	mov	ah,2h
	mov     dl,13
	int     21h
	mov     dl,10
	int     21h

	call    fileread
	call    matrixout

	mov	ah,2h
	mov     dl,13
	int     21h
	mov     dl,10
	int     21h

	call    sort
	call    matrixout
error:
	mov	ax,4c00h
	int	21h
end	start