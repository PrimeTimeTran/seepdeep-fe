# Find all SVG files in the directory and its subdirectories
svg_files=$(find . -type f -name "*.svg")

# Loop through each SVG file
for file in $svg_files; do
    echo "Processing file: $file"
    inkscape "$file" --actions="select-all;selection-ungroup;object-stroke-to-path;path-union;path-combine;vacuum-defs;export-filename:"refined/$file";export-do"
    svgo "$file" --output="refined/$file"
done