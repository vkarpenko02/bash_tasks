#!/bin/bash

create_db() {
    local db_name="$1"

    if [[ -z $db_name ]]; then
        echo "Not a valid database name"
        exit 1
    fi

    touch "${db_name}.txt"
    echo "Database $db_name.txt created"
}

case "$1" in
    create_db) create_db "$2";;
    create_table) create_table "$2" "$3" "${@:4}";;
    insert_data) insert_data "$2" "$3" "${@:4}";;
    select_data) select_data "$2" "$3";;
    delete_data) delete_data "$2" "$3" "$4";;
    *) echo "Invalid command"; exit 1;;
esac