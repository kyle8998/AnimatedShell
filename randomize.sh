#!/bin/env bash
tput clear

cols=`tput cols`
rows=`tput lines`

while true
do
    x=$(( ( RANDOM % $rows ) + 1 ))
    y=$(( ( RANDOM % $cols ) + 1 ))
    tput cup $x $y
    echo '#'
done
