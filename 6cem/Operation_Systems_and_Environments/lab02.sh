#!/bin/bash

# Supremum of 'rand_val' value set by 'rand' function.
readonly MAXRANDOM=32767
# Interval (in seconds) of updating clock's position.
readonly UPDATE_INTERVAL=10
# Colors that are used in script below.
readonly RESTORE="\e[0m"
readonly WHITE="\e[107m"
# Character's dimension.
readonly CHAR_HEIGHT=7
readonly CHAR_WIDTH=6
# The foreground/background colours.
bg=$RESTORE
fg=$WHITE
# Length of string returned by 'clock' function
readonly TIME_LENGTH=8


# Set current time to 'seed' that is used in 'rand' function.
function srand {
    seed=$(date +%s)
}

# Update 'seed' value and set new random value to 'rand_val'.
function rand {
    seed=$(((seed*214013+2531011) % (1 << 32)))
    rand_val=$((seed % (MAXRANDOM+1) ))
}

# Read current time and store it in 'TIME'.
clock()
{
    TIME=$(date "+%H:%M:%S")
}

# *********************************************************
# The eleven characters required for this DEMO are 0 to 9
# and the : colon character.
zero()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg  $3  $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg $3 $bg $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3  $bg  $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
one()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3  $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$3   $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$3     $bg "
}
two()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3     $bg "
}
three()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
four()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg   $3 $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3  $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3 $bg $3 $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg  $3 $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3     $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg   $3 $bg "
}
five()
{
    local row=$1
    printf "\x1B[$row;$2""f$3     $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
six()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3    $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
seven()
{
    local row=$1
    printf "\x1B[$row;$2""f$3     $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg   $3 $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3 $bg    "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg     "
}
eight()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
nine()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg $3   $bg  "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$3 $bg   $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3    $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg    $3 $bg "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg $3   $bg  "
}
colon()
{
    local row=$1
    printf "\x1B[$row;$2""f$bg      "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg      "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg      "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg  $3 $bg   "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg      "
    ((row+=1))
    printf "\x1B[$row;$2""f$bg      "
}
# End of the character set.
# *********************************************************

# Print current time to terminal.
echo_time() {
    clock
    local horiz=$2
    for i in $(seq 0 1 $((TIME_LENGTH)))
    do
        # Take each character of current time and print it to terminal.
        char="${TIME:${i}:1}"
        if [ "$char" == ":" ]
        then
            colon $1 $horiz $3
        fi
        if [ "$char" == "0" ]
        then
            zero $1 $horiz $3
        fi
        if [ "$char" == "1" ]
        then
            one $1 $horiz $3
        fi
        if [ "$char" == "2" ]
        then
            two $1 $horiz $3
        fi
        if [ "$char" == "3" ]
        then
            three $1 $horiz $3
        fi
        if [ "$char" == "4" ]
        then
            four $1 $horiz $3
        fi
        if [ "$char" == "5" ]
        then
            five $1 $horiz $3
        fi
        if [ "$char" == "6" ]
        then
            six $1 $horiz $3
        fi
        if [ "$char" == "7" ]
        then
            seven $1 $horiz $3
        fi
        if [ "$char" == "8" ]
        then
            eight $1 $horiz $3
        fi
        if [ "$char" == "9" ]
        then
            nine $1 $horiz $3
        fi
        ((horiz+=6))
    done
}

# Remove the cursor.
tput civis
# Set initial seed for rand.
srand
# Now clear the screen.
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
        echo_time $start_row $start_col $fg
        sleep 1
        echo_time $start_row $start_col $bg
    done
    # srand
done
