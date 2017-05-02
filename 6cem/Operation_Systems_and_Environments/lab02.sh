#!/bin/bash

readonly MAXRANDOM=32767
readonly UPDATE_INTERVAL=1
readonly RESTORE="\e[0m"
readonly WHITE="\e[107;43m"
readonly CHAR_HEIGHT=7
readonly CHAR_WIDTH=6
b=$RESTORE
f=$WHITE
readonly TIME_LENGTH=8


function rand {

    seed=$(((seed*214013+2531011) % (1 << 32)))
    rand_val=$((seed % (MAXRANDOM+1) ))
}

clock()
{
    TIME=$(date "+%H:%M:%S")
}

zero()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
one()
{
    local row=$1
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
    ((row+=1))
    printf "\x1B[$row;$2""f$b  $f $b   "
}
two()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
three()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
four()
{
    local row=$1
    printf "\x1B[$row;$2""f$f $b   $f "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f "
}
five()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
six()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b  "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b     "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
seven()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
}
eight()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
nine()
{
    local row=$1
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f $b   $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b    $f $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$f     $b "
}
colon()
{
    local row=$1
    printf "\x1B[$row;$2""f$b      "
    ((row+=1))
    printf "\x1B[$row;$2""f$b      "
    ((row+=1))
    printf "\x1B[$row;$2""f$b      "
    ((row+=1))
    printf "\x1B[$row;$2""f$b $f   $b "
    ((row+=1))
    printf "\x1B[$row;$2""f$b      "
    ((row+=1))
    printf "\x1B[$row;$2""f$b      "
    ((row+=1))
    printf "\x1B[$row;$2""f$b      "
}

draw_digit() {
    clock
    local horiz=$2
    for i in $(seq 0 1 $((TIME_LENGTH)))
    do
        char="${TIME:${i}:1}"
		 if [ "$char" == ":" ]
        then
            colon $1 $horiz 
        fi
        if [ "$char" == "0" ]
        then
            zero $1 $horiz 
        fi
        if [ "$char" == "1" ]
        then
            one $1 $horiz 
        fi
        if [ "$char" == "2" ]
        then
            two $1 $horiz 
        fi
        if [ "$char" == "3" ]
        then
            three $1 $horiz 
        fi
        if [ "$char" == "4" ]
        then
            four $1 $horiz 
        fi
        if [ "$char" == "5" ]
        then
            five $1 $horiz 
        fi
        if [ "$char" == "6" ]
        then
            six $1 $horiz 
        fi
        if [ "$char" == "7" ]
        then
            seven $1 $horiz 
        fi
        if [ "$char" == "8" ]
        then
            eight $1 $horiz 
        fi
        if [ "$char" == "9" ]
        then
            nine $1 $horiz 
        fi
        ((horiz+=6))
    done
}

clear

nrows=$(tput lines)
ncols=$(tput cols)
while true
do
    rand
    start_row=$((rand_val % (nrows-CHAR_HEIGHT)+1))
    rand
    start_col=$((rand_val % (ncols-CHAR_WIDTH*TIME_LENGTH)+1))
    for i in $(seq 1 1 $((UPDATE_INTERVAL)))
    do
        draw_digit $start_row $start_col 
        sleep 1
		clear
    done
done
