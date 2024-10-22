#!/bin/bash

NUMBER=$1

# Function to calculate the Fibonacci number
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

# verify amount of arguments
if [ $# -ne 1 ]; then
    echo "You passed more than one argument"
    exit 1
fi

# verify if argument is a number
if [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
    echo "Fibonacci of $NUMBER: $(fib "$1")"
else
    echo "Invalid input"
    exit 1
fi