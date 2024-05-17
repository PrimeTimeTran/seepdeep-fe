import os
from xml.dom import minidom

def remove_style_attribute(svg_file):
    try:
        # Parse the SVG file
        doc = minidom.parse(svg_file)
        
        # Get all 'path' elements
        paths = doc.getElementsByTagName('path')
        
        # Remove style attribute from each 'path' element
        for path in paths:
            if path.hasAttribute('style'):
                path.removeAttribute('style')
        
        # Write the modified SVG back to the file
        with open(svg_file, 'w') as f:
            doc.writexml(f)
            
        print(f"Style attribute removed from {svg_file}")
        
    except Exception as e:
        print(f"Error processing {svg_file}: {e}")

def remove_style_from_svg_files(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.svg'):
            svg_file = os.path.join(directory, filename)
            remove_style_attribute(svg_file)

# Directory containing SVG files
directory = './assets/refined'

# Call the function to remove style attribute from SVG files in the directory
remove_style_from_svg_files(directory)
