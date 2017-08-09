#!/bin/env bash
tput clear

cols=`tput cols`
cols=$((cols-2))
rows=`tput lines`
rows=$((rows-2))

y=$(( ( RANDOM % $rows ) ))
x=$(( ( RANDOM % $cols ) ))

buffer=10

declare -A pair
pair[x]=y

declare -A arrX
arrX[0]=$x

declare -A arrY
arrY[0]=$y

i=1
d=-1

big=false

trap resize SIGWINCH
trap cleanup HUP TERM
trap 'break 2' INT

while true
do
    case "$(( ( RANDOM % 4 ) + 1 ))" in
        1)
            if [[ $y < rows-2 ]]; then
                y=$((y+1))
            fi
            ;;
        2)
            if [[ $y > 2 ]]; then
                y=$((y-1))
            fi
            ;;
        3)
            if [[ $x < cols-2 ]]; then
                x=$((x+1))
            fi
            ;;
        4)
            if [[ $x > 2 ]]; then
                x=$((x-1))
            fi
            ;;
    esac
    arrX[$i]=$x
    arrY[$i]=$y

    i=$((i + 1))

    if [[ $i -eq 10 ]]; then
        big=true
        #echo "${arrX[$i]}"
        #x=${arrX[$i]}
        #y=${arrY[$i]}
        #tput cup $x $y
        #echo ' '
        #delX=0
    fi
    if [[ $i -eq 11 ]]; then
        i=0
    fi




    #sleepTime=$(bc <<< "scale=2; $(printf '0.%02d' $(( $RANDOM % 100))) / 2")
    tput cup $x $y
    echo '#'
    #echo -en "\r\e[$1A\e[K"

    if [[ $big = true ]]; then
        d=$((d + 1))

        x=${arrX[$d]}
        y=${arrY[$d]}
        tput rmcup $x $y
        echo ' '
        #echo -en "\r\e[$1A\e[K"
        if [[ $d -eq 10 ]]; then
            d=0
        fi
        tput civis
    fi

done

