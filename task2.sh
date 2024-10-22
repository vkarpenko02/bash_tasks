#!/bin/bash

operation="None"
numbers=()
result=0
is_first_number="1"

# function that displays additional info
additionalInfo () {
    echo "==============="
    echo "Additional info:"
    echo "User: $USER"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
    echo "==============="
}


# function to calculate result
calculateResult () {
    for num in "${numbers[@]}"; do
        if [ $is_first_number = "0" ]; then
            is_first_number="1"
            continue
        fi
        if [ "$operation" = "addition" ]; then
            result=$((num+result))
        elif [ "$operation" = "subtraction" ]; then
            result=$((result-num))
        elif [ "$operation" = "multiplication" ]; then
            result=$((result * num))
        elif [ "$operation" = "division by modulo" ]; then
            result=$((result % num))
        fi
    done
    return "$result"
}


while [ -n "$1" ]; do
    case "$1" in
        -o) case "$2" in
            "+") operation="addition";;
            "-") operation="subtraction";;
            "*") operation="multiplication";;
            "%") operation="division by modulo";;
            *) echo "Invalid operation"; exit 1;;
            esac
            shift;;
        -n) while [ -n "$2" ]; do
                # verify if the argument is a number
                if [[ "$2" =~ ^-?[0-9]+$ ]]; then
                    numbers+=("$2") # add number to array
                    # if its the first number, result will be equal to it
                    if [ $is_first_number = "1" ]; then
                        result="$2"
                        is_first_number="0"
                    fi
                # verify if the argument is the next option
                elif [[ "$2" =~ ^-.+ ]]; then
                    break
                # else it is an input error
                else
                    echo "$2 is not a number"
                    exit 1
                fi
                shift
            done;;
        -d) additionalInfo;;
        --) shift
            break;;
        *) echo "$1 is not an option"; exit 1;;
    esac
    shift
done


calculateResult
echo "Result: $?"