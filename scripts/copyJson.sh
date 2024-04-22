#!/bin/bash

# Get the script's directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Define source and destination directories relative to the script's directory
SOURCE_DIR="$SCRIPT_DIR/../assets/json"
DEST_DIR="$SCRIPT_DIR/../web/assets/json"

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy all files from source to destination
cp -r "$SOURCE_DIR"/* "$DEST_DIR"

# Print a success message
echo "All files from $SOURCE_DIR have been copied to $DEST_DIR"
