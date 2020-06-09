.model small
.stack 200h

.data

sinput	 db	'String: $'
soutput  db     'Filter: $'
inpstr	 db	128,0,128 dup (' ')
outstr   db     128,0,128 dup (' ')

.code

input proc cpp
USES	ax
	mov     ah,0ah
	int     21h			
ret
input endp
		
filter proc pascal
uses	ax,bx,cx,dx,di,si
local	@x:word,@y:word,@z:word
	mov     @z,0
	mov     si,dx
	mov     di,cx
	xor     bx,bx
	xor     ax,ax
	add     si,2
	add     di,2
	push    di
prespacechk:
	lodsb
	cmp     al,' '
	jz      prespacechk
	dec     si
	jmp     filtbeg
copyspace:
	dec     si
	movsb
	inc     @z	
filtbeg:
	mov     @x,0
	mov     @y,0
	lodsb
	cmp	al,' ' 
	je	copyspace
	cmp     al,0dh
	jne     next1
	jmp     filtexit
next1:  
	mov     @x,0
	xor     dx,dx
wdchck:	
	mov     ah,1
	mov     bl,al
	mov     bh,0
	sub     si,@y
	dec     si
	mov     cx,@y
	inc     @y
	jmp     skipch
skiptrue:
	mov     bh,1
skipch:
	test    cx,cx
	jz      skipchend
	dec     cx
	lodsb
	cmp     al,bl
	je      skiptrue
	jmp     skipch
skipchend:
	inc     si
	cmp     bh,1
	jne     letchck
	lodsb
	cmp     al,' '
	je      checkcopy
	cmp     al,0dh
	je	checkcopy
	jmp     wdchck
fndlet:
	inc     ah
letchck:
	lodsb
	inc     @x
	cmp     al,0dh
	je      endletchck
	cmp     al,' '
	je      endletchck
	cmp     al,bl
	je      fndlet
	jmp     letchck
endletchck:
	shr     ah,1
	add     dl,ah
	xor     ah,ah
	std
	mov     cx,@x
	rep     lodsb
	cld
	mov     @x,0
	lodsb
	cmp     al,' '
	je      checkcopy
	cmp     al,0dh
	je	checkcopy
	jmp     wdchck
checkcopy:
	cmp     dl,1
	jna     needcopy
nocopy:
	cmp     al,0dh
	jz      filtexit
	jmp     spacecheck
spacedel:
	lodsb
spacecheck:
	cmp     al,' '
	jz      spacedel
	dec     si
	jmp     filtbeg
needcopy:
	std
	mov     cx,@y
	inc     cx
	rep     lodsb
	cld
	mov     cx,@y
	rep     movsb
	mov     ax,@y
	add     @z,ax
	lodsb
	cmp     al,' '
	jne     filtexit
	dec     si
	jmp     spacecheck1
spacedel1:
	lodsb
spacecheck1:
	cmp     al,' '
	jz      spacedel1
	dec     si
	jmp     copyspace 		
filtexit:
	mov     al,0dh
	stosb
	pop     di
	dec     di
	mov     ax,@z
	stosb
ret
filter endp

output proc cpp
uses 	ax,bx,dx
	mov 	di, dx
	mov 	bx, 0
	mov 	bl, [di+1]
	mov 	byte ptr [di+bx+2], '$'

	add 	dx, 2
	mov 	ah, 09h
	int 	21h
ret
output endp

start:
	mov 	ax,@data
	mov 	ds,ax
	mov     es,ax
	
	mov     dx,offset sinput
	mov     ah,09h
	int     21h
	mov     dx,offset inpstr	
	call    input	
	mov     dl,10
	mov     ah,02h
	int     21h

	mov     cx,offset outstr
	mov     dx,offset inpstr
	call    filter

	mov     ah,09h
	mov     dx,offset soutput
	int     21h
	mov     dx,offset outstr
	call    output

	mov	ax,4c00h
	int	21h
end	start