#!/bin/bash

for num in {1..100}; do
    if (( num % 3 == 0 && num % 5 == 0 )); then
        echo "FizzBuzz"
    elif (( num % 5 == 0 )); then
        echo "Buzz"
    elif (( num % 3 == 0 )); then
        echo "Fizz"
    else
        echo "$num"
    fi
done
