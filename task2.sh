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
        case "$operation" in
            "addition") result=$((result + num));;
            "subtraction") result=$((result - num));;
            "multiplication") result=$((result * num));;
            "modulo") result=$((result % num));;
            *) echo "No valid operation set"; exit 1;;
        esac
    done
    return "$result"
}


while [ -n "$1" ]; do
    case "$1" in
        -o) case "$2" in
                "+") operation="addition";;
                "-") operation="subtraction";;
                "*") operation="multiplication";;
                "%") operation="modulo";;
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
            done
            if [ "${#numbers[@]}" -eq "1" ]; then
                echo "There are must be minimum 2 arguments"
                exit 1
            fi;;
        -d) additionalInfo; shift;;
        --) shift
            break;;
        *) echo "$1 is not an option"; exit 1;;
    esac
    shift
done


calculateResult
echo "Result: $?"