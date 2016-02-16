
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
            tmpx dd ?
            tmpk dd ?
            tmps dd ?
            x dd 0.53333
            k dd 2.0
            twokplusone dd ?
            one dd 1.0
            two dd 2.0
            minusone dd -1.0
            tmptwokplus dd ?
            fact_twokplusone dd ?

.code
        start:
        mov ax, @data                                                           ;заносим область с данными
        mov ds, ax                                                              ;в рабочую зону DS


        finit
        fld k
        call sintail
        fld x
        call sinFPU




        mov ah, 4ch                                                             ;передаём в ah код прерываня для выхода из программы
        int 21h                                                                 ;прерываение




        sinFPU proc

        fsin
        fstp y
        fld y
        call outfloat


        ret
        sinFPU endp




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


call outfloat
ret
sintail endp



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
        mov     cx, 8                                                   ;максимум 6цифр после запятой

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
