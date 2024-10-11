#!/bin/bash

fib() {
    local n=$1
    if [ "$n" -eq 0 ]; then
        echo 0
    elif [ "$n" -eq 1 ]; then
        echo 1
    else
        local a=0
        local b=1
        local c
        for (( i=2; i<=n; i++ )); do
            c=$((a + b))
            a=$b
            b=$c
        done
        echo $b
    fi
}

echo "Fibonacci of $1: $(fib $1)"
