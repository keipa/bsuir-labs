model small
.stack 100h
.386
.data
           STRING_A DB ' INPUT A: $'
           STRING_B DB ' INPUT B: $'
           STRING_C DB ' INPUT C: $'
           STRING_test DB ' INPUT test: $'

            ;рабочие переменные коэффициэнтов Ax^2+Bx+C
            a dd ?
            b dd ?
            nb dd ?
            c dd ?
            d dd ?
            two dd 2.0
            four dd 4.0
            kd dd ?
            nkd dd ?
            x1 dd ?
            x2 dd ?
            testkoef dd 7.3

            ;переменные для ввода

.code
                        start:
                                    mov ax, @data
                                    mov ds, ax

                                call infloat
                                fstp a
                                call infloat
                                fstp b
                                call infloat
                                fstp c
                                ;LEA DX,STRING_test
                                ;MOV AH,09H	;STRING OUT
                                ;INT 21H
                                ;fld testkoef
                                fstp st(0)
                                fstp st(1)
                                fstp st(2)



                                  fld b     ; s(0)=b
                                  fmul b  ;s(0)=b*b
                                  fld a ; s(0) = a, s(1)=b*b
                                  fmul c ;s(0) = a*c, s(1)=b*b
                                  fmul four ;s(0) =4*a*c, s(1)=b*b
                                  fsub  ;s(0) = b*b-4*a*c
                                  fsqrt ;s(0) =sqrt(b*b-4*a*c)
                                  fstp kd  ;успешный случай вычисления дискриминанта

                                  fstp st(0)    ;st(0)=0
                                  fldz;st(0)=0, st(1)=0
                                  fld b;st(0)=b, st(1)=0
                                  fsub ;st(0)=-b

                                  fstp nb


                                  fstp st(0)    ;st(0)=0
                                  fldz;st(0)=0, st(1)=0
                                  fld kd;st(0)=kd, st(1)=0
                                  fsub ;st(0)=-kd
                                  fstp nkd


                                  fld nb
                                  fld nkd
                                  fadd
                                  fld a
                                  fmul two
                                  fdiv



                                  call outfloat

                                  fld nb
                                  fld kd
                                  fadd
                                  fld a
                                  fmul two
                                  fdiv



                                  call outfloat



                                ;fld a
                                ;fstp st(0)
                                ;call outfloat

                                ;fstp a  ;вытолкнуть из стека первое введённое значение


                                    ;fld testkoef ;тестовый ввод своей переменной(success)
                                    ;call outfloat


                                    ;call outfloat ;не забыть про вывод


                                    mov ah, 4ch
                                    int 21h

                                    infloat proc    near
                                        push    ax
                                        push    dx
                                        push    si
                                ; Формируем кадр стэка, чтобы хранить десятку и ещё какую-нибудь цифру.
                                        push    bp
                                        mov     bp, sp
                                        push    10
                                        push    0
                                ; В SI признак знака.
                                        xor     si, si
                                ; Начнём накапливать число. Сначала это ноль.
                                        fldz
                                ; Вводим первый символ. Это может быть минус.
                                        mov     ah, 01h
                                        int     21h
                                        cmp     al, '-'
                                        jne     short @if1
                                ; Если это действительно минус, запоминаем это
                                ; и вводим следующую цифру.
                                        inc     si
                                @if0:   mov     ah, 01h
                                        int     21h
                                ; Если введена точка, то пора переходить
                                ; к формированию дробной части.
                                @if1:   cmp     al, '.'
                                        je      short @if2
                                ; Ну а если нет, то проверим, что ввели цифру
                                ; (в противном случае закончим ввод),
                                        cmp     al, 39h
                                        ja      short @if5
                                        sub     al, 30h
                                        jb      short @if5
                                ; сохраним её во временной ячейке и допишем
                                ; к текущему результату справа,
                                        mov     [bp - 4], al
                                ; то есть умножим уже имеющееся число на десять
                                        fimul   word ptr [bp - 2]
                                ; и прибавим только что обретённую цифру.
                                        fiadd   word ptr [bp - 4]
                                ; И так, пока не надоест.
                                        jmp     short @if0
                                ; Если собрались вводить дробную часть,
                                ; то запасёмся единицей.
                                @if2:   fld1
                                ; Вводим нечто.
                                @if3:   mov     ah, 01h
                                        int     21h
                                ; Если это не цифра, сдаёмся.
                                        cmp     al, 39h
                                        ja      short @if4
                                        sub     al, 30h
                                        jb      short @if4
                                ; Иначе сохраняем её во временной ячейке,
                                        mov     [bp - 4], al
                                ; получаем очередную отрицательную степень десятки,
                                        fidiv   word ptr [bp - 2]
                                ; дублируем её,
                                        fld     st(0)
                                ; помножаем на введённую цифру, тем самым получая
                                ; её на нужном месте,
                                        fimul   word ptr [bp - 4]
                                ; и добавляем к текущему результату.
                                        faddp   st(2), st
                                ; Опять-таки, пока не надоест.
                                        jmp     short @if3
                                ; Если ввод дробной части закончен,
                                ; нам больше не нужна степень десятки.
                                @if4:   fstp    st(0)
                                ; Итак, на вершине стэка получено введённое число.
                                ; Осталось разве только перейти на новую строку
                                @if5:   mov     ah, 02h
                                        mov     dl, 0Dh
                                        int     21h
                                        mov     dl, 0Ah
                                        int     21h
                                ; и вспомнить про знак.
                                        test    si, si
                                        jz      short @if6
                                        fchs
                                @if6:   leave
                                        pop     si
                                        pop     dx
                                        pop     ax
                                        ret
                        infloat endp



                        outfloat proc near
                                        push    ax
                                        push    cx
                                        push    dx
                                ; Формируем кадр стэка, чтобы хранить в нём десятку
                                ; и ещё какую-нибудь цифру.
                                        push    bp
                                        mov     bp, sp
                                        push    10
                                        push    0
                                ; Проверяем число на знак, и если оно отрицательное,
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jnc     @of1
                                ; то выводим минус
                                        mov     ah, 02h
                                        mov     dl, '-'
                                        int     21h
                                ; и оставляем модуль числа.
                                        fchs
                                ; Пояснение далее пойдёт на примере.   ; ST(0) ST(1) ST(2) ST(3) ...
                                ; Отделим целую часть от дробной.      ; 73.25 ... что-то не наше
                                @of1:   fld1                           ;  1    73.25 ...
                                        fld     st(1)                  ; 73.25  1    73.25 ...
                                ; Остаток от деления на единицу даст дробную часть.
                                        fprem                          ;  0.25  1    73.25 ...
                                ; Если вычесть её из исходного числа, получится целая часть.
                                        fsub    st(2), st              ;  0.25  1    73    ...
                                        fxch    st(2)                  ; 73     1     0.25 ...
                                ; Сначала поработаем с целой частью. Считать количество цифр будем в CX.
                                        xor     cx, cx
                                ; Поделим целую часть на десять,
                                @of2:   fidiv   word ptr [bp - 2]      ;  7.3   1     0.25 ...
                                        fxch    st(1)                  ;  1     7.3   0.25 ...
                                        fld     st(1)                  ;  7.3   1     7.3   0.25 ...
                                ; отделим дробную часть - очередную справа цифру целой части исходного числа,-
                                        fprem                          ;  0.3   1     7.3   0.25 ...
                                ; от чатсного оставим только целую часть
                                        fsub    st(2), st              ;  0.3   1     7     0.25 ...
                                ; и сохраним цифру
                                        fimul   word ptr [bp - 2]      ;  3     1     7     0.25 ...
                                        fistp   word ptr [bp - 4]      ;  1     7     0.25 ...
                                        inc     cx
                                ; в стэке.
                                        push    word ptr [bp - 4]
                                        fxch    st(1)                  ;  7     1     0.25 ...
                                ; Так будем повторять, пока от целой части не останется ноль.
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jnz     short @of2
                                ; Теперь выведем её.
                                        mov     ah, 02h
                                @of3:   pop     dx
                                ; Вытаскиваем очередную цифру, переводим её в символ и выводим.
                                        add     dl, 30h
                                        int     21h
                                ; И так, пока не выведем все цифры.
                                        loop    @of3                   ;  0     1     0.25 ...
                                ; Итак, теперь возьмёмся за дробную часть, для начала проверив её существование.
                                        fstp    st(0)                  ;  1     0.25 ...
                                        fxch    st(1)                  ;  0.25  1    ...
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jz      short @of5
                                ; Если она всё-таки ненулевая, выведем точку
                                        mov     ah, 02h
                                        mov     dl, '.'
                                        int     21h
                                ; и не более шести цифр дробной части.
                                        mov     cx, 6
                                ; Помножим дрообную часть на десять,
                                @of4:   fimul   word ptr [bp - 2]      ;  2.5   1    ...
                                        fxch    st(1)                  ;  1     2.5  ...
                                        fld     st(1)                  ;  2.5   1     2.5  ...
                                ; отделим целую часть - очередную слева цифру дробной части исходного числа,-
                                        fprem                          ;  0.5   1     2.5  ...
                                ; оставим от произведения лишь дробную часть,
                                        fsub    st(2), st              ;  0.5   1     2    ...
                                        fxch    st(2)                  ;  2     1     0.5  ...
                                ; сохраним полученную цифру во временной ячейке
                                        fistp   word ptr [bp - 4]      ;  1     0.5  ...
                                ; и сразу выведем.
                                        mov     ah, 02h
                                        mov     dl, [bp - 4]
                                        add     dl, 30h
                                        int     21h
                                ; Теперь, если остаток дробной части ненулевой
                                        fxch    st(1)                  ;  0.5   1    ...
                                        ftst
                                        fstsw   ax
                                        sahf
                                ; и мы вывели менее шести цифр, продолжим.
                                        loopnz  @of4                   ;  0     1    ...
                                ; Итак, число выведено. Осталось убрать мусор из стэка.
                                @of5:   fstp    st(0)                  ;  1     ...
                                        fstp    st(0)                  ;  ...
                                ; Точнее, стэков.
                                        leave
                                        pop     dx
                                        pop     cx
                                        pop     ax
                                        ret
                        outfloat endp



                        end start
