#!/bin/bash

inputfile=""
outputfile=""
new_text=""

# to uppercase function
toUpperCase () {
    echo "$1" | tr 'a-z' 'A-Z'
}

# to lowercase function
toLowerCase () {
    echo "$1" | tr 'A-Z' 'a-z'
}

# function that converts lowercase letters to uppercase and vice versa
swapFunc () {
    if [[ $1 =~ [A-Z] ]]; then
        echo $(toLowerCase "$1")
    elif [[ $1 =~ [a-z] ]]; then
        echo $(toUpperCase "$1")
    else
        echo "$1"
    fi
}

# function to reverse text
reverseText () {
    while IFS= read -r line; do
        new_line=$(echo "$line" | rev)
        new_text+="$new_line\n"
    done < "$inputfile"

    echo -e "$new_text" > "$outputfile"
}

# function that reads a file by symbol
readFile () {
    while IFS= read -r line; do
        new_line=""
        for (( i=0; i<${#line}; i++ )); do
            lt="${line:$i:1}"
            if [ "$1" = "swap" ]; then
                new_line+=$(swapFunc "$lt")
            elif [ "$1" = "toupper" ]; then
                new_line+=$(toUpperCase "$lt")
            elif [ "$1" = "tolower" ]; then
                new_line+=$(toLowerCase "$lt")
            fi
        done
        new_text+="$new_line\n"
    done < "$inputfile"
    echo -e "$new_text" > "$outputfile"
}

# function for replacement
replaceWords () {
    local a_word="$1"
    local b_word="$2"

    sed "s/$a_word/$b_word/Ig" "$inputfile" > "$outputfile"
}


while [ -n "$1" ]; do
    case "$1" in
        -i) inputfile="$2"; shift;;
        -o) outputfile="$2"; shift;;
        -v) readFile "swap"; shift;;
        -s) words=()
            while [ -n "$2" ]; do
                if [[ ! "$2" =~ ^-.+ ]]; then
                    words+=("$2")
                else
                    break
                fi
                shift
            done
            if [ "${#words[@]}" -ne "2" ]; then
                echo "There are must be 2 arguments"
                exit 1
            else
                replaceWords "${words[0]}" "${words[1]}"
            fi;;
        -r) reverseText; shift;;
        -l) readFile "tolower"; shift;;
        -u) readFile "toupper"; shift;;
        *) echo "$1 is not an option"; exit 1;;
    esac
    shift
done
