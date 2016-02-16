model small
.stack 100h
.386
.data
           STRING_A DB 10,13, ' INPUT A: $'
           STRING_B DB ' INPUT B: $'
           STRING_H DB ' INPUT H: $'
           STRING_EPS DB ' INPUT EPS: $'

           STRING_XE DB ' X = $'
           STRING_YE DB ' Y(x) = $'

           STRING_KE DB ' K = $'
           STRING_SE DB ' S(x) = $'
           STRING_ENT DB 10, 13, '$'
           STRING_TAB DB 9, '$'
           STRING_D db 10,13, ' D  = $'
           STRING_CONT db 10,13, ' Continue y/n?    $'
           STRING_NOTKVADR db 10,13, ' Format error. Enter correct format     $'


                                                                                ;рабочие переменные
            a dd ?
            b dd ?
            h dd ?
            eps dd ?
            s dd ?
            y dd ?
            x dd ?
            tmpx dd ?
            tmpk dd ?
            tmps dd ?
            k dd 0.0
            one dd 1.0
            two dd 2.0
            minusone dd -1.0
            twokplusone dd ?
            fact_twokplusone dd ?
            tmptwokplus dd ?
            ten dd 10.0

.code
        start:
        mov ax, @data                                                           ;заносим область с данными
        mov ds, ax                                                              ;в рабочую зону DS
        finit
        ;fstp	st(1)          ; Удаляем st1
        org 100h
        mov  ax,2
        int  10H                                                                ;установка видеорежима 80x25

        lea dx,STRING_A                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A

        call infloat
        fstp a
        lea dx,STRING_B                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A

        call infloat
        fstp b

        lea dx,STRING_H                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        call infloat
        fstp h

        lea dx,STRING_EPS                                                       ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        call infloat
        fld ten
        fdiv
        fstp eps





        fld a
        fstp x


        xplush:


        lea dx,STRING_XE                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        fld x
        call outfloat
        lea dx,STRING_TAB                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        lea dx,STRING_YE                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A

        fld x
        call sinFPU

        kplusone:
        ;sum goes here
        fld one
        fld k
        fadd
        fstp k

        fld k

        call sintail            ;st(0) = sintail

        fld s
        fld y                   ;st(0) = sinfpu; st(1) = sintail
        fsub                    ;st(0) = sinfpu-sintail
        fabs                    ;st(0) = ABS(sinfpu-sintail)
        fld eps                 ;st(0) = eps; st(1) =  ABS(sinfpu-sintail)
        fsub
        ftst
        fstsw ax
        sahf
        jnc kplusone

        lea dx,STRING_TAB                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A

        lea dx,STRING_KE                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        fld k
        call outfloat
        lea dx,STRING_TAB                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A

        lea dx,STRING_SE                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A
        fld s
        call outfloat
        lea dx,STRING_ENT                                                         ;вывод
        mov ah,09h	                                                        ;сообщения
        int 21h                                                                 ;INPUT A



        fld x
        fld h
        fadd
        fstp x
        fld x
        fld b
        fsub

        ftst
        fstsw ax
        sahf
        fldz
        fstp k  ;обнуляем k

        jc xplush










        mov ah, 4ch                                                             ;передаём в ah код прерываня для выхода из программы
        int 21h                                                                 ;прерываение







        sintail proc ;на входе только K(st0 = k)
        fld k
        fldz ;st0 0 st1 k st2 k
        fxch ;st0 k st1 0 st2 k
        fld x   ;st0 x  st1 k   st2 sum  st3 k            (в st2 лежит сумма st3 общий счётчик)

        sumcalculating:

        fstp tmpx
        fstp tmpk
        fstp tmps

        fld tmpk
        fld two
        fmul
        fld1
        fadd
        fstp twokplusone

        fcom minusone
        fstsw ax
        sahf
        je sumcalculatingETX
        fld tmps
        fld tmpk
        fld tmpx

        fld twokplusone                                                         ;st0 twokplusone st1 x st2 sum st3 k
        fxch                                                                    ;st0 x st1 twokplusone st2 sum st3 k
        xpowtwokplusone:
        fxch                                                                    ;st0 twokplusone st1 x
        fcom one
        fstsw ax                                                                ;сравнение с нулём если равен, то уходим
        sahf
        fxch                                                                    ;st0 x st1 twokplusone st2 sum st3 k
        je xpowtwokplusoneEXT
        fld x                                                                   ;st0 x st1 x st2 twokplusone st3 sum st4 k
        fmul                                                                    ;st0 pow(x) st1 twokplusone st2 sum st3 k
        fxch    ;st0 twokplusone st1 pow(x)
        fst tmptwokplus
        fdiv
        fld tmptwokplus
        fld1
        fsub    ;st0 twokplusone-1 st1 -pow(x)
        fxch    ;st0 -pow(x) st1 twokplusone-1
        jmp xpowtwokplusone
        xpowtwokplusoneEXT:                                                     ;st0 pow(x) st1 0 st2 sum st3 k
        fxch                                                                    ;st0 0 st1 pow(x) st2 sum st3 k
        fstp st(0)

        xminus:
        fxch            ;берём к и проверяем на ноль
        ftst
        fstsw ax         ;сравнение с нулём если равен, то уходим
        sahf
        je xminusexit   ;if k = 0 then exit
        fxch
        fchs  ;st0 -x st1 k
        fxch    ;st0 k st1 -x
        fld1
        fsub    ;st0 k-1 st1 -x
        fxch    ;st0 -x st1 k-1
        jmp xminus
        xminusexit:                                                             ;st0 x st1 0 st2 sum st3 k
        fstp st(0)                                                              ;st0 x st1 sum st2 k ;убираем мусор

        fadd                                                                    ;st(0) sum st1 k
        fxch
        fld1
        fsub                                                                    ;st0 k-1 st1 sum
        fst tmpk

        fxch                                                                    ;st0 sum st1 k-1

        fld tmpk                                                                ;st0 k-1 st1 sum st2 k-1
        fld x                                                                   ;st0 x st1 k st2 sum st3 k-1
        jmp sumcalculating                                                      ;st0 x st1 k st2 sum st3 k-1
        sumcalculatingETX:
        fld tmps
        fst s

        ;call outfloat
        ret
        sintail endp










        sinFPU proc

        fsin
        fstp y
        fld y
        call outfloat


        ret
        sinFPU endp

            infloat proc    near
                push    ax                                                      ;сохранение регистра ax
                push    dx                                                      ;регистра dx
                push    si                                                      ;регистра si
                                                                                ;Формируем  стэк, чтобы хранить десятку и ещё какую-нибудь цифру.
                push    bp                                                      ;регистра bp
                mov     bp, sp                                                  ;помещаем в bp указатель стека
                push    10                                                      ;заносим в стек  10
                push    0                                                       ;заносим в стек  0
                xor     si, si                                                  ; В SI хранится знак.

                                                                                ; Начнём накапливать число. Сначала это ноль.
                fldz
                mov     ah, 01h                                                 ;Вводим первый символ
                int     21h                                                     ;через первую функцию 21го прерывания
                cmp     al, '-'                                                 ;сравниваем введённое значение с символом "-"
                jne     short @if1                                              ;если "-" то запоминаем, если нет то проверяем следующие условия
                inc     si                                                      ;запомиинаем минус в регистре si
        @if0:
                mov     ah, 01h                                                 ;Вводим  символ
                int     21h                                                     ;через первую функцию 21го прерывания


        @if1:
                cmp     al, '.'                                                 ;Если введена точка, то
                je      short @if2                                              ;формируем дробную часть


                cmp     al, 39h                                                 ;проверяем
                ja      short @if5                                              ;что вводим числа,
                sub     al, 30h                                                 ;и в случае если вводятся не числа,
                jb      short @if5                                              ;то переходим по метке завершающей ввод
                                                                                ;сохраним её во временной ячейке и допишем
                                                                                ; к текущему результату справа,
                mov     [bp - 4], al                                            ;переместим введённое число в память
                fimul   word ptr [bp - 2]                                       ;домножим верх стека на 10
                fiadd   word ptr [bp - 4]                                       ;добавим к верху стека введённое число
                jmp     short @if0                                              ;повторяем
        @if2:                                                                   ;метка вычисления дробной части
         fld1                                                                   ;добавляю в верх стека единицу
        @if3:
                mov     ah, 01h                                                 ;принимаем
                int     21h                                                     ;символ

                cmp     al, 39h                                                 ;проверяем
                ja      short @if4                                              ;что вводим числа,
                sub     al, 30h                                                 ;и в случае если вводятся не числа,
                jb      short @if4                                              ; то переходим по метке завершающей ввод

                mov     [bp - 4], al                                            ;иначе сохраняем её во временной ячейке,
                fidiv   word ptr [bp - 2]                                       ;получаем очередную отрицательную степень десятки,
                fld     st(0)                                                   ;записываем её в стек
                fimul   word ptr [bp - 4]                                       ;помножаем на введённую цифру, тем самым получая её на нужном месте
                faddp   st(2), st                                               ;и добавляем к  результату.
                jmp     short @if3                                              ;повторяем


        @if4:
        fstp    st(0)                                                           ;на вершине стэка получено введённое число.
        @if5:
                mov     ah, 02h                                                 ;вывод на экран
                mov     dl, 0Dh                                                 ;перевод каретки
                int     21h
                test    si, si                                                  ;проверяем  наличие знака
                jz      short @if6                                              ;если флаг  не ноль
                fchs                                                            ;то меняем в стеке знак
        @if6:   leave
                pop     si                                                      ;восстанавливаем регистр si
                pop     dx                                                      ;восстанавливаем регистр dx
                pop     ax                                                      ;восстанавливаем регистр ax
                ret
        infloat endp



        outfloat proc near
                push    ax                                                      ;сохраняем регистр ах
                push    cx                                                      ;регистр cx
                push    dx                                                      ;регистр dx
                push    bp                                                      ;регистр bp
                mov     bp, sp                                                  ;помещаем в bp указатель стека
                push    10                                                      ;заносим в стек  10
                push    0                                                       ;заносим в стек  0

                ftst                                                            ;Проверяем число на знак, и если оно отрицательное
                fstsw   ax                                                      ;сохраняем флаги
                sahf                                                            ;помещает значение регистра ah в младший байт флагового регистра.
                jnc   @of1                                                      ;проверяем отрицание

                mov     ah, 02h                                                 ;выводим
                mov     dl, '-'                                                 ;минус
                int     21h
                fchs                                                            ;берём модуль числа

        @of1:
                fld1
                fld     st(1)
                fprem                                                           ;Остаток от деления в вершине стека
                fsub    st(2), st                                               ;вычитаем из исходного числа
                fxch    st(2)                                                   ;меняем местами
                xor     cx, cx                                                  ;обнулим cx для того, чтобы считать количество цифр до запятой
                                                                                ;Поделим целую часть на десять,
        @of2:
                fidiv   word ptr [bp - 2]                                       ;поделим на 10 вершину
                fxch    st(1)                                                   ;поменяем местами вершину и 1й элемент
                fld     st(1)                                                   ;число  1  число  дробь

                fprem                                                           ;снова берём остаток от вершины

                fsub    st(2), st                                               ;и от последующего разряда оставляем только целую часть

                fimul   word ptr [bp - 2]                                       ;домножим этот остаток на 10
                fistp   word ptr [bp - 4]                                       ;сохраним цифру во временной ячейке вершины стека.те самую близкую к точке с левой стороны
                                                                                ;сейчас в стеке осталось в вершине 1 , 1-й целая часть без одного разряда стоящего ближе к точке, 2-й дробь
                inc     cx                                                      ;увеличим счётчик, чтобы знать сколько выводим цифр из стека.
                push    word ptr [bp - 4]                                       ;сохраняемся
                fxch    st(1)                                                   ;меняем местами вершину и первый элемент, чтобы заново пройти цикл

                ftst                                                            ;проверяемся на ноль
                fstsw   ax                                                      ;сохраняем флаги
                sahf                                                            ;смотреть выше
                jnz     short @of2                                              ;Так будем повторять, пока от целой части не останется ноль.

                mov     ah, 02h                                                 ;выведем цифру
        @of3:                                                                   ;метка для вывода уже всех чисел до запятой из стека
                pop     dx                                                      ;Вытаскиваем очередную цифру, переводим её в символ и выводим.
                add     dl, 30h
                int     21h
                loop    @of3                                                    ;И так, пока не выведем все цифры работает флаг cx
                                                                                ;работа с дробной частью
                fstp    st(0)
                fxch    st(1)                                                   ;поменяем местами
                ftst                                                            ;проверим наличие дробной части
                fstsw   ax
                sahf
                ;jz      short @of5                                              ; если её нет то идём на выход



                mov     ah, 02h
                mov     dl, '.'                                                 ; Если она всё-таки ненулевая, выведем точку
                int     21h
                mov     cx, 6                                                   ;максимум 6цифр после запятой

        @of4:
                fimul   word ptr [bp - 2]                                       ;Помножим дрообную часть на десять (разница в том, что мы умножаем на 10, а не делим)
                fxch    st(1)                                                   ;та же операция как и с целыми
                fld     st(1)                                                   ;ставим в верх домноженную на 10 дробь

                fprem                                                           ; отделим целую часть
                fsub    st(2), st                                               ; оставим от домноженной на 10дроби лишь дробную часть
                fxch    st(2)                                                   ;поменяем местами верх и второй элемент

                fistp   word ptr [bp - 4]                                       ; сохраним полученную цифру во временной ячейке, чтобы можно было потом с ней работать
                mov     ah, 02h                                                 ; и сразу выведем.
                mov     dl, [bp - 4]
                add     dl, 30h
                int     21h

                fxch    st(1)                                                   ;снова проверяем на наличие нуля в остатке
                ftst                                                            ;(спрашивается зачем делать два раза,
                fstsw   ax                                                      ; потому что при первоначальной проверке дробь может отсутствовать )
                sahf
                loopnz  @of4                                                    ;пока не выведем 6 цифр (регистр CX)

        @of5:
                fstp    st(0)                                                   ;очищаем остатки стека
                fstp    st(0)
                leave
                pop     dx                                                      ;восстанавливаем все регистры
                pop     cx
                pop     ax
                ret

        outfloat endp
        end start
