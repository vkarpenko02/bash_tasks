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

create_table () {
    local db_name="$1"
    local table_name="$2"
    shift 2
    # check if database exists
    if [ -f "$db_name.txt" ]; then
        # add table name
        echo "** Table: $table_name **" >> "$db_name.txt"

        # create a formatted row for the fields
        local row=""
        for el in "$@"; do
            if [[ ${#el} -gt 8 ]]; then
                echo "Error: Field '$el' exceeds maximum length of 8 characters"
                exit 1
            fi
            row+=" $el"
        done
        row+=" "

        echo "**$row**" >> "$db_name.txt"
        echo "Table '$table_name' created in database '$db_name'."
    else
        echo "Error: Database '$db_name' does not exist"
        exit 1
    fi
}

insert_data () {
    local db_name="$1"
    local table_name="$2"
    shift 2
    #check if database and table exists
    if [ -f "$db_name.txt" ] && grep -q "$table_name" "$db_name.txt"; then
        # create a formatted row for the fields
        local row=""
        for el in "$@"; do
            if [[ ${#el} -gt 8 ]]; then
                echo "Error: Field '$el' exceeds maximum length of 8 characters"
                exit 1
            fi
            row+=" $el"
        done
        row+=" "

        # insert right into specified table
        awk -v table="$table_name" -v data="**$row**" '
            /'"$table_name"'/{ print; getline; print; print data; next }
            1
        ' "$db_name.txt" > temp.txt && mv temp.txt "$db_name.txt"

        echo "Data inserted in table $table_name"
    else
        echo "Error: Database '$db_name' or table '$table_name' does not exist"
        exit 1
    fi
}

select_data () {
    local db_name="$1"
    local table_name="$2"

    #check if database and table exists
    if [ -f "$db_name.txt" ] && grep -q "$table_name" "$db_name.txt"; then
        echo "Data from table '${table_name}' in database '${db_name}':"
        awk -v table="$table_name" ' # initialize variable to work with
            # when we find the table name, start printing
            /'"$table_name"'/ { found_table=1; next }
            # if we found the table and encounter a blank line, stop printing
            found_table && /^$/ { exit }
            # print all lines after finding the table name
            found_table { print }
        ' "$db_name.txt"
    else
        echo "Error: Database '$db_name' or table '$table_name' does not exist"
        exit 1
    fi
}

delete_data () {
    local db_name="$1"
    local table_name="$2"
    local condition="$3"

    echo "Function in development!"
}

case "$1" in
    create_db) create_db "$2";;
    create_table) create_table "$2" "$3" "${@:4}";;
    insert_data) insert_data "$2" "$3" "${@:4}";;
    select_data) select_data "$2" "$3";;
    delete_data) delete_data "$2" "$3" "$4";;
    *) echo "Invalid command"; exit 1;;
esac