#!/bin/bash

# Function to find and modify the file
find_and_modify() {
    local file="$1"
    local replacement="$2"
    
    # Check if the file exists
    if [ -f "$file" ]; then
        # Modify line 193
        sed -i '193s/.*/'"$replacement"'/' "$file"
        echo "Line 193 in $file has been modified."
    else
        echo "File $file not found."
    fi
}

# Main script

# String to replace with
replacement="style: Theme.of(context).textTheme.bodySmall,"

# Find the file and modify
find_and_modify "$(find / -name 'filter_list_widget.dart' -print -quit)" "$replacement"
