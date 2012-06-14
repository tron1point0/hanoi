#!/bin/bash

N=$1
[ -z "$N" ] && N=7

function solve {
    [ "$1" = "0" ] && return 0
    solve $(($1-1)) $2 $4 $3
    echo "$2 -> $4"
    solve $(($1-1)) $3 $2 $4
    return 0
}

echo $N
solve $N A B C
