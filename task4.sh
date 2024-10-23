#!/bin/bash

shft=0
inputfile="None"
outputfile="None"

# chech if input file exists and output file is enetered
checkForFiles () {
    if [[ -z "$inputfile" || ! -f "$inputfile" ]]; then
        echo "Input file is missing or does not exist."
        exit 1
    fi
    if [[ -z "$outputfile" ]]; then
        echo "Output file is not specified."
        exit 1
    fi
}

# read input
while [ -n "$1" ]; do
    case "$1" in
        -s) shft=$2; shift;;
        -i) inputfile="$2"; shift;;
        -o) outputfile="$2"; shift;;
        *) echo "$1 is not an option"; exit 1;;
    esac
    shift
done

shifted_text=""

# function for caesar cipher
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
        # convert letter to ASCII code
        ascii_code=$(printf "%d" "'$char")
        # calculate new value with shift and code base
        r=$(( (ascii_code - base + shift) % 26 + base ))
        # convert back
        new_char=$(printf "\\$(printf '%03o' "$r")")
    else
        # if symbol is not a letter
        new_char="$char"
    fi
    echo "$new_char"
}

checkForFiles

# read textfile by line
while IFS= read -r line; do
    encrypted_line=""
    for (( i=0; i<${#line}; i++ )); do
        # read line by one character
        lt="${line:$i:1}"
        encrypted_line+=$(shift_letter "$lt" "$shft") # add to encrypted line shift letter using function for this (pass char and shift)
    done
    shifted_text+="$encrypted_line\n" # don't forget to go to a new line
done < "$inputfile"

# the -e option enables the interpretation of backslash-escaped characters (\n)
echo -e "$shifted_text" > "$outputfile"
