#!/bin/bash

shft=0
inputfile="None"
outputfile="None"

while [ -n "$1" ]
do
case "$1" in
    -s) shft=$2
    shift;;
    -i) inputfile="$2"
    shift;;
    -o) outputfile="$2"
    shift;;
    *) echo "$1 is not an option"
    exit 1;;
esac
shift
done

shifted_text=""

shift_letter() {
    local char=$1
    local shift=$2
    local new_char=""
    if [[ $char =~ [A-Za-z] ]]; then
        if [[ $char =~ [A-Z] ]]; then
            base=65  # ASCII base for uppercase
        else
            base=97  # ASCII base for lowercase
        fi
        new_char=$(printf "\\$(printf '%03o' $(( ( $(printf '%d' "'$char") - base + shift) % 26 + base )))")
    else
        new_char="$char"
    fi
    echo "$new_char"
}

while IFS= read -r line; do
    encrypted_line=""
    for (( i=0; i<${#line}; i++ )); do
        lt="${line:$i:1}"
        encrypted_line+=$(shift_letter "$lt" "$shft")
    done
    shifted_text+="$encrypted_line\n"
done < "$inputfile"

echo -e "$shifted_text" > "$outputfile"

