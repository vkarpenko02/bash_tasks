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

# function that reads a file by symbol
readFile () {
    while IFS= read -r line; do
        new_line=""
        if [ "$1" = "replace" ]; then
            for word in $line; do
                if [[ ${word:0:1}"" =~ [Aa] ]; then
                    if [[ "${word:0:1}" = "A" ]]; then
                        new_line+="B${word:1} "
                    else
                        new_line+="b${word:1} "
                    fi
                else
                    new_line+="$word "
                fi
            done
        else
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
        fi
        new_text+="$new_line\n"
    done < "$inputfile"

    echo -e "$new_text" > "$outputfile"
}


while [ -n "$1" ]; do
    case "$1" in
        -i) inputfile="$2"; shift;;
        -o) outputfile="$2"; shift;;
        -v) readFile "swap"; shift;;
        -s) readFile "replace"; shift;;
        -r) while IFS= read -r line; do
                new_line=$(echo "$line" | rev)
                new_text+="$new_line\n"
            done < "$inputfile"

            echo -e "$new_text" > "$outputfile"
            shift;;
        -l) readFile "tolower"; shift;;
        -u) readFile "toupper"; shift;;
        *) echo "$1 is not an option"; exit 1;;
    esac
    shift
done


