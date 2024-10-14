#!/bin/bash

operation="None"
numbers=()
result=0
flag="1"

while [ -n "$1" ]
do
case "$1" in
-o) case "$2" in
    "+") operation="addition";;
    "-") operation="subtraction";;
    "*") operation="multiplication";;
    "%") operation="division by modulo";;
    esac
shift;;
-n) while [[ "$2" =~ ^-?[0-9]+$ ]]; do
numbers+=("$2")
if [ $flag = "1" ]; then
result="$2"
flag="0"
fi
shift
done;;
-d) echo "Additional info:"
echo "User: $USER"
echo "Script: $0"
echo "Operation: $operation"
echo "Numbers: ${numbers[@]}";;
--) shift
break;;
*) echo "$1 is not an option";;
esac
shift
done

for num in ${numbers[*]}; do
if [ $flag = "0" ]; then
flag="1"
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

echo "Result: $result"