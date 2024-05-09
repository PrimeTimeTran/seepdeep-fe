#!/bin/bash

find_and_modify() {
    local file="$1"
    local replacement="$2"
    if [ -f "$file" ]; then
        sed -i '193s/.*/'"$replacement"'/' "$file"
        echo "Line 193 in $file has been modified."
    else
        echo "File $file not found."
    fi
}
replacement="style: Theme.of(context).textTheme.bodySmall,"
find_and_modify "$(find / -name 'filter_list_widget.dart' -print -quit)" "$replacement"
