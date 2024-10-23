#!/bin/bash

inputfile=""
outputfile=""
new_text=""

# function that converts lowercase letters to uppercase
toUpperCase () {
    echo "$1" | tr 'a-z' 'A-Z'
}

# function that converts uppercase letters to lowercase
toLowerCase () {
    echo "$1" | tr 'A-Z' 'a-z'
}


while [ -n "$1" ]; do
case "$1" in
    -i) inputfile="$2"; shift;;
    -o) outputfile="$2"; shift;;
    -v) while IFS= read -r line; do
            new_line=""
            # read line by symbol
            for (( i=0; i<${#line}; i++ )); do
                lt="${line:$i:1}"
                if [[ $lt =~ [A-Z] ]]; then
                    new_line+=$(toLowerCase "$lt")
                elif [[ $lt =~ [a-z] ]]; then
                    new_line+=$(toUpperCase "$lt")
                else
                    new_line+="$lt"
                fi
            done
            new_text+="$new_line\n"
        done < "$inputfile"

        echo -e "$new_text" > "$outputfile"
        shift;;
    -s) while IFS= read -r line; do
            new_line=""
            for word in $line; do
                if [[ "${word:0:1}" =~ [Aa] ]]; then
                    if [[ "${word:0:1}" = "A" ]]; then
                        new_line+="B${word:1} "
                    else
                        new_line+="b${word:1} "
                    fi
                else
                    new_line+="$word "
                fi
            done
            new_text+="$new_line\n"
        done < "$inputfile"
        
        echo -e "$new_text" > "$outputfile"
        shift;;
    -r) while IFS= read -r line; do
            new_line=$(echo "$line" | rev)
            new_text+="$new_line\n"
        done < "$inputfile"

        echo -e "$new_text" > "$outputfile"
        shift;;
    -l) while IFS= read -r line; do
            new_line=""
            for (( i=0; i<${#line}; i++ )); do
                lt="${line:$i:1}"
                if [[ $lt =~ [A-Z] ]]; then
                    new_line+=$(toLowerCase "$lt")
                else
                    new_line+="$lt"
                fi
            done
            new_text+="$new_line\n"
        done < "$inputfile"

        echo -e "$new_text" > "$outputfile"
        shift;;
    -u) while IFS= read -r line; do
            new_line=""
            for (( i=0; i<${#line}; i++ )); do
                lt="${line:$i:1}"
                if [[ $lt =~ [a-z] ]]; then
                    new_line+=$(toUpperCase "$lt")
                else
                    new_line+="$lt"
                fi
            done
            new_text+="$new_line\n"
        done < "$inputfile"

        echo -e "$new_text" > "$outputfile"
        shift;;
    *) echo "$1 is not an option"; exit 1;;
esac
shift
done


